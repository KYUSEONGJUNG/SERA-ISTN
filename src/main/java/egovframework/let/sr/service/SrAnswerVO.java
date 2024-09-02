package egovframework.let.sr.service;

import java.io.Serializable;

/**
 * 고객사 VO 클래스
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
public class SrAnswerVO implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/** 답변변호 */
	private int answerNo          = 0;
	/** SR번호 */
	private String srNo           = "";
	/** 담당자 아이디 */
	private String rid            = "";
	/** 담당자명 */
	private String rname          = "";
	/** 담당자 영문명 */
	private String rnameEn        = "";
	/** 실제공수 */
	private String realExpectTime = "";
	/** 처리구분 */
	private String category       = "";
	/** 모듈코드 */
	private String moduleCode     = "";
	/** 답변내용 */
	private String comment        = "";
	/** 고객의견 */
	private String cstmrComment   = "";
	/** 첨부파일ID */
	private String fileId         = "";
	/** 답변(추가요청)일시 */
	private String signDate       = "";
	
	/** 답변구분(담당자,요청자) */
	private String answerSe       = "";
	/** 차순위 답변(추가요청) 건수 */
	private String afterCnt       = "";
	

	/** 생성일자 */
	private String createDate     = "";
	/** 수정일자 */
	private String editDate       = "";
	/** 생성자 */
	private String creatorId      = "";
	/** 변경자 */
	private String editorId       = "";
	public int getAnswerNo() {
		return answerNo;
	}
	public void setAnswerNo(int answerNo) {
		this.answerNo = answerNo;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getRealExpectTime() {
		return realExpectTime;
	}
	public void setRealExpectTime(String realExpectTime) {
		this.realExpectTime = realExpectTime;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getModuleCode() {
		return moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCstmrComment() {
		return cstmrComment;
	}
	public void setCstmrComment(String cstmrComment) {
		this.cstmrComment = cstmrComment;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getSignDate() {
		return signDate;
	}
	public void setSignDate(String signDate) {
		this.signDate = signDate;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getAnswerSe() {
		return answerSe;
	}
	public void setAnswerSe(String answerSe) {
		this.answerSe = answerSe;
	}
	public String getAfterCnt() {
		return afterCnt;
	}
	public void setAfterCnt(String afterCnt) {
		this.afterCnt = afterCnt;
	}
	public String getRnameEn() {
		return rnameEn;
	}
	public void setRnameEn(String rnameEn) {
		this.rnameEn = rnameEn;
	}
	
	
	
	
	

}
