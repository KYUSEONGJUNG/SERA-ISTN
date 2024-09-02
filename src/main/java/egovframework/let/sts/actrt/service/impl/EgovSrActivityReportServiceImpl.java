package egovframework.let.sts.actrt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.sts.actrt.service.ActivityReportVO;
import egovframework.let.sts.actrt.service.EgovSrActivityReportService;
import egovframework.let.sts.prcrt.service.ProcessRateVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * SR Activity Report 검색 비즈니스 구현 클래스
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
@Service("srActivityReportService")
public class EgovSrActivityReportServiceImpl extends EgovAbstractServiceImpl implements
	EgovSrActivityReportService {

    @Resource(name="srActivityReportDAO")
    private SrActivityReportDAO srActivityReportDAO;

    /**
	 * SR Activity Report를 조회한다
	 * @param vo ActivityReportVO
	 * @return List
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List selectSrActivityReport(ActivityReportVO vo) throws Exception {
        return srActivityReportDAO.selectSrActivityReport(vo);
	}
    
	/**
	 * SR 총 갯수를 조회한다.
	 */
	public int selectSrActivityReportTotCnt(ActivityReportVO vo) throws Exception {
        return srActivityReportDAO.selectSrActivityReportTotCnt(vo);
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
        return srActivityReportDAO.excelDownActivityReportList(vo);
    }
}
