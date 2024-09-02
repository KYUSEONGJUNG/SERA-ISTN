package egovframework.let.main.service.com.cop.ems.service;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import egovframework.let.main.service.com.cmm.service.EgovFileMngService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngUtil;
import egovframework.let.main.service.com.cmm.service.FileVO;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.ibatis.annotations.Property;
import org.egovframe.rte.fdl.property.EgovPropertyService;

import egovframework.let.sr.service.EgovSrManageService;
import egovframework.let.sr.service.SrVO;

import java.util.Iterator;

/**
 * 발송메일에 첨부파일용으로 사용되는 VO 클래스
 * @author 공통서비스 개발팀 이기하
 * @since 2011.12.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *    수정일      	수정자          수정내용
 *  ----------     --------    ---------------------------
 *  2011.12.06		이기하          최초 생성 
 *  2013.05.23		이기하          thread-safe 하게 변경
 *  
 *  </pre>
 */

public class EgovMultiPartEmail implements Serializable{

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "EgovFileMngService")
    protected EgovFileMngService fileService;
    
    @Resource(name = "SrManageService")
    private EgovSrManageService srManageService;
    
    /** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	private static final long serialVersionUID = -4322006921324597283L;
	protected String id;
	protected String password;
	protected int port;
	protected String host;
	protected String emailAddress;
	protected String senderName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}
	
	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	@Deprecated
	public String send() throws EmailException {
		MultiPartEmail email = new MultiPartEmail();
		
		email.setCharset("UTF-8");
		email.setHostName(this.host);
		email.setSmtpPort(this.port);
		email.setTLS(true);
		email.setAuthenticator(new DefaultAuthenticator(this.id, this.password));
		email.setSocketConnectionTimeout(60000);
		email.setSocketTimeout(60000);
		email.setFrom(this.emailAddress, this.senderName);


		
		return email.send();
	}
	
	public String send(String addTo, String subject, String msg) throws Exception {
		return send(addTo, subject, msg, null, null, 0);
	}

	public String send(String addTo, String subject, String msg, String atchFileId, String srNo, int answerNo) throws Exception {
		
		String imgStr = "<img";
		int currentPos = 0;
		
		SrVO srVO = new SrVO();
		srVO.setMailSenderEmplyrNm(this.senderName);
		srVO.setMailSenderEmail(this.emailAddress);
		srVO.setMailReceiverEmail(addTo);
		srVO.setMailSubject(subject);
		
		while(true) {
			int imgPos = msg.indexOf(imgStr, currentPos);
			
			if(msg == null || msg.equals("") || imgPos == -1) break;
			else {
				int imgEndPos = msg.indexOf(">", imgPos + imgStr.length());
				int imgStylePos = msg.indexOf("style=", imgPos + imgStr.length());
				
				if(imgStylePos != -1 && imgStylePos < imgEndPos) {
					msg = msg.substring(0, imgStylePos+7) + "width : 100% ; height : auto; " + msg.substring(imgStylePos+7);
				}
				currentPos = imgPos +1;
			}
		} 
		
		srVO.setMailComment(msg);
		srVO.setMailFileId(atchFileId);
		srVO.setMailSrNo(srNo);
		srVO.setMailAnswerNo(answerNo);
		srManageService.insertSrMailHisto(srVO);
		
		return null;
	}

	public String sendEmail(String addTo, String subject, String msg, String atchFileId, String srNo, int answerNo) throws Exception {
		
		//HTML Email 발송.
		HtmlEmail email = new HtmlEmail();

		String ret = "";
		
		email.setCharset("UTF-8");
		email.setHostName(this.host);
		email.setSmtpPort(this.port);
		email.setAuthenticator(new DefaultAuthenticator(this.id, this.password));
		email.setSSLOnConnect(false);
		email.setSocketConnectionTimeout(60000);
		email.setSocketTimeout(60000);
		String developFlag = propertiesService.getString("Globals.DevelopFlag");
		if (this.emailAddress.contains("@istn.co.kr") || addTo.contains("@istn.co.kr")) {
			email.setFrom(this.emailAddress, this.senderName);
			if(developFlag != null && developFlag.equals("Y")) {
				email.addTo(propertiesService.getString("Globals.DevelopMailAddress"));
			}else {
				email.addTo(addTo);
			}
		}else{
			email.setFrom("istncc@istn.co.kr",this.senderName);
			if(developFlag != null && developFlag.equals("Y")) {
				email.addTo(propertiesService.getString("Globals.DevelopMailAddress"));
			}else {
				email.addTo(addTo);
			}
			email.addReplyTo(this.emailAddress,this.senderName);
		}
		

		
		email.setSubject(subject);
		email.setMsg(msg);

		//아래 첨부파일 로직 제외함.. 에러로 발송 못함. WBPARK 2016.12.20
		FileVO fileVO = new FileVO();
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);
	    if(result.size() != 0){	//담당자 및 결재자에게 메일발송
	    	FileVO vo;
			Iterator<FileVO> iter = result.iterator();
			while (iter.hasNext()) {
				vo = (FileVO)iter.next();
				
				EmailAttachment attachment = new EmailAttachment();
				attachment.setPath(vo.getFileStreCours().concat(vo.getStreFileNm()));
				attachment.setDisposition(EmailAttachment.ATTACHMENT);
				attachment.setName(MimeUtility.encodeText(vo.getOrignlFileNm(),"UTF-8","B"));
				email.attach(attachment);
			}
		}
			    		
        try {
        	email.send();
        	ret = "SUCCESS";
        }catch(Exception e) {
        	ret = "FAIL";
            System.out.println("MailException발생");
            e.printStackTrace();
        }

        return ret;
		
	}	
	
	public String sendMessage(SrVO srVO) {
		return "";
	}
}


