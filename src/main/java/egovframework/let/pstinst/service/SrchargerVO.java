package egovframework.let.pstinst.service;

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
public class SrchargerVO implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/** 모듈코드 */
	private String[] moduleCodes;
	/** 담당자ID-정 */
	private String[] userIdAs;
	/** 담당자ID-부 */
	private String[] userIdBs;

	/** 업체코드 */
	private String pstinstCode    = "";
	
	/** 업체이름 */
	private String pstinstName 	  = "";
	/** 모듈코드 */
	private String moduleCode     = "";
	/** 모듈명 */
	private String moduleName     = "";
	/** 정부구분 */
	private String mainAt         = "";
	/** 담당자ID */
	private String userId         = "";
	
	/** 담당자ID-정 */
	private String userIdA         = "";
	/** 담당자ID-부 */
	private String userIdB         = "";
	
	
	/** 담당자명 */
	private String userName       = "";
	/** 생성일자 */
	private String createDate     = "";
	/** 수정일자 */
	private String editDate       = "";
	/** 생성자 */
	private String creatorId      = "";
	/** 변경자 */
	private String editorId       = "";
	
	public String getPstinstCode() {
		return pstinstCode;
	}
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}
	public String getModuleCode() {
		return moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getMainAt() {
		return mainAt;
	}
	public void setMainAt(String mainAt) {
		this.mainAt = mainAt;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public String getPstinstName() {
		return pstinstName;
	}
	public void setPstinstName(String pstinstName) {
		this.pstinstName = pstinstName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String[] getModuleCodes() {
		return moduleCodes;
	}
	public void setModuleCodes(String[] moduleCodes) {
		this.moduleCodes = moduleCodes;
	}
	public String[] getUserIdAs() {
		return userIdAs;
	}
	public void setUserIdAs(String[] userIdAs) {
		this.userIdAs = userIdAs;
	}
	public String[] getUserIdBs() {
		return userIdBs;
	}
	public void setUserIdBs(String[] userIdBs) {
		this.userIdBs = userIdBs;
	}
	public String getUserIdA() {
		return userIdA;
	}
	public void setUserIdA(String userIdA) {
		this.userIdA = userIdA;
	}
	public String getUserIdB() {
		return userIdB;
	}
	public void setUserIdB(String userIdB) {
		this.userIdB = userIdB;
	}
	
	

}
