package egovframework.let.sts.mprcstsc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sts.mprcstsc.service.MinbyProcessSttusChargeVO;
import egovframework.let.sts.prcdt.service.ProcessDetailVO;
import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 접속 통계 검색 DAO 클래스
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
@Repository("srMinbyProcessSttusChargeDAO")
public class SrMinbyProcessSttusChargeDAO extends EgovAbstractDAO {

	/**
	 * SR월별 처리현황을 조회한다.
	 * @param vo MinbyProcessSttusChargeVO
	 * @return List
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List selectSrMinbyProcessSttusCharge(MinbyProcessSttusChargeVO vo) throws Exception {
        return list("SrMinbyProcessSttusChargeDAO.selectSrMinbyProcessSttusCharge", vo);
    }
    
    /**
	 * SR 총 갯수를 조회한다.
     * @param vo
     * @return int(SR 총 갯수)
     */
    @SuppressWarnings("unchecked")
    public int selectSrMinbyProcessSttusChargeTotCnt(MinbyProcessSttusChargeVO vo) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("SrMinbyProcessSttusChargeDAO.selectSrMinbyProcessSttusChargeTotCnt", vo);
    }
    
    
	/**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    public List excelDownSrMinbyProcessSttusChargeReportList(MinbyProcessSttusChargeVO vo) throws Exception {
        return list("SrMinbyProcessSttusChargeDAO.excelDownSrMinbyProcessSttusChargeReportList", vo);
    }    
    
}
