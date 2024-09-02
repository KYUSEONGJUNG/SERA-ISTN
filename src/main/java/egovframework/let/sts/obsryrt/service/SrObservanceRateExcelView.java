package egovframework.let.sts.obsryrt.service;

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
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

/**
 * @Class Name : SrObservanceRateExcelView.java
 * @Description : SrObservanceRateExcelView class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2014.08.21    박원배          최초 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 *  @author SR 개발팀 박원배
 *  @since 2014.08.21
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2014 by ISPRINT  All right reserved.
 */
public class SrObservanceRateExcelView extends AbstractXlsxView {

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

        XSSFCell cell = null;
        int idx = 0;
        Sheet sheet = null;
        
        if("en".equals((String)req.getSession().getAttribute("language"))) {
        	
        	String fileName = "Reception and on-time Completed Ratio_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));
            
            sheet = wb.createSheet("Reception and on-time Completed Ratio");
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("Reception and on-time Completed Ratio");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("Module");
            row.createCell(idx++).setCellValue("Requests");
            row.createCell(idx++).setCellValue("Receipt");
            row.createCell(idx++).setCellValue("day Reception");
            row.createCell(idx++).setCellValue("day Reception Ratio(%)");
            row.createCell(idx++).setCellValue("Completion");
            row.createCell(idx++).setCellValue("Completed on time");
            row.createCell(idx++).setCellValue("Completed on time Ratio(%)");
        	
        } else if ("cn".equals((String)req.getSession().getAttribute("language"))) {
        	
        	String fileName = "提交率和按时完成率_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));
            
            sheet = wb.createSheet("提交率和按时完成率");
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("提交率和按时完成率");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("模块");
            row.createCell(idx++).setCellValue("提交个数");
            row.createCell(idx++).setCellValue("接收个数");
            row.createCell(idx++).setCellValue("当日接待");
            row.createCell(idx++).setCellValue("当日接待率(%)");
            row.createCell(idx++).setCellValue("完成个数");
            row.createCell(idx++).setCellValue("按时完成");
            row.createCell(idx++).setCellValue("按时完成率(%)");
        	
        } else {
        	
        	String fileName = "접수및납기준수율_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));
            
            sheet = wb.createSheet("접수및납기준수율");
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("접수 및 납기 준수율");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("구분");
            row.createCell(idx++).setCellValue("요청건수");
            row.createCell(idx++).setCellValue("접수건수");
            row.createCell(idx++).setCellValue("당일 접수 건");
            row.createCell(idx++).setCellValue("당일 접수 준수율(%)");
            row.createCell(idx++).setCellValue("완료건수");
            row.createCell(idx++).setCellValue("납기 내 완료 건");
            row.createCell(idx++).setCellValue("납기 준수율(%)");
        	
        }      
        

        Map<String, Object> map= (Map<String, Object>) model.get("srObservanceRateReportMap");
        List<Object> srObservanceRateReportList = (List<Object>) map.get("srObservanceRateReport");

        for (int i = 0; i < srObservanceRateReportList.size(); i++) {
        		
    		Object obj = srObservanceRateReportList.get(i);
    		SrObservanceRateVO processRateVO = (SrObservanceRateVO) obj;
    		idx = 0;
    		Row row = sheet.createRow(1+i);
    		row = sheet.createRow(1+i);
    		//cell = createCell(sheet, 1 + i, idx++);
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
    		row.createCell(idx++).setCellValue(processRateVO.getSignCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getConfirmCnt());
    		    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getInConfirmCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getInConfirmRate());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getCompleteCnt());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getInCompleteCnt());        		
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(processRateVO.getInCompleteRate());
    		
        }
    }
}
