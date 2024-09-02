package egovframework.let.sec.security.userdetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

/**
 * User 클래스의 확장 클래스
 * 
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  ByungHun Woo    최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 * </pre>
 */

public class EgovUserDetails extends User {

	private static final long serialVersionUID = 1L;

	/**
	 * User 클래스의 생성자 Override
	 * @param username 사용자계정
	 * @param password 사용자 패스워드
	 * @param enabled 사용자계정 사용여부
	 * @param accountNonExpired boolean
	 * @param credentialsNonExpired boolean
	 * @param accountNonLocked boolean
	 * @param authorities GrantedAuthority[]
	 * @param egovVO 사용자 VO객체
	 * @throws IllegalArgumentException 
	 */
	public EgovUserDetails(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked, Collection<GrantedAuthority> authorities, Object egovVO)
			throws IllegalArgumentException {
    	
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, authorities);

		this.egovVO = egovVO;
	}
	
	/**
	 * EgovUserDetails 생성자
	 * @param username String
	 * @param password String
	 * @param enabled boolean
	 * @param egovVO 사용자 VO객체
	 * @throws IllegalArgumentException
	 */
	public EgovUserDetails(String username, String password, boolean enabled, Object egovVO)
	    throws IllegalArgumentException {
		this(username, password, enabled, true, true, true, new ArrayList<GrantedAuthority>() { {add(new SimpleGrantedAuthority("HOLDER"));}}, egovVO);
	}

	private Object egovVO;	

	/**
	 * getEgovUserVO
	 * @return 사용자VO 객체
	 */
	public Object getEgovUserVO() {
		return egovVO;
	}

	/**
	 * setEgovUserVO
	 * @param egovVO 사용자VO객체
	 */
	public void setEgovUserVO(Object egovVO) {
		this.egovVO = egovVO;
	}
}
