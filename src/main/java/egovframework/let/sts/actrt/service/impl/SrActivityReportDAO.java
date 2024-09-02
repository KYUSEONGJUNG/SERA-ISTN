package egovframework.let.sts.actrt.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sts.actrt.service.ActivityReportVO;
import egovframework.let.sts.prcrt.service.ProcessRateVO;
import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * SR Activity Report 검색 DAO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성
 *  2011.06.30  이기하          패키지 분리(sts -> sts.cst)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@Repository("srActivityReportDAO")
public class SrActivityReportDAO extends EgovAbstractDAO {

	/**
	 * SR Activity Report 를 조회한다.
	 * @param vo ProcessRateVO
	 * @return List
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List selectSrActivityReport(ActivityReportVO vo) throws Exception {
        return list("SrActivityReportDAO.selectSrActivityReport", vo);
    }
    
    /**
	 * SR Activity Report 총 갯수를 조회한다.
     * @param vo
     * @return int(SR 총 갯수)
     */
    @SuppressWarnings("unchecked")
    public int selectSrActivityReportTotCnt(ActivityReportVO vo) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("SrActivityReportDAO.selectSrActivityReportTotCnt", vo);
    }
    
	/**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownActivityReportList(ActivityReportVO vo) throws Exception {
        return list("SrActivityReportDAO.excelDownActivityReportList", vo);
    }
    
}
