package egovframework.let.pstinst.service;

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
public class Pstinst implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;	
	
	/** 업체코드 */
	private String pstinstCode    = "";
	/** 업체약어 */
	private String pstinstAbrv    = "";	
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
	private String searchPstinstNm;
	/** 검색-업체명 */
	private String searchPstinstCode;
	/** 검색-삭제여부 */
	private String searchDelAt;
	
	private String connMethodCode = "";
	private String vpnUrl = "";
	private String vpnAddr = "";
	private String vpnPort = "";
	private String vpnId = "";
	private String vpnPasswd = "";
	private String otp = "";
	private String remark = "";
	private String solman = "";
	private String fileId = "";
	
	
	private String nameDetail = "";
	private String typeCode = "";
	private String sid = "";
	private String ins = "";
	private String ipAddr = "";
	private String sapId = "";
	private String sapPasswd = "";
	private String client = "";
	
	private String[] nameDetails;
	private String[] typeCodes;
	private String[] sids;
	private String[] inss;
	private String[] ipAddrs;
	private String[] sapIds;
	private String[] sapPasswds;
	private String[] clients;
	
	public String getNameDetail() {
		return nameDetail;
	}
	public void setNameDetail(String nameDetail) {
		this.nameDetail = nameDetail;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getIns() {
		return ins;
	}
	public void setIns(String ins) {
		this.ins = ins;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getSapId() {
		return sapId;
	}
	public void setSapId(String sapId) {
		this.sapId = sapId;
	}
	public String getSapPasswd() {
		return sapPasswd;
	}
	public void setSapPasswd(String sapPasswd) {
		this.sapPasswd = sapPasswd;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String[] getNameDetails() {
		return nameDetails;
	}
	public void setNameDetails(String[] nameDetails) {
		this.nameDetails = nameDetails;
	}
	public String[] getTypeCodes() {
		return typeCodes;
	}
	public void setTypeCodes(String[] typeCodes) {
		this.typeCodes = typeCodes;
	}
	public String[] getSids() {
		return sids;
	}
	public void setSids(String[] sids) {
		this.sids = sids;
	}
	public String[] getInss() {
		return inss;
	}
	public void setInss(String[] inss) {
		this.inss = inss;
	}
	public String[] getIpAddrs() {
		return ipAddrs;
	}
	public void setIpAddrs(String[] ipAddrs) {
		this.ipAddrs = ipAddrs;
	}
	public String[] getSapIds() {
		return sapIds;
	}
	public void setSapIds(String[] sapIds) {
		this.sapIds = sapIds;
	}
	public String[] getSapPasswds() {
		return sapPasswds;
	}
	public void setSapPasswds(String[] sapPasswds) {
		this.sapPasswds = sapPasswds;
	}
	public String[] getClients() {
		return clients;
	}
	public void setClients(String[] clients) {
		this.clients = clients;
	}
	public String getPstinstCode() {
		return pstinstCode;
	}
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
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
	public String getSearchPstinstNm() {
		return searchPstinstNm;
	}
	public void setSearchPstinstNm(String searchPstinstNm) {
		this.searchPstinstNm = searchPstinstNm;
	}
	public String getSearchDelAt() {
		return searchDelAt;
	}
	public void setSearchDelAt(String searchDelAt) {
		this.searchDelAt = searchDelAt;
	}
	public String getPstinstAbrv() {
		return pstinstAbrv;
	}
	public void setPstinstAbrv(String pstinstAbrv) {
		this.pstinstAbrv = pstinstAbrv;
	}
	
	/**
	 * @return the searchPstinstCode
	 */
	public String getSearchPstinstCode() {
		return searchPstinstCode;
	}
	/**
	 * @param searchPstinstCode the searchPstinstCode to set
	 */
	public void setSearchPstinstCode(String searchPstinstCode) {
		this.searchPstinstCode = searchPstinstCode;
	}
	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getVpnUrl() {
		return vpnUrl;
	}
	public void setVpnUrl(String vpnUrl) {
		this.vpnUrl = vpnUrl;
	}
	public String getVpnAddr() {
		return vpnAddr;
	}
	public void setVpnAddr(String vpnAddr) {
		this.vpnAddr = vpnAddr;
	}
	public String getVpnPort() {
		return vpnPort;
	}
	public void setVpnPort(String vpnPort) {
		this.vpnPort = vpnPort;
	}
	public String getVpnId() {
		return vpnId;
	}
	public void setVpnId(String vpnId) {
		this.vpnId = vpnId;
	}
	public String getVpnPasswd() {
		return vpnPasswd;
	}
	public void setVpnPasswd(String vpnPasswd) {
		this.vpnPasswd = vpnPasswd;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getConnMethodCode() {
		return connMethodCode;
	}
	public void setConnMethodCode(String connMethodCode) {
		this.connMethodCode = connMethodCode;
	}
	public String getSolman() {
		return solman;
	}
	public void setSolman(String solman) {
		this.solman = solman;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
}
