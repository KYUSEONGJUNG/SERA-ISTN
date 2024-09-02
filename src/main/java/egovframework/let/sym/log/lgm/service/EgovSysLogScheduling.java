package egovframework.let.sym.log.lgm.service;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.sr.service.EgovSrManageService;
import egovframework.let.sr.service.SrVO;
import egovframework.let.main.service.com.cop.ems.service.EgovMultiPartEmail;
import egovframework.let.main.service.com.cop.ems.service.MailSender;

/**
 * 시스템 로그 요약을 위한 스케쥴링 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.lgm)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Service("egovSysLogScheduling")
public class EgovSysLogScheduling {

	@Resource(name = "EgovSysLogService")
	private EgovSysLogService sysLogService;

	@Resource(name = "SrManageService")
	private EgovSrManageService srManageService;

	// 첨부파일 사용시
	@Resource(name = "egovMultiPartEmail")
	private EgovMultiPartEmail egovMultiPartEmail;

	@Resource(name = "mailSender")
	private MailSender mailSender;

	/**
	 * 시스템 로그정보를 요약한다. 전날의 로그를 요약하여 입력하고, 일주일전의 로그를 삭제한다.
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void sysLogSummary() throws Exception {
		sysLogService.logInsertSysLogSummary();
	}

	public void sysEmailLog() throws Exception {

		// 이메일 정보 조회
		List<SrVO> emailList = null;
		emailList = srManageService.selectMailList(); // 모듈담당자

		
		//ISTN용 발송 메일		
		if (emailList.size() != 0) {
			SrVO vo;
			Iterator<SrVO> iter = emailList.iterator();
			while (iter.hasNext()) {

				String ret = "";
				vo = (SrVO) iter.next();
				try {
					if (vo.getMailReceiverEmail().contains("@istn.co.kr")) {
						mailSender.setSenderName(vo.getMailSenderEmplyrNm()); // 보내는사람 이름
						mailSender.setEmailAddress(vo.getMailSenderEmail()); // 보내는사람 메일
						ret = mailSender.sendEmail(vo.getMailReceiverEmail(), vo.getMailSubject(), vo.getMailComment(),
								vo.getMailFileId(), vo.getMailSrNo(), vo.getMailAnswerNo()); // 받는사람 메일
					} else if (vo.getMailSenderEmail().contains("@istn.co.kr")) {
						egovMultiPartEmail.setSenderName(vo.getMailSenderEmplyrNm()); // 보내는사람 이름
						egovMultiPartEmail.setEmailAddress(vo.getMailSenderEmail()); // 보내는사람 메일
						ret = egovMultiPartEmail.sendEmail(vo.getMailReceiverEmail(), vo.getMailSubject(),
								vo.getMailComment(), vo.getMailFileId(), vo.getMailSrNo(), vo.getMailAnswerNo()); // 받는사람
																													// 메일
					} else {
//						TODO 20220412
//
//						egovMultiPartEmail.setSenderName(vo.getMailSenderEmplyrNm()); // 보내는사람 이름
//						egovMultiPartEmail.setEmailAddress("ssonghun@istn.co.kr"); // 보내는사람 메일
//						ret = egovMultiPartEmail.sendEmail(vo.getMailReceiverEmail(), vo.getMailSubject(),
//								vo.getMailComment(), vo.getMailFileId(), vo.getMailSrNo(), vo.getMailAnswerNo()); // 받는사람
//																													// 메일
						egovMultiPartEmail.setSenderName(vo.getMailSenderEmplyrNm()); // 보내는사람 이름
						egovMultiPartEmail.setEmailAddress(vo.getMailSenderEmail()); // 보내는사람 메일
						ret = egovMultiPartEmail.sendEmail(vo.getMailReceiverEmail(), vo.getMailSubject(),
								vo.getMailComment(), vo.getMailFileId(), vo.getMailSrNo(), vo.getMailAnswerNo()); // 받는사람
																													// 메일
					}
				} catch (Exception e) {
					e.printStackTrace();
					ret = "FAIL";
				}

				if ("SUCCESS".equals(ret)) {
					try {
						// 이메일 발송 완료처리
						srManageService.updateSrEmail(vo);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} 
			}
		}
	}

}
