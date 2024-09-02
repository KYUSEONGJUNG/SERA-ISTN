package egovframework.let.sts.stsfdg.web;

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
import egovframework.let.sts.stsfdg.service.EgovStsfdgSttusService;
import egovframework.let.sts.stsfdg.service.StsfdgSttusVO;
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
public class EgovStsfdgSttusController {

	/** EgovStsfdgSttusService */
	@Resource(name = "stsfdgSttusService")
    private EgovStsfdgSttusService stsfdgSttusService;
	
	/** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovStsfdgSttusController.class);

    /**
	 * 만족도현황을 조회한다
	 * @param searchVO StsfdgSttusVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/stsfdg/selectStsfdgSttus.do")
	public String selectStsfdgSttus(@ModelAttribute("searchVO") StsfdgSttusVO searchVO,
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
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || 
		 "ROLE_USER_SANCTNER".equals(user.getAuthorCode())){		//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());		//자신의 업체만을 볼수있다.
		}	
		
		model.addAttribute("resultList", stsfdgSttusService.selectStsfdgSttus(searchVO));
        
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
				
		int totCnt = stsfdgSttusService.selectStsfdgSttusTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
		model.addAttribute("processRateInfo", searchVO);
		
		//고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		
        return "sts/stsfdg/EgovStsfdgSttus";
	}
    
    /**
	 * 만족도현황을 조회한다
	 * @param searchVO StsfdgSttusVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/sts/stsfdg/selectStsfdgSttus.do")
    @ResponseBody
	public Map<String, Object> selectEgovStsfdgSttus(@ModelAttribute("searchVO") StsfdgSttusVO searchVO,
			HttpServletRequest request,
			HttpSession session,			
			ModelMap model) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();

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
		
//		/** 검색-요청일(접수확인일) */
//		if (!"".equals(searchVO.getSearchDateFView())){
//			searchVO.setSearchDateF(searchVO.getSearchDateFView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			if("".equals(searchVO.getSearchAt())){
//				searchVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
//				searchVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");				
//			}
//		}
//		if (!"".equals(searchVO.getSearchDateTView())){
//			searchVO.setSearchDateT(searchVO.getSearchDateTView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			if("".equals(searchVO.getSearchAt())){
//				searchVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
//				searchVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);				
//			}
//		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		retMap.put("authorCode", user.getAuthorCode());
		
		if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || 
		 "ROLE_USER_SANCTNER".equals(user.getAuthorCode())){		//현업, 결재자
			searchVO.setPstinstCode(user.getPstinstCode());		//자신의 업체만을 볼수있다.
		}	
		
		model.addAttribute("resultList", stsfdgSttusService.selectStsfdgSttus(searchVO));
        retMap.put("resultList", stsfdgSttusService.selectStsfdgSttus(searchVO));
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		retMap.put("authorCode", user.getAuthorCode());
				
		int totCnt = stsfdgSttusService.selectStsfdgSttusTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
    	
		model.addAttribute("processRateInfo", searchVO);
		retMap.put("processRateInfo", searchVO);
		
		//고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		
        return retMap;
	}
    
    /**
	 * SR처리 상세내역 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/sts/stsfdg/EgovStsfdgSttusExcelReport"
     * @throws Exception
     */
    @RequestMapping(value="/sts/stsfdg/EgovStsfdgSttusExcelReport.do")
	public ModelAndView selectSrListExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") StsfdgSttusVO stsfdgSttusVO
			, ModelMap model
			) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
		}else{																//현업, 결재자
			stsfdgSttusVO.setPstinstCode(user.getPstinstCode());
		}	
		
		model.addAttribute("resultList", stsfdgSttusService.selectStsfdgSttus(stsfdgSttusVO));
        
		List stsfdgSttusReportList =  stsfdgSttusService.excelDownSrStsfdgSttusReportList(stsfdgSttusVO);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("stsfdgSttusReport", stsfdgSttusReportList);
        
        return new ModelAndView("stsfdgSttusReportExcelView", "stsfdgSttusReportMap", map);
    }
}