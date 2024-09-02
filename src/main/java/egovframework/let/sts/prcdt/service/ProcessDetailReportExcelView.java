package egovframework.let.sts.prcdt.service;

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
public class ProcessDetailReportExcelView extends AbstractXlsxView {

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
		
		String fileName = "SR상세처리내역_"+strSaveDate+".xlsx";
		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

        HSSFCell cell = null;
        int idx = 0;

        Sheet sheet = wb.createSheet("SR상세처리내역");
        //sheet.setDefaultColumnWidth((short) 12);
        
        // put text in first cell
        //cell = createCell(sheet, 0, 0);
        Row row = sheet.createRow(0);
        row.createCell(0).setCellValue("SR상세처리내역");
        // set header information
        idx = 0;
        row.createCell(idx++).setCellValue("고객사명");
        row.createCell(idx++).setCellValue("요청일");
        row.createCell(idx++).setCellValue("SR번호");
        row.createCell(idx++).setCellValue("SR제목");
        row.createCell(idx++).setCellValue("요청자성명");
        row.createCell(idx++).setCellValue("고객테스트완료일");
        row.createCell(idx++).setCellValue("운영잉관일");
        row.createCell(idx++).setCellValue("예상공수(H)");
        row.createCell(idx++).setCellValue("실적공수(H)");
        row.createCell(idx++).setCellValue("모듈(분야)");
        row.createCell(idx++).setCellValue("담당자(처리자)");
        row.createCell(idx++).setCellValue("해결일자");
        row.createCell(idx++).setCellValue("처리내역");

        Map<String, Object> map= (Map<String, Object>) model.get("processDetailReportMap");
        List<Object> processDetailReportList = (List<Object>) map.get("processDetailReport");

        for (int i = 0; i < processDetailReportList.size(); i++) {
        	Object obj = processDetailReportList.get(i);
        	ProcessDetailVO processDetailVO = (ProcessDetailVO) obj;
            idx = 0;
            
            row = sheet.createRow(1+i);
    	
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getCompanyName());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getRequestDate());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getSrNo());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getSubject());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getRequesterName());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getTestCompleteDate());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getTransferDate());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getExpectTime());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getRealExpectTime());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getModuleName());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getResponserName());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getCompleteDate());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue(processDetailVO.getComment());
            
        }
    }
}
