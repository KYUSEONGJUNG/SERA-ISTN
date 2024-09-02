package egovframework.let.uat.uia.web;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.utl.sim.service.EgovClntInfo;

import org.apache.commons.collections.map.HashedMap;
import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.security.crypto.password.PasswordEncoder;
/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovLoginController {

	 
	 
	
    /** EgovLoginService */
	@Resource(name = "loginService")
    private EgovLoginService loginService;
	
	/** EgovCmmUseService */
	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** EgovLoginPolicyService */
	@Resource(name="egovLoginPolicyService")
	EgovLoginPolicyService egovLoginPolicyService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /** TRACE */
    @Resource(name="leaveaTrace") 
    LeaveaTrace leaveaTrace;
    
	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {
    	
//    	//다국어 wbpark 2016.05.24
//    	if(loginVO.getLanguage().equals("ko")){
//    		model.addAttribute("srLanguage", "ko");
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//    	}else if(loginVO.getLanguage().equals("en")){
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
//    		model.addAttribute("srLanguage", "en");
//    	}else if(loginVO.getLanguage().equals("cn")){
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
//    		model.addAttribute("srLanguage", "cn");
//    	}else{
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//    		model.addAttribute("srLanguage", "ko");
//    	}
    	
    	return "uat/uia/EgovLoginUsr";
	}
	
    /**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionSecurityLogin.do")
    public String actionSecurityLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
    		                   HttpServletRequest request, HttpServletResponse response,
    		                   ModelMap model)
            throws Exception {
    	
//    	//다국어 wbpark 2016.05.24
//    	if(loginVO.getLanguage().equals("ko")){
//    		model.addAttribute("srLanguage", "ko");
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//    	}else if(loginVO.getLanguage().equals("en")){
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
//    		model.addAttribute("srLanguage", "en");
//    	}else if(loginVO.getLanguage().equals("cn")){
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
//    		model.addAttribute("srLanguage", "cn");
//    	}else{
//    		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
//    		model.addAttribute("srLanguage", "ko");
//    	}
    	
    	// 접속IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	
    	loginVO.setPassword(request.getParameter("password"));
    	// 1. 일반 로그인 처리
        LoginVO resultVO = loginService.actionLogin(loginVO);
        
        loginVO.setLanguage(resultVO.getLanguage());
        loginVO.setLanguageCode(resultVO.getLanguage());
        //다국어
//        request.getSession().setAttribute("language", loginVO.getLanguage());
        request.getSession().setAttribute("language", resultVO.getLanguage());		//db에 저장된 사용자 국가 사용 2017.02.27
        
        if(null == resultVO.getLanguage() || "".equals(resultVO.getLanguage()) || "ko".equals(resultVO.getLanguage())) {        	
        	Locale.setDefault(Locale.KOREA);        	
        }else if("cn".equals(resultVO.getLanguage())){
        	Locale.setDefault(Locale.CHINA);
    	}else if ("en".equals(resultVO.getLanguage())){
    		Locale.setDefault(Locale.US); 
    	}else {
    		Locale.setDefault(Locale.KOREA);
    	}
        
        boolean loginPolicyYn = true;
        
        LoginPolicyVO loginPolicyVO = new LoginPolicyVO();        
		loginPolicyVO.setEmplyrId(resultVO.getId());
		loginPolicyVO = egovLoginPolicyService.selectLoginPolicy(loginPolicyVO);

		if (loginPolicyVO == null) {
		    loginPolicyYn = true;
		} else {
		    if (loginPolicyVO.getLmttAt().equals("Y")) {
				if (!userIp.equals(loginPolicyVO.getIpInfo())) {
				    loginPolicyYn = false;
				}
		    }
		}
        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {

            // 2. spring security 연동
        	request.getSession().setAttribute("LoginVO", resultVO);
        	//return "redirect:/j_spring_security_check?j_username=" + resultVO.getUserSe() + resultVO.getId() + "&j_password=" + resultVO.getUniqId();
    		//2024.02.21 spring security 연동변경
        	UsernamePasswordAuthenticationFilter springSecurity = null;
        	
        	ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
        	@SuppressWarnings("rawtypes")
        	Map beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
        	if (beans.size() > 0) {
        		springSecurity = (UsernamePasswordAuthenticationFilter)beans.values().toArray()[0];
        	} else {
        		throw new IllegalStateException("No AuthenticationProcessingFilter");
        	}
         
        	springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)
        	springSecurity.doFilter(
        		new RequestWrapperForSecurity(request, resultVO.getUserSe() + resultVO.getId() , resultVO.getUniqId()), 
        		response, null);
        	
        	return null;
        } else {
        	
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
        }
    } 
    
    /**
	 * 로그인 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionMain.do")
	public String actionMain(HttpServletRequest request, ModelMap model) 
			throws Exception {
    	// 1. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
    	
		// 2. 메인 페이지 이동
//		return "forward:/cmm/main/mainPage.do";    	
		return "forward:/sr/EgovSrList.do";    	
	}
    
    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) 
			throws Exception {
    	try{
    	    request.getSession().setAttribute("LoginVO", null);
    	    request.getSession().invalidate();
    	    SecurityContextHolder.clearContext();
		} catch (Exception e) {
			// 1. Security 연동
			leaveaTrace.trace("fail.common.msg", this.getClass());
		}
    	//return "redirect:/j_spring_security_logout";
    	return "redirect:/uat/uia/egovLoginUsr.do";
    }
    
    /**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param 
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model, HttpServletRequest request) 
			throws Exception {
		
		//다국어
        request.getSession().setAttribute("language", loginVO.getLanguage());
            	
    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
		// 1. 비밀번호 힌트 공통코드 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM022");
		List code = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("pwhtCdList", code);
		
		return "/uat/uia/EgovIdPasswordSearch";
	}

	/**
	 * //다국어 wbpark 2016.05.24    	
	 * @param model
	 * @param request
	 */
	private void getLanguage(ModelMap model, HttpServletRequest request) {
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
	}
	
	/**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/searchId.do")
    public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
    	if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
//    		return "egovframework/com/cmm/egovError";
    		return "cmm/error/egovError";
    	}
    	
    	// 1. 아이디 찾기
    	loginVO.setName(loginVO.getName().replaceAll(" ", ""));
        LoginVO resultVO = loginService.searchId(loginVO);
        
        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
        	
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "ID is " + resultVO.getId());
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "您的用户名为 " + resultVO.getId());
        	}else{
        		model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
        	}
        	return "uat/uia/EgovIdPasswordResult";
        } else {
//        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "아이디를 찾을수 없습니다");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "Cannot find ID");
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "找不到用户名。");
        	}else{
        		model.addAttribute("resultInfo", "아이디를 찾을수 없습니다");
        	}
        	
        	return "uat/uia/EgovIdPasswordResult";
        }
    }
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/searchPassword.do")
    public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
    	if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("")
    		&& loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("")
    		&& loginVO.getPasswordCnsr() == null || loginVO.getPasswordCnsr().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
    		return "cmm/error/egovError";
    	}
    	
    	// 1. 비밀번호 찾기
//        boolean result = loginService.searchPassword(loginVO);
    	LoginVO resultVO = loginService.searchPassword(loginVO);
        
        // 2. 결과 리턴
//        if (result) {
//        	model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
    	if (resultVO != null && resultVO.getNewpassword() != null) {    		
    		if("ko".equals((String)request.getSession().getAttribute("language"))){
    			model.addAttribute("resultInfo", "임시 비밀번호는 " + resultVO.getNewpassword() + " 입니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "A temporary password is " + resultVO.getId());
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "您的临时密码为 " + resultVO.getId());
        	}else{
        		model.addAttribute("resultInfo", "임시 비밀번호는 " + resultVO.getNewpassword() + " 입니다.");
        	}
        	return "uat/uia/EgovIdPasswordResult";
        } else {
//        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "비밀번호를 찾을수 없습니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "Cannot find Password.");
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		model.addAttribute("resultInfo", "密码不正确，请再次确认。");
        	}else{
        		model.addAttribute("resultInfo", "비밀번호를 찾을수 없습니다.");
        	}        	
        	return "uat/uia/EgovIdPasswordResult";
        }
    }
    
    /**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
    @RequestMapping(value="/select/uat/uia/searchId.do")
    @ResponseBody
    public Map<String, Object> searchIdAjax(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
    		retMap.put("resultInfo", "loginVO 값이 없습니다.");
    		return retMap;
    	}
    	
    	// 1. 아이디 찾기
    	loginVO.setName(loginVO.getName().replaceAll(" ", ""));
        LoginVO resultVO = loginService.searchId(loginVO);
        
        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
        	
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "ID is " + resultVO.getId());
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "您的用户名为 " + resultVO.getId());
        	}else{
        		retMap.put("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
        	}
        	
        	return retMap;
        } else {
//        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "아이디를 찾을수 없습니다");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "Cannot find ID");
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "找不到用户名。");
        	}else{
        		retMap.put("resultInfo", "아이디를 찾을수 없습니다");
        	}

        	return retMap;
        }
    }
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
    @RequestMapping(value="/select/uia/searchPassword.do")
    @ResponseBody
    public Map<String, Object> searchPasswordAjax(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("")
    		&& loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("")
    		&& loginVO.getPasswordCnsr() == null || loginVO.getPasswordCnsr().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
    		retMap.put("resultInfo", "loginVO 값이 없습니다.");
    		return retMap;
    	}
    	
    	// 1. 비밀번호 찾기
//        boolean result = loginService.searchPassword(loginVO);
    	LoginVO resultVO = loginService.searchPassword(loginVO);
        
        // 2. 결과 리턴
//        if (result) {
//        	model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
    	if (resultVO != null && resultVO.getNewpassword() != null) {    		
    		if("ko".equals((String)request.getSession().getAttribute("language"))){
    			retMap.put("resultInfo", "임시 비밀번호는 " + resultVO.getNewpassword() + " 입니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "A temporary password is " + resultVO.getId());
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "您的临时密码为 " + resultVO.getId());
        	}else{
        		retMap.put("resultInfo", "임시 비밀번호는 " + resultVO.getNewpassword() + " 입니다.");
        	}
        	return retMap;
        } else {
//        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
        	if("ko".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "비밀번호를 찾을수 없습니다.");
        	}else if("en".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "Cannot find Password.");
        	}else if("cn".equals((String)request.getSession().getAttribute("language"))){
        		retMap.put("resultInfo", "密码不正确，请再次确认。");
        	}else{
        		retMap.put("resultInfo", "비밀번호를 찾을수 없습니다.");
        	}        	
        	return retMap;
        }
    }
    
    
    class RequestWrapperForSecurity extends HttpServletRequestWrapper {	
    	private String username = null;
    	private String password = null;
     
    	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
    		super(request);
     
    		this.username = username;
    		this.password = password;
    	}
     
    	@Override
    	public String getRequestURI() {
    		return ((HttpServletRequest)super.getRequest()).getContextPath() + "/j_spring_security_check";
    	}
    	
    	@Override
    	public String getServletPath() {
    		return "/j_spring_security_check";
    	}
    	
    	@Override
    	public String getParameter(String name) {
            if (name.equals("j_username")) {
            	return username;
            }
            
            if(name.equals("username")) {
            	return username;
            }
            
            if (name.equals("j_password")) {
            	return password;
            }
     
            return super.getParameter(name);
        }
    }
}