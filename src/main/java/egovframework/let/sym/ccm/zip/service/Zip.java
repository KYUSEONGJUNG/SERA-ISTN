package egovframework.let.sym.ccm.zip.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 우편번호 모델 클래스
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
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
public class Zip implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/*
	 * 우편번호
	 */
    private String zip            = "";
    
    /*
     * 일련번호
     */
    private int    sn             = 0;
    
    /*
     * 시도명
     */
	private String ctprvnNm       = "";
	
	/*
	 * 시군구명
	 */
    private String signguNm       = "";
    
    /*
     * 읍면동명
     */
    private String emdNm          = "";
    
    /*
     * 리건물명
     */
    private String liBuldNm      = "";
    
    /*
     * 도로명
     */
    private String loadNm      = "";
    
    /*
     * 번지동호
     */
    private String lnbrDongHo     = "";
    
    /*
     * 구-리건물명
     */
    private String liBuldNmOld      = "";
    
    /*
     * 구-번지동호
     */
    private String lnbrDongHoOld     = "";

    /*
     * 최초등록자ID
     */
    private String frstRegisterId = "";
    
    /*
     * 최종수정자ID
     */
    private String lastUpdusrId   = "";
    
    /** 검색-우편번호 */
	private String searchZip;	
	/** 검색-시도명 */
	private String searchCtprvnNm;
	/** 검색-시군구명 */
	private String searchSignguNm;	
	/** 검색-읍면동명 */
	private String searchEmdNm;	
	/** 검색-리건물명 */
	private String searchLiBuldNm;	
	/** 검색-도로명 */
	private String searchLoadNm;				
	/** 검색-번지동호 */
	private String searchLnbrDongHo;				
	/** 검색-구-리건물명 */
	private String searchLiBuldNmOld;				
	/** 검색-구-번지동호 */
	private String searchLnbrDongHoOld;				    

	/**
	 * zip attribute 를 리턴한다.
	 * @return String
	 */
	public String getZip() {
		return zip;
	}

	/**
	 * zip attribute 값을 설정한다.
	 * @param zip String
	 */
	public void setZip(String zip) {
		this.zip = zip;
	}

	/**
	 * sn attribute 를 리턴한다.
	 * @return int
	 */
	public int getSn() {
		return sn;
	}

	/**
	 * sn attribute 값을 설정한다.
	 * @param sn int
	 */
	public void setSn(int sn) {
		this.sn = sn;
	}

	/**
	 * ctprvnNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getCtprvnNm() {
		return ctprvnNm;
	}

	/**
	 * ctprvnNm attribute 값을 설정한다.
	 * @param ctprvnNm String
	 */
	public void setCtprvnNm(String ctprvnNm) {
		this.ctprvnNm = ctprvnNm;
	}

	/**
	 * signguNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getSignguNm() {
		return signguNm;
	}

	/**
	 * signguNm attribute 값을 설정한다.
	 * @param signguNm String
	 */
	public void setSignguNm(String signguNm) {
		this.signguNm = signguNm;
	}

	/**
	 * emdNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getEmdNm() {
		return emdNm;
	}

	/**
	 * emdNm attribute 값을 설정한다.
	 * @param emdNm String
	 */
	public void setEmdNm(String emdNm) {
		this.emdNm = emdNm;
	}

	/**
	 * liBuldNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getLiBuldNm() {
		return liBuldNm;
	}

	/**
	 * liBuldNm attribute 값을 설정한다.
	 * @param liBuldNm String
	 */
	public void setLiBuldNm(String liBuldNm) {
		this.liBuldNm = liBuldNm;
	}

	/**
	 * lnbrDongHo attribute 를 리턴한다.
	 * @return String
	 */
	public String getLnbrDongHo() {
		return lnbrDongHo;
	}

	/**
	 * lnbrDongHo attribute 값을 설정한다.
	 * @param lnbrDongHo String
	 */
	public void setLnbrDongHo(String lnbrDongHo) {
		this.lnbrDongHo = lnbrDongHo;
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

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

	public String getLoadNm() {
		return loadNm;
	}

	public void setLoadNm(String loadNm) {
		this.loadNm = loadNm;
	}

	public String getLiBuldNmOld() {
		return liBuldNmOld;
	}

	public void setLiBuldNmOld(String liBuldNmOld) {
		this.liBuldNmOld = liBuldNmOld;
	}

	public String getLnbrDongHoOld() {
		return lnbrDongHoOld;
	}

	public void setLnbrDongHoOld(String lnbrDongHoOld) {
		this.lnbrDongHoOld = lnbrDongHoOld;
	}

	public String getSearchZip() {
		return searchZip;
	}

	public void setSearchZip(String searchZip) {
		this.searchZip = searchZip;
	}

	public String getSearchCtprvnNm() {
		return searchCtprvnNm;
	}

	public void setSearchCtprvnNm(String searchCtprvnNm) {
		this.searchCtprvnNm = searchCtprvnNm;
	}

	public String getSearchSignguNm() {
		return searchSignguNm;
	}

	public void setSearchSignguNm(String searchSignguNm) {
		this.searchSignguNm = searchSignguNm;
	}

	public String getSearchEmdNm() {
		return searchEmdNm;
	}

	public void setSearchEmdNm(String searchEmdNm) {
		this.searchEmdNm = searchEmdNm;
	}

	public String getSearchLiBuldNm() {
		return searchLiBuldNm;
	}

	public void setSearchLiBuldNm(String searchLiBuldNm) {
		this.searchLiBuldNm = searchLiBuldNm;
	}

	public String getSearchLoadNm() {
		return searchLoadNm;
	}

	public void setSearchLoadNm(String searchLoadNm) {
		this.searchLoadNm = searchLoadNm;
	}

	public String getSearchLnbrDongHo() {
		return searchLnbrDongHo;
	}

	public void setSearchLnbrDongHo(String searchLnbrDongHo) {
		this.searchLnbrDongHo = searchLnbrDongHo;
	}

	public String getSearchLiBuldNmOld() {
		return searchLiBuldNmOld;
	}

	public void setSearchLiBuldNmOld(String searchLiBuldNmOld) {
		this.searchLiBuldNmOld = searchLiBuldNmOld;
	}

	public String getSearchLnbrDongHoOld() {
		return searchLnbrDongHoOld;
	}

	public void setSearchLnbrDongHoOld(String searchLnbrDongHoOld) {
		this.searchLnbrDongHoOld = searchLnbrDongHoOld;
	}
    
    
}
