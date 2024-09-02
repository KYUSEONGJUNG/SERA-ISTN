package egovframework.let.main.service.com.cmm.service;

import java.io.Serializable;

/**
 * 공통상세코드 모델 클래스
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
public class CmmnDetailCode implements Serializable {
	
	/*
	 * 코드ID
	 */
    private String codeId = "";
    
    /*
     * 코드명
     */
    private String codeIdNm = "";
    
    /*
     * 코드
     */
	private String code = "";
	
	/*
	 * 코드명
	 */
    private String codeNm = "";
    
    
    /*
     * 코드명 영어
     */
    private String codeNmEn = "";
    
    /*
     * 코드명 중국어
     */
    private String codeNmCn = "";    
    
    /*
     * 코드설명
     */
    private String codeDc = "";
    
    /*
     * 사용여부
     */
    private String useAt = "";

    /*
     * 최초등록자ID
     */
    private String frstRegisterId = "";
    
    /*
     * 최종수정자ID
     */
    private String lastUpdusrId   = "";
    
	/** 검색-코드ID */
	private String searchCodeId;	
	/** 검색-코드 */
	private String searchCode;
	/** 검색-코드명 */
	private String searchCodeIdNm;    
	
	private String userNm;
	
	private String userNmEn;
	
	
    public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getUserNmEn() {
		return userNmEn;
	}

	public void setUserNmEn(String userNmEn) {
		this.userNmEn = userNmEn;
	}
	
	/**
	 * codeId attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeId() {
		return codeId;
	}

	/**
	 * codeId attribute 값을 설정한다.
	 * @param codeId String
	 */
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	/**
	 * codeIdNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeIdNm() {
		return codeIdNm;
	}

	/**
	 * codeIdNm attribute 값을 설정한다.
	 * @param codeIdNm String
	 */
	public void setCodeIdNm(String codeIdNm) {
		this.codeIdNm = codeIdNm;
	}

	/**
	 * code attribute 를 리턴한다.
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * code attribute 값을 설정한다.
	 * @param code String
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * codeNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeNm() {
		return codeNm;
	}

	/**
	 * codeNm attribute 값을 설정한다.
	 * @param codeNm String
	 */
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	/**
	 * codeDc attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeDc() {
		return codeDc;
	}

	/**
	 * codeDc attribute 값을 설정한다.
	 * @param codeDc String
	 */
	public void setCodeDc(String codeDc) {
		this.codeDc = codeDc;
	}

	/**
	 * useAt attribute 를 리턴한다.
	 * @return String
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt String
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * frstRegisterId attribute 를 리턴한다.
	 * @return String
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId String
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * lastUpdusrId attribute 를 리턴한다.
	 * @return String
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId String
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	public String getSearchCodeId() {
		return searchCodeId;
	}

	public void setSearchCodeId(String searchCodeId) {
		this.searchCodeId = searchCodeId;
	}

	public String getSearchCode() {
		return searchCode;
	}

	public void setSearchCode(String searchCode) {
		this.searchCode = searchCode;
	}

	public String getSearchCodeIdNm() {
		return searchCodeIdNm;
	}

	public void setSearchCodeIdNm(String searchCodeIdNm) {
		this.searchCodeIdNm = searchCodeIdNm;
	}

	public String getCodeNmEn() {
		return codeNmEn;
	}

	public void setCodeNmEn(String codeNmEn) {
		this.codeNmEn = codeNmEn;
	}

	public String getCodeNmCn() {
		return codeNmCn;
	}

	public void setCodeNmCn(String codeNmCn) {
		this.codeNmCn = codeNmCn;
	}
	
	


}
