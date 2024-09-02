package egovframework.let.sts.mprcstsc.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.CmmnDetailCode;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sts.mprcstsc.service.EgovSrMinbyProcessSttusChargeService;
import egovframework.let.sts.mprcstsc.service.MinbyProcessSttusChargeVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;

/**
 * 접속 통계 검색 컨트롤러 클래스
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
public class EgovSrMinbyProcessSttusChargeController {

	/** EgovSrMinbyProcessSttusChargeService */
	@Resource(name = "srMinbyProcessSttusChargeService")
    private EgovSrMinbyProcessSttusChargeService srMinbyProcessSttusChargeService;
	
	/** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovSrMinbyProcessSttusChargeController.class);

    /**
	 * 담당자별 SR월별 처리현황을 조회한다
	 * @param searchVO MinbyProcessSttusVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/mprcstsc/selectSrMinbyProcessSttusCharge.do")
	public String selectSrMinbyProcessSttusCharge(@ModelAttribute("searchVO") MinbyProcessSttusChargeVO searchVO,
			HttpServletRequest request,
			HttpSession session,
			ModelMap model) throws Exception {

    	//다국어 wbpark 2016.05.24    	
    	String language = (String)request.getSession().getAttribute("language");
    	if("ko".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
    		model.addAttribute("srLanguage", "ko");
    	}else if("en".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
    		model.addAttribute("srLanguage", "en");
    	}else if("cn".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
    		model.addAttribute("srLanguage", "cn");
    	}else{
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
    		model.addAttribute("srLanguage", "ko");
    	}
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		// 현재년도로부터 5년전까지의 연도 리스트를 셋팅.
		Calendar car = Calendar.getInstance();
		int iYear = car.get(Calendar.YEAR);
		ArrayList yearList = new ArrayList();

		for(int i = 0 ; i<5 ; i++){
			yearList.add(iYear--);
		}
		
		// 년도리스트.
		model.addAttribute("year_list", yearList);
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		//검색에 의한 조회 아닐때 초기값 부여
		if("".equals(searchVO.getSearchAt())){
			searchVO.setSearchYear(String.valueOf(car.get(Calendar.YEAR)));		//현재년도 셋팅.
			searchVO.setSearchDateCondition("C");								//집계기준 :완료일기준
			searchVO.setSearchCountCondition("C");								//집계대상 : 건수
		}
				
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", srMinbyProcessSttusChargeService.selectSrMinbyProcessSttusCharge(searchVO));
        
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
				
//		int totCnt = srMinbyProcessSttusService.selectSrMinbyProcessSttusTotCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//        model.addAttribute("paginationInfo", paginationInfo);
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
    	
		// 모듈코드를 코드정보로부터 조회 - SR0003
				ComDefaultCodeVO vo = new ComDefaultCodeVO();
				vo.setCodeId("SR0003");
				vo.setPstinstCode(user.getPstinstCode());
				List<CmmnDetailCode> moduleCode = cmmUseService.selectCmmCodeDetail(vo);
				model.addAttribute("moduleCode_result", moduleCode);
				
        return "sts/mprcstsc/EgovSrMinbyProcessSttusCharge";
	}
    
    
    /**
	 * 담당자별 SR처리 상세내역 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/sts/mprcstsc/EgovMinbyProcessSttusChargeExcelReport"
     * @throws Exception
     */
    @RequestMapping(value="/sts/mprcstsc/EgovMinbyProcessSttusChargeExcelReport.do")
	public ModelAndView selectSrListExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") MinbyProcessSttusChargeVO minbyProcessSttusChargeVO
			, ModelMap model
			) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
		}else{																//현업, 결재자
			minbyProcessSttusChargeVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", srMinbyProcessSttusChargeService.selectSrMinbyProcessSttusCharge(minbyProcessSttusChargeVO));
        
		List minbyProcessSttusChargeReportList =  srMinbyProcessSttusChargeService.excelDownSrMinbyProcessSttusChargeReportList(minbyProcessSttusChargeVO);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("minbyProcessSttusChargeReport", minbyProcessSttusChargeReportList);
        
        return new ModelAndView("minbyProcessSttusChargeReportExcelView", "minbyProcessSttusChargeReportMap", map);
	}
    
    
    /**
	 * 담당자별 SR월별 처리현황을 조회한다
	 * @param searchVO MinbyProcessSttusChargeVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/mprcstsc/selectSrMinbyProcessSttusCharge.do")
    @ResponseBody
	public Map<String, Object> selectMinbyProcessSttusCharge(@ModelAttribute("searchVO") MinbyProcessSttusChargeVO searchVO,
			HttpServletRequest request,
			HttpSession session,
			ModelMap model) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();
    	
    	//다국어 wbpark 2016.05.24    	
    	String language = (String)request.getSession().getAttribute("language");
    	if("ko".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
    		model.addAttribute("srLanguage", "ko");
    		retMap.put("srLanguage", "ko");
    	}else if("en".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
    		model.addAttribute("srLanguage", "en");
    		retMap.put("srLanguage", "en");
    	}else if("cn".equals(language)){
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
    		model.addAttribute("srLanguage", "cn");
    		retMap.put("srLanguage", "cn");
    	}else{
    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
    		model.addAttribute("srLanguage", "ko");
    		retMap.put("srLanguage", "ko");
    	}
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		// 현재년도로부터 5년전까지의 연도 리스트를 셋팅.
		Calendar car = Calendar.getInstance();
		int iYear = car.get(Calendar.YEAR);
		ArrayList yearList = new ArrayList();

		for(int i = 0 ; i<5 ; i++){
			yearList.add(iYear--);
		}
		
		// 년도리스트.
		model.addAttribute("year_list", yearList);
		retMap.put("year_list", yearList);
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		retMap.put("authorCode", user.getAuthorCode());
		
		//검색에 의한 조회 아닐때 초기값 부여
		if("".equals(searchVO.getSearchAt())){
			searchVO.setSearchYear(String.valueOf(car.get(Calendar.YEAR)));		//현재년도 셋팅.
			searchVO.setSearchDateCondition("C");								//집계기준 : 완료일기준
			searchVO.setSearchCountCondition("C");								//집계대상 : 건수
		}
				
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", srMinbyProcessSttusChargeService.selectSrMinbyProcessSttusCharge(searchVO));
		retMap.put("resultList", srMinbyProcessSttusChargeService.selectSrMinbyProcessSttusCharge(searchVO));
        
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		retMap.put("authorCode", user.getAuthorCode());
				
//		int totCnt = srMinbyProcessSttusService.selectSrMinbyProcessSttusTotCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//        model.addAttribute("paginationInfo", paginationInfo);
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
    	
		// 모듈코드를 코드정보로부터 조회 - SR0003
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SR0003");
		vo.setPstinstCode(user.getPstinstCode());
		List<CmmnDetailCode> moduleCode = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("moduleCode_result", moduleCode);
		
        return retMap;
	}
}