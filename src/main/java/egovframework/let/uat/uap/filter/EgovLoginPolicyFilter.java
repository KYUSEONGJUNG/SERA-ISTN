package egovframework.let.uat.uap.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.utl.sim.service.EgovClntInfo;
/**
 * 로그인 정책 체크 필터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  
 *  </pre>
 */


public class EgovLoginPolicyFilter implements Filter {

	private FilterConfig config;
	
    final private Log logger = LogFactory.getLog(this.getClass());

	public void destroy() {

	}

	
	/**
	 * IP를 이용해 로그인을 제한하는 메서든
	 * @param request
	 * @param response
	 * @param chain
	 * @return void
	 * @exception IOException, ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		EgovLoginPolicyService egovLoginPolicyService = (EgovLoginPolicyService) act.getBean("egovLoginPolicyService");	
		EgovMessageSource egovMessageSource = (EgovMessageSource)act.getBean("egovMessageSource"); 
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;

		String id = request.getParameter("id");
		//String password = request.getParameter("password");
		String userSe = request.getParameter("userSe");
		String userIp = "";

		if (id == null || userSe == null) {//if (id == null || password == null || userSe == null) {
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do");
			return;
		}

		// 1. LoginVO를 DB로 부터 가져오는 과정

		try {
			// 접속IP
			userIp = EgovClntInfo.getClntIP((HttpServletRequest) request);

			boolean loginPolicyYn = true;

			LoginPolicyVO loginPolicyVO = new LoginPolicyVO();
			loginPolicyVO.setEmplyrId(id);
			loginPolicyVO = egovLoginPolicyService
					.selectLoginPolicy(loginPolicyVO);

			if (loginPolicyVO == null) {
				loginPolicyYn = true;
			} else {
				if (loginPolicyVO.getLmttAt().equals("Y")) {
					if (!userIp.equals(loginPolicyVO.getIpInfo())) {
						loginPolicyYn = false;
					}
				}
			}

			if (loginPolicyYn) {
				chain.doFilter(request, response);

			} else {
				((HttpServletRequest) request).setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
				((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do");
				return;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("Exception:  "  +  e.getClass().getName());  
			logger.error("Exception  Message:  "  +  e.getMessage());
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do?login_error=1");
			return;
		}

		

	}

	public void init(FilterConfig config) throws ServletException {

		this.config = config;

	}

}
