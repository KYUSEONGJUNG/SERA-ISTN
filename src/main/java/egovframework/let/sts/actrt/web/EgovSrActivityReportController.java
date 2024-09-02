package egovframework.let.sts.actrt.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sts.actrt.service.ActivityReportVO;
import egovframework.let.sts.actrt.service.EgovSrActivityReportService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * SR Activity Report 검색 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성
 *  2011.06.30  이기하          패키지 분리(sts -> sts.cst)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@Controller
public class EgovSrActivityReportController {

	/** EgovSrActivityReportService */
	@Resource(name = "srActivityReportService")
    private EgovSrActivityReportService srActivityReportService;
	
	/** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovSrActivityReportController.class);

    /**
	 * SR Activity Report 을 조회한다
	 * @param ActivityReportVO activityReportVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/actrt/selectSrActivityReport.do")
	public String selectUserStats(@ModelAttribute("searchVO") ActivityReportVO activityReportVO,
			ModelMap model) throws Exception {

    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	/** EgovPropertyService.sample */
    	activityReportVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	activityReportVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(activityReportVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(activityReportVO.getPageUnit());
		paginationInfo.setPageSize(activityReportVO.getPageSize());
		
		activityReportVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		activityReportVO.setLastIndex(paginationInfo.getLastRecordIndex());
		activityReportVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(activityReportVO.getSearchDateFView())){
			activityReportVO.setSearchDateF(activityReportVO.getSearchDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			activityReportVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
			activityReportVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
		}
		if (!"".equals(activityReportVO.getSearchDateTView())){
			activityReportVO.setSearchDateT(activityReportVO.getSearchDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			activityReportVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
			activityReportVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode())){					//Admin
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//등록
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_CHARGER".equals(user.getAuthorCode())){			//담당자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_MNGR".equals(user.getAuthorCode())){				//관리자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_MEMBER".equals(user.getAuthorCode())){		//고객
			activityReportVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//등록
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_SANCTNER".equals(user.getAuthorCode())){	//결재자
			activityReportVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){
				activityReportVO.setSearchPstinstNm(user.getPstinstNm());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001");		//SR등록(결재자 검색 초기용)
				activityReportVO.setSearchStatus(strStatus);
			}
		}
		
		//조회조건은 Default 로 SR번호별로 조회.
		if("".equals(activityReportVO.getSearchCondition()))
			activityReportVO.setSearchCondition("N");	//SR번호별
		
		model.addAttribute("resultList", srActivityReportService.selectSrActivityReport(activityReportVO));
        
		int totCnt = srActivityReportService.selectSrActivityReportTotCnt(activityReportVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
        //모듈코드를 코드정보로부터 조회 - SR0003
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //상태코드를 코드정보로부터 조회 - SR0004
        vo.setCodeId("SR0004");
        model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		
        return "sts/actrt/EgovSrActivityReport";
       
	}
    
    /**
	 * SR Activity Report 을 조회한다
	 * @param ActivityReportVO activityReportVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/sts/actrt/selectSrActivityReport.do")
    @ResponseBody
	public Map<String, Object> selectEgovUserStats(@ModelAttribute("searchVO") ActivityReportVO activityReportVO,
			ModelMap model) throws Exception {


		Map<String, Object> retMap = new HashMap<String, Object> ();
		
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	/** EgovPropertyService.sample */
    	activityReportVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	activityReportVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(activityReportVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(activityReportVO.getPageUnit());
		paginationInfo.setPageSize(activityReportVO.getPageSize());
		
		activityReportVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		activityReportVO.setLastIndex(paginationInfo.getLastRecordIndex());
		activityReportVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
//		if (!"".equals(activityReportVO.getSearchDateFView())){
//			activityReportVO.setSearchDateF(activityReportVO.getSearchDateFView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			activityReportVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
//			activityReportVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
//		}
//		if (!"".equals(activityReportVO.getSearchDateTView())){
//			activityReportVO.setSearchDateT(activityReportVO.getSearchDateTView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			activityReportVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
//			activityReportVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
//		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode())){					//Admin
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//등록
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_CHARGER".equals(user.getAuthorCode())){			//담당자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_MNGR".equals(user.getAuthorCode())){				//관리자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_MEMBER".equals(user.getAuthorCode())){		//고객
			activityReportVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//등록
				strStatus.add("1002");		//접수대기
				strStatus.add("1003");		//접수완료
				strStatus.add("1004");		//해결중
				strStatus.add("1005");		//고객테스트
				strStatus.add("1006");		//완료
				activityReportVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_SANCTNER".equals(user.getAuthorCode())){	//결재자
			activityReportVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(activityReportVO.getSearchAt())){
				activityReportVO.setSearchPstinstNm(user.getPstinstNm());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001");		//SR등록(결재자 검색 초기용)
				activityReportVO.setSearchStatus(strStatus);
			}
		}
		
		//조회조건은 Default 로 SR번호별로 조회.
		if("".equals(activityReportVO.getSearchCondition()))
			activityReportVO.setSearchCondition("N");	//SR번호별
		
		model.addAttribute("resultList", srActivityReportService.selectSrActivityReport(activityReportVO));
		retMap.put("resultList", srActivityReportService.selectSrActivityReport(activityReportVO));
		
		int totCnt = srActivityReportService.selectSrActivityReportTotCnt(activityReportVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
    	
        //모듈코드를 코드정보로부터 조회 - SR0003
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        retMap.put("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //상태코드를 코드정보로부터 조회 - SR0004
        vo.setCodeId("SR0004");
        model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        retMap.put("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		retMap.put("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		
        return retMap;
       
	}

    /**
	 * SR Activity Report 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "sts/actrt/EgovActivityExcelReport"
     * @throws Exception
     */
    @RequestMapping(value="/sts/actrt/EgovActivityExcelReport.do")
	public ModelAndView selectActivityExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ActivityReportVO activityReportVO
			, ModelMap model
			) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(activityReportVO.getSearchDateFView())){
			activityReportVO.setSearchDateF(activityReportVO.getSearchDateFView().replaceAll("-", ""));
		}
		if (!"".equals(activityReportVO.getSearchDateTView())){
			activityReportVO.setSearchDateT(activityReportVO.getSearchDateTView().replaceAll("-", ""));
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) ||
			"ROLE_USER_SANCTNER".equals(user.getAuthorCode())){		//고객, 결제자
			//업체코드 셋팅.
			activityReportVO.setPstinstCode(user.getPstinstCode());
		}else{
			
		}
		
		//고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		
		List activityReportList =  srActivityReportService.excelDownActivityReportList(activityReportVO);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("activityReport", activityReportList);
        
        return new ModelAndView("activityReportExcelView", "activityReportMap", map);
	}
}