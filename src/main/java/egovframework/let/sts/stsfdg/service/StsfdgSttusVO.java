package egovframework.let.sts.stsfdg.service;

import java.io.Serializable;

import egovframework.let.main.service.com.cmm.ComDefaultVO;

/**
 * 통계 결과 VO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성
 *  2011.06.30  이기하          패키지 분리(sts -> sts.com)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
public class StsfdgSttusVO extends ComDefaultVO implements Serializable {

	/** 답변변호 */
	private int[] answerNoArr;
	/** 고객의견 */
	private String[] cstmrCommentArr;
	/** 업체코드 배열 */
	private String[] pstinstCodeArr;
	/** 답변변호 */
	private String answerNoDelete = "";	
	/** 상태 선택 */
	private String selectStatus = "";
	/** 검색에 의한 조건 여부 */
	private String searchAt = "";
	
	
	/** SR번호 */
	private String srNo           = "";
	/** 업체코드 */
	private String pstinstCode    = "";
	/** 업체명 */
	private String pstinstNm      = "";
	/** 업체약어 */
	private String pstinstAbrv      = "";	
	/** 사용자아이디 */
	private String customerId     = "";
	/** 사용자명 */
	private String customerNm     = "";
	/** 제목 */
	private String subject        = "";
	/** 1연락처(연락처(내선)) */
	private String tel1           = "";
	/** 2연락처(연락처(이동전화)) */
	private String tel2           = "";
	/** 이메일 */
	private String email          = "";
	/** 상태 */
	private String status         = "";
	/** 모듈코드 */
	private String moduleCode     = "";
	/** 처리구분 */
	private String category       = "";
	/** 우선순위 */
	private String priority       = "";
	/** 완료희망일시 */
	private String hopeDate       = "";
	/** 완료희망일시 */
	private String hopeDateView   = "";
	/** 완료예정일 */
	private String scheduleDate   = "";
	/** 완료예정일 */
	private String scheduleDateView   = "";
	/** 완료일 */
	private String completeDate   = "";
	/** 완료일 */
	private String completeDateView   = "";
	/** 예상공수 */
	private String expectTime     = "";
	/** 실제공수 */
	private String realExpectTime = "";
	/** 실제공수 */
	private String realExpectTimeDisp = "";
	/** 담당자 아이디 */
	private String rid            = "";
	/** 담당자명 */
	private String rname          = "";
	/** TCODE */
	private String tcode          = "";
	/** 테스트완료여부 */
	private String testAt         = "";
	/** 테스트내역 */
	private String testContent    = "";
	/** 만족도점수 */
	private String point          = "";
	/** 기타의견 */
	private String pointContent   = "";
	/** 요청내용 */
	private String comment        = "";
	/** 요청내용 */
	private String cstmrComment        = "";
	/** 첨부파일ID */
	private String fileId         = "";
	/** 신청일(요청일) */
	private String signDate       = "";
	/** 답변처리일 */
	private String replyDate      = "";
	/** 수정일자 */
	private String editDate       = "";
	/** 접수확인일 */
	private String confirmDate    = "";
	
	/** 권한코드 */
	private String authorCode;
	/** 임시저장여부 */
	private String tempSaveAt     = "";	
	/** 반려사유 */
	private String returnResn     = "";	
	/** 결재 및 반려 여부 */
	private String sanctnerAt     = "";
	
	/**
	 * SR답변(신규)
	 */
	/** 답변변호 */
	private int answerNo             = 0;
	/** 담당자 아이디 */
	private String ansRid            = "";
	/** 담당자명 */
	private String ansRname          = "";
	/** 실제공수 */
	private String ansRealExpectTime = "";
	/** 처리구분 */
	private String ansCategory       = "";
	/** 모듈코드 */
	private String ansModuleCode     = "";
	/** 답변내용 */
	private String ansComment        = "";
	/** 고객의견 */
	private String ansCstmrComment   = "";
	/** 첨부파일ID */
	private String ansFileId     = "";
	/** 답변일시 */
	private String ansSignDate     = "";
	/** 생성일자 */
	private String ansCreateDate     = "";
	/** 수정일자 */
	private String ansEditDate       = "";
	/** 생성자 */
	private String ansCreatorId      = "";
	/** 변경자 */
	private String ansEditorId       = "";
	
	/** 검색-년,월,일 구분 */
	private String pdKind       = "";
	
	/** 검색-요청일(접수확인일) */
	private String searchDateF    = "";
	private String searchDateT    = "";
	private String searchDateFView    = "";
	private String searchDateTView    = "";
	
	/** 검색-업체명 */
	private String searchPstinstNm       = "";
	/** 검색-담당자(사용자아이디) */
	private String searchRname           = "";
	
	/** 엑셀-업체명 */
	private String name       = "";
	/** 엑셀-모듈명 */
	private String moduleName       = "";
	private String moduleNameEn       = "";
	private String moduleNameCn       = "";
	/** 엑셀-전체건수 */
	private String totalCount       = "";
	/** 엑셀-완료건수 */
	private String completeCount       = "";
	/** 엑셀-미완료건수 */
	private String uncompleteCount       = "";
	/** 엑셀-5(매우만족) */
	private String value5       = "";
	/** 엑셀-4(만족) */
	private String value4       = "";
	/** 엑셀-3(보통) */
	private String value3       = "";
	/** 엑셀-2(불만) */
	private String value2       = "";
	/** 엑셀-1(매우불만) */
	private String value1       = "";
	/** 엑셀-평균 */
	private String avgValue       = "";
	 
	
	
	/**
	 * @return the searchRname
	 */
	public String getSearchRname() {
		return searchRname;
	}
	/**
	 * @param searchRname the searchRname to set
	 */
	public void setSearchRname(String searchRname) {
		this.searchRname = searchRname;
	}
	/**
	 * @return the answerNoArr
	 */
	public int[] getAnswerNoArr() {
		return answerNoArr;
	}
	/**
	 * @param answerNoArr the answerNoArr to set
	 */
	public void setAnswerNoArr(int[] answerNoArr) {
		this.answerNoArr = answerNoArr;
	}
	/**
	 * @return the cstmrCommentArr
	 */
	public String[] getCstmrCommentArr() {
		return cstmrCommentArr;
	}
	/**
	 * @param cstmrCommentArr the cstmrCommentArr to set
	 */
	public void setCstmrCommentArr(String[] cstmrCommentArr) {
		this.cstmrCommentArr = cstmrCommentArr;
	}
	/**
	 * @return the answerNoDelete
	 */
	public String getAnswerNoDelete() {
		return answerNoDelete;
	}
	/**
	 * @param answerNoDelete the answerNoDelete to set
	 */
	public void setAnswerNoDelete(String answerNoDelete) {
		this.answerNoDelete = answerNoDelete;
	}
	/**
	 * @return the selectStatus
	 */
	public String getSelectStatus() {
		return selectStatus;
	}
	/**
	 * @param selectStatus the selectStatus to set
	 */
	public void setSelectStatus(String selectStatus) {
		this.selectStatus = selectStatus;
	}
	/**
	 * @return the searchAt
	 */
	public String getSearchAt() {
		return searchAt;
	}
	/**
	 * @param searchAt the searchAt to set
	 */
	public void setSearchAt(String searchAt) {
		this.searchAt = searchAt;
	}
	/**
	 * @return the srNo
	 */
	public String getSrNo() {
		return srNo;
	}
	/**
	 * @param srNo the srNo to set
	 */
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	/**
	 * @return the pstinstCode
	 */
	public String getPstinstCode() {
		return pstinstCode;
	}
	/**
	 * @param pstinstCode the pstinstCode to set
	 */
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}
	/**
	 * @return the pstinstNm
	 */
	public String getPstinstNm() {
		return pstinstNm;
	}
	/**
	 * @param pstinstNm the pstinstNm to set
	 */
	public void setPstinstNm(String pstinstNm) {
		this.pstinstNm = pstinstNm;
	}
	/**
	 * @return the pstinstAbrv
	 */
	public String getPstinstAbrv() {
		return pstinstAbrv;
	}
	/**
	 * @param pstinstAbrv the pstinstAbrv to set
	 */
	public void setPstinstAbrv(String pstinstAbrv) {
		this.pstinstAbrv = pstinstAbrv;
	}
	/**
	 * @return the customerId
	 */
	public String getCustomerId() {
		return customerId;
	}
	/**
	 * @param customerId the customerId to set
	 */
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	/**
	 * @return the customerNm
	 */
	public String getCustomerNm() {
		return customerNm;
	}
	/**
	 * @param customerNm the customerNm to set
	 */
	public void setCustomerNm(String customerNm) {
		this.customerNm = customerNm;
	}
	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
	/**
	 * @return the tel1
	 */
	public String getTel1() {
		return tel1;
	}
	/**
	 * @param tel1 the tel1 to set
	 */
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	/**
	 * @return the tel2
	 */
	public String getTel2() {
		return tel2;
	}
	/**
	 * @param tel2 the tel2 to set
	 */
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the moduleCode
	 */
	public String getModuleCode() {
		return moduleCode;
	}
	/**
	 * @param moduleCode the moduleCode to set
	 */
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return the priority
	 */
	public String getPriority() {
		return priority;
	}
	/**
	 * @param priority the priority to set
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}
	/**
	 * @return the hopeDate
	 */
	public String getHopeDate() {
		return hopeDate;
	}
	/**
	 * @param hopeDate the hopeDate to set
	 */
	public void setHopeDate(String hopeDate) {
		this.hopeDate = hopeDate;
	}
	/**
	 * @return the hopeDateView
	 */
	public String getHopeDateView() {
		return hopeDateView;
	}
	/**
	 * @param hopeDateView the hopeDateView to set
	 */
	public void setHopeDateView(String hopeDateView) {
		this.hopeDateView = hopeDateView;
	}
	/**
	 * @return the scheduleDate
	 */
	public String getScheduleDate() {
		return scheduleDate;
	}
	/**
	 * @param scheduleDate the scheduleDate to set
	 */
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	/**
	 * @return the scheduleDateView
	 */
	public String getScheduleDateView() {
		return scheduleDateView;
	}
	/**
	 * @param scheduleDateView the scheduleDateView to set
	 */
	public void setScheduleDateView(String scheduleDateView) {
		this.scheduleDateView = scheduleDateView;
	}
	/**
	 * @return the completeDate
	 */
	public String getCompleteDate() {
		return completeDate;
	}
	/**
	 * @param completeDate the completeDate to set
	 */
	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
	/**
	 * @return the completeDateView
	 */
	public String getCompleteDateView() {
		return completeDateView;
	}
	/**
	 * @param completeDateView the completeDateView to set
	 */
	public void setCompleteDateView(String completeDateView) {
		this.completeDateView = completeDateView;
	}
	/**
	 * @return the expectTime
	 */
	public String getExpectTime() {
		return expectTime;
	}
	/**
	 * @param expectTime the expectTime to set
	 */
	public void setExpectTime(String expectTime) {
		this.expectTime = expectTime;
	}
	/**
	 * @return the realExpectTime
	 */
	public String getRealExpectTime() {
		return realExpectTime;
	}
	/**
	 * @param realExpectTime the realExpectTime to set
	 */
	public void setRealExpectTime(String realExpectTime) {
		this.realExpectTime = realExpectTime;
	}
	/**
	 * @return the realExpectTimeDisp
	 */
	public String getRealExpectTimeDisp() {
		return realExpectTimeDisp;
	}
	/**
	 * @param realExpectTimeDisp the realExpectTimeDisp to set
	 */
	public void setRealExpectTimeDisp(String realExpectTimeDisp) {
		this.realExpectTimeDisp = realExpectTimeDisp;
	}
	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}
	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}
	/**
	 * @return the rname
	 */
	public String getRname() {
		return rname;
	}
	/**
	 * @param rname the rname to set
	 */
	public void setRname(String rname) {
		this.rname = rname;
	}
	/**
	 * @return the tcode
	 */
	public String getTcode() {
		return tcode;
	}
	/**
	 * @param tcode the tcode to set
	 */
	public void setTcode(String tcode) {
		this.tcode = tcode;
	}
	/**
	 * @return the testAt
	 */
	public String getTestAt() {
		return testAt;
	}
	/**
	 * @param testAt the testAt to set
	 */
	public void setTestAt(String testAt) {
		this.testAt = testAt;
	}
	/**
	 * @return the testContent
	 */
	public String getTestContent() {
		return testContent;
	}
	/**
	 * @param testContent the testContent to set
	 */
	public void setTestContent(String testContent) {
		this.testContent = testContent;
	}
	/**
	 * @return the point
	 */
	public String getPoint() {
		return point;
	}
	/**
	 * @param point the point to set
	 */
	public void setPoint(String point) {
		this.point = point;
	}
	/**
	 * @return the pointContent
	 */
	public String getPointContent() {
		return pointContent;
	}
	/**
	 * @param pointContent the pointContent to set
	 */
	public void setPointContent(String pointContent) {
		this.pointContent = pointContent;
	}
	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}
	/**
	 * @param comment the comment to set
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	/**
	 * @return the cstmrComment
	 */
	public String getCstmrComment() {
		return cstmrComment;
	}
	/**
	 * @param cstmrComment the cstmrComment to set
	 */
	public void setCstmrComment(String cstmrComment) {
		this.cstmrComment = cstmrComment;
	}
	/**
	 * @return the fileId
	 */
	public String getFileId() {
		return fileId;
	}
	/**
	 * @param fileId the fileId to set
	 */
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	/**
	 * @return the signDate
	 */
	public String getSignDate() {
		return signDate;
	}
	/**
	 * @param signDate the signDate to set
	 */
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}
	/**
	 * @return the replyDate
	 */
	public String getReplyDate() {
		return replyDate;
	}
	/**
	 * @param replyDate the replyDate to set
	 */
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	/**
	 * @return the editDate
	 */
	public String getEditDate() {
		return editDate;
	}
	/**
	 * @param editDate the editDate to set
	 */
	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}
	/**
	 * @return the confirmDate
	 */
	public String getConfirmDate() {
		return confirmDate;
	}
	/**
	 * @param confirmDate the confirmDate to set
	 */
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}
	/**
	 * @return the authorCode
	 */
	public String getAuthorCode() {
		return authorCode;
	}
	/**
	 * @param authorCode the authorCode to set
	 */
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	/**
	 * @return the tempSaveAt
	 */
	public String getTempSaveAt() {
		return tempSaveAt;
	}
	/**
	 * @param tempSaveAt the tempSaveAt to set
	 */
	public void setTempSaveAt(String tempSaveAt) {
		this.tempSaveAt = tempSaveAt;
	}
	/**
	 * @return the returnResn
	 */
	public String getReturnResn() {
		return returnResn;
	}
	/**
	 * @param returnResn the returnResn to set
	 */
	public void setReturnResn(String returnResn) {
		this.returnResn = returnResn;
	}
	/**
	 * @return the sanctnerAt
	 */
	public String getSanctnerAt() {
		return sanctnerAt;
	}
	/**
	 * @param sanctnerAt the sanctnerAt to set
	 */
	public void setSanctnerAt(String sanctnerAt) {
		this.sanctnerAt = sanctnerAt;
	}
	/**
	 * @return the answerNo
	 */
	public int getAnswerNo() {
		return answerNo;
	}
	/**
	 * @param answerNo the answerNo to set
	 */
	public void setAnswerNo(int answerNo) {
		this.answerNo = answerNo;
	}
	/**
	 * @return the ansRid
	 */
	public String getAnsRid() {
		return ansRid;
	}
	/**
	 * @param ansRid the ansRid to set
	 */
	public void setAnsRid(String ansRid) {
		this.ansRid = ansRid;
	}
	/**
	 * @return the ansRname
	 */
	public String getAnsRname() {
		return ansRname;
	}
	/**
	 * @param ansRname the ansRname to set
	 */
	public void setAnsRname(String ansRname) {
		this.ansRname = ansRname;
	}
	/**
	 * @return the ansRealExpectTime
	 */
	public String getAnsRealExpectTime() {
		return ansRealExpectTime;
	}
	/**
	 * @param ansRealExpectTime the ansRealExpectTime to set
	 */
	public void setAnsRealExpectTime(String ansRealExpectTime) {
		this.ansRealExpectTime = ansRealExpectTime;
	}
	/**
	 * @return the ansCategory
	 */
	public String getAnsCategory() {
		return ansCategory;
	}
	/**
	 * @param ansCategory the ansCategory to set
	 */
	public void setAnsCategory(String ansCategory) {
		this.ansCategory = ansCategory;
	}
	/**
	 * @return the ansModuleCode
	 */
	public String getAnsModuleCode() {
		return ansModuleCode;
	}
	/**
	 * @param ansModuleCode the ansModuleCode to set
	 */
	public void setAnsModuleCode(String ansModuleCode) {
		this.ansModuleCode = ansModuleCode;
	}
	/**
	 * @return the ansComment
	 */
	public String getAnsComment() {
		return ansComment;
	}
	/**
	 * @param ansComment the ansComment to set
	 */
	public void setAnsComment(String ansComment) {
		this.ansComment = ansComment;
	}
	/**
	 * @return the ansCstmrComment
	 */
	public String getAnsCstmrComment() {
		return ansCstmrComment;
	}
	/**
	 * @param ansCstmrComment the ansCstmrComment to set
	 */
	public void setAnsCstmrComment(String ansCstmrComment) {
		this.ansCstmrComment = ansCstmrComment;
	}
	/**
	 * @return the ansFileId
	 */
	public String getAnsFileId() {
		return ansFileId;
	}
	/**
	 * @param ansFileId the ansFileId to set
	 */
	public void setAnsFileId(String ansFileId) {
		this.ansFileId = ansFileId;
	}
	/**
	 * @return the ansSignDate
	 */
	public String getAnsSignDate() {
		return ansSignDate;
	}
	/**
	 * @param ansSignDate the ansSignDate to set
	 */
	public void setAnsSignDate(String ansSignDate) {
		this.ansSignDate = ansSignDate;
	}
	/**
	 * @return the ansCreateDate
	 */
	public String getAnsCreateDate() {
		return ansCreateDate;
	}
	/**
	 * @param ansCreateDate the ansCreateDate to set
	 */
	public void setAnsCreateDate(String ansCreateDate) {
		this.ansCreateDate = ansCreateDate;
	}
	/**
	 * @return the ansEditDate
	 */
	public String getAnsEditDate() {
		return ansEditDate;
	}
	/**
	 * @param ansEditDate the ansEditDate to set
	 */
	public void setAnsEditDate(String ansEditDate) {
		this.ansEditDate = ansEditDate;
	}
	/**
	 * @return the ansCreatorId
	 */
	public String getAnsCreatorId() {
		return ansCreatorId;
	}
	/**
	 * @param ansCreatorId the ansCreatorId to set
	 */
	public void setAnsCreatorId(String ansCreatorId) {
		this.ansCreatorId = ansCreatorId;
	}
	/**
	 * @return the ansEditorId
	 */
	public String getAnsEditorId() {
		return ansEditorId;
	}
	/**
	 * @param ansEditorId the ansEditorId to set
	 */
	public void setAnsEditorId(String ansEditorId) {
		this.ansEditorId = ansEditorId;
	}
	
	/**
	 * @return the pdKind
	 */
	public String getPdKind() {
		return pdKind;
	}
	/**
	 * @param pdKind the pdKind to set
	 */
	public void setPdKind(String pdKind) {
		this.pdKind = pdKind;
	}
	/**
	 * @return the searchDateF
	 */
	public String getSearchDateF() {
		return searchDateF;
	}
	/**
	 * @param searchDateF the searchDateF to set
	 */
	public void setSearchDateF(String searchDateF) {
		this.searchDateF = searchDateF;
	}
	/**
	 * @return the searchDateT
	 */
	public String getSearchDateT() {
		return searchDateT;
	}
	/**
	 * @param searchDateT the searchDateT to set
	 */
	public void setSearchDateT(String searchDateT) {
		this.searchDateT = searchDateT;
	}
	/**
	 * @return the searchDateFView
	 */
	public String getSearchDateFView() {
		return searchDateFView;
	}
	/**
	 * @param searchDateFView the searchDateFView to set
	 */
	public void setSearchDateFView(String searchDateFView) {
		this.searchDateFView = searchDateFView;
	}
	/**
	 * @return the searchDateTView
	 */
	public String getSearchDateTView() {
		return searchDateTView;
	}
	/**
	 * @param searchDateTView the searchDateTView to set
	 */
	public void setSearchDateTView(String searchDateTView) {
		this.searchDateTView = searchDateTView;
	}
	/**
	 * @return the searchPstinstNm
	 */
	public String getSearchPstinstNm() {
		return searchPstinstNm;
	}
	/**
	 * @param searchPstinstNm the searchPstinstNm to set
	 */
	public void setSearchPstinstNm(String searchPstinstNm) {
		this.searchPstinstNm = searchPstinstNm;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the moduleName
	 */
	public String getModuleName() {
		return moduleName;
	}
	/**
	 * @param moduleName the moduleName to set
	 */
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	/**
	 * @return the totalCount
	 */
	public String getTotalCount() {
		return totalCount;
	}
	/**
	 * @param totalCount the totalCount to set
	 */
	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}
	/**
	 * @return the completeCount
	 */
	public String getCompleteCount() {
		return completeCount;
	}
	/**
	 * @param completeCount the completeCount to set
	 */
	public void setCompleteCount(String completeCount) {
		this.completeCount = completeCount;
	}
	/**
	 * @return the uncompleteCount
	 */
	public String getUncompleteCount() {
		return uncompleteCount;
	}
	/**
	 * @param uncompleteCount the uncompleteCount to set
	 */
	public void setUncompleteCount(String uncompleteCount) {
		this.uncompleteCount = uncompleteCount;
	}
	/**
	 * @return the value5
	 */
	public String getValue5() {
		return value5;
	}
	/**
	 * @param value5 the value5 to set
	 */
	public void setValue5(String value5) {
		this.value5 = value5;
	}
	/**
	 * @return the value4
	 */
	public String getValue4() {
		return value4;
	}
	/**
	 * @param value4 the value4 to set
	 */
	public void setValue4(String value4) {
		this.value4 = value4;
	}
	/**
	 * @return the value3
	 */
	public String getValue3() {
		return value3;
	}
	/**
	 * @param value3 the value3 to set
	 */
	public void setValue3(String value3) {
		this.value3 = value3;
	}
	/**
	 * @return the value2
	 */
	public String getValue2() {
		return value2;
	}
	/**
	 * @param value2 the value2 to set
	 */
	public void setValue2(String value2) {
		this.value2 = value2;
	}
	/**
	 * @return the value1
	 */
	public String getValue1() {
		return value1;
	}
	/**
	 * @param value1 the value1 to set
	 */
	public void setValue1(String value1) {
		this.value1 = value1;
	}
	/**
	 * @return the avgValue
	 */
	public String getAvgValue() {
		return avgValue;
	}
	/**
	 * @param avgValue the avgValue to set
	 */
	public void setAvgValue(String avgValue) {
		this.avgValue = avgValue;
	}
	public String getModuleNameEn() {
		return moduleNameEn;
	}
	public void setModuleNameEn(String moduleNameEn) {
		this.moduleNameEn = moduleNameEn;
	}
	public String getModuleNameCn() {
		return moduleNameCn;
	}
	public void setModuleNameCn(String moduleNameCn) {
		this.moduleNameCn = moduleNameCn;
	}
	public String[] getPstinstCodeArr() {
		return pstinstCodeArr;
	}
	public void setPstinstCodeArr(String[] pstinstCodeArr) {
		this.pstinstCodeArr = pstinstCodeArr;
	}
	
	
}
