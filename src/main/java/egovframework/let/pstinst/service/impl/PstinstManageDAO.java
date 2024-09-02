package egovframework.let.pstinst.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.pstinst.service.Pstinst;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.pstinst.service.SrchargerVO;
import egovframework.let.pstinst.service.SrconnectVO;
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
@Repository("PstinstManageDAO")
public class PstinstManageDAO extends EgovAbstractDAO {
	
	/**
	 * 고객사를 삭제한다.
	 * @param pstinst
	 * @throws Exception
	 */
	public void deletePstinst(Pstinst pstinst) throws Exception {
		delete("PstinstManageDAO.deletePstinst", pstinst);
	}

	/**
	 * 고객사 전체를 삭제한다.
	 * @throws Exception
	 */
	public void deleteAllPstinst() throws Exception {
		delete("PstinstManageDAO.deleteAllPstinst", new Object());
	}

	/**
	 * 고객사를 등록한다.
	 * @param pstinst
	 * @throws Exception
	 */
	public void insertPstinst(PstinstVO pstinstVO) throws Exception {
        insert("PstinstManageDAO.insertPstinst", pstinstVO);
	}
	
	/**
	 * 고객사 상세항목을 조회한다.
	 * @param pstinst
	 * @return Pstinst(고객사)
	 */
	public Pstinst selectPstinstDetail(Pstinst pstinst) throws Exception {
		return (Pstinst) selectByPk("PstinstManageDAO.selectPstinstDetail", pstinst);
	}


    /**
	 * 고객사 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectPstinstList(PstinstVO searchVO) throws Exception {
        return list("PstinstManageDAO.selectPstinstList", searchVO);
    }

    /**
	 * 고객사 총 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
    public int selectPstinstListTotCnt(PstinstVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("PstinstManageDAO.selectPstinstListTotCnt", searchVO);
    }
    
    /**
	 * 고객사 전체 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectPstinstAllList(PstinstVO searchVO) throws Exception {
        return list("PstinstManageDAO.selectPstinstAllList", searchVO);
    }
    
    /**
	 * 고객사 전체 목록(삭제된 고객사 포함)을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectPstinstAllList2(PstinstVO searchVO) throws Exception {
        return list("PstinstManageDAO.selectPstinstAllList2", searchVO);
    }
    
    /**
	 * 고객사 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectPopupPstinstList(PstinstVO searchVO) throws Exception {
        return list("PstinstManageDAO.selectPopupPstinstList", searchVO);
    }

    /**
	 * 고객사 총 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
    public int selectPopupPstinstListTotCnt(PstinstVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("PstinstManageDAO.selectPopupPstinstListTotCnt", searchVO);
    }

	/**
	 * 고객사를 수정한다.
	 * @param pstinst
	 * @throws Exception
	 */
	public void updatePstinst(PstinstVO pstinstVO) throws Exception {
		update("PstinstManageDAO.updatePstinst", pstinstVO);
	}
	
	/**
	 * 모듈담당자 목록을 조회한다.
     * @param searchVO
     * @return List(고객사 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List selectSrchargerList(SrchargerVO srchargerVO) throws Exception {
        return list("PstinstManageDAO.selectSrchargerList", srchargerVO);
    }
    
    
	/**
	 *  협력담당자의 고객, 모듈을 조회한다.
	 */
    public List selectCooperchargerList(SrchargerVO srchargerVO) throws Exception {
        return list("PstinstManageDAO.selectCooperchargerList", srchargerVO);
    }
    
    
	/**
	 * 고객사 접속정보를 조회한다.
     * @param searchVO
     * @return List(접속방법)
     * @throws Exception
     */
    public List selectSrconnectList(SrconnectVO srconnectVO) throws Exception{
    	return list("PstinstManageDAO.selectSrconnectList",srconnectVO);
    }
    
    /**
	 * 모듈담당자를 삭제한다.
	 * @param pstinst
	 * @throws Exception
	 */
	public void deleteSrcharger(SrchargerVO srchargerVO) throws Exception {
		delete("PstinstManageDAO.deleteSrcharger", srchargerVO);
	}
	
	/**
	 * 모듈담당자를 등록한다.
	 * @param pstinst
	 * @throws Exception
	 */
	public void insertSrcharger(SrchargerVO srchargerVO) throws Exception {
        insert("PstinstManageDAO.insertSrcharger", srchargerVO);
	}
	
	/**
	 * 고객사 약어를 조회한다.
	 * @param sr
	 * @return Sr(고객사)
	 */
	public String strPstinstAbrb(PstinstVO pstinstVO) throws Exception {
		return (String) selectByPk("PstinstManageDAO.strPstinstAbrb", pstinstVO);
	}
	
    /**
	 * 접속정보를 삭제한다.
	 */
	public void deleteSrconnect(SrconnectVO srconnectVO) throws Exception {
		delete("PstinstManageDAO.deleteSrconnect", srconnectVO);
	}
	
	/**
	 * 접속정보를 등록한다.
	 */
	public void insertSrconnect(SrconnectVO srconnectVO) throws Exception {
        insert("PstinstManageDAO.insertSrconnect", srconnectVO);
	}
	
	public void insertSrconnectNew(SrconnectVO srconnectVO) throws Exception {
		insert("PstinstManageDAO.insertSrconnectNew", srconnectVO);
	}
	
	public List selectChargerPstinstList(SrchargerVO srchargerVO) throws Exception{
		return list("PstinstManageDAO.selectChargerPstinstList",srchargerVO);
	}

}
