package egovframework.let.main.web;

import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.ComDefaultVO;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.SrchargerVO;
import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.08.31  JJY            최초 생성
 *
 * </pre>
 */
@Controller@SessionAttributes(types = ComDefaultVO.class)
public class EgovMainController {
	
	/**
	 * EgovBBSManageService
	 */
	@Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;
	
	@Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;
	
	/** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    /** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
	
	/**
	 * 메인 페이지에서 각 업무 화면으로 연계하는 기능을 제공한다.
	 * 
	 * @param request
	 * @param commandMap
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/cmm/forwardPage.do")
	public String forwardPageWithMenuNo(HttpServletRequest request, Map<String, Object> commandMap)
	  throws Exception{
		return "";
	}

	/**
	 * 템플릿 메인 페이지 조회
	 * @return 메인페이지 정보 Map [key : 항목명]
	 * 
	 * @param request
	 * @param model
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/cmm/main/mainPage.do")
	public String getMgtMainPage(HttpServletRequest request, ModelMap model)
	  throws Exception{
		
		// 공지사항 메인 컨텐츠 조회 시작 ---------------------------------
		BoardVO boardVO = new BoardVO();
		boardVO.setPageUnit(10);
		boardVO.setPageSize(10);
		boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "BBSA02");
		model.addAttribute("notiList", map.get("resultList"));
		
		
		// 공지사항 메인컨텐츠 조회 끝 -----------------------------------
		
		// 업무게시판 메인 컨텐츠 조회 시작 -------------------------------
		boardVO.setPageUnit(5);
		boardVO.setPageSize(10);
		boardVO.setBbsId("BBSMSTR_CCCCCCCCCCCC");
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		model.addAttribute("bbsList", bbsMngService.selectBoardArticles(boardVO, "BBSA02").get("resultList"));
		
		// 업무게시판 메인컨텐츠 조회 끝 -----------------------------------
		
		//return "main/EgovMainView";
		return "main/sample_menu/Sample";
	}
	
	/**
     * Head메뉴를 조회한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "main_headG", "main_head"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuHead.do")
    public String selectMainMenuHead(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception { 
    	
    	LoginVO user = 
    		EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
    		
    	if(EgovUserDetailsHelper.isAuthenticated() && user!=null){
    		menuManageVO.setTmp_Id(user.getId());
        	menuManageVO.setTmp_Password(user.getPassword());
        	menuManageVO.setTmp_UserSe(user.getUserSe());
        	menuManageVO.setTmp_Name(user.getName());
        	menuManageVO.setTmp_Email(user.getEmail());
        	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
        	menuManageVO.setTmp_UniqId(user.getUniqId());
    		model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO));
    		model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO));
    		
    		
//        	//다국어 wbpark 2016.05.24
//        	if("ko".equals(request.getParameter("language"))){
//        		model.addAttribute("srLanguage", "ko");
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//        	}else if("en".equals(request.getParameter("language"))){
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
//        		model.addAttribute("srLanguage", "en");
//        	}else if("cn".equals(request.getParameter("language"))){
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
//        		model.addAttribute("srLanguage", "cn");
//        	}else{
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//        		model.addAttribute("srLanguage", "ko");
//        	}
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
    		//권한코드
    		model.addAttribute("authorCode", user.getAuthorCode());
    		
    	}else{
    		//model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadAnonymous(menuManageVO));
    		//model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftAnonymous(menuManageVO));
    	}
        return "main/inc/EgovIncTopnav"; // 내부업무의 상단메뉴 화면
    }
    
    
    /**
     * 좌측메뉴를 조회한다. 
     * @param menuManageVO MenuManageVO
     * @param vStartP      String
     * @return 출력페이지정보 "main_left"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuLeft.do")
    public String selectMainMenuLeft(@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		HttpServletRequest request,
    		ModelMap model,
    		@RequestParam(value="baseMenuNo", required=false) String baseMenuNo,
			@RequestParam(value="selMenuNo", required=false) String selMenuNo
			,@ModelAttribute("srchargerVO") SrchargerVO srchargerVO
 			,@ModelAttribute("userManageVO") UserManageVO userManageVO)
            throws Exception { 
    	
    	// 선택된 메뉴정보를 세션으로 등록한다.
		if (baseMenuNo!=null && !baseMenuNo.equals("") && !baseMenuNo.equals("null")){
			request.getSession().setAttribute("baseMenuNo",baseMenuNo);
		}
		// 선택된 세부메뉴정보를 세션으로 등록한다.
		if (selMenuNo!=null && !selMenuNo.equals("") && !selMenuNo.equals("null")){
			request.getSession().setAttribute("selMenuNo",selMenuNo);
		}
		
    	LoginVO user = 
    		EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
    		
    	if(EgovUserDetailsHelper.isAuthenticated() && user!=null){
    		menuManageVO.setTmp_Id(user.getId());
        	menuManageVO.setTmp_Password(user.getPassword());
        	menuManageVO.setTmp_UserSe(user.getUserSe());
        	menuManageVO.setTmp_Name(user.getName());
        	menuManageVO.setTmp_Email(user.getEmail());
        	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
        	menuManageVO.setTmp_UniqId(user.getUniqId());
    		model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO));
    		model.addAttribute("menulist", menuManageService.selectMainMenuLeft(menuManageVO));
    		model.addAttribute("childMenulist", menuManageService.selectMainChildMenuLeft(menuManageVO));
    		
//        	//다국어 wbpark 2016.05.24
//        	if("ko".equals(request.getParameter("language"))){
//        		model.addAttribute("srLanguage", "ko");
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//        	}else if("en".equals(request.getParameter("language"))){
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
//        		model.addAttribute("srLanguage", "en");
//        	}else if("cn".equals(request.getParameter("language"))){
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
//        		model.addAttribute("srLanguage", "cn");
//        	}else{
//        		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//        		model.addAttribute("srLanguage", "ko");
//        	}
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
    		//권한코드
    		model.addAttribute("authorCode", user.getAuthorCode());
    		srchargerVO.setPstinstCode(user.getPstinstCode());
    		//모듈담당자정보
    		model.addAttribute("srchargerList", pstinstManageService.selectSrchargerList(srchargerVO));
    		
            //모듈코드를 코드정보로부터 조회 - SR0003
            ComDefaultCodeVO vo = new ComDefaultCodeVO();
            vo.setCodeId("SR0003");
            model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
            
            //담당자 및 관리자 목록
            model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
    		
    	}else{
    		//model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadAnonymous(menuManageVO));
    		//model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftAnonymous(menuManageVO));
    	}
		
      	return "main/inc/incLeftmenu"; 
    }

}