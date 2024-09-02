package egovframework.let.sts.prcrt.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

/**
 * @Class Name : SrReportExcelView.java
 * @Description : SrReportExcelView class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.05    천종덕          최초 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 *  @author 실행환경 개발팀 천종덕
 *  @since 2009.03.05
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
public class ProcessRateReportExcelView extends AbstractXlsxView {

	/**
	 * 엑셀파일을 만들어 다운로드한다.
	 * @param model - 생성할 정보가 담긴 Map
	 * @return "엑셀파일 다운로드"
	 * @exception Exception
	 */                 
	@Override
	protected void buildExcelDocument(Map model, Workbook wb,
            HttpServletRequest req, HttpServletResponse resp) throws Exception {
						
		//저장일
		Calendar cal = Calendar.getInstance();
    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
    	Date saveDate = sdfmt.parse(strSaveDate);
    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);

    	HSSFCell cell = null;
    	int idx = 0;
    	Sheet sheet = null;

    	if("ko".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "SR처리율_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("SR처리율");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR처리율");

            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈");
            row.createCell(idx++).setCellValue("요청건수");
            row.createCell(idx++).setCellValue("접수건수");
//            row.createCell(idx++).setCellValue("신청건수");
            row.createCell(idx++).setCellValue("해결중건수");
            row.createCell(idx++).setCellValue("고객확인건수");
            row.createCell(idx++).setCellValue("완료건수");
            row.createCell(idx++).setCellValue("완료율(%)");
            row.createCell(idx++).setCellValue("평가건수");
            row.createCell(idx++).setCellValue("평가점수(평균)");
    	}else if("en".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "SR processing ratio_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("SR processing ratio");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR processing ratio");

            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("Module");
            row.createCell(idx++).setCellValue("The number of requests");
            row.createCell(idx++).setCellValue("The number of receipt");
//            row.createCell(idx++).setCellValue("신청건수");
            row.createCell(idx++).setCellValue("Number of being solved");
            row.createCell(idx++).setCellValue("Number of Customer confirm");
            row.createCell(idx++).setCellValue("Number of completion");
            row.createCell(idx++).setCellValue("Completion ratio(%)");
            row.createCell(idx++).setCellValue("Number of evaluation");
            row.createCell(idx++).setCellValue("Evaluation receipt(Average)");
    		
    	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "系统需求处理率_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

    		sheet = wb.createSheet("系统需求处理率");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("系统需求处理率");

            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("模块");
            row.createCell(idx++).setCellValue("提交个数");
            row.createCell(idx++).setCellValue("接收个数");
//            row.createCell(idx++).setCellValue("신청건수");
            row.createCell(idx++).setCellValue("处理中个数");
            row.createCell(idx++).setCellValue("客户确认个数");
            row.createCell(idx++).setCellValue("完成个数");
            row.createCell(idx++).setCellValue("完成率(%)");
            row.createCell(idx++).setCellValue("评估个数");
            row.createCell(idx++).setCellValue("评估接收（平均）");
            
    	}else{

    		String fileName = "SR처리율_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("SR처리율");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR처리율");

            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈");
            row.createCell(idx++).setCellValue("요청건수");
            row.createCell(idx++).setCellValue("접수건수");
//            row.createCell(idx++).setCellValue("신청건수");
            row.createCell(idx++).setCellValue("해결중건수");
            row.createCell(idx++).setCellValue("고객확인건수");
            row.createCell(idx++).setCellValue("완료건수");
            row.createCell(idx++).setCellValue("완료율(%)");
            row.createCell(idx++).setCellValue("평가건수");
            row.createCell(idx++).setCellValue("평가점수(평균)");
            
    	}

        Map<String, Object> map= (Map<String, Object>) model.get("processRateReportMap");
        List<Object> processRateReportList = (List<Object>) map.get("processRateReport");
        
        for (int i = 0; i < processRateReportList.size(); i++) {
        		
    		Object obj = processRateReportList.get(i);
    		ProcessRateVO processRateVO = (ProcessRateVO) obj;
    		idx = 0;
    		Row row = sheet.createRow(1+i);
    		//cell = createCell(sheet, 1 + i, idx++);
//    		row.createCell(idx++).setCellValue(processRateVO.getModuleName());
            if("ko".equals((String)req.getSession().getAttribute("language"))){
            	row.createCell(idx++).setCellValue(processRateVO.getModuleName());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue(processRateVO.getModuleNameEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue(processRateVO.getModuleNameCn());
        	}else{
        		row.createCell(idx++).setCellValue(processRateVO.getModuleName());
        	}
            
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getSrTotalCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getSignCnt());
    		
//    		//cell = createCell(sheet, 1 + i, idx++);
//    		row.createCell(idx++).setCellValue(processRateVO.getRequestCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getResolveCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getTestAtCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getCompleteCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getCompleteRate());        		
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getEvalCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getEvalPoint()); 

        }
    }
}
