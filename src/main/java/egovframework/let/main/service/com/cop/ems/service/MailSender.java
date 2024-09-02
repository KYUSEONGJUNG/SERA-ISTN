package egovframework.let.main.service.com.cop.ems.service;

import java.util.Iterator;
import java.util.List;

import javax.mail.internet.MimeUtility;

import egovframework.let.main.service.com.cmm.service.FileVO;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;

public class MailSender extends EgovMultiPartEmail{
	
	public String sendEmail(String addTo, String subject, String msg, String atchFileId, String srNo, int answerNo) throws Exception {
		
		//HTML Email 발송.
		HtmlEmail email = new HtmlEmail();
//		MultiPartEmail email = new MultiPartEmail();
		
		String ret = "";
		
		email.setCharset("UTF-8");
		email.setHostName(this.host);
		email.setSmtpPort(this.port);
//		email.setAuthenticator(new DefaultAuthenticator(this.id, this.password));
		email.setSocketConnectionTimeout(60000);
		email.setSocketTimeout(60000);
		email.setFrom(this.emailAddress, this.senderName);
		String developFlag = propertiesService.getString("Globals.DevelopFlag");
		if(developFlag != null && developFlag.equals("Y")) {
			email.addTo(propertiesService.getString("Globals.DevelopMailAddress"));
		}else {
			email.addTo(addTo);
		}		
		email.setSubject(subject);		
		email.setMsg(msg);
//      email.setSSL(true);

		
		
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
//			    attachment.setPath("C:\\Users\\LeeMin\\Pictures\\img_loginbg2.jpg");
				attachment.setPath(vo.getFileStreCours().concat(vo.getStreFileNm()));
				attachment.setDisposition(EmailAttachment.ATTACHMENT);
//				attachment.setDescription("첨부 관련 TEST입니다");
//				attachment.setName("xxxx.jpg"); 						
//				attachment.setName(vo.getOrignlFileNm());
//				attachment.setName(vo.getStreFileNm().concat(".").concat(vo.fileExtsn));
				attachment.setName(MimeUtility.encodeText(vo.getOrignlFileNm(),"UTF-8","B"));
//				mbp.setFileName(MimeUtility.encodeText(fds.getName(),"EUC-KR","B"));   //한글파일네임을 적기 위해서
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
}
