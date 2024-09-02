package egovframework.let.main.service.com.cmm.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

//import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import egovframework.let.main.service.com.cmm.LoginVO;

import org.egovframe.rte.fdl.security.userdetails.EgovUserDetails;
import org.egovframe.rte.fdl.string.EgovObjectUtil;

/**
 * EgovUserDetails Helper 클래스
 * 
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon    최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 * </pre>
 */

public class EgovUserDetailsHelper {

	    //Logger log = Logger.getLogger(this.getClass());
		//로그인 객체
		static LoginVO loginVO = new LoginVO();
		/**
		 * 인증된 사용자객체를 VO형식으로 가져온다.
		 * @return Object - 사용자 ValueObject
		 */
		public static Object getAuthenticatedUser() {
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				return null;
			}
			EgovUserDetails details = (EgovUserDetails) authentication.getPrincipal();

			//return loginVO;
			return details.getEgovUserVO();
		}

		/**
		 * 인증된 사용자의 권한 정보를 가져온다.
		 * 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
		 * @return List - 사용자 권한정보 목록
		 */
		public static List<String> getAuthorities() {
			List<String> listAuth = new ArrayList<String>();
			
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				// log.debug("## authentication object is null!!");
				return null;
			}
			
//			GrantedAuthority[] authorities = authentication.getAuthorities();
//
//			for (int i = 0; i < authorities.length; i++) {
//				listAuth.add(authorities[i].getAuthority());
//
//				// log.debug("## EgovUserDetailsHelper.getAuthorities : Authority is " + authorities[i].getAuthority());
//			}
			//24.2.20 버전 업그레이드로 인하여 소스 변경
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) authentication.getAuthorities();
			 
			for (GrantedAuthority authority : authorities) {
				listAuth.add(authority.getAuthority());
			}
			return listAuth;
		}
		
		/**
		 * 인증된 사용자 여부를 체크한다.
		 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
		 */
		public static Boolean isAuthenticated() {
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				// log.debug("## authentication object is null!!");
				return Boolean.FALSE;
			}
			
			String username = authentication.getName();
			if (username.equals("anonymousUser")) {		// 기존 2.0.8의 경우 'roleAnonymous'
				// log.debug("## username is " + username);
				return Boolean.FALSE;
			}
 
			Object principal = authentication.getPrincipal();
			
			return Boolean.valueOf(!EgovObjectUtil.isNull(principal));
		}
}
