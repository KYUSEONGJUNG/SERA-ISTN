package egovframework.let.sts.stsfdg.service;

import java.util.List;

import egovframework.let.sts.mprcsts.service.MinbyProcessSttusVO;

/**
 * 접속 통계 검색 비즈니스 인터페이스 클래스
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
public interface EgovStsfdgSttusService {

	/**
	 * 만족도현황을 조회한다
	 * @param vo ProcessRateVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	List selectStsfdgSttus(StsfdgSttusVO vo) throws Exception;
	
    /**
	 * SR의 갯수를 조회한다.
     * @param searchVO
     * @return int(고객사 총 갯수)
     */
    int selectStsfdgSttusTotCnt(StsfdgSttusVO searchVO) throws Exception;
    
    
    /**
     * 엑셀파일 목록을 조회한다.
     * 
     * @param searchVO
     *            - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */
    List excelDownSrStsfdgSttusReportList(StsfdgSttusVO searchVO) throws Exception;    
}
