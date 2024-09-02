package egovframework.let.sr.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.sr.service.Sr;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sr.service.SrAnswerVO;
import egovframework.let.sr.service.SrCtsVO;
import egovframework.let.uss.umt.service.UserManageVO;
import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 고객사에 대한 데이터 접근 클래스를 정의한다
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
@Repository("SrManageDAO")
public class SrManageDAO extends EgovAbstractDAO {
	
	/**
	 * SR를 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	public void deleteSr(SrVO srVO) throws Exception {
		insert("SrManageDAO.insertDeletedSr", srVO);
		delete("SrManageDAO.deleteSr", srVO);
	}
	
	/**
	 * SR답변 전체를 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	public void deleteSrAnswerAll(SrVO srVO) throws Exception {
		insert("SrManageDAO.insertDeletedSrAnswerAll", srVO);
		delete("SrManageDAO.deleteSrAnswerAll", srVO);
	}

//	/**
//	 * 고객사 전체를 삭제한다.
//	 * @throws Exception
//	 */
//	public void deleteAllSr() throws Exception {
//		delete("SrManageDAO.deleteAllSr", new Object());
//	}

	/**
	 * 고객사를 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	public void insertSr(SrVO srVO) throws Exception {
        insert("SrManageDAO.insertSr", srVO);
	}
	
	/**
	 * SR 메일을 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	public void insertSrMailHisto(SrVO srVO) throws Exception {
        insert("SrManageDAO.insertSrMailHisto", srVO);
	}
	
	
	/**
	 * 고객사 상세항목을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public SrVO selectSrDetail(SrVO srVO) throws Exception {
		return (SrVO) selectByPk("SrManageDAO.selectSrDetail", srVO);
	}
	
	/**
	 * SR Count 상세항목을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	@SuppressWarnings("unchecked")
	public List selectSrCntDetail(SrVO searchVO) throws Exception {
        return list("SrManageDAO.selectSrCntDetail", searchVO);
    }
	
	/**
	 * SR Count 상세항목을 조회한다.(협력담당자용)
	 * @param sr
	 * @return Sr(고객사)
	 */
	@SuppressWarnings("unchecked")
	public List selectCooperSrCntDetail(SrVO searchVO) throws Exception {
        return list("SrManageDAO.selectCooperSrCntDetail", searchVO);
    }
	/**
	 * SR답변 목록을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	@SuppressWarnings("unchecked")
	public List selectSrAnswerList(SrAnswerVO srAnswerVO) throws Exception {
        return list("SrManageDAO.selectSrAnswerList", srAnswerVO);
    }
	
	/**
	 * SR답변 목록을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	@SuppressWarnings("unchecked")
	public List selectSrAnswerListTemp(SrAnswerVO srAnswerVO) throws Exception {
        return list("SrManageDAO.selectSrAnswerListTemp", srAnswerVO);
    }


    /**
	 * 고객사 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectSrList(SrVO searchVO) throws Exception {
        return list("SrManageDAO.selectSrList", searchVO);
    }

    
    /**
	 * 담당자(협력)의 고객사 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectCooperSrList(SrVO searchVO) throws Exception {
        return list("SrManageDAO.selectCooperSrList", searchVO);
    }

    
    
    
    
    /**
	 * 고객사 총 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
//    public int selectSrListTotCnt(SrVO searchVO) throws Exception {
//        return (Integer)getSqlMapClientTemplate().queryForObject("SrManageDAO.selectSrListTotCnt", searchVO);
//    }
    public SrVO selectSrListTotCnt(SrVO searchVO) throws Exception {
        return (SrVO) selectByPk("SrManageDAO.selectSrListTotCnt", searchVO);
    }
    
    
    public SrVO selectCooperSrListTotCnt(SrVO searchVO) throws Exception {
        return (SrVO) selectByPk("SrManageDAO.selectCooperSrListTotCnt", searchVO);
    }    
    /**
	 * 고객사를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrCstmr(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrCstmr", srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrSanctner(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrSanctner", srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSr(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSr", srVO);
	}
	
	/**
	 * 고객사를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrAnswer(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrAnswer", srVO);
	}
	
	/**
	 * SR 이메일을 발송 완료처리한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrEmail(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrEmail", srVO);
	}
	
	/**
	 * 고객의견 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrAnswerCstmrComment(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrAnswerCstmrComment", srVO);
	}
	
//	/**
//	 * 모듈담당자 목록을 조회한다.
//     * @param searchVO
//     * @return List(고객사 목록)
//     * @throws Exception
//     */
//    @SuppressWarnings("unchecked")
//	public List selectSrAnswerList(SrAnswerVO srAnswerVO) throws Exception {
//        return list("SrManageDAO.selectSrAnswerList", srAnswerVO);
//    }
    
    /**
	 * SR답변을 삭제한다.
	 * @param sr
	 * @throws Exception
	 */
	public void deleteSrAnswer(SrVO srVO) throws Exception {
		insert("SrManageDAO.insertDeletedSrAnswer", srVO);
		delete("SrManageDAO.deleteSrAnswer", srVO);
	}
	
	/**
	 * 답변를 등록한다.
	 * @param sr
	 * @throws Exception
	 */
	public void insertSrAnswer(SrVO srVO) throws Exception {
        insert("SrManageDAO.insertSrAnswer", srVO);
	}
    
	/**
	 * 고객사 결제여부를 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public String selectPstinstSettleAt(SrVO srVO) throws Exception {
		return (String) selectByPk("SrManageDAO.selectPstinstSettleAt", srVO);
	}
	
	/**
	 * SR 답변임시저장여부를 조회한다.
	 * @param sr
	 * @return Sr
	 */
	public String selectAnsTempSaveAt(SrVO srVO) throws Exception {
		return (String) selectByPk("SrManageDAO.selectAnsTempSaveAt", srVO);
	}
	
	/**
	 * 파일ID를 조회한다.
	 * @param sr
	 * @return Sr
	 */
	public String selectFileId(SrVO srVO) throws Exception {
		return (String) selectByPk("SrManageDAO.selectFileId", srVO);
	}
	
	/**
	 * 관리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public List selectMngrEmail(SrVO srVO) throws Exception {
		return (List) list("SrManageDAO.selectMngrEmail", srVO);
	}
	
	/**
	 * 관리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public List selectEmptyMngrEmail(SrVO srVO) throws Exception {
		return (List) list("SrManageDAO.selectEmptyMngrEmail", srVO);
	}
	
	/**
	 * 요청자명을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public String strCstmrName(SrVO srVO) throws Exception {
		return (String) selectByPk("SrManageDAO.strCstmrName", srVO);
	}
	
	/**
	 * 요청자 Language을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public String strCstmrLanguage(SrVO srVO) throws Exception {
		return (String) selectByPk("SrManageDAO.strCstmrLanguage", srVO);
	}
	
	/**
	 * SR Service Level을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public String strServiceLvl(SrVO searchVO) throws Exception {
		return (String) selectByPk("SrManageDAO.strServiceLvl", searchVO);
	}
	
	/**
	 * 담당자 메일을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public SrVO selectChargerEmail(SrVO srVO) throws Exception {
		return (SrVO) selectByPk("SrManageDAO.selectChargerEmail", srVO);
	}
	
	/**
	 * 처리자 메일을 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public SrVO selectAnsChargerEmail(SrVO srVO) throws Exception {
		return (SrVO) selectByPk("SrManageDAO.selectAnsChargerEmail", srVO);
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
        return list("SrManageDAO.excelDownSrReportList", searchVO);
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
        return list("SrManageDAO.excelDownSrDetailList", searchVO);
    }
    
    /**
     * 담당자및 관리자 메일 목록 조회
     * @param searchVO 검색조건
     * @return List 업무사용자 목록정보
     */
	public List selectChargerMailList(SrVO srVO) throws Exception {
        return list("SrManageDAO.selectChargerMailList", srVO);
    }
	
	/**
     * 메일 목록 조회(이력테이블)
     * @param searchVO 검색조건
     * @return List 업무사용자 목록정보
     */
	public List selectMailList() throws Exception {
        return list("SrManageDAO.selectMailList", null);
    }
	
	/**
     * 결재자 메일 목록 조회
     * @param searchVO 검색조건
     * @return List 업무사용자 목록정보
     */
	public List selectSanctnerEmailList(SrVO srVO) throws Exception {
        return list("SrManageDAO.selectSanctnerEmailList", srVO);
    }
	
	/**
     * 고객(현업) 메일 목록 조회
     * @param searchVO 검색조건
     * @return List 업무사용자 목록정보
     */
	public List selectMemberEmailList(SrVO srVO) throws Exception {
        return list("SrManageDAO.selectMemberEmailList", srVO);
    }
	
	/**
	 * 실제공수(헤더)를 수정한다.
	 * @param sr
	 * @throws Exception
	 */
	public void updateSrRealExpectTime(SrVO srVO) throws Exception {
		update("SrManageDAO.updateSrRealExpectTime", srVO);
	}
	
	public void deleteCts(String srNo) throws Exception{
		delete("SrManageDAO.deleteCts", srNo);
	}
	
	public void insertCts(SrCtsVO srCts) throws Exception{
		insert("SrManageDAO.insertCts",srCts);
	}
	
	public List selectSrCtsList(SrVO srVO) throws Exception{
		return list("SrManageDAO.selectSrCtsList",srVO);
	}
	
	public String selectSigature(LoginVO loginVO) throws Exception{
		return (String) selectByPk("SrManageDAO.selectSigature",loginVO);
	}

	public List excelDownSrMonthReport(SrVO searchVO) {
		// TODO Auto-generated method stub
		return list("SrManageDAO.excelDownSrMonthReport", searchVO);
	}

}
