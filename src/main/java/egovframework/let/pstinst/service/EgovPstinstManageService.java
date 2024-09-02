package egovframework.let.pstinst.service;

import java.io.InputStream;
import java.util.List;

import egovframework.let.sr.service.SrVO;

/**
 * 고객사에 관한 서비스 인터페이스 클래스를 정의한다
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
public interface EgovPstinstManageService {
	
	/**
	 * 고객사를 삭제한다.
	 * @param pstinst
	 * @throws Exception
	 */
	void deletePstinst(Pstinst pstinst) throws Exception;

	/**
	 * 고객사 전체를 삭제한다.
	 * @throws Exception
	 */
	void deleteAllPstinst() throws Exception;

	/**
	 * 고객사를 등록한다.
	 * @param pstinst
	 * @throws Exception
	 */
	void insertPstinst(PstinstVO pstinstVO) throws Exception;
	
	/**
	 * 고객사 상세항목을 조회한다.
	 * @param pstinst
	 * @return Pstinst(고객사)
	 * @throws Exception
	 */
	Pstinst selectPstinstDetail(Pstinst pstinst) throws Exception;
	
	/**
	 * 고객사 목록을 조회한다.
	 * @param searchVO
	 * @return List(고객사 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectPstinstList(PstinstVO searchVO) throws Exception;
	
    /**
	 * 고객사 총 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
    int selectPstinstListTotCnt(PstinstVO searchVO) throws Exception;
    
    /**
	 * 고객사 전체 목록을 조회한다.
	 * @param searchVO
	 * @return List(고객사 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectPstinstAllList(PstinstVO searchVO) throws Exception;
    
    /**
	 * 고객사 전체 목록(삭제된 고객사 포함)을 조회한다.
	 * @param searchVO
	 * @return List(고객사 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectPstinstAllList2(PstinstVO searchVO) throws Exception;
	
    /**
	 * 고객사 목록을 조회한다.
	 * @param searchVO
	 * @return List(고객사 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectPopupPstinstList(PstinstVO searchVO) throws Exception;

    /**
	 * 고객사 총 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
    int selectPopupPstinstListTotCnt(PstinstVO searchVO) throws Exception;
	
	/**
	 * 고객사를 수정한다.
	 * @param pstinst
	 * @throws Exception
	 */
	void updatePstinst(PstinstVO pstinstVO) throws Exception;
	
	/**
	 * 모듈담당자 목록을 조회한다.
	 * @param searchVO
	 * @return List(고객사 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrchargerList(SrchargerVO srchargerVO) throws Exception;
	
	
	/**
	 *  협력담당자의 고객, 모듈을 조회한다.
	 */
	List selectCooperchargerList(SrchargerVO srchargerVO) throws Exception;
	
	
	/**
	 * 모듈담당자를 삭제한다.
	 * @param pstinst
	 * @throws Exception
	 */
	void deleteSrcharger(SrchargerVO srchargerVO) throws Exception;
	

	/**
	 * 모듈담당자를 등록한다.
	 * @param pstinst
	 * @throws Exception
	 */
	void insertSrcharger(SrchargerVO srchargerVO) throws Exception;
	
	/**
	 * 고객사 약어를 조회한다.
	 * @param pstinst
	 * @return 
	 * @throws Exception
	 */
	String strPstinstAbrb(PstinstVO pstinstVO) throws Exception;
	
	/**
	 * 고객사 접속정보를 조회한다.
	 * @param srConnect
	 * @return 
	 * @throws Exception
	 */	
	List selectSrconnectList(SrconnectVO srconnectVO) throws Exception;

	//접속정보를 삭제한다.
	void deleteSrconnect(SrconnectVO srconnectVO) throws Exception;
	
	//접속정보를 등록한다.
	void insertSrconnect(SrconnectVO srconnectVO) throws Exception;
	
	void insertSrconnectNew(SrconnectVO srconnectVO) throws Exception;
	

	List selectChargerPstinstList(SrchargerVO srchargerVO) throws Exception;
}
