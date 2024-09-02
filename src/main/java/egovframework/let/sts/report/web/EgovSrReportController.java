package egovframework.let.sts.report.web;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.FontUnderline;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.IndexedColorMap;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sr.service.EgovSrManageService;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sts.obsryrt.service.EgovSrObservanceRateService;
import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;
import egovframework.let.sts.prcrt.service.EgovSrProcessRateService;
import egovframework.let.sts.prcrt.service.ProcessRateVO;
import egovframework.let.sts.stsfdg.service.EgovStsfdgSttusService;
import egovframework.let.sts.stsfdg.service.StsfdgSttusVO;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.JSONArray;

/**
 * 접속 통계 검색 컨트롤러 클래스
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
public class EgovSrReportController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    /** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;
    /** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    @Resource(name = "SrManageService")
	private EgovSrManageService srManageService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** EgovStsfdgSttusService */
	@Resource(name = "stsfdgSttusService")
    private EgovStsfdgSttusService stsfdgSttusService;
    
	/** SrObservanceRateService */
    @Resource(name = "SrObservanceRateService")
    private EgovSrObservanceRateService srObservanceRateService;
    
    /** EgovSrProcessRateService */
	@Resource(name = "srProcessRateService")
    private EgovSrProcessRateService srProcessRateService;
	
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovSrReportController.class);

    /**
	 * 월간보고서 화면을 조회한다
	 * @param statsVO ProcessRateVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sts/report/EgovSrReport.do")
	public String selectSrProcessRate(@ModelAttribute("searchVO") ProcessRateVO searchVO
			,@ModelAttribute("userManageVO") UserManageVO userManageVO
			, HttpServletRequest request
			, HttpSession session			
			,ModelMap model) throws Exception {
    	    
		
        return "sts/report/EgovSrReport";
	}
    
    
	/**
	 * SR 엑셀다운로드(월간보고서)을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sts/report/EgovSrReportExcelDownload.do")
	@ResponseBody
	public void selectSrListExcelReportMap(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") SrVO searchVO, 
			ModelMap model, 
			HttpServletRequest req, 
			HttpServletResponse resp) throws Exception {
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, req);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		PstinstVO PstinstVO = new PstinstVO();
		List pstinstList = pstinstManageService.selectPstinstAllList(PstinstVO);
		String reportName = "report";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if(!"".equals(searchVO.getSearchCompleteDateT())) {
			
			String yyyymm = searchVO.getSearchCompleteDateT();
			reportName += "_"+yyyymm;
			Calendar cal = Calendar.getInstance(); // 날짜 계산을 위해 Calendar 추상클래스 선언 및 getInstance() 메서드 사용
	        cal.set(Integer.parseInt(yyyymm.substring(0, 4)), Integer.parseInt(yyyymm.substring(4, 6)) - 1, 1);
	        
	        cal.add(Calendar.MONTH, 1);  
			cal.add(Calendar.DATE, -1);
			searchVO.setSearchCompleteDateF(yyyymm+"01");
			searchVO.setSearchCompleteDateT(sdf.format(cal.getTime()));
			
		}
		List<String> strStatus = new ArrayList<String>();
		strStatus.add("1001"); // 등록
		strStatus.add("1002"); // 접수대기
		strStatus.add("1003"); // 접수완료
		strStatus.add("1004"); // 해결중
		strStatus.add("1005"); // 고객테스트
		strStatus.add("1006"); // 완료
		searchVO.setSearchStatus(strStatus);
		
		
		resp.setContentType("application/octet-stream");
		reportName = URLEncoder.encode(reportName,"UTF-8").replaceAll("\\+", "%20");
		resp.setHeader("Content-Disposition", "attachment;filename=" + reportName +".zip");
		ZipOutputStream zos = new ZipOutputStream(resp.getOutputStream());
		
		//YG-HR, 와이지 원 (394,435)		
		EgovMap multiPstinst = new EgovMap();
		multiPstinst.put("pstinstCode", "394,435");
		String multiPstinstNm = "";
		for(Object pstinst : pstinstList) {	
			EgovMap map = (EgovMap) pstinst;
			if("394".equals(map.get("pstinstCode")) || "435".equals(map.get("pstinstCode"))) {
				if(!"".equals(multiPstinstNm)) multiPstinstNm += ",";
				multiPstinstNm += (String)map.get("pstinstNm");
			}
		}
		multiPstinst.put("pstinstNm", multiPstinstNm);		
		pstinstList.add(multiPstinst);
		
		for(Object pstinst : pstinstList) {			
			
			EgovMap map = (EgovMap) pstinst;
			
			searchVO.setSearchPstinstCode((String)map.get("pstinstCode"));
			
					
			String pstinstCode = (String)map.get("pstinstCode");
			String[] pstinstCodeArr = pstinstCode.split(",");
			if(pstinstCodeArr.length > 1) searchVO.setPstinstCodeArr(pstinstCodeArr);
			searchVO.setFirstIndex(0);
			List srReportList = srManageService.excelDownSrMonthReport(searchVO); 
			
			
			if(srReportList.size() > 0) {
				ZipEntry zipEntry = new ZipEntry((String)map.get("pstinstNm")+".xlsx");
				
				zos.putNextEntry(zipEntry);
				XSSFWorkbook wb = null;
				ByteArrayOutputStream bos = null;
				try {
					//Sheet 1 (SR List)
					wb = new XSSFWorkbook();
					//저장일
					Calendar cal = Calendar.getInstance();
			    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			    	Date saveDate = sdfmt.parse(strSaveDate);
			    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);

			    	XSSFCell cell = null;
			    	int idx = 0;
			    	XSSFSheet sheet = null;
			    	String fileName = "";
			    	
			    	//헤더 스타일
			    	XSSFCellStyle headerStyle= (XSSFCellStyle) wb.createCellStyle();
			    	headerStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
			    	headerStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
			    	headerStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
			    	headerStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
			    	headerStyle.setAlignment(HorizontalAlignment.CENTER);
			    	headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
			    	
			    	//배경색
			    	IndexedColorMap colorMap =  wb.getStylesSource().getIndexedColors();
			    	headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(184,204,228), colorMap));
			    	headerStyle.setFillBackgroundColor(new XSSFColor(new java.awt.Color(184,204,228), colorMap));
			    	headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			    	
			    	//폰트
			    	XSSFFont headerFont = wb.createFont();
			    	headerFont.setBold(true);
			    	headerFont.setFontHeight(9);
			    	headerFont.setFontName("맑은 고딕");
			    	headerStyle.setFont(headerFont);
			    	///헤더
			    	
			    	//셀 스타일 
			    	XSSFCellStyle cellStyle= (XSSFCellStyle) wb.createCellStyle();
			    	cellStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
			    	cellStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
			    	cellStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
			    	cellStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
			    	cellStyle.setAlignment(HorizontalAlignment.CENTER);
			    	cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
			    	
			    	//폰트
			    	XSSFFont cellFont = wb.createFont();
			    	cellFont.setFontHeight(9);
			    	cellFont.setFontName("맑은 고딕");
			    	cellStyle.setFont(cellFont);
			    	
			    	
			    	XSSFCellStyle leftCellStyle= (XSSFCellStyle) wb.createCellStyle();
			    	leftCellStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
			    	leftCellStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
			    	leftCellStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
			    	leftCellStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
			    	leftCellStyle.setAlignment(HorizontalAlignment.LEFT);
			    	leftCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
			    	
			    	leftCellStyle.setFont(cellFont);
			    	
			    	
						    		
					fileName = "SR리스트(월간보고서용)_"+strSaveDate+".xlsx";
					
		
					sheet = (XSSFSheet)wb.createSheet("SR리스트");
			        //sheet.setDefaultColumnWidth((short) 12);
		
			        // put text in first cell
		//					        cell = createCell(sheet, 0, 0);
		//					        setText(cell, "SR리스트(월간보고서용)");
			        XSSFRow row = sheet.createRow(0);
			        row.createCell(0).setCellValue("SR리스트(월간보고서용)");
			        // set header information
			        idx = 0;
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("SR 번호");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("제목");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("모듈");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("처리구분");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("상태");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("요청자");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("요청일시");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("완료예정일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("담당자");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("처리완료일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("고객확인완료일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("전체공수");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("ABAP공수");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("만족도");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("요청내역");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("답변");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
		    		cell.setCellValue("고객사");
			        cell.setCellStyle(headerStyle);
				        
			    	
					
					sheet.createFreezePane(0, 1);
					
					
			        row = null;
			        Double realSum = 0.0;
			        Double abapSum = 0.0;
			        String prevStatus = "";
			        int headerRowCnt = 2;
			        for (int i = 0; i < srReportList.size(); i++) {
			        	Object obj = srReportList.get(i);
			        	SrVO srReportVO = (SrVO) obj;
			            idx = 0;
			            
			            if(i==0) {
			            	row = sheet.createRow(1);
			            	if("1006".equals(srReportVO.getStatus())) {
			            		row.createCell(0).setCellValue("완료");
			            	}else if("1005".equals(srReportVO.getStatus())) {
			            		//row.createCell(0).setCellValue("Customer confirmation Service Request");
			            		row.createCell(0).setCellValue("고객확인");
			            	}else {
			            		//row.createCell(0).setCellValue("Recept and resolving Service Request");
			            		row.createCell(0).setCellValue("해결중 / 접수완료 / 접수대기 / 등록");
			            	}
			            }
			            
			            if(( "1006".equals(prevStatus) && !prevStatus.equals(srReportVO.getStatus()) )
			            		|| ( "1005".equals(prevStatus) && !prevStatus.equals(srReportVO.getStatus()) )
					    		){
			            	row = sheet.createRow(headerRowCnt+i);
			    			//합 계 Row
			            	cell = row.createCell(0);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(1);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(2);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(3);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(4);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(5);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(6);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(7);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(8);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(9);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(10);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        
			            	sheet.addMergedRegion(new CellRangeAddress(headerRowCnt+i,headerRowCnt+i,0,10));
			            	
			            	cell = row.createCell(11);
			        		cell.setCellValue(realSum);
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(12);
			        		cell.setCellValue(abapSum);
					        cell.setCellStyle(cellStyle);
			            	sheet.createRow(headerRowCnt+i+1);
			            	
			            	row = sheet.createRow(headerRowCnt+i+2);
			            	
			            	if("1005".equals(srReportVO.getStatus())) {
			            		//row.createCell(0).setCellValue("Customer confirmation Service Request");
			            		row.createCell(0).setCellValue("고객확인");
			            	}else {
			            		//row.createCell(0).setCellValue("Recept and resolving Service Request");
			            		row.createCell(0).setCellValue("해결중 / 접수완료 / 접수대기 / 등록");
			            	}
			            	
			            	headerRowCnt+=3;
			            	realSum = 0.0;
			            	abapSum = 0.0;
			    		}
			            
			            row = sheet.createRow(headerRowCnt+i);
			            


			            cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getSrNo());
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getSubject());
				        cell.setCellStyle(leftCellStyle);          
			            if("en".equals((String)req.getSession().getAttribute("language"))){
			            	cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getModuleNmEn());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getCategoryNmEn());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getStatusNmEn());
					        cell.setCellStyle(cellStyle);   
					        
			        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
			        		cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getModuleNmCn());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getCategoryNmCn());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getStatusNmCn());
					        cell.setCellStyle(cellStyle);   
			        	}else{
			        		cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getModuleNm());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getCategoryNm());
					        cell.setCellStyle(cellStyle);   
					        cell = row.createCell(idx++);
			        		cell.setCellValue(srReportVO.getStatusNm());
					        cell.setCellStyle(cellStyle);  
			        	}
			            cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getCustomerNm());
				        cell.setCellStyle(leftCellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getSignDate());
				        cell.setCellStyle(cellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getScheduleDate());
				        cell.setCellStyle(cellStyle); 
				        
				        cell = row.createCell(idx++);
				        if("en".equals((String)req.getSession().getAttribute("language"))){	
			        		cell.setCellValue(srReportVO.getRnameEn());
			        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){ 
			        		cell.setCellValue(srReportVO.getRnameEn());
			        	}else{ 
			        		cell.setCellValue(srReportVO.getRname());				        
			        	}
				        cell.setCellStyle(leftCellStyle);
				        
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getCompleteDate());
				        cell.setCellStyle(cellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getTestCompleteDate());
				        cell.setCellStyle(cellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getRealExpectTime());
				        cell.setCellStyle(cellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getAbapRealExpectTime());
				        cell.setCellStyle(cellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getPoint());
				        cell.setCellStyle(cellStyle);
				        htmlRemove(srReportVO);	
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getComment());
				        cell.setCellStyle(leftCellStyle); 
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getAnsComment());
				        cell.setCellStyle(leftCellStyle);
				        
				        cell = row.createCell(idx++);
			    		if("en".equals((String)req.getSession().getAttribute("language"))){
			        		cell.setCellValue(srReportVO.getPstinstNmEn());
			        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
			        		cell.setCellValue(srReportVO.getPstinstNmEn());
			        	}else{
			        		cell.setCellValue(srReportVO.getPstinstNm());				        
			        	}		    		
			    		cell.setCellStyle(leftCellStyle); 
			    		
			    		
			    		prevStatus = srReportVO.getStatus();
			    		
			    		if(srReportVO.getRealExpectTime() != null && !"".equals(srReportVO.getRealExpectTime())) {
			            	realSum += Double.parseDouble(srReportVO.getRealExpectTime());
			            }
			            if(srReportVO.getAbapRealExpectTime() != null && !"".equals(srReportVO.getAbapRealExpectTime())) {
			            	abapSum += Double.parseDouble(srReportVO.getAbapRealExpectTime());
			            }
			            
			            if(i == srReportList.size() - 1 ) {
			            	row = sheet.createRow(headerRowCnt+i+1);
			    			//합 계 Row
			            	cell = row.createCell(0);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(1);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(2);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(3);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(4);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(5);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(6);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(7);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(8);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(9);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(10);
			        		cell.setCellValue("Total");
					        cell.setCellStyle(cellStyle);
			            	
			            	sheet.addMergedRegion(new CellRangeAddress(headerRowCnt+i+1,headerRowCnt+i+1,0,10));
			            	
			            	cell = row.createCell(11);
			        		cell.setCellValue(realSum);
					        cell.setCellStyle(cellStyle);
					        cell = row.createCell(12);
			        		cell.setCellValue(abapSum);
					        cell.setCellStyle(cellStyle);
			            }
			        }
			        
			        
			        //Sheet 2 (SR KPI)
			        XSSFSheet kpiSheet = (XSSFSheet)wb.createSheet("SR-KPI");
			        
			        kpiSheet.createRow(0);
			        
			        //헤더 스타일
			    	XSSFCellStyle kpiTitleStyle= (XSSFCellStyle) wb.createCellStyle();
			    	kpiTitleStyle.setAlignment(HorizontalAlignment.CENTER);
			    	kpiTitleStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
			    	
			    	//폰트
			    	XSSFFont kpiTitleFont = wb.createFont();
			    	kpiTitleFont.setBold(true);
			    	kpiTitleFont.setUnderline(FontUnderline.SINGLE);
			    	kpiTitleFont.setFontHeight(12);
			    	kpiTitleFont.setFontName("맑은 고딕");
			    	kpiTitleStyle.setFont(kpiTitleFont);
			    	///헤더
			    	
			    	//------- 만족도 현황
			    	int rowCnt = 1;
			        XSSFRow kpiRow = kpiSheet.createRow(rowCnt++);
			        
			        cell = kpiRow.createCell(0);
			        cell.setCellValue(egovMessageSource.getMessage("sr.satisfactionStatus"));
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(1);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(2);
			        
			        cell.setCellStyle(kpiTitleStyle);
			        cell = kpiRow.createCell(3);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(4);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(5);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(6);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(7);
			        cell.setCellStyle(kpiTitleStyle);
			        kpiSheet.addMergedRegion(new CellRangeAddress(1,1,0,7));
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        
			        cell = kpiRow.createCell(0);
			        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.completionDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        
			        idx = 0;
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.5point"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.4point"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.3point"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.2point"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.1point"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.average"));
			        cell.setCellStyle(headerStyle);
			        
			        
			        StsfdgSttusVO stsfdgSttusVO = new StsfdgSttusVO();
			        
			        stsfdgSttusVO.setSearchDateF(searchVO.getSearchCompleteDateF());
			        stsfdgSttusVO.setSearchDateT(searchVO.getSearchCompleteDateT());
			        stsfdgSttusVO.setPstinstCode(searchVO.getSearchPstinstCode());
			        
			        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
							"ROLE_CHARGER".equals(user.getAuthorCode()) ||
							"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
					}else{																//현업, 결재자
						stsfdgSttusVO.setPstinstCode(user.getPstinstCode());
					}	        
			        
			        
			        if(pstinstCodeArr.length > 1) stsfdgSttusVO.setPstinstCodeArr(pstinstCodeArr);
					List stsfdgSttusReportList =  stsfdgSttusService.excelDownSrStsfdgSttusReportList(stsfdgSttusVO);
					
			        
			        
			        for (int i = 0; i < stsfdgSttusReportList.size(); i++) {
			        	Object obj = stsfdgSttusReportList.get(i);
			        	StsfdgSttusVO reportVO = (StsfdgSttusVO) obj;
			            idx = 0;
			    		row = kpiSheet.createRow(rowCnt++);
			    		cell = row.createCell(idx++);
			    		if("en".equals((String)req.getSession().getAttribute("language"))){		            	
			        		cell.setCellValue(reportVO.getModuleNameEn());
			        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
			        		cell.setCellValue(reportVO.getModuleNameCn());				        
			        	}else{
			        		cell.setCellValue(reportVO.getModuleName());
			        	}
			            cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getCompleteCount());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getValue5());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getValue4());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getValue3());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getValue2());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getValue1());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getAvgValue());
			    		cell.setCellStyle(cellStyle);
			        }
			        
			        //--------만족도 현황
			        
			        //---------접수 및 납기 접수
			        
			        rowCnt+=2;
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        
			        cell = kpiRow.createCell(0);
			        cell.setCellValue(egovMessageSource.getMessage("sr.receptionAndCompleteOnTime"));
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(1);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(2);
			        cell.setCellStyle(kpiTitleStyle);
			        cell = kpiRow.createCell(3);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(4);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(5);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(6);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(7);
			        cell.setCellStyle(kpiTitleStyle);
			        kpiSheet.addMergedRegion(new CellRangeAddress(rowCnt-1,rowCnt-1,0,7));
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        cell = kpiRow.createCell(0);
			        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.requestDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        idx = 0;
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.requestCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.receiptCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.dayReceptCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.dayRecpetPercent"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completeOnTimeCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completeOnTimePercent"));
			        cell.setCellStyle(headerStyle);
			        
			        
			        SrObservanceRateVO srObservanceRateVO = new SrObservanceRateVO();
			        
			        srObservanceRateVO.setSearchConfirmDateF(searchVO.getSearchCompleteDateF());
			        srObservanceRateVO.setSearchConfirmDateT(searchVO.getSearchCompleteDateT());
			        srObservanceRateVO.setPstinstCode(searchVO.getSearchPstinstCode());
			        
			        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
							"ROLE_CHARGER".equals(user.getAuthorCode()) ||
							"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
					}else{																//현업, 결재자
						srObservanceRateVO.setPstinstCode(user.getPstinstCode());
					}	     
			        		        
			        if(pstinstCodeArr.length > 1) srObservanceRateVO.setPstinstCodeArr(pstinstCodeArr);
			        	
			        List srObservanceRateReportList = srObservanceRateService.excelDownProcessRateReportList(srObservanceRateVO);
					
			        
			        for (int i = 0; i < srObservanceRateReportList.size(); i++) {
		        		
			    		Object obj = srObservanceRateReportList.get(i);
			    		SrObservanceRateVO reportVO = (SrObservanceRateVO) obj;
			    		idx = 0;
			    		row = kpiSheet.createRow(rowCnt++);
			    		
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getModuleName());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getSignCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getConfirmCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getInConfirmCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getInConfirmRate());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getCompleteCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getInCompleteCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getInCompleteRate());
			    		cell.setCellStyle(cellStyle);
			    		
			        }
			        
			        //---------접수 및 납기 접수
			        //---------처리율
			        rowCnt+=2;
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        
			        cell = kpiRow.createCell(0);
			        cell.setCellValue(egovMessageSource.getMessage("sr.processingRatio"));
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(1);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(2);
			        cell.setCellStyle(kpiTitleStyle);
			        cell = kpiRow.createCell(3);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(4);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(5);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(6);
			        cell.setCellStyle(kpiTitleStyle);		        
			        cell = kpiRow.createCell(7);
			        cell.setCellStyle(kpiTitleStyle);
			        kpiSheet.addMergedRegion(new CellRangeAddress(rowCnt-1,rowCnt-1,0,8));
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        cell = kpiRow.createCell(0);
			        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.requestDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
			        
			        kpiRow = kpiSheet.createRow(rowCnt++);
			        idx = 0;
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.requestCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.receiptCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.beingSolvedCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.customerConfirmCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.completionRatio"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.evaluationCnt"));
			        cell.setCellStyle(headerStyle);
			        cell = kpiRow.createCell(idx++);
	        		cell.setCellValue(egovMessageSource.getMessage("sr.evaluationReceipt"));
			        cell.setCellStyle(headerStyle);
			        
			        
			        ProcessRateVO processRateVO = new ProcessRateVO();
			        
			        processRateVO.setSearchDateF(searchVO.getSearchCompleteDateF());
			        processRateVO.setSearchDateT(searchVO.getSearchCompleteDateT());
			        processRateVO.setPstinstCode(searchVO.getSearchPstinstCode());
			        processRateVO.setRid(searchVO.getSearchRid());
			        
			        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
							"ROLE_CHARGER".equals(user.getAuthorCode()) ||
							"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
						
					}else{																//현업, 결재자
						processRateVO.setPstinstCode(user.getPstinstCode());
					}	
			        if(pstinstCodeArr.length > 1) processRateVO.setPstinstCodeArr(pstinstCodeArr);
					List processRateReportList =  srProcessRateService.excelDownProcessRateReportList(processRateVO);
			        
					for (int i = 0; i < processRateReportList.size(); i++) {
		        		
			    		Object obj = processRateReportList.get(i);
			    		ProcessRateVO reportVO = (ProcessRateVO) obj;
			    		idx = 0;
			    		row = kpiSheet.createRow(rowCnt++);
			    		
			    		
			    		cell = row.createCell(idx++);
			    		if("en".equals((String)req.getSession().getAttribute("language"))){		            	
			        		cell.setCellValue(reportVO.getModuleNameEn());
			        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
			        		cell.setCellValue(reportVO.getModuleNameCn());				        
			        	}else{
			        		cell.setCellValue(reportVO.getModuleName());
			        	}
			            cell.setCellStyle(cellStyle);
			            cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getSrTotalCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getSignCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getResolveCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getTestAtCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getCompleteCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getCompleteRate());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getEvalCnt());
			    		cell.setCellStyle(cellStyle);
			    		cell = row.createCell(idx++);
			    		cell.setCellValue(reportVO.getEvalPoint());
			    		cell.setCellStyle(cellStyle);		    		
			        }
			        
			        //resp.setContentType("application/octetstream");
			        //resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));
			        bos = new ByteArrayOutputStream();
			        wb.write(bos);
			        //wb.write(zos);
			        zos.write(bos.toByteArray(), 0, bos.size());
			        zos.closeEntry();
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(wb != null) wb.close();
					if(bos != null) bos.close();
				}				
				
			}
		}
		
		zos.flush();
		zos.closeEntry();
		zos.close();
		resp.flushBuffer();
		
		//return retMap;
		
		
	}
	
	private void getLanguage(ModelMap model, HttpServletRequest request) {
		// 다국어 wbpark 2016.05.24
		String language = (String) request.getSession().getAttribute("language");
		if ("ko".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		} else if ("en".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
			model.addAttribute("srLanguage", "en");
		} else if ("cn".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
			model.addAttribute("srLanguage", "cn");
		} else {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		}
	}
	
	/**
	 * html 코드 삭제
	 * @param srReportVO
	 */
	private void htmlRemove(SrVO srDetailVO) {
		//요청내용
		srDetailVO.setComment(srDetailVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
		if(srDetailVO.getComment().length() > 32767) {
			srDetailVO.setComment(srDetailVO.getComment().substring(0,32767));
		}
		//답변내용
		srDetailVO.setAnsComment(srDetailVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
		if(srDetailVO.getAnsComment().length() > 32767) {
			srDetailVO.setAnsComment(srDetailVO.getAnsComment().substring(0,32767));
		}
	}
}