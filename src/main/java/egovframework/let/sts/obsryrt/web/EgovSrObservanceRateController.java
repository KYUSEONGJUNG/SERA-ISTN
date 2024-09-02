package egovframework.let.sts.obsryrt.web;

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
import egovframework.let.sts.obsryrt.service.EgovSrObservanceRateService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;

/**
 * 
 * SR에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author SR리스트 개발팀 박원배
 * @since 2014.08.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.08.20  박원배          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovSrObservanceRateController {
	protected Log log = LogFactory.getLog(this.getClass());
	
	/** SrObservanceRateService */
    @Resource(name = "SrObservanceRateService")
    private EgovSrObservanceRateService srObservanceRateService;
    
    /** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /**
	 * 접수 및 납기준수율을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/sts/obsryrt/EgovSrObservanceRate"
     * @throws Exception
     */
    @RequestMapping(value="/sts/obsryrt/EgovSrObservanceRate.do")
	public String selectSrObservanceRate (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") SrObservanceRateVO searchVO
			, ModelMap model
			, HttpServletRequest request
			, HttpSession session
			) throws Exception {
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
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	//권한코드
    	model.addAttribute("authorCode", user.getAuthorCode());
    	
    	//Admin, 담당자, 관리자
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode()) || "ROLE_MNGR".equals(user.getAuthorCode())){					
			//고객사정보
	        PstinstVO PstinstVO = new PstinstVO();
			model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}
		
		/** 검색-요청일 */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
				searchVO.setSearchConfirmDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");				
			}
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
				searchVO.setSearchConfirmDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
			}
		}
    	
    	model.addAttribute("resultList", srObservanceRateService.selectSrObservanceRate(searchVO));
    	
    	int totCnt = srObservanceRateService.selectSrObservanceRateTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/sts/obsryrt/EgovSrObservanceRate";
	}
    
    /**
	 * 접수 및 납기준수율 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/sts/obsryrt/EgovSrObservanceRate"
     * @throws Exception
     */
    @RequestMapping(value="/sts/obsryrt/EgovSrObservanceRateExcelReport.do")
    public ModelAndView selectSrObservanceRateExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") SrObservanceRateVO searchVO
			, ModelMap model
			, HttpServletRequest request
			, HttpSession session
			) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	searchVO.setSearchConfirmDateFView(searchVO.getSearchConfirmDateF());
    	searchVO.setSearchConfirmDateTView(searchVO.getSearchConfirmDateT());
    	    	
    	//권한코드
    	model.addAttribute("authorCode", user.getAuthorCode());
    	
    	//Admin, 담당자, 관리자
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode()) || "ROLE_MNGR".equals(user.getAuthorCode())){					
//			//고객사정보
//	        PstinstVO PstinstVO = new PstinstVO();
//			model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}
		
		/** 검색-요청일 */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
				searchVO.setSearchConfirmDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");				
			}
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
				searchVO.setSearchConfirmDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
			}
		}
		List srObservanceRateReportList =  srObservanceRateService.excelDownProcessRateReportList(searchVO);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("srObservanceRateReport", srObservanceRateReportList);
        
        return new ModelAndView("srObservanceRateExcelView", "srObservanceRateReportMap", map);
	}
    
    
    /**
	 * 접수 및 납기준수율을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/sts/obsryrt/EgovSrObservanceRate"
     * @throws Exception
     */
    @RequestMapping(value="/select/obsryrt/EgovSrObservanceRate.do")
    @ResponseBody
	public Map<String, Object> selectSrObservanceRateGrid (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") SrObservanceRateVO searchVO
			, ModelMap model
			, HttpServletRequest request
			, HttpSession session
			) throws Exception {
    	Map<String, Object> retMap = new HashMap<String, Object> ();
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
		
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
    	
    	//권한코드
    	model.addAttribute("authorCode", user.getAuthorCode());
    	retMap.put("authorCode", user.getAuthorCode());
    	
    	//Admin, 담당자, 관리자
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode()) || "ROLE_MNGR".equals(user.getAuthorCode())){					
			//고객사정보
	        PstinstVO PstinstVO = new PstinstVO();
			model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
			retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		}else{																//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());
		}
		
		/** 검색-요청일 */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())){
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
				searchVO.setSearchConfirmDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");				
			}
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())){
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			if("".equals(searchVO.getSearchAt())){
				searchVO.setSearchConfirmDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
				searchVO.setSearchConfirmDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
			}
		}
    	
    	model.addAttribute("resultList", srObservanceRateService.selectSrObservanceRate(searchVO));
    	retMap.put("resultList", srObservanceRateService.selectSrObservanceRate(searchVO));
    	
    	int totCnt = srObservanceRateService.selectSrObservanceRateTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
        
        return retMap;
	}
    

}
