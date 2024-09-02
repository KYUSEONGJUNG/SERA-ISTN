package egovframework.let.sts.prcdt.web;

import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sts.prcdt.service.ProcessDetailVO;
import egovframework.let.sts.prcdt.service.EgovSrProcessDetailService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.JSONArray;

/**
 * SR처리 상세내역 검색 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.19
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
@Controller
public class EgovSrProcessDetailController {

	/** EgovSrProcessDetailService */
	@Resource(name = "srProcessDetailService")
    private EgovSrProcessDetailService srProcessDetailService;
	
	/** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovSrProcessDetailController.class);

    /**
	 * SR처리 상세내역 을 조회한다
	 * @param ProcessDetailVO processDetailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/prcdt/selectSrProcessDetail.do")
	public String selectSrProcessDetail(@ModelAttribute("searchVO") ProcessDetailVO processDetailVO,
			ModelMap model) throws Exception {

    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	/** EgovPropertyService.sample */
    	processDetailVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	processDetailVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(processDetailVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(processDetailVO.getPageUnit());
		paginationInfo.setPageSize(processDetailVO.getPageSize());
		
		processDetailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		processDetailVO.setLastIndex(paginationInfo.getLastRecordIndex());
		processDetailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(processDetailVO.getSearchDateFView())){
			processDetailVO.setSearchDateF(processDetailVO.getSearchDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			processDetailVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
			processDetailVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
		}
		if (!"".equals(processDetailVO.getSearchDateTView())){
			processDetailVO.setSearchDateT(processDetailVO.getSearchDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			processDetailVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
			processDetailVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
		}
		
		
		/** 검색-완료일 */
		if (!"".equals(processDetailVO.getSearchCompleteDateFView())){
			processDetailVO.setSearchCompleteDateF(processDetailVO.getSearchCompleteDateFView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			processDetailVO.setSearchCompleteDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
			processDetailVO.setSearchCompleteDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
		}
		if (!"".equals(processDetailVO.getSearchCompleteDateTView())){
			processDetailVO.setSearchCompleteDateT(processDetailVO.getSearchCompleteDateTView().replaceAll("-", ""));
		}else{
			//초기값 셋팅.
			processDetailVO.setSearchCompleteDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
			processDetailVO.setSearchCompleteDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode())){					//Admin
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//SR등록
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_CHARGER".equals(user.getAuthorCode())){			//담당자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_MNGR".equals(user.getAuthorCode())){				//관리자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_MEMBER".equals(user.getAuthorCode())){		//고객
			processDetailVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//SR등록
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_SANCTNER".equals(user.getAuthorCode())){	//결재자
			processDetailVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){
				processDetailVO.setSearchPstinstNm(user.getPstinstNm());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001");		//SR등록(결재자 검색 초기용)
				processDetailVO.setSearchStatus(strStatus);
			}
		}
		
		//조회조건은 Default 로 SR번호별로 조회.
		if("".equals(processDetailVO.getSearchCondition()))
			processDetailVO.setSearchCondition("N");	//SR번호별
		
		//model.addAttribute("resultList", srProcessDetailService.selectSrProcessDetail(processDetailVO));
        
		int totCnt = srProcessDetailService.selectSrProcessDetailTotCnt(processDetailVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
        //모듈코드를 코드정보로부터 조회 - SR0003
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //상태코드를 코드정보로부터 조회 - SR0004
        vo.setCodeId("SR0004");
        model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		
        return "sts/prcdt/EgovSrProcessDetail";
        
	}
    
    /**
	 * SR처리 상세내역 을 조회한다
	 * @param ProcessDetailVO processDetailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/sts/prcdt/selectSrProcessDetail.do")
    @ResponseBody
	public Map<String, Object> selectEgovSrProcessDetail(@ModelAttribute("searchVO") ProcessDetailVO processDetailVO,
			ModelMap model) throws Exception {

    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();
    	
    	/** EgovPropertyService.sample */
    	processDetailVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	processDetailVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(processDetailVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(processDetailVO.getPageUnit());
		paginationInfo.setPageSize(processDetailVO.getPageSize());
		
		processDetailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		processDetailVO.setLastIndex(paginationInfo.getLastRecordIndex());
		processDetailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDay = cal.get(Calendar.DAY_OF_MONTH);
		
		String sMonth = (iMonth < 10)? "0" + String.valueOf(iMonth):String.valueOf(iMonth);
		String sDay = (iDay < 10)? "0" + String.valueOf(iDay):String.valueOf(iDay);
		
//		/** 검색-요청일(접수확인일) */
//		if (!"".equals(processDetailVO.getSearchDateFView())){
//			processDetailVO.setSearchDateF(processDetailVO.getSearchDateFView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			processDetailVO.setSearchDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
//			processDetailVO.setSearchDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
//		}
//		if (!"".equals(processDetailVO.getSearchDateTView())){
//			processDetailVO.setSearchDateT(processDetailVO.getSearchDateTView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			processDetailVO.setSearchDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
//			processDetailVO.setSearchDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
//		}
//		
//		
//		/** 검색-완료일 */
//		if (!"".equals(processDetailVO.getSearchCompleteDateFView())){
//			processDetailVO.setSearchCompleteDateF(processDetailVO.getSearchCompleteDateFView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			processDetailVO.setSearchCompleteDateF(String.valueOf(cal.get(Calendar.YEAR)) + "0101");
//			processDetailVO.setSearchCompleteDateFView(String.valueOf(cal.get(Calendar.YEAR)) + "-01-01");
//		}
//		if (!"".equals(processDetailVO.getSearchCompleteDateTView())){
//			processDetailVO.setSearchCompleteDateT(processDetailVO.getSearchCompleteDateTView().replaceAll("-", ""));
//		}else{
//			//초기값 셋팅.
//			processDetailVO.setSearchCompleteDateT(String.valueOf(cal.get(Calendar.YEAR)) + sMonth + sDay);
//			processDetailVO.setSearchCompleteDateTView(String.valueOf(cal.get(Calendar.YEAR)) + "-" + sMonth + "-" + sDay);
//		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode())){					//Admin
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//SR등록
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_CHARGER".equals(user.getAuthorCode())){			//담당자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_MNGR".equals(user.getAuthorCode())){				//관리자
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_MEMBER".equals(user.getAuthorCode())){		//고객
			processDetailVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){		
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1000");		//임시저장(검색 초기용)
				strStatus.add("1001");		//SR등록
				strStatus.add("1002");		//SR접수중
				strStatus.add("1003");		//SR해결중
				strStatus.add("1004");		//고객테스트
				strStatus.add("1005");		//운영이관완료
				processDetailVO.setSearchStatus(strStatus);
			}
		}else if("ROLE_USER_SANCTNER".equals(user.getAuthorCode())){	//결재자
			processDetailVO.setPstinstCode(user.getPstinstCode());
			//검색에 의한 조회 아닐때 초기값 부여
			if("".equals(processDetailVO.getSearchAt())){
				processDetailVO.setSearchPstinstNm(user.getPstinstNm());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001");		//SR등록(결재자 검색 초기용)
				processDetailVO.setSearchStatus(strStatus);
			}
		}
		
		//조회조건은 Default 로 SR번호별로 조회.
		if("".equals(processDetailVO.getSearchCondition()))
			processDetailVO.setSearchCondition("N");	//SR번호별
		
		//model.addAttribute("resultList", srProcessDetailService.selectSrProcessDetail(processDetailVO));
		retMap.put("resultList", srProcessDetailService.selectSrProcessDetail(processDetailVO));
        
		int totCnt = srProcessDetailService.selectSrProcessDetailTotCnt(processDetailVO);
		paginationInfo.setTotalRecordCount(totCnt);
        //model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
    	
        //모듈코드를 코드정보로부터 조회 - SR0003
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("SR0003");
        //model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        //retMap.put("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //상태코드를 코드정보로부터 조회 - SR0004
        vo.setCodeId("SR0004");
        //model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        //retMap.put("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		//model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
		//retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		
		 return retMap;
        
	}
    
    /**
	 * SR처리 상세내역 엑셀다운로드을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "sts/prcdt/EgovSrProcessDetail"
     * @throws Exception
     */
    @RequestMapping(value="/sts/prcdt/EgovProcessDetailExcelReport.do")
    @ResponseBody
	public Map<String, Object> selectSrListExcelReport (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ProcessDetailVO processDetailVO
			, ModelMap model, HttpServletRequest req, HttpServletResponse resp
			) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		/** 검색-요청일(접수확인일) */
		if (!"".equals(processDetailVO.getSearchDateFView())){
			processDetailVO.setSearchDateF(processDetailVO.getSearchDateFView().replaceAll("-", ""));
		}
		if (!"".equals(processDetailVO.getSearchDateTView())){
			processDetailVO.setSearchDateT(processDetailVO.getSearchDateTView().replaceAll("-", ""));
		}
		
		//권한코드
		model.addAttribute("authorCode", user.getAuthorCode());
		
		if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
				"ROLE_CHARGER".equals(user.getAuthorCode()) ||
				"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
			
		}else{																//현업, 결재자
			processDetailVO.setPstinstCode(user.getPstinstCode());
		}		
		
		List processDetailReportList =  srProcessDetailService.excelDownProcessDetailReportList(processDetailVO);
        

		if(processDetailReportList.size() > 0) {
			
			Workbook wb = null;
			ByteArrayOutputStream bos = null;
			try {
				wb = new XSSFWorkbook();
				Calendar cal = Calendar.getInstance();
		    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
		    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
		    	Date saveDate = sdfmt.parse(strSaveDate);
		    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);
				
				String fileName = "SR상세처리내역_"+strSaveDate+".xlsx";
				resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

		        XSSFCell cell = null;
		        int idx = 0;

		        Sheet sheet = wb.createSheet("SR상세처리내역");
		        //sheet.setDefaultColumnWidth((short) 12);
		        
		        // put text in first cell
		        //cell = createCell(sheet, 0, 0);
		        Row row = sheet.createRow(0);
		        row.createCell(0).setCellValue("SR상세처리내역");
		        // set header information 
		        idx = 0;
		        row.createCell(idx++).setCellValue("고객사");
		        row.createCell(idx++).setCellValue("요청일");
		        row.createCell(idx++).setCellValue("SR번호");
		        row.createCell(idx++).setCellValue("제목");
		        row.createCell(idx++).setCellValue("요청자");
		        row.createCell(idx++).setCellValue("고객확인완료일");
		        row.createCell(idx++).setCellValue("운영이관일");
		        row.createCell(idx++).setCellValue("구분");
		        row.createCell(idx++).setCellValue("예상공수(H)");
		        row.createCell(idx++).setCellValue("실공수(H)");
		        row.createCell(idx++).setCellValue("모듈");
		        row.createCell(idx++).setCellValue("담당자");
		        row.createCell(idx++).setCellValue("완료예정일");
		        row.createCell(idx++).setCellValue("처리내역");

		        
		        for (int i = 0; i < processDetailReportList.size(); i++) {
		        	Object obj = processDetailReportList.get(i);
		        	ProcessDetailVO excelProcessDetailVO = (ProcessDetailVO) obj;
		            idx = 0;
		            row = sheet.createRow(1+i);
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getCompanyName());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getRequestDate());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getSrNo());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getSubject());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getRequesterName());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getTestCompleteDate());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getTransferDate());
		            if(excelProcessDetailVO.getAnswerSe().equals("10")){
		            	row.createCell(idx++).setCellValue(egovMessageSource.getMessage("sr.answers"));
					}else {
						row.createCell(idx++).setCellValue(egovMessageSource.getMessage("sr.addRequest"));
					}
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getExpectTime());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getRealExpectTime());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getModuleName());
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getResponserName());		            
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getCompleteDate());
		            htmlRemove(excelProcessDetailVO);
		            row.createCell(idx++).setCellValue(excelProcessDetailVO.getComment());		            
		        }
		        bos = new ByteArrayOutputStream();
		        wb.write(bos);
		        
		        //wb.write(resp.getOutputStream());
		        retMap.put("filename", fileName);
		        retMap.put("fileBinary", new JSONArray(bos.toByteArray()).toString());
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(wb != null) wb.close();
				if(bos != null) bos.close();
			}
		}
        
		return retMap;
        
        //return new ModelAndView("processDetailReportExcelView", "processDetailReportMap", map);
	}
    /**
	 * html 코드 삭제
	 * @param ProcessDetailVO
	 */
	private void htmlRemove(ProcessDetailVO processDetailVO) {
		//요청내용
		processDetailVO.setComment(processDetailVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
		
	}
    
}