package egovframework.let.sts.obsryrt.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;

@Repository("SrObservanceRateDAO")
public class SrObservanceRateDAO extends EgovAbstractDAO {
	
	/**
	 * 접수 및 납기준수율 목록을 조회한다.
	 * @param vo ProcessRateVO
	 * @return List
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List selectSrObservanceRate(SrObservanceRateVO vo) throws Exception {
        return list("SrObservanceRateDAO.selectSrObservanceRate", vo);
    }
    
    /**
	 * SR 총 갯수를 조회한다.
     * @param vo
     * @return int(SR 총 갯수)
     */
    @SuppressWarnings("unchecked")
    public int selectSrObservanceRateTotCnt(SrObservanceRateVO vo) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("SrObservanceRateDAO.selectSrObservanceRateTotCnt", vo);
    }
    
    /**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownProcessRateReportList(SrObservanceRateVO searchVO) throws Exception {
        return list("SrObservanceRateDAO.excelDownProcessRateReportList", searchVO);
    }

}
