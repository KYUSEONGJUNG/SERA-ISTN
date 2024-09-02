package egovframework.let.sr.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import egovframework.let.main.service.com.cmm.ComDefaultVO;

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
public class SrVO extends ComDefaultVO implements Serializable {
	
	/** 상태 */
	List<String> searchStatus = new ArrayList<String>();

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
	/** 업체 영문명 */
	private String pstinstNmEn      = "";
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
	/** 상태명 */
	private String statusNm         = "";
	/** 상태명 영어*/
	private String statusNmEn         = "";
	/** 상태명 중국어*/
	private String statusNmCn         = "";
	/** 모듈코드 */
	private String moduleCode     = "";
	/** 모듈명 */
	private String moduleNm     = "";
	/** 모듈명 영어*/
	private String moduleNmEn     = "";
	/** 모듈명 중국어*/
	private String moduleNmCn     = "";
	/** 처리구분 */
	private String category       = "";
	/** 처리구분명 */
	private String categoryNm       = "";
	/** 처리구분명 영어*/
	private String categoryNmEn       = "";
	/** 처리구분명 중국어 */
	private String categoryNmCn       = "";
	/** 우선순위 */
	private String priority       = "";
	/** 우선순위명 */
	private String priorityNm       = "";
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
	/** Abap실제공수 */
	private String abapRealExpectTime = "";	
	/** 실제공수 */
	private String realExpectTimeDisp = "";
	/** 담당자 아이디 */
	private String rid            = "";
	/** 담당자명 */
	private String rname          = "";
	/** 담당자 영문명 */
	private String rnameEn          = "";
	/** ABAP 담당자 아이디 */
	private String abapRid            = "";
	/** ABAP 담당자명 */
	private String abapRname          = "";
	/** ABAP 담당자 영문명 */
	private String abapRnameEn          = "";
	/** 이메일 */
	private String remail          = "";
	/** TCODE */
	private String tcode          = "";
	/** 테스트완료여부 */
	private String testAt         = "";
	/** 테스트완료여부(리스트 출력용) */
	private String tat         = "";
	/** 테스트내역 */
	private String testContent    = "";
	/** 테스트완료일 */
	private String testCompleteDate    = "";	
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
	
	/** 신청일(요청일) */
	private String signDateDisp       = "";
	/** 완료희망일 */
	private String hopeDateDisp       = "";
	
	/** 권한코드 */
	private String authorCode;
	/** 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장) */
	private String saveSe     = "";
	/** 임시저장여부 */
	private String tempSaveAt     = "";
	/** 답변임시저장여부 */
	private String AnsTempSaveAt     = "";
	/** 반려사유 */
	private String returnResn     = "";	
	/** 결재 및 반려 여부 */
	private String sanctnerAt     = "";
	/** 결재일 */
	private String sanctnerDate    = "";
	
	private String emailSendAt     = "";

	
	/** 
	 *  kpmg 2021.07.14
	 */
	/** 결재기능 여부(Y/N) */
	private String settleAt     = "";	
	/** 결자자(승인권자)명 */
	private String sanctnerId     = "";
	/** 결자자(승인권자)명 */
	private String sanctnerNm     = "";	
	
	/**
	 * SR답변(신규)
	 */
	/** 답변변호 */
	private int answerNo             = 0;
	/** 담당자 아이디 */
	private String ansRid            = "";
	/** 담당자명 */
	private String ansRname          = "";
	/** 담당자 영문명 */
	private String ansRnameEn          = "";
	/** 실제공수 */
	private String ansRealExpectTime = "";
	/** 처리구분 */
	private String ansCategory       = "";
	/** 모듈코드 */
	private String ansModuleCode     = "";
	/** 모듈명 */
	private String ansModuleNm     = "";
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
	/** 답변구분(담당자,요청자) */
	private String answerSe       = "";
	
	/** 생성일자 */
	private String createDate     = "";
	/** 생성자 */
	private String creatorId      = "";
	/** 변경자 */
	private String editorId       = "";
	
	/**
	 * SR답변(임시저장)
	 */
	/** 답변변호 */
	private int answerNoUpdate             = 0;
	/** 담당자 아이디 */
	private String ansRidUpdate            = "";
	/** 담당자명 */
	private String ansRnameUpdate          = "";
	/** 실제공수 */
	private String ansRealExpectTimeUpdate = "";
	/** 처리구분 */
	private String ansCategoryUpdate       = "";
	/** 모듈코드 */
	private String ansModuleCodeUpdate     = "";
	/** 답변내용 */
	private String ansCommentUpdate        = "";
	/** 고객의견 */
	private String ansCstmrCommentUpdate   = "";
	/** 첨부파일ID */
	private String ansFileIdUpdate     = "";
	/** 답변일시 */
	private String ansSignDateUpdate     = "";
	/** 생성일자 */
	private String ansCreateDateUpdate     = "";
	/** 수정일자 */
	private String ansEditDateUpdate       = "";
	/** 생성자 */
	private String ansCreatorIdUpdate      = "";
	/** 변경자 */
	private String ansEditorIdUpdate       = "";
	
	
	
	/** 검색-요청일(접수확인일) */
	private String searchConfirmDateF    = "";
	private String searchConfirmDateT    = "";
	private String searchConfirmDateFView    = "";
	private String searchConfirmDateTView    = "";
	/** 검색-요청자(사용자아이디) */
	private String searchCustomerNm      = "";
	/** 검색-담당자(사용자아이디) */
	private String searchRname           = "";
	/** 검색-담당자(사용자아이디) */
	private String searchRid           = "";
	/** 검색-완료일 */
	private String searchCompleteDateF   = "";
	private String searchCompleteDateT   = "";
	private String searchCompleteDateFView   = "";
	private String searchCompleteDateTView   = "";
	/** 검색-검색키워드(TCODE) */
	private String searchTcode           = "";
	/** 검색-업체코드 */
	private String searchPstinstCode     = "";
	/** 검색-업체명 */
	private String searchPstinstNm       = "";
	/** 검색-모듈코드 */
	private String searchModuleCode      = "";
	/** 검색-상태(임시저장) */
	private String searchStatus1         = "";
	/** 검색-상태(등록) */
	private String searchStatus2         = "";
	/** 검색-상태(접수중) */
	private String searchStatus3         = "";
	/** 검색-상태(해결중) */
	private String searchStatus4         = "";
	/** 검색-상태(고객테스트) */
	private String searchStatus5         = "";
	/** 검색-상태(운영이관완료) */
	private String searchStatus6         = "";
	/** 검색-상태(전체) */
	private String searchStatusAllCheck         = "";
	
	/** 검색-제목 */
	private String searchSubject         = "";
	/** 검색-내용포함 */
	private String searchContentFlag	= "";
	
	/** 결재 및 반려 여부 */
	private String searchSanctnerAt     = "";
	/** 반려 Checkbox 선택 여부 */
	private String searchStatusRetnrn     = "";
	/** 등록 Checkbox 선택 여부 */
	private String searchStatus1001At     = "";
	
	/** 다국어 */
	private String language     = "";
	/** 메일 전송 언어 */
	private String sendLanguage     = "";	
	
	/** SR건수 */
	private int totcnt             = 0;
	/** 실제공수 합계 */
	private String realExpectTimeSum = "";
	
	/**
	 * 메일발송용
	 */
	/** 이메일 */
	private String mailNo = "";	
	private String mailSenderEmplyrNm = "";
	private String mailSenderEmail    = "";
	private String mailReceiverEmail  = "";
	private String mailSubject        = "";
	private String mailComment        = "";
	private String mailFileId         = "";
	private String mailSrNo           = "";	
	private int mailAnswerNo             = 0;
	
	/**
	 * ROLE_COOPER 조회를 위한 UserID 
	 * 
	 */
	private String userId = "";
	
	
	public String getSearchContentFlag() {
		return searchContentFlag;
	}
	public void setSearchContentFlag(String searchContentFlag) {
		this.searchContentFlag = searchContentFlag;
	}
	
	public List<String> getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(List<String> searchStatus) {
		this.searchStatus = searchStatus;
	}
	public int[] getAnswerNoArr() {
		return answerNoArr;
	}
	public void setAnswerNoArr(int[] answerNoArr) {
		this.answerNoArr = answerNoArr;
	}
	public String[] getCstmrCommentArr() {
		return cstmrCommentArr;
	}
	public void setCstmrCommentArr(String[] cstmrCommentArr) {
		this.cstmrCommentArr = cstmrCommentArr;
	}
	public String getAnswerNoDelete() {
		return answerNoDelete;
	}
	public void setAnswerNoDelete(String answerNoDelete) {
		this.answerNoDelete = answerNoDelete;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getPstinstCode() {
		return pstinstCode;
	}
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}
	public String getPstinstNm() {
		return pstinstNm;
	}
	public void setPstinstNm(String pstinstNm) {
		this.pstinstNm = pstinstNm;
	}
	public String getPstinstAbrv() {
		return pstinstAbrv;
	}
	public void setPstinstAbrv(String pstinstAbrv) {
		this.pstinstAbrv = pstinstAbrv;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerNm() {
		return customerNm;
	}
	public void setCustomerNm(String customerNm) {
		this.customerNm = customerNm;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getModuleCode() {
		return moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getHopeDate() {
		return hopeDate;
	}
	public void setHopeDate(String hopeDate) {
		this.hopeDate = hopeDate;
	}
	public String getHopeDateView() {
		return hopeDateView;
	}
	public void setHopeDateView(String hopeDateView) {
		this.hopeDateView = hopeDateView;
	}
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleDateView() {
		return scheduleDateView;
	}
	public void setScheduleDateView(String scheduleDateView) {
		this.scheduleDateView = scheduleDateView;
	}
	public String getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
	public String getCompleteDateView() {
		return completeDateView;
	}
	public void setCompleteDateView(String completeDateView) {
		this.completeDateView = completeDateView;
	}
	public String getExpectTime() {
		return expectTime;
	}
	public void setExpectTime(String expectTime) {
		this.expectTime = expectTime;
	}
	public String getRealExpectTime() {
		return realExpectTime;
	}
	public void setRealExpectTime(String realExpectTime) {
		this.realExpectTime = realExpectTime;
	}
	public String getRealExpectTimeDisp() {
		return realExpectTimeDisp;
	}
	public void setRealExpectTimeDisp(String realExpectTimeDisp) {
		this.realExpectTimeDisp = realExpectTimeDisp;
	}
	public String getAbapRid() {
		return abapRid;
	}
	public void setAbapRid(String abapRid) {
		this.abapRid = abapRid;
	}
	public String getAbapRname() {
		return abapRname;
	}
	public void setAbapRname(String abapRname) {
		this.abapRname = abapRname;
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
	public String getTcode() {
		return tcode;
	}
	public void setTcode(String tcode) {
		this.tcode = tcode;
	}
	public String getTestAt() {
		return testAt;
	}
	public void setTestAt(String testAt) {
		this.testAt = testAt;
	}
	public String getTestContent() {
		return testContent;
	}
	public void setTestContent(String testContent) {
		this.testContent = testContent;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getPointContent() {
		return pointContent;
	}
	public void setPointContent(String pointContent) {
		this.pointContent = pointContent;
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
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public String getEditDate() {
		return editDate;
	}
	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}
	public String getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}
	public String getAuthorCode() {
		return authorCode;
	}
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	
	public String getSaveSe() {
		return saveSe;
	}
	public void setSaveSe(String saveSe) {
		this.saveSe = saveSe;
	}
	public String getReturnResn() {
		return returnResn;
	}
	public void setReturnResn(String returnResn) {
		this.returnResn = returnResn;
	}
	public String getSanctnerAt() {
		return sanctnerAt;
	}
	public void setSanctnerAt(String sanctnerAt) {
		this.sanctnerAt = sanctnerAt;
	}
	public int getAnswerNo() {
		return answerNo;
	}
	public void setAnswerNo(int answerNo) {
		this.answerNo = answerNo;
	}
	public String getAnsRid() {
		return ansRid;
	}
	public void setAnsRid(String ansRid) {
		this.ansRid = ansRid;
	}
	public String getAnsRname() {
		return ansRname;
	}
	public void setAnsRname(String ansRname) {
		this.ansRname = ansRname;
	}
	public String getAnsRealExpectTime() {
		return ansRealExpectTime;
	}
	public void setAnsRealExpectTime(String ansRealExpectTime) {
		this.ansRealExpectTime = ansRealExpectTime;
	}
	public String getAnsCategory() {
		return ansCategory;
	}
	public void setAnsCategory(String ansCategory) {
		this.ansCategory = ansCategory;
	}
	public String getAnsModuleCode() {
		return ansModuleCode;
	}
	public void setAnsModuleCode(String ansModuleCode) {
		this.ansModuleCode = ansModuleCode;
	}
	public String getAnsComment() {
		return ansComment;
	}
	public void setAnsComment(String ansComment) {
		this.ansComment = ansComment;
	}
	public String getAnsCstmrComment() {
		return ansCstmrComment;
	}
	public void setAnsCstmrComment(String ansCstmrComment) {
		this.ansCstmrComment = ansCstmrComment;
	}
	public String getAnsFileId() {
		return ansFileId;
	}
	public void setAnsFileId(String ansFileId) {
		this.ansFileId = ansFileId;
	}
	public String getAnsSignDate() {
		return ansSignDate;
	}
	public void setAnsSignDate(String ansSignDate) {
		this.ansSignDate = ansSignDate;
	}
	public String getAnsCreateDate() {
		return ansCreateDate;
	}
	public void setAnsCreateDate(String ansCreateDate) {
		this.ansCreateDate = ansCreateDate;
	}
	public String getAnsEditDate() {
		return ansEditDate;
	}
	public void setAnsEditDate(String ansEditDate) {
		this.ansEditDate = ansEditDate;
	}
	public String getAnsCreatorId() {
		return ansCreatorId;
	}
	public void setAnsCreatorId(String ansCreatorId) {
		this.ansCreatorId = ansCreatorId;
	}
	public String getAnsEditorId() {
		return ansEditorId;
	}
	public void setAnsEditorId(String ansEditorId) {
		this.ansEditorId = ansEditorId;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	public int getAnswerNoUpdate() {
		return answerNoUpdate;
	}
	public void setAnswerNoUpdate(int answerNoUpdate) {
		this.answerNoUpdate = answerNoUpdate;
	}
	public String getAnsRidUpdate() {
		return ansRidUpdate;
	}
	public void setAnsRidUpdate(String ansRidUpdate) {
		this.ansRidUpdate = ansRidUpdate;
	}
	public String getAnsRnameUpdate() {
		return ansRnameUpdate;
	}
	public void setAnsRnameUpdate(String ansRnameUpdate) {
		this.ansRnameUpdate = ansRnameUpdate;
	}
	public String getAnsRealExpectTimeUpdate() {
		return ansRealExpectTimeUpdate;
	}
	public void setAnsRealExpectTimeUpdate(String ansRealExpectTimeUpdate) {
		this.ansRealExpectTimeUpdate = ansRealExpectTimeUpdate;
	}
	public String getAnsCategoryUpdate() {
		return ansCategoryUpdate;
	}
	public void setAnsCategoryUpdate(String ansCategoryUpdate) {
		this.ansCategoryUpdate = ansCategoryUpdate;
	}
	public String getAnsModuleCodeUpdate() {
		return ansModuleCodeUpdate;
	}
	public void setAnsModuleCodeUpdate(String ansModuleCodeUpdate) {
		this.ansModuleCodeUpdate = ansModuleCodeUpdate;
	}
	public String getAnsCommentUpdate() {
		return ansCommentUpdate;
	}
	public void setAnsCommentUpdate(String ansCommentUpdate) {
		this.ansCommentUpdate = ansCommentUpdate;
	}
	public String getAnsCstmrCommentUpdate() {
		return ansCstmrCommentUpdate;
	}
	public void setAnsCstmrCommentUpdate(String ansCstmrCommentUpdate) {
		this.ansCstmrCommentUpdate = ansCstmrCommentUpdate;
	}
	public String getAnsFileIdUpdate() {
		return ansFileIdUpdate;
	}
	public void setAnsFileIdUpdate(String ansFileIdUpdate) {
		this.ansFileIdUpdate = ansFileIdUpdate;
	}
	public String getAnsSignDateUpdate() {
		return ansSignDateUpdate;
	}
	public void setAnsSignDateUpdate(String ansSignDateUpdate) {
		this.ansSignDateUpdate = ansSignDateUpdate;
	}
	public String getAnsCreateDateUpdate() {
		return ansCreateDateUpdate;
	}
	public void setAnsCreateDateUpdate(String ansCreateDateUpdate) {
		this.ansCreateDateUpdate = ansCreateDateUpdate;
	}
	public String getAnsEditDateUpdate() {
		return ansEditDateUpdate;
	}
	public void setAnsEditDateUpdate(String ansEditDateUpdate) {
		this.ansEditDateUpdate = ansEditDateUpdate;
	}
	public String getAnsCreatorIdUpdate() {
		return ansCreatorIdUpdate;
	}
	public void setAnsCreatorIdUpdate(String ansCreatorIdUpdate) {
		this.ansCreatorIdUpdate = ansCreatorIdUpdate;
	}
	public String getAnsEditorIdUpdate() {
		return ansEditorIdUpdate;
	}
	public void setAnsEditorIdUpdate(String ansEditorIdUpdate) {
		this.ansEditorIdUpdate = ansEditorIdUpdate;
	}
	public String getSearchConfirmDateF() {
		return searchConfirmDateF;
	}
	public void setSearchConfirmDateF(String searchConfirmDateF) {
		this.searchConfirmDateF = searchConfirmDateF;
	}
	public String getSearchConfirmDateT() {
		return searchConfirmDateT;
	}
	public void setSearchConfirmDateT(String searchConfirmDateT) {
		this.searchConfirmDateT = searchConfirmDateT;
	}
	public String getSearchConfirmDateFView() {
		return searchConfirmDateFView;
	}
	public void setSearchConfirmDateFView(String searchConfirmDateFView) {
		this.searchConfirmDateFView = searchConfirmDateFView;
	}
	public String getSearchConfirmDateTView() {
		return searchConfirmDateTView;
	}
	public void setSearchConfirmDateTView(String searchConfirmDateTView) {
		this.searchConfirmDateTView = searchConfirmDateTView;
	}
	public String getSearchCustomerNm() {
		return searchCustomerNm;
	}
	public void setSearchCustomerNm(String searchCustomerNm) {
		this.searchCustomerNm = searchCustomerNm;
	}
	public String getSearchRname() {
		return searchRname;
	}
	public void setSearchRname(String searchRname) {
		this.searchRname = searchRname;
	}
	public String getSearchCompleteDateF() {
		return searchCompleteDateF;
	}
	public void setSearchCompleteDateF(String searchCompleteDateF) {
		this.searchCompleteDateF = searchCompleteDateF;
	}
	public String getSearchCompleteDateT() {
		return searchCompleteDateT;
	}
	public void setSearchCompleteDateT(String searchCompleteDateT) {
		this.searchCompleteDateT = searchCompleteDateT;
	}
	public String getSearchCompleteDateFView() {
		return searchCompleteDateFView;
	}
	public void setSearchCompleteDateFView(String searchCompleteDateFView) {
		this.searchCompleteDateFView = searchCompleteDateFView;
	}
	public String getSearchCompleteDateTView() {
		return searchCompleteDateTView;
	}
	public void setSearchCompleteDateTView(String searchCompleteDateTView) {
		this.searchCompleteDateTView = searchCompleteDateTView;
	}
	public String getSearchTcode() {
		return searchTcode;
	}
	public void setSearchTcode(String searchTcode) {
		this.searchTcode = searchTcode;
	}
	public String getSearchPstinstNm() {
		return searchPstinstNm;
	}
	public void setSearchPstinstNm(String searchPstinstNm) {
		this.searchPstinstNm = searchPstinstNm;
	}
	public String getSearchModuleCode() {
		return searchModuleCode;
	}
	public void setSearchModuleCode(String searchModuleCode) {
		this.searchModuleCode = searchModuleCode;
	}
	public String getSearchStatus1() {
		return searchStatus1;
	}
	public void setSearchStatus1(String searchStatus1) {
		this.searchStatus1 = searchStatus1;
	}
	public String getSearchStatus2() {
		return searchStatus2;
	}
	public void setSearchStatus2(String searchStatus2) {
		this.searchStatus2 = searchStatus2;
	}
	public String getSearchStatus3() {
		return searchStatus3;
	}
	public void setSearchStatus3(String searchStatus3) {
		this.searchStatus3 = searchStatus3;
	}
	public String getSearchStatus4() {
		return searchStatus4;
	}
	public void setSearchStatus4(String searchStatus4) {
		this.searchStatus4 = searchStatus4;
	}
	public String getSearchStatus5() {
		return searchStatus5;
	}
	public void setSearchStatus5(String searchStatus5) {
		this.searchStatus5 = searchStatus5;
	}
	public String getSearchStatus6() {
		return searchStatus6;
	}
	public void setSearchStatus6(String searchStatus6) {
		this.searchStatus6 = searchStatus6;
	}
	public String getSearchSubject() {
		return searchSubject;
	}
	public void setSearchSubject(String searchSubject) {
		this.searchSubject = searchSubject;
	}
	public String getSelectStatus() {
		return selectStatus;
	}
	public void setSelectStatus(String selectStatus) {
		this.selectStatus = selectStatus;
	}
	public String getSearchAt() {
		return searchAt;
	}
	public void setSearchAt(String searchAt) {
		this.searchAt = searchAt;
	}
	public String getSearchPstinstCode() {
		return searchPstinstCode;
	}
	public void setSearchPstinstCode(String searchPstinstCode) {
		this.searchPstinstCode = searchPstinstCode;
	}
	public String getStatusNm() {
		return statusNm;
	}
	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}
	public String getModuleNm() {
		return moduleNm;
	}
	public void setModuleNm(String moduleNm) {
		this.moduleNm = moduleNm;
	}
	public String getCategoryNm() {
		return categoryNm;
	}
	public void setCategoryNm(String categoryNm) {
		this.categoryNm = categoryNm;
	}
	public String getAnsModuleNm() {
		return ansModuleNm;
	}
	public void setAnsModuleNm(String ansModuleNm) {
		this.ansModuleNm = ansModuleNm;
	}
	public String getRemail() {
		return remail;
	}
	public void setRemail(String remail) {
		this.remail = remail;
	}
	public String getPriorityNm() {
		return priorityNm;
	}
	public void setPriorityNm(String priorityNm) {
		this.priorityNm = priorityNm;
	}
	public String getTestCompleteDate() {
		return testCompleteDate;
	}
	public void setTestCompleteDate(String testCompleteDate) {
		this.testCompleteDate = testCompleteDate;
	}
	public String getTat() {
		return tat;
	}
	public void setTat(String tat) {
		this.tat = tat;
	}
	public String getTempSaveAt() {
		return tempSaveAt;
	}
	public void setTempSaveAt(String tempSaveAt) {
		this.tempSaveAt = tempSaveAt;
	}
	public String getSearchRid() {
		return searchRid;
	}
	public void setSearchRid(String searchRid) {
		this.searchRid = searchRid;
	}
	public String getSignDateDisp() {
		return signDateDisp;
	}
	public void setSignDateDisp(String signDateDisp) {
		this.signDateDisp = signDateDisp;
	}
	public String getHopeDateDisp() {
		return hopeDateDisp;
	}
	public void setHopeDateDisp(String hopeDateDisp) {
		this.hopeDateDisp = hopeDateDisp;
	}
	public String getEmailSendAt() {
		return emailSendAt;
	}
	public void setEmailSendAt(String emailSendAt) {
		this.emailSendAt = emailSendAt;
	}
	public String getAbapRealExpectTime() {
		return abapRealExpectTime;
	}
	public void setAbapRealExpectTime(String abapRealExpectTime) {
		this.abapRealExpectTime = abapRealExpectTime;
	}
	public String getAnswerSe() {
		return answerSe;
	}
	public void setAnswerSe(String answerSe) {
		this.answerSe = answerSe;
	}
	public String getSearchStatusAllCheck() {
		return searchStatusAllCheck;
	}
	public void setSearchStatusAllCheck(String searchStatusAllCheck) {
		this.searchStatusAllCheck = searchStatusAllCheck;
	}
	public String getSearchSanctnerAt() {
		return searchSanctnerAt;
	}
	public void setSearchSanctnerAt(String searchSanctnerAt) {
		this.searchSanctnerAt = searchSanctnerAt;
	}
	public String getSearchStatusRetnrn() {
		return searchStatusRetnrn;
	}
	public void setSearchStatusRetnrn(String searchStatusRetnrn) {
		this.searchStatusRetnrn = searchStatusRetnrn;
	}
	public String getSearchStatus1001At() {
		return searchStatus1001At;
	}
	public void setSearchStatus1001At(String searchStatus1001At) {
		this.searchStatus1001At = searchStatus1001At;
	}
	public String getSanctnerDate() {
		return sanctnerDate;
	}
	public void setSanctnerDate(String sanctnerDate) {
		this.sanctnerDate = sanctnerDate;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getRnameEn() {
		return rnameEn;
	}
	public void setRnameEn(String rnameEn) {
		this.rnameEn = rnameEn;
	}
	public String getAnsRnameEn() {
		return ansRnameEn;
	}
	public void setAnsRnameEn(String ansRnameEn) {
		this.ansRnameEn = ansRnameEn;
	}
	public String getPstinstNmEn() {
		return pstinstNmEn;
	}
	public void setPstinstNmEn(String pstinstNmEn) {
		this.pstinstNmEn = pstinstNmEn;
	}
	public String getStatusNmEn() {
		return statusNmEn;
	}
	public void setStatusNmEn(String statusNmEn) {
		this.statusNmEn = statusNmEn;
	}
	public String getAbapRnameEn() {
		return abapRnameEn;
	}
	public void setAbapRnameEn(String abapRnameEn) {
		this.abapRnameEn = abapRnameEn;
	}	
	public String getStatusNmCn() {
		return statusNmCn;
	}
	public void setStatusNmCn(String statusNmCn) {
		this.statusNmCn = statusNmCn;
	}
	public String getModuleNmEn() {
		return moduleNmEn;
	}
	public void setModuleNmEn(String moduleNmEn) {
		this.moduleNmEn = moduleNmEn;
	}
	public String getModuleNmCn() {
		return moduleNmCn;
	}
	public void setModuleNmCn(String moduleNmCn) {
		this.moduleNmCn = moduleNmCn;
	}
	public String getCategoryNmEn() {
		return categoryNmEn;
	}
	public void setCategoryNmEn(String categoryNmEn) {
		this.categoryNmEn = categoryNmEn;
	}
	public String getCategoryNmCn() {
		return categoryNmCn;
	}
	public void setCategoryNmCn(String categoryNmCn) {
		this.categoryNmCn = categoryNmCn;
	}
	public String getSendLanguage() {
		return sendLanguage;
	}
	public void setSendLanguage(String sendLanguage) {
		this.sendLanguage = sendLanguage;
	}
	
	public int getTotcnt() {
		return totcnt;
	}
	public void setTotcnt(int totcnt) {
		this.totcnt = totcnt;
	}
	public String getRealExpectTimeSum() {
		return realExpectTimeSum;
	}
	public void setRealExpectTimeSum(String realExpectTimeSum) {
		this.realExpectTimeSum = realExpectTimeSum;
	}
	public String getAnsTempSaveAt() {
		return AnsTempSaveAt;
	}
	public void setAnsTempSaveAt(String ansTempSaveAt) {
		AnsTempSaveAt = ansTempSaveAt;
	}
	public String getMailSenderEmplyrNm() {
		return mailSenderEmplyrNm;
	}
	public void setMailSenderEmplyrNm(String mailSenderEmplyrNm) {
		this.mailSenderEmplyrNm = mailSenderEmplyrNm;
	}
	public String getMailSenderEmail() {
		return mailSenderEmail;
	}
	public void setMailSenderEmail(String mailSenderEmail) {
		this.mailSenderEmail = mailSenderEmail;
	}
	public String getMailReceiverEmail() {
		return mailReceiverEmail;
	}
	public void setMailReceiverEmail(String mailReceiverEmail) {
		this.mailReceiverEmail = mailReceiverEmail;
	}
	public String getMailSubject() {
		return mailSubject;
	}
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getMailComment() {
		return mailComment;
	}
	public void setMailComment(String mailComment) {
		this.mailComment = mailComment;
	}
	public String getMailFileId() {
		return mailFileId;
	}
	public void setMailFileId(String mailFileId) {
		this.mailFileId = mailFileId;
	}
	public String getMailSrNo() {
		return mailSrNo;
	}
	public void setMailSrNo(String mailSrNo) {
		this.mailSrNo = mailSrNo;
	}
	public int getMailAnswerNo() {
		return mailAnswerNo;
	}
	public void setMailAnswerNo(int mailAnswerNo) {
		this.mailAnswerNo = mailAnswerNo;
	}
	public String getMailNo() {
		return mailNo;
	}
	public void setMailNo(String mailNo) {
		this.mailNo = mailNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSettleAt() {
		return settleAt;
	}
	public void setSettleAt(String settleAt) {
		this.settleAt = settleAt;
	}
	public String getSanctnerNm() {
		return sanctnerNm;
	}
	public void setSanctnerNm(String sanctnerNm) {
		this.sanctnerNm = sanctnerNm;
	}
	public String getSanctnerId() {
		return sanctnerId;
	}
	public void setSanctnerId(String sanctnerId) {
		this.sanctnerId = sanctnerId;
	}
	public String[] getPstinstCodeArr() {
		return pstinstCodeArr;
	}
	public void setPstinstCodeArr(String[] pstinstCodeArr) {
		this.pstinstCodeArr = pstinstCodeArr;
	}
	
	
}
