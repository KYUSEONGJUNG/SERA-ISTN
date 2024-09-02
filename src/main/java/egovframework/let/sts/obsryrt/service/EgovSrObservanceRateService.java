package egovframework.let.sts.obsryrt.service;

import java.util.List;

import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;
import egovframework.let.sts.prcrt.service.ProcessRateVO;

public interface EgovSrObservanceRateService {
	
	/**
	 * 접수 및 납기준수율 목록을 조회한다.
	 * @param searchVO
	 * @return List(접수 및 납기준수율 목록)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	List selectSrObservanceRate(SrObservanceRateVO searchVO) throws Exception;
	
	/**
	 * SR의 갯수를 조회한다.
     * @param searchVO
     * @return int(총 갯수)
     */
    int selectSrObservanceRateTotCnt(SrObservanceRateVO searchVO) throws Exception;
	
    /**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    List excelDownProcessRateReportList(SrObservanceRateVO searchVO) throws Exception;
    

}
