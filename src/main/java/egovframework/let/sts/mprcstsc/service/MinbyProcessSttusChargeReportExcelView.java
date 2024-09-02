package egovframework.let.sts.mprcstsc.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.text.DecimalFormat;

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
public class MinbyProcessSttusChargeReportExcelView extends AbstractXlsxView {

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
    	Sheet sheet  = null;

        if("ko".equals((String)req.getSession().getAttribute("language"))){

    		String fileName = "담당자별SR월별처리현황_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

    		sheet = wb.createSheet("담당자별SR월별처리현황");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
//            cell = createCell(sheet, 0, 0);
//            setText(cell, "SR월별처리현황");
    		Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("담당자별SR월별처리현황");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈명");
            row.createCell(idx++).setCellValue("담당자");
            row.createCell(idx).setCellValue("건수");
            row.createCell(idx+13).setCellValue("공수");
            
            
            row = sheet.createRow(1);
            
            row.createCell(idx++).setCellValue("1월");
            row.createCell(idx++).setCellValue("2월");
            row.createCell(idx++).setCellValue("3월");
            row.createCell(idx++).setCellValue("4월");
            row.createCell(idx++).setCellValue("5월");
            row.createCell(idx++).setCellValue("6월");
            row.createCell(idx++).setCellValue("7월");
            row.createCell(idx++).setCellValue("8월");
            row.createCell(idx++).setCellValue("9월");
            row.createCell(idx++).setCellValue("10월");
            row.createCell(idx++).setCellValue("11월");
            row.createCell(idx++).setCellValue("12월");
            row.createCell(idx++).setCellValue("합계");
            row.createCell(idx++).setCellValue("1월");
            row.createCell(idx++).setCellValue("2월");
            row.createCell(idx++).setCellValue("3월");
            row.createCell(idx++).setCellValue("4월");
            row.createCell(idx++).setCellValue("5월");
            row.createCell(idx++).setCellValue("6월");
            row.createCell(idx++).setCellValue("7월");
            row.createCell(idx++).setCellValue("8월");
            row.createCell(idx++).setCellValue("9월");
            row.createCell(idx++).setCellValue("10월");
            row.createCell(idx++).setCellValue("11월");
            row.createCell(idx++).setCellValue("12월");
            row.createCell(idx++).setCellValue("합계");
            
    	}else if("en".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "SR Monthly Processing Status_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

    		sheet = wb.createSheet("SR Monthly Processing Status");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
//            cell = createCell(sheet, 0, 0);
//            setText(cell, "SR Monthly Processing Status");
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("SR Monthly Processing Status By Charge");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("Module	");
            row.createCell(idx++).setCellValue("Charge	");
            row.createCell(idx).setCellValue("Number ");
            row.createCell(idx+13).setCellValue("Labour Hours");
            
            
            row = sheet.createRow(1);
            row.createCell(idx++).setCellValue("January");
            row.createCell(idx++).setCellValue("February");
            row.createCell(idx++).setCellValue("March");
            row.createCell(idx++).setCellValue("April");
            row.createCell(idx++).setCellValue("May");
            row.createCell(idx++).setCellValue("June");
            row.createCell(idx++).setCellValue("July");
            row.createCell(idx++).setCellValue("August");
            row.createCell(idx++).setCellValue("September");
            row.createCell(idx++).setCellValue("October");
            row.createCell(idx++).setCellValue("November");
            row.createCell(idx++).setCellValue("December");
            row.createCell(idx++).setCellValue("Total");
            row.createCell(idx++).setCellValue("January");
            row.createCell(idx++).setCellValue("February");
            row.createCell(idx++).setCellValue("March");
            row.createCell(idx++).setCellValue("April");
            row.createCell(idx++).setCellValue("May");
            row.createCell(idx++).setCellValue("June");
            row.createCell(idx++).setCellValue("July");
            row.createCell(idx++).setCellValue("August");
            row.createCell(idx++).setCellValue("September");
            row.createCell(idx++).setCellValue("October");
            row.createCell(idx++).setCellValue("November");
            row.createCell(idx++).setCellValue("December");
            row.createCell(idx++).setCellValue("Total");
            
    	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
    		
    		String fileName = "月度系统需求处理情况_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

    		sheet = wb.createSheet("月度系统需求处理情况");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
//            cell = createCell(sheet, 0, 0);
//            setText(cell, "月度系统需求处理情况");
            Row row = sheet.createRow(0);
            row.createCell(0).setCellValue("月度系统需求处理情况");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("模块");
            row.createCell(idx++).setCellValue("擔當者");
            row.createCell(idx).setCellValue("个数");
            row.createCell(idx+13).setCellValue("小时数");
            
            
            row = sheet.createRow(1);
            row.createCell(idx++).setCellValue("一月");
            row.createCell(idx++).setCellValue("二月");
            row.createCell(idx++).setCellValue("三月");
            row.createCell(idx++).setCellValue("四月");
            row.createCell(idx++).setCellValue("五月");
            row.createCell(idx++).setCellValue("六月");
            row.createCell(idx++).setCellValue("七月");
            row.createCell(idx++).setCellValue("八月");
            row.createCell(idx++).setCellValue("九月");
            row.createCell(idx++).setCellValue("十月");
            row.createCell(idx++).setCellValue("十一月");
            row.createCell(idx++).setCellValue("十二月");
            row.createCell(idx++).setCellValue("总计");
            row.createCell(idx++).setCellValue("一月");
            row.createCell(idx++).setCellValue("二月");
            row.createCell(idx++).setCellValue("三月");
            row.createCell(idx++).setCellValue("四月");
            row.createCell(idx++).setCellValue("五月");
            row.createCell(idx++).setCellValue("六月");
            row.createCell(idx++).setCellValue("七月");
            row.createCell(idx++).setCellValue("八月");
            row.createCell(idx++).setCellValue("九月");
            row.createCell(idx++).setCellValue("十月");
            row.createCell(idx++).setCellValue("十一月");
            row.createCell(idx++).setCellValue("十二月");
            row.createCell(idx++).setCellValue("总计");
            
    	}else{
    		
    		String fileName = "담당자별SR월별처리현황_"+strSaveDate+".xlsx";
    		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

    		sheet = wb.createSheet("담당자별SR월별처리현황");
            //sheet.setDefaultColumnWidth((short) 12);

            // put text in first cell
//          cell = createCell(sheet, 0, 0);
//          setText(cell, "SR월별처리현황");
    		Row row = sheet.createRow(0);
    		row.createCell(0).setCellValue("담당자별SR월별처리현황");
            // set header information
            idx = 0;
            row.createCell(idx++).setCellValue("모듈명");
            row.createCell(idx++).setCellValue("담당자");
            row.createCell(idx).setCellValue("건수");
            row.createCell(idx+13).setCellValue("공수");
                        
            row = sheet.createRow(1);
            row.createCell(idx++).setCellValue("1월");
            row.createCell(idx++).setCellValue("2월");
            row.createCell(idx++).setCellValue("3월");
            row.createCell(idx++).setCellValue("4월");
            row.createCell(idx++).setCellValue("5월");
            row.createCell(idx++).setCellValue("6월");
            row.createCell(idx++).setCellValue("7월");
            row.createCell(idx++).setCellValue("8월");
            row.createCell(idx++).setCellValue("9월");
            row.createCell(idx++).setCellValue("10월");
            row.createCell(idx++).setCellValue("11월");
            row.createCell(idx++).setCellValue("12월");
            row.createCell(idx++).setCellValue("합계");
            row.createCell(idx++).setCellValue("1월");
            row.createCell(idx++).setCellValue("2월");
            row.createCell(idx++).setCellValue("3월");
            row.createCell(idx++).setCellValue("4월");
            row.createCell(idx++).setCellValue("5월");
            row.createCell(idx++).setCellValue("6월");
            row.createCell(idx++).setCellValue("7월");
            row.createCell(idx++).setCellValue("8월");
            row.createCell(idx++).setCellValue("9월");
            row.createCell(idx++).setCellValue("10월");
            row.createCell(idx++).setCellValue("11월");
            row.createCell(idx++).setCellValue("12월");
            row.createCell(idx++).setCellValue("합계");
            
    	}

        Map<String, Object> map= (Map<String, Object>) model.get("minbyProcessSttusChargeReportMap");
        List<Object> minbyProcessSttusChargeReportList = (List<Object>) map.get("minbyProcessSttusChargeReport");
        Row row = null;
        for (int i = 0; i < minbyProcessSttusChargeReportList.size(); i++) {
    		
    		Object obj = minbyProcessSttusChargeReportList.get(i);
    		MinbyProcessSttusChargeVO minbyProcessSttusChargeVO = (MinbyProcessSttusChargeVO) obj;
    		row = sheet.createRow(2+i);
    		idx = 0;

    		//cell = createCell(sheet, 1 + i, idx++);
//    		setText(cell, minbyProcessSttusVO.getModuleName());
            if("ko".equals((String)req.getSession().getAttribute("language"))){
            	if(minbyProcessSttusChargeVO.getRname() == null) {
            		if("합계".equals(minbyProcessSttusChargeVO.getModuleName())) {		
            			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName());
            		}else {	
            			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName() + " 합계");
            		}
            	}else {
            		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName());
            	}
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		if(minbyProcessSttusChargeVO.getRname() == null) {        			
        			if("Total".equals(minbyProcessSttusChargeVO.getModuleName())) {					
        				row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameEn());
        			}else {		
        				row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameEn() + " Total");
        			}
        		}else {	
        			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameEn());
        		}
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		if(minbyProcessSttusChargeVO.getRname() == null) {
        			if("总计".equals(minbyProcessSttusChargeVO.getModuleName())) {			
        				row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameCn() + " 总计");
        			}	else {
        				row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameCn() + " 总计");
        			}			
        		}else {
        			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleNameCn());
        		}
        	}else{
        		if(minbyProcessSttusChargeVO.getRname() == null) {
        			if("합계".equals(minbyProcessSttusChargeVO.getModuleName())) {		
            			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName());
            		}else {	
            			row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName() + " 합계");
            		}
            	}else {
            		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getModuleName());
            	}
        	}
            
            row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getRname());
    		
            //cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJan());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getFeb());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getMar());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getApr());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getMay());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJun());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJul());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getAug());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getSep());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getOct());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getNov());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getDec());

    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getTotal());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJan1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getFeb1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getMar1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getApr1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getMay1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJun1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getJul1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getAug1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getSep1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getOct1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getNov1());
    		
    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getDec1());

    		//cell = createCell(sheet, 1 + i, idx++);
    		row.createCell(idx++).setCellValue(minbyProcessSttusChargeVO.getTotal1());
        }
    }
}
