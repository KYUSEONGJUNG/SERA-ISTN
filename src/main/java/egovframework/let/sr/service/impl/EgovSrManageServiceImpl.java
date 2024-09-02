package egovframework.let.sr.service.impl;

import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.sr.service.EgovSrManageService;
import egovframework.let.sr.service.Sr;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sr.service.SrAnswerVO;
import egovframework.let.sr.service.SrCtsVO;
import egovframework.let.uss.umt.service.UserManageVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 고객사에 대한 서비스 구현클래스를 정의한다
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
@Service("SrManageService")
public class EgovSrManageServiceImpl extends EgovAbstractServiceImpl implements EgovSrManageService {

    @Resource(name="SrManageDAO")
    private SrManageDAO srManageDAO;

    /**
	 * SR를 삭제한다.
	 */
	public void deleteSr(SrVO srVO) throws Exception {
		srManageDAO.deleteSr(srVO);
	}
	
	/**
	 * SR답변 전체를 삭제한다.
	 */
	public void deleteSrAnswerAll(SrVO srVO) throws Exception {
		srManageDAO.deleteSrAnswerAll(srVO);
	}

//	/**
//	 * 고객사 전체를 삭제한다.
//	 */
//	public void deleteAllSr() throws Exception {
//		srManageDAO.deleteAllSr();
//	}

	/**
	 * 고객사를 등록한다.
	 */
	public void insertSr(SrVO srVO) throws Exception {
    	srManageDAO.insertSr(srVO);    	
	}
	
	/**
	 * SR 메일을 등록한다.
	 */
	public void insertSrMailHisto(SrVO srVO) throws Exception {
    	srManageDAO.insertSrMailHisto(srVO);    	
	}

	/**
	 * 고객사 상세항목을 조회한다.
	 */
	public SrVO selectSrDetail(SrVO srVO) throws Exception {
    	return srManageDAO.selectSrDetail(srVO);
	}
	
	/**
	 * SR Count 상세항목을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrCntDetail(SrVO searchVO) throws Exception {
//		if("ROLE_COOPERATION".equals(searchVO.getAuthorCode())){
//			return srManageDAO.selectCooperSrCntDetail(searchVO);
//		}else {
//			return srManageDAO.selectSrCntDetail(searchVO);
//		}
		return srManageDAO.selectSrCntDetail(searchVO);
	}
	
	/**
	 * SR답변 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrAnswerList(SrAnswerVO srAnswerVO) throws Exception {
        return srManageDAO.selectSrAnswerList(srAnswerVO);
	}
	
	/**
	 * SR답변 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrAnswerListTemp(SrAnswerVO srAnswerVO) throws Exception {
        return srManageDAO.selectSrAnswerListTemp(srAnswerVO);
	}

	/**
	 * 고객사 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrList(SrVO searchVO) throws Exception {
//		if("ROLE_COOPERATION".equals(searchVO.getAuthorCode())){
//			return srManageDAO.selectCooperSrList(searchVO);			
//		}else {
//			return srManageDAO.selectSrList(searchVO);
//		}
		return srManageDAO.selectSrList(searchVO);
	}

	/**
	 * 고객사 총 갯수를 조회한다.
	 */
//	public int selectSrListTotCnt(SrVO searchVO) throws Exception {
//        return srManageDAO.selectSrListTotCnt(searchVO);
//	}
	public SrVO selectSrListTotCnt(SrVO searchVO) throws Exception {
//		if("ROLE_COOPERATION".equals(searchVO.getAuthorCode())){
//			return srManageDAO.selectCooperSrListTotCnt(searchVO);
//		}else {
//			return srManageDAO.selectSrListTotCnt(searchVO);
//		}
		return srManageDAO.selectSrListTotCnt(searchVO);
	}

	/**
	 * 고객사를 수정한다.
	 */
	public void updateSrCstmr(SrVO srVO) throws Exception {
		srManageDAO.updateSrCstmr(srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 */
	public void updateSrSanctner(SrVO srVO) throws Exception {
		srManageDAO.updateSrSanctner(srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 */
	public void updateSr(SrVO srVO) throws Exception {
		srManageDAO.updateSr(srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 */
	public void updateSrAnswer(SrVO srVO) throws Exception {
		srManageDAO.updateSrAnswer(srVO);
	}
	
	/**
	 * SR 이메일을 발송 완료처리한다.
	 */
	public void updateSrEmail(SrVO srVO) throws Exception {
		srManageDAO.updateSrEmail(srVO);
	}
	
	/**
	 * 고객의견 등록한다.
	 */
	public void updateSrAnswerCstmrComment(SrVO srVO) throws Exception {
		srManageDAO.updateSrAnswerCstmrComment(srVO);
	}
	
//	/**
//	 * 모듈담당자 목록을 조회한다.
//	 */
//	@SuppressWarnings("unchecked")
//	public List selectSrAnswerList(SrAnswerVO srAnswerVO) throws Exception {
//        return srManageDAO.selectSrAnswerList(srAnswerVO);
//	}
	
	/**
	 * SR답변을 삭제한다.
	 */
	public void deleteSrAnswer(SrVO srVO) throws Exception {
		srManageDAO.deleteSrAnswer(srVO);
	}
	
	/**
	 * 답변를 등록한다.
	 */
	public void insertSrAnswer(SrVO srVO) throws Exception {
    	srManageDAO.insertSrAnswer(srVO);    	
	}
	
	/**
	 * 고객사 결제여부를 조회한다.
	 */
	public String selectPstinstSettleAt(SrVO srVO) throws Exception {
    	return srManageDAO.selectPstinstSettleAt(srVO);
	}
	
	/**
	 * SR 답변임시저장여부를 조회한다.
	 */
	public String selectAnsTempSaveAt(SrVO srVO) throws Exception {
    	return srManageDAO.selectAnsTempSaveAt(srVO);
	}
	
	/**
	 * 파일ID를 조회한다.
	 */
	public String selectFileId(SrVO srVO) throws Exception {
    	return srManageDAO.selectFileId(srVO);
	}
	
	/**
	 * 관리자 메일을 조회한다.
	 */
	public List selectMngrEmail(SrVO srVO) throws Exception {
    	return srManageDAO.selectMngrEmail(srVO);
	}
	
	/**
	 * 관리자 메일을 조회한다.
	 */
	public List selectEmptyMngrEmail(SrVO srVO) throws Exception {
    	return srManageDAO.selectEmptyMngrEmail(srVO);
	}
	
	
	/**
	 * 요청자명을 조회한다.
	 */
	public String strCstmrName(SrVO srVO) throws Exception {
    	return srManageDAO.strCstmrName(srVO);
	}
	
	/**
	 * 요청자 Language을 조회한다.
	 */
	public String strCstmrLanguage(SrVO srVO) throws Exception {
    	return srManageDAO.strCstmrLanguage(srVO);
	}
	
	/**
	 * SR Service Level을 조회한다.
	 */
	public String strServiceLvl(SrVO searchVO) throws Exception {
    	return srManageDAO.strServiceLvl(searchVO);
	}
	
	/**
	 * 담당자 메일을 조회한다.
	 */
	public SrVO selectChargerEmail(SrVO srVO) throws Exception {
    	return srManageDAO.selectChargerEmail(srVO);
	}
	
	/**
	 * 처리자 메일을 조회한다.
	 */
	public SrVO selectAnsChargerEmail(SrVO srVO) throws Exception {
    	return srManageDAO.selectAnsChargerEmail(srVO);
	}
	
	/**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownSrReportList(SrVO searchVO) throws Exception {
        return srManageDAO.excelDownSrReportList(searchVO);
    }
    
    public List excelDownSrMonthReport(SrVO searchVO) throws Exception {
        return srManageDAO.excelDownSrMonthReport(searchVO);
    }
    
    /**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownSrDetailList(SrVO searchVO) throws Exception {
        return srManageDAO.excelDownSrDetailList(searchVO);
    }
    
    /**
	 * 담당자및 관리자 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List selectChargerMailList(SrVO srVO) throws Exception {
		return  srManageDAO.selectChargerMailList(srVO);
	}
	
	/**
	 * 메일 목록 조회(이력테이블)
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List selectMailList() throws Exception {
		return  srManageDAO.selectMailList();
	}
	
	/**
	 * 결재자 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List selectSanctnerEmailList(SrVO srVO) throws Exception {
		return  srManageDAO.selectSanctnerEmailList(srVO);
	}
	
	/**
	 * 고객(현업) 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List selectMemberEmailList(SrVO srVO) throws Exception {
		return  srManageDAO.selectMemberEmailList(srVO);
	}
	
	/**
	 * 실제공수(헤더)를 수정한다.
	 */
	public void updateSrRealExpectTime(SrVO srVO) throws Exception {
		srManageDAO.updateSrRealExpectTime(srVO);
	}
	
	public void deleteSrCts(String srNo) throws Exception{
		srManageDAO.deleteCts(srNo);
	}
	
	public void insertSrCts(SrCtsVO srCtsVO) throws Exception{
		srManageDAO.insertCts(srCtsVO);	
	}
	
	public List selectSrCtsList(SrVO srVO) throws Exception{
		return srManageDAO.selectSrCtsList(srVO);
	}
	
	
	public String selectSigature(LoginVO loginVO) throws Exception{
		return srManageDAO.selectSigature(loginVO);
	}
}