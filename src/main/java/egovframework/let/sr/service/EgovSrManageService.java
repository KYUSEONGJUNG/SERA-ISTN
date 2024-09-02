package egovframework.let.sr.service;

import java.io.InputStream;
import java.util.List;

import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.uss.umt.service.UserManageVO;

/**
 * SR에 관한 서비스 인터페이스 클래스를 정의한다
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
public interface EgovSrManageService {
	
	/**
	 * SR를 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	void deleteSr(SrVO srVO) throws Exception;
	
	/**
	 * SR 답변전체를 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	void deleteSrAnswerAll(SrVO srVO) throws Exception;
	
	

//	/**
//	 * SR 전체를 삭제한다.
//	 * @throws Exception
//	 */
//	void deleteAllSr() throws Exception;

	/**
	 * SR를 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	void insertSr(SrVO srVO) throws Exception;
	
	/**
	 * SR 메일을 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	void insertSrMailHisto(SrVO srVO) throws Exception;
	
	
	
	/**
	 * SR 상세항목을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	SrVO selectSrDetail(SrVO srVO) throws Exception;
	
	/**
	 * SR Count 정보
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrCntDetail(SrVO searchVO) throws Exception;
	
	/**
	 * SR답변 목록을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrAnswerList(SrAnswerVO srAnswerVO) throws Exception;
	
	/**
	 * SR답변 목록을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrAnswerListTemp(SrAnswerVO srAnswerVO) throws Exception;
	
	/**
	 * SR 목록을 조회한다.
	 * @param searchVO
	 * @return List(SR 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrList(SrVO searchVO) throws Exception;

    /**
	 * SR 총 갯수를 조회한다.
     * @param searchVO
     * @return int(SR 총 갯수)
     */
//    int selectSrListTotCnt(SrVO searchVO) throws Exception;
	SrVO selectSrListTotCnt(SrVO searchVO) throws Exception;
	
    /**
	 * SR를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrCstmr(SrVO srVO) throws Exception;
	
    /**
	 * SR를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrSanctner(SrVO srVO) throws Exception;	
	
	/**
	 * SR를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSr(SrVO srVO) throws Exception;
	
	/**
	 * SR를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrAnswer(SrVO srVO) throws Exception;
	
	/**
	 * SR 이메일을 발송 완료처리한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrEmail(SrVO srVO) throws Exception;
	
	/**
	 * 고객의견 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrAnswerCstmrComment(SrVO srVO) throws Exception;
	
//	/**
//	 * 모듈담당자 목록을 조회한다.
//	 * @param searchVO
//	 * @return List(SR 목록)
//	 * @throws Exception
//	 */
//	@SuppressWarnings("unchecked")
//	List selectCstmrList(SrchargerVO cstmrVO) throws Exception;
	
	/**
	 * SR답변을 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	void deleteSrAnswer(SrVO srVO) throws Exception;
	
	/**
	 * 답변를 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	void insertSrAnswer(SrVO srVO) throws Exception;
    
	/**
	 * SR 결제여부를 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String selectPstinstSettleAt(SrVO srVO) throws Exception;

	/**
	 * SR 답변임시저장여부를 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String selectAnsTempSaveAt(SrVO srVO) throws Exception;
	
	
	/**
	 * 파일ID를 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String selectFileId(SrVO srVO) throws Exception;
	
	/**
	 * 관리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	List selectMngrEmail(SrVO srVO) throws Exception;
	
	/**
	 * 관리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	List selectEmptyMngrEmail(SrVO srVO) throws Exception;
	
	/**
	 * 요청자명을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String strCstmrName(SrVO srVO) throws Exception;
	
	/**
	 * 요청자 Language을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String strCstmrLanguage(SrVO srVO) throws Exception;
		
	/**
	 * SR Service Level을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	String strServiceLvl(SrVO searchVO) throws Exception;
	
	
	/**
	 * 담당자 메일을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	SrVO selectChargerEmail(SrVO srVO) throws Exception;
	
	/**
	 * 처리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(SR)
	 * @throws Exception
	 */
	SrVO selectAnsChargerEmail(SrVO srVO) throws Exception;
	
	/**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    List excelDownSrReportList(SrVO searchVO) throws Exception;
    
    List excelDownSrMonthReport(SrVO searchVO) throws Exception;
    
    /**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    List excelDownSrDetailList(SrVO searchVO) throws Exception;
    
    /**
	 * 담당자및 관리자 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	List selectChargerMailList(SrVO srVO) throws Exception;
	
	/**
	 * 메일 목록 조회(이력테이블)
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	List selectMailList() throws Exception;
	
	/**
	 * 결재자 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	List selectSanctnerEmailList(SrVO srVO) throws Exception;
	
	/**
	 * 고객(현업) 메일 목록 조회
	 * @param searchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	List selectMemberEmailList(SrVO srVO) throws Exception;
	
	/**
	 * 실제공수(헤더)를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	void updateSrRealExpectTime(SrVO srVO) throws Exception;
	
	/*
	 *	CTS 정보를 삭제후 저장한다. 
	 * 
	 *
	 */
	void insertSrCts(SrCtsVO srCtsVO) throws Exception;

	void deleteSrCts(String srNo) throws Exception;
	
	List selectSrCtsList(SrVO srVO) throws Exception;
	
	
	String selectSigature(LoginVO loginVO) throws Exception;
}
