package egovframework.let.sr.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 고객사 모델 클래스
 * @author 공통서비스 개발팀 박원배
 * @since 2014.02.27
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.02.27  박원배          최초 생성
 *
 * </pre>
 */
public class Sr implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;	
	
	/** 업체코드 */
	private String srCode    = "";
	/** 업종코드 */
	private String jobCode        = "";
	/** 업무명 */
	private String jobName        = "";
	/** 업체명 */
	private String name           = "";
	/** 업체 영문명 */
	private String ename          = "";
	/** 우편번호 */
	private String zipCode        = "";
	/** 주소1 */
	private String address1       = "";
	/** 주소2 */
	private String address2       = "";
	/** 전화번호 */            
	private String tel            = "";
	/** 팩스번호 */
	private String fax            = "";
	/** 기관설명 */
	private String note           = "";
	/** 결제기능여부 */
	private String settleAt       = "";
	/** 계약공수 */
	private String contractTime   = "";
	/** 계약방식 */
	private String contractKind   = "";
	/** 삭제여부 */
	private String delAt          = "";
	/** 생성일자 */
	private String createDate     = "";
	/** 수정일자 */
	private String editDate       = "";
	/** 생성자 */
	private String creatorId      = "";
	/** 변경자 */
	private String editorId       = "";
	
	/** 검색-업체명 */
	private String searchSrNm;
	/** 검색-삭제여부 */
	private String searchDelAt;
	
	
	public String getSrCode() {
		return srCode;
	}
	public void setSrCode(String srCode) {
		this.srCode = srCode;
	}
	public String getJobCode() {
		return jobCode;
	}
	public void setJobCode(String jobCode) {
		this.jobCode = jobCode;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getSettleAt() {
		return settleAt;
	}
	public void setSettleAt(String settleAt) {
		this.settleAt = settleAt;
	}
	public String getContractTime() {
		return contractTime;
	}
	public void setContractTime(String contractTime) {
		this.contractTime = contractTime;
	}
	public String getContractKind() {
		return contractKind;
	}
	public void setContractKind(String contractKind) {
		this.contractKind = contractKind;
	}
	public String getDelAt() {
		return delAt;
	}
	public void setDelAt(String delAt) {
		this.delAt = delAt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEditDate() {
		return editDate;
	}
	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}
	public String getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}
	public String getEditorId() {
		return editorId;
	}
	public void setEditorId(String editorId) {
		this.editorId = editorId;
	}
	public String getSearchSrNm() {
		return searchSrNm;
	}
	public void setSearchSrNm(String searchSrNm) {
		this.searchSrNm = searchSrNm;
	}
	public String getSearchDelAt() {
		return searchDelAt;
	}
	public void setSearchDelAt(String searchDelAt) {
		this.searchDelAt = searchDelAt;
	}
	
	

}
