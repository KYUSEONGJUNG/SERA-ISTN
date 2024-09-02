package egovframework.let.sts.obsryrt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.pstinst.service.impl.PstinstManageDAO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.let.sts.obsryrt.service.EgovSrObservanceRateService;
import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;
import egovframework.let.sts.obsryrt.service.impl.SrObservanceRateDAO;


@Service("SrObservanceRateService")
public class EgovSrObservanceRateServiceImpl extends EgovAbstractServiceImpl implements EgovSrObservanceRateService {
	
	@Resource(name="SrObservanceRateDAO")
    private SrObservanceRateDAO srObservanceRateDAO;
	
	@Resource(name="PstinstManageDAO")
    private PstinstManageDAO pstinstManageDAO;

	/**
	 *접수 및 납기준수율 목록을 조회한다.
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List selectSrObservanceRate(SrObservanceRateVO searchVO) throws Exception {
		return srObservanceRateDAO.selectSrObservanceRate(searchVO);
	}    
	
	/**
	 * SR 총 갯수를 조회한다.
	 */
	public int selectSrObservanceRateTotCnt(SrObservanceRateVO vo) throws Exception {
        return srObservanceRateDAO.selectSrObservanceRateTotCnt(vo);
	}
	
	/**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownProcessRateReportList(SrObservanceRateVO searchVO) throws Exception {
        return srObservanceRateDAO.excelDownProcessRateReportList(searchVO);
    }


}
