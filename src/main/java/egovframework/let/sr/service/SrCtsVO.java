package egovframework.let.sr.service;

import java.io.Serializable;
import java.util.List;

import egovframework.let.main.service.com.cmm.ComDefaultVO;

public class SrCtsVO extends ComDefaultVO implements Serializable {

	private static final long serialVersionUID = 1L;	
	private String srNo           = "";
	private String cts_number	  = "";
	private String cts_desc		  = "";
	private String cts_owner 	  = "";
	private int    cts_seq		  = 0;
	/** 생성일자 */
	private String createDate     = "";
	/** 생성자 */
	private String creatorId      = "";

	private String[] cts_numbers;
	private String[] cts_descs;
	private String[] cts_owners;
	
	
	public String[] getCts_numbers() {
		return cts_numbers;
	}
	public void setCts_numbers(String[] cts_numbers) {
		this.cts_numbers = cts_numbers;
	}
	public String[] getCts_descs() {
		return cts_descs;
	}
	public void setCts_descs(String[] cts_descs) {
		this.cts_descs = cts_descs;
	}
	public String[] getCts_owners() {
		return cts_owners;
	}
	public void setCts_owners(String[] cts_owners) {
		this.cts_owners = cts_owners;
	}
	private List<SrCtsVO> srCtsVOList;
	
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getCts_number() {
		return cts_number;
	}
	public void setCts_number(String cts_number) {
		this.cts_number = cts_number;
	}
	public String getCts_desc() {
		return cts_desc;
	}
	public void setCts_desc(String cts_desc) {
		this.cts_desc = cts_desc;
	}
	public String getCts_owner() {
		return cts_owner;
	}
	public void setCts_owner(String cts_owner) {
		this.cts_owner = cts_owner;
	}
	public List<SrCtsVO> getSrCtsVOList() {
		return srCtsVOList;
	}
	public void setSrCtsVOList(List<SrCtsVO> srCtsVOList) {
		this.srCtsVOList = srCtsVOList;
	}
	public int getCts_seq() {
		return cts_seq;
	}
	public void setCts_seq(int cts_seq) {
		this.cts_seq = cts_seq;
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
	
	

}