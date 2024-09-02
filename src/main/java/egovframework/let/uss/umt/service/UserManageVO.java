package egovframework.let.uss.umt.service;

import java.util.List;

import egovframework.let.sec.ram.service.AuthorManageVO;

/**
 * 업무사용자VO클래스로서 업무사용자관리 비지니스로직 처리용 항목을 구성한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
public class UserManageVO extends UserDefaultVO{
	
	/**
	 * SR-관리자 및 SR-담당자 목록
	 */
	List <UserManageVO> roleChargerList;		

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/** 이전비밀번호 - 비밀번호 변경시 사용*/
    private String oldPassword = "";
    
	/**
	 * 사용자고유아이디
	 */
	private String uniqId="";
	/**
	 * 사용자 유형
	 */
	private String userTy;
	/**
	 * 이메일주소
	 */
	private String emailAdres;
	/**
	 * 사용자 ID
	 */
	private String emplyrId;
	/**
	 * 사용자 명
	 */
	private String emplyrNm;
	/**
	 * 사용자 영문명
	 */
	private String emplyrNmEn;
	/**
	 * 사용자 상태
	 */
	private String emplyrSttusCode;
	/**
	 * 그룹 ID
	 */
	private String groupId;
	/**
	 * 업체코드
	 */
	private String pstinstCode;
	/**
	 * 업체명
	 */
	private String pstinstNm;
	/**
	 * 업체 영문명
	 */
	private String pstinstNmEn;
	/**
	 * 이동전화번호
	 */
	private String moblphonNo;
	/**
	 * 사무실전화번호
	 */
	private String offmTelno;
	/**
	 * 조직 ID
	 */
	private String orgnztId;
	/**
	 * 비밀번호
	 */
	private String password;
	/**
	 * 비밀번호 정답
	 */
	private String passwordCnsr;
	/**
	 * 비밀번호 힌트
	 */
	private String passwordHint;
	
	/**
	 * 권한여부(SR-관리자, Admin만 처리권한 부여)
	 */
	private String authorSe;
	
	/**
	 * 권한코드
	 */
	private String authorCode;
	
	/**
	 * 로그인 언어
	 */
	private String languageCode;
	
	/**
	 * 삭제여부
	 */
	private String delAt;
	
	/**
	 * 생성일자
	 */
	private String frstRegistPnttm;
	
	/**
	 * 변경일자
	 */
	private String lastUpdtPnttm;
	
	/**
	 * 등록여부(권한)
	 */
	private String regYn;
		
	/**
	 * 비고
	 */
	private String note;
	
	/** 검색-업체코드 */
	private String searchPstinstCode;
	/** 검색-업체명 */
	private String searchPstinstNm;
	/** 검색-이름 */
	private String searchUserNm;
	/** 검색-아이디 */
	private String searchEmplyrId;
	/** 검색-등록일 */
	private String searchFrstRegistPnttm;
	/** 검색-삭제여부 */
	private String searchDelAt;
	/**이메일 여부**/
	private String emailYn;
	/**이메일 서명**/
	private String emailSignature;
	

	public String getEmailSignature() {
		return emailSignature;
	}
	public void setEmailSignature(String emailSignature) {
		this.emailSignature = emailSignature;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	/**
	 * oldPassword attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOldPassword() {
		return oldPassword;
	}
	/**
	 * oldPassword attribute 값을 설정한다.
	 * @param oldPassword String
	 */
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	/**
	 * uniqId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId String
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	/**
	 * userTy attribute 값을  리턴한다.
	 * @return String
	 */
	public String getUserTy() {
		return userTy;
	}
	/**
	 * userTy attribute 값을 설정한다.
	 * @param userTy String
	 */
	public void setUserTy(String userTy) {
		this.userTy = userTy;
	}
	/**
	 * emailAdres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmailAdres() {
		return emailAdres;
	}
	/**
	 * emailAdres attribute 값을 설정한다.
	 * @param emailAdres String
	 */
	public void setEmailAdres(String emailAdres) {
		this.emailAdres = emailAdres;
	}
	/**
	 * emplyrId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrId() {
		return emplyrId;
	}
	/**
	 * emplyrId attribute 값을 설정한다.
	 * @param emplyrId String
	 */
	public void setEmplyrId(String emplyrId) {
		this.emplyrId = emplyrId;
	}
	/**
	 * emplyrNm attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrNm() {
		return emplyrNm;
	}
	/**
	 * emplyrNm attribute 값을 설정한다.
	 * @param emplyrNm String
	 */
	public void setEmplyrNm(String emplyrNm) {
		this.emplyrNm = emplyrNm;
	}
	/**
	 * emplyrSttusCode attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrSttusCode() {
		return emplyrSttusCode;
	}
	/**
	 * emplyrSttusCode attribute 값을 설정한다.
	 * @param emplyrSttusCode String
	 */
	public void setEmplyrSttusCode(String emplyrSttusCode) {
		this.emplyrSttusCode = emplyrSttusCode;
	}
	/**
	 * groupId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * groupId attribute 값을 설정한다.
	 * @param groupId String
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * moblphonNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMoblphonNo() {
		return moblphonNo;
	}
	/**
	 * moblphonNo attribute 값을 설정한다.
	 * @param moblphonNo String
	 */
	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}
	/**
	 * offmTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOffmTelno() {
		return offmTelno;
	}
	/**
	 * offmTelno attribute 값을 설정한다.
	 * @param offmTelno String
	 */
	public void setOffmTelno(String offmTelno) {
		this.offmTelno = offmTelno;
	}
	/**
	 * orgnztId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * orgnztId attribute 값을 설정한다.
	 * @param orgnztId String
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * password attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * password attribute 값을 설정한다.
	 * @param password String
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * passwordCnsr attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPasswordCnsr() {
		return passwordCnsr;
	}
	/**
	 * passwordCnsr attribute 값을 설정한다.
	 * @param passwordCnsr String
	 */
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}
	/**
	 * passwordHint attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPasswordHint() {
		return passwordHint;
	}
	/**
	 * passwordHint attribute 값을 설정한다.
	 * @param passwordHint String
	 */
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	
	/**
	 * 권한여부(SR-관리자, Admin만 처리권한 부여) 설정한다.
	 * @return
	 */	
	public String getAuthorSe() {
		return authorSe;
	}
	/**
	 * 권한여부(SR-관리자, Admin만 처리권한 부여) 리턴한다.
	 * @return
	 */
	public void setAuthorSe(String authorSe) {
		this.authorSe = authorSe;
	}
	public String getPstinstCode() {
		return pstinstCode;
	}
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}
	public String getAuthorCode() {
		return authorCode;
	}
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	public String getDelAt() {
		return delAt;
	}
	public void setDelAt(String delAt) {
		this.delAt = delAt;
	}
	public String getFrstRegistPnttm() {
		return frstRegistPnttm;
	}
	public void setFrstRegistPnttm(String frstRegistPnttm) {
		this.frstRegistPnttm = frstRegistPnttm;
	}
	public String getLastUpdtPnttm() {
		return lastUpdtPnttm;
	}
	public void setLastUpdtPnttm(String lastUpdtPnttm) {
		this.lastUpdtPnttm = lastUpdtPnttm;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getSearchPstinstCode() {
		return searchPstinstCode;
	}
	public void setSearchPstinstCode(String searchPstinstCode) {
		this.searchPstinstCode = searchPstinstCode;
	}
	public String getSearchUserNm() {
		return searchUserNm;
	}
	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
	}
	public String getSearchEmplyrId() {
		return searchEmplyrId;
	}
	public void setSearchEmplyrId(String searchEmplyrId) {
		this.searchEmplyrId = searchEmplyrId;
	}
	public String getSearchFrstRegistPnttm() {
		return searchFrstRegistPnttm;
	}
	public void setSearchFrstRegistPnttm(String searchFrstRegistPnttm) {
		this.searchFrstRegistPnttm = searchFrstRegistPnttm;
	}
	public String getPstinstNm() {
		return pstinstNm;
	}
	public void setPstinstNm(String pstinstNm) {
		this.pstinstNm = pstinstNm;
	}
	public String getSearchPstinstNm() {
		return searchPstinstNm;
	}
	public void setSearchPstinstNm(String searchPstinstNm) {
		this.searchPstinstNm = searchPstinstNm;
	}
	public String getRegYn() {
		return regYn;
	}
	public void setRegYn(String regYn) {
		this.regYn = regYn;
	}
	public String getSearchDelAt() {
		return searchDelAt;
	}
	public void setSearchDelAt(String searchDelAt) {
		this.searchDelAt = searchDelAt;
	}
	public List<UserManageVO> getRoleChargerList() {
		return roleChargerList;
	}
	public void setRoleChargerList(List<UserManageVO> roleChargerList) {
		this.roleChargerList = roleChargerList;
	}
	public String getEmplyrNmEn() {
		return emplyrNmEn;
	}
	public void setEmplyrNmEn(String emplyrNmEn) {
		this.emplyrNmEn = emplyrNmEn;
	}
	public String getPstinstNmEn() {
		return pstinstNmEn;
	}
	public void setPstinstNmEn(String pstinstNmEn) {
		this.pstinstNmEn = pstinstNmEn;
	}
	public String getLanguageCode() {
		return languageCode;
	}
	public void setLanguageCode(String languageCode) {
		this.languageCode = languageCode;
	}
	
	
	
	
}