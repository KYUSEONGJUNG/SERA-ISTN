package egovframework.let.sts.prcrt.web;

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

import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sts.prcrt.service.EgovSrProcessRateService;
import egovframework.let.sts.prcrt.service.ProcessRateVO;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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
public class EgovSrProcessRateController {

	/** EgovSrProcessRateService */
	@Resource(name = "srProcessRateService")
    private EgovSrProcessRateService srProcessRateService;
	
	/** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovSrProcessRateController.class);

    /**
	 * SR처리율을 조회한다
	 * @param statsVO ProcessRateVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/prcrt/selectSrProcessRate.do")
	public String selectSrProcessRate(@ModelAttribute("searchVO") ProcessRateVO searchVO
			,@ModelAttribute("userManageVO") UserManageVO userManageVO
			, HttpServletRequest request
			, HttpSession session			
			,ModelMap model) throws Exception {
    	
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
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchDateFView())){
			searchVO.setSearchDateF(searchVO.getSearchDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
				searchVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");				
			}
		}
		if (!"".equals(searchVO.getSearchDateTView())){
			searchVO.setSearchDateT(searchVO.getSearchDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
				searchVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
			}
		}
		
//		/** 검색-완료일 */
//		if (!"".equals(searchVO.getSearchCompleteDateFView())){
//			searchVO.setSearchCompleteDateF(searchVO.getSearchCompleteDateFView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			if("".equals(searchVO.getSearchAt())){
//				searchVO.setSearchCompleteDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
//				searchVO.setSearchCompleteDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
//			}
//		}
//		if (!"".equals(searchVO.getSearchCompleteDateTView())){
//			searchVO.setSearchCompleteDateT(searchVO.getSearchCompleteDateTView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			if("".equals(searchVO.getSearchAt())){
//				searchVO.setSearchCompleteDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
//				searchVO.setSearchCompleteDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
//			}
//		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
			
			//고객사정보
	        PstinstVO PstinstVO = new PstinstVO();
			model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
			
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", srProcessRateService.selectSrProcessRate(searchVO));
        
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
				
		int totCnt = srProcessRateService.selectSrProcessRateTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
		model.addAttribute("processRateInfo", searchVO);
		
		//담당자 및 관리자 목록
        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
		
        return "sts/prcrt/EgovSrProcessRate";
	}
    
    
    
    /**
	 * SR처리율 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "sts/prcrt/EgovSrProcessRate"
     * @throws Exception
     */
    @RequestMapping(value="/sts/prcrt/EgovProcessRateExcelReport.do")
	public ModelAndView selectSrListExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ProcessRateVO searchVO
			, ModelMap model
			) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchDateFView())){
			searchVO.setSearchDateF(searchVO.getSearchDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchDateTView())){
			searchVO.setSearchDateT(searchVO.getSearchDateTView().replaceAll("-", ""));
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
			
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}	
		
		List processRateReportList =  srProcessRateService.excelDownProcessRateReportList(searchVO);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("processRateReport", processRateReportList);
        
        return new ModelAndView("processRateReportExcelView", "processRateReportMap", map);
	}
    
    /**
	 * SR처리율을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
    @RequestMapping(value = "/select/prcrt/EgovSrProcessRate.do")
    @ResponseBody
    public Map<String, Object> selectEgovSrProcessRate(@ModelAttribute("searchVO") ProcessRateVO searchVO
			,@ModelAttribute("userManageVO") UserManageVO userManageVO
			, HttpServletRequest request
			, HttpSession session			
			,ModelMap model) throws Exception {
    	
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
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchDateFView())){
			searchVO.setSearchDateF(searchVO.getSearchDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchDateTView())){
			searchVO.setSearchDateT(searchVO.getSearchDateTView().replaceAll("-", ""));
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
			
			//고객사정보
	        PstinstVO PstinstVO = new PstinstVO();
			model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
			retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
			
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", srProcessRateService.selectSrProcessRate(searchVO));
        
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
				
		int totCnt = srProcessRateService.selectSrProcessRateTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
		model.addAttribute("processRateInfo", searchVO);
		
		//담당자 및 관리자 목록
        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
        
        retMap.put("resultList", srProcessRateService.selectSrProcessRate(searchVO));
        retMap.put("authorCode", user.getAuthorCode());
        retMap.put("paginationInfo", paginationInfo);
        retMap.put("processRateInfo", searchVO);
        retMap.put("chargerList", userManageService.selectChargerList(userManageVO));
        
    	
    	return retMap;
    	
    }
}