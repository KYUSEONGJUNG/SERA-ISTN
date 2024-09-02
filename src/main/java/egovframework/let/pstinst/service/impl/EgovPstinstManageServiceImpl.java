package egovframework.let.pstinst.service.impl;

import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.Pstinst;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.pstinst.service.SrchargerVO;
import egovframework.let.pstinst.service.SrconnectVO;
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
@Service("PstinstManageService")
public class EgovPstinstManageServiceImpl extends EgovAbstractServiceImpl implements EgovPstinstManageService {

    @Resource(name="PstinstManageDAO")
    private PstinstManageDAO pstinstManageDAO;

	/**
	 * 고객사를 삭제한다.
	 */
	public void deletePstinst(Pstinst pstinst) throws Exception {
		pstinstManageDAO.deletePstinst(pstinst);
	}

	/**
	 * 고객사 전체를 삭제한다.
	 */
	public void deleteAllPstinst() throws Exception {
		pstinstManageDAO.deleteAllPstinst();
	}

	/**
	 * 고객사를 등록한다.
	 */
	public void insertPstinst(PstinstVO pstinstVO) throws Exception {
    	pstinstManageDAO.insertPstinst(pstinstVO);    	
	}

	/**
	 * 고객사 상세항목을 조회한다.
	 */
	public Pstinst selectPstinstDetail(Pstinst pstinst) throws Exception {
    	Pstinst ret = (Pstinst)pstinstManageDAO.selectPstinstDetail(pstinst);
    	return ret;
	}

	/**
	 * 고객사 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectPstinstList(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPstinstList(searchVO);
	}

	/**
	 * 고객사 총 갯수를 조회한다.
	 */
	public int selectPstinstListTotCnt(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPstinstListTotCnt(searchVO);
	}
	
	/**
	 * 고객사 전체 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectPstinstAllList(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPstinstAllList(searchVO);
	}
	
	/**
	 * 고객사 전체 목록(삭제된 고객사 포함)을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectPstinstAllList2(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPstinstAllList2(searchVO);
	}
	
	/**
	 * 고객사 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectPopupPstinstList(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPopupPstinstList(searchVO);
	}

	/**
	 * 고객사 총 갯수를 조회한다.
	 */
	public int selectPopupPstinstListTotCnt(PstinstVO searchVO) throws Exception {
        return pstinstManageDAO.selectPopupPstinstListTotCnt(searchVO);
	}

	/**
	 * 고객사를 수정한다.
	 */
	public void updatePstinst(PstinstVO pstinstVO) throws Exception {
		pstinstManageDAO.updatePstinst(pstinstVO);
	}
	
	/**
	 * 모듈담당자 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrchargerList(SrchargerVO srchargerVO) throws Exception {
        return pstinstManageDAO.selectSrchargerList(srchargerVO);
	}

	/**
	 *  협력담당자의 고객, 모듈을 조회한다.
	 */
	public List selectCooperchargerList(SrchargerVO srchargerVO)throws Exception{
		return pstinstManageDAO.selectCooperchargerList(srchargerVO);
	}
	
	/**
	 * 모듈담당자를 삭제한다.
	 */
	public void deleteSrcharger(SrchargerVO srchargerVO) throws Exception {
		pstinstManageDAO.deleteSrcharger(srchargerVO);
	}
	
	/**
	 * 모듈담당자를 등록한다.
	 */
	public void insertSrcharger(SrchargerVO srchargerVO) throws Exception {
    	pstinstManageDAO.insertSrcharger(srchargerVO);    	
	}
	
	/**
	 * 고객사 약어를 조회한다.
	 */
	public String strPstinstAbrb(PstinstVO pstinstVO) throws Exception {
    	return pstinstManageDAO.strPstinstAbrb(pstinstVO);
	}

	/**
	 * 고객사 접속정보를 조회한다.
	 */
	public List selectSrconnectList(SrconnectVO srconnectVO) throws Exception {
		return pstinstManageDAO.selectSrconnectList(srconnectVO);
	}
	
	

	/**
	 * 접속정보를 삭제한다.
	 */
	public void deleteSrconnect(SrconnectVO srconnectVO) throws Exception {
		pstinstManageDAO.deleteSrconnect(srconnectVO);
	}
	
	/**
	 * 접속정보를 등록한다.
	 */
	public void insertSrconnect(SrconnectVO srconnectVO) throws Exception {
    	pstinstManageDAO.insertSrconnect(srconnectVO);    	
	}
	
	public List selectChargerPstinstList(SrchargerVO srchargerVO) throws Exception{
		return pstinstManageDAO.selectChargerPstinstList(srchargerVO);
	}

	@Override
	public void insertSrconnectNew(SrconnectVO srconnectVO) throws Exception {
		pstinstManageDAO.insertSrconnectNew(srconnectVO);
		
	}
	

}