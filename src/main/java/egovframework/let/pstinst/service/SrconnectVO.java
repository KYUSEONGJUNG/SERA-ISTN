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
public class SrconnectVO implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String pstinstCode = "";
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
	
	
	public String getPstinstCode() {
		return pstinstCode;
	}
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}
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
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	
	
}
