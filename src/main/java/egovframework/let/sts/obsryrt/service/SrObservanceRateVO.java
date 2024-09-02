package egovframework.let.sts.obsryrt.service;

import java.io.Serializable;

import egovframework.let.main.service.com.cmm.ComDefaultVO;

public class SrObservanceRateVO extends ComDefaultVO implements Serializable {
	
	/** 검색-요청일(접수확인일) */
	private String searchConfirmDateF    = "";
	private String searchConfirmDateT    = "";
	private String searchConfirmDateFView    = "";
	private String searchConfirmDateTView    = "";
	
	/** 업체코드 배열 */
	private String[] pstinstCodeArr;
	
	/** 검색에 의한 조건 여부 */
	private String searchAt = "";

	/** 업체코드 */
	private String pstinstCode     = "";
	/** 담당자 아이디 */
	private String rid            = "";
	
	/** 모듈코드 */
	private String moduleCode     = "";
	/** 모듈명 */
	private String moduleName           = "";
	
	/** 요청건수 */
	private String signCnt       = "";	
	/** 접수건수 */
	private String confirmCnt    = "";
	/** 당일접수건수 */
	private String inConfirmCnt    = "";
	/** 완료건수 */
	private String completeCnt    = "";
	/** 납기내완료건수 */
	private String inCompleteCnt    = "";
	/** 당일접수 준수율 */
	private String inConfirmRate           = "";
	/** 납기 준수율 */
	private String inCompleteRate           = "";
	
	private String moduleNameEn = "";

	private String moduleNameCn = "";

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

	public String getSignCnt() {
		return signCnt;
	}

	public void setSignCnt(String signCnt) {
		this.signCnt = signCnt;
	}

	public String getConfirmCnt() {
		return confirmCnt;
	}

	public void setConfirmCnt(String confirmCnt) {
		this.confirmCnt = confirmCnt;
	}

	public String getInConfirmCnt() {
		return inConfirmCnt;
	}

	public void setInConfirmCnt(String inConfirmCnt) {
		this.inConfirmCnt = inConfirmCnt;
	}

	public String getCompleteCnt() {
		return completeCnt;
	}

	public void setCompleteCnt(String completeCnt) {
		this.completeCnt = completeCnt;
	}

	public String getInCompleteCnt() {
		return inCompleteCnt;
	}

	public void setInCompleteCnt(String inCompleteCnt) {
		this.inCompleteCnt = inCompleteCnt;
	}

	public String getInConfirmRate() {
		return inConfirmRate;
	}

	public void setInConfirmRate(String inConfirmRate) {
		this.inConfirmRate = inConfirmRate;
	}

	public String getInCompleteRate() {
		return inCompleteRate;
	}

	public void setInCompleteRate(String inCompleteRate) {
		this.inCompleteRate = inCompleteRate;
	}

	public String getPstinstCode() {
		return pstinstCode;
	}

	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getSearchAt() {
		return searchAt;
	}

	public void setSearchAt(String searchAt) {
		this.searchAt = searchAt;
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
