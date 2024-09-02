package egovframework.let.sts.stsfdg.service;

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
 * @Class Name : StsfdgSttusReportExcelView.java
 * @Description : StsfdgSttusReportExcelView class
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
public class StsfdgSttusReportExcelView extends AbstractXlsxView {

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
        	
    		String fileName = "SR만족도현황_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("SR만족도현황");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR만족도현황");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈");
//            row.createCell(idx++).setCellValue("전체건수");
            row.createCell(idx++).setCellValue("완료건수");
//            row.createCell(idx++).setCellValue("미완료건수");
            row.createCell(idx++).setCellValue("5(매우만족)");
            row.createCell(idx++).setCellValue("4(만족)");
            row.createCell(idx++).setCellValue("3(보통)");
            row.createCell(idx++).setCellValue("2(불만)");
            row.createCell(idx++).setCellValue("1(매우불만)");
            row.createCell(idx++).setCellValue("평균");
            
    	}else if("en".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "Satisfaction Status_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("Satisfaction Status");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("Satisfaction Status");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("Module");
//            row.createCell(idx++).setCellValue("전체건수");
            row.createCell(idx++).setCellValue("Number of completion");
//            row.createCell(idx++).setCellValue("미완료건수");
            row.createCell(idx++).setCellValue("5 points(Very satisfied)");
            row.createCell(idx++).setCellValue("4 points(Somewhat satisfied)");
            row.createCell(idx++).setCellValue("3 points(Neutral)");
            row.createCell(idx++).setCellValue("2 points(Somewhat dissatisfied)");
            row.createCell(idx++).setCellValue("1 points(Very dissatisfied)");
            row.createCell(idx++).setCellValue("Average");
            
    	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "满意度现状_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("满意度现状");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("满意度现状");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("模块");
//            row.createCell(idx++).setCellValue("전체건수");
            row.createCell(idx++).setCellValue("完成个数");
//            row.createCell(idx++).setCellValue("미완료건수");
            row.createCell(idx++).setCellValue("5分（非常满意）)");
            row.createCell(idx++).setCellValue("4分（满意）");
            row.createCell(idx++).setCellValue("3分 （一般）");
            row.createCell(idx++).setCellValue("2分 （不满意）");
            row.createCell(idx++).setCellValue("1分 （非常不满意）");
            row.createCell(idx++).setCellValue("平均");
            
    	}else{
    		
    		String fileName = "SR만족도현황_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

            sheet = wb.createSheet("SR만족도현황");
            //sheet.setDefaultColumnWidth((short) 12);
            
            // put text in first cell
            //cell = createCell(sheet, 0, 0);
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR만족도현황");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈");
//            row.createCell(idx++).setCellValue("전체건수");
            row.createCell(idx++).setCellValue("완료건수");
//            row.createCell(idx++).setCellValue("미완료건수");
            row.createCell(idx++).setCellValue("5(매우만족)");
            row.createCell(idx++).setCellValue("4(만족)");
            row.createCell(idx++).setCellValue("3(보통)");
            row.createCell(idx++).setCellValue("2(불만)");
            row.createCell(idx++).setCellValue("1(매우불만)");
            row.createCell(idx++).setCellValue("평균");
            
    	}

        Map<String, Object> map= (Map<String, Object>) model.get("stsfdgSttusReportMap");
        List<Object> stsfdgSttusReportList = (List<Object>) map.get("stsfdgSttusReport");
        Row row = null;
        for (int i = 0; i < stsfdgSttusReportList.size(); i++) {
        		
    		Object obj = stsfdgSttusReportList.get(i);
    		StsfdgSttusVO stsfdgSttusVO = (StsfdgSttusVO) obj;
    		idx = 0;
    		row = sheet.createRow(1+i);
    		//cell = createCell(sheet, 1 + i, idx++);
//    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getModuleName());
            if("ko".equals((String)req.getSession().getAttribute("language"))){
            	row.createCell(idx++).setCellValue(stsfdgSttusVO.getModuleName());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue(stsfdgSttusVO.getModuleNameEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue(stsfdgSttusVO.getModuleNameCn());
        	}else{
        		row.createCell(idx++).setCellValue(stsfdgSttusVO.getModuleName());
        	}
    		
//    		//cell = createCell(sheet, 1 + i, idx++);
//    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getTotalCount());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getCompleteCount());
    		
//    		//cell = createCell(sheet, 1 + i, idx++);
//    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getUncompleteCount());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getValue5());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getValue4());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getValue3());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getValue2());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getValue1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(stsfdgSttusVO.getAvgValue());
            
        }
    }
}
