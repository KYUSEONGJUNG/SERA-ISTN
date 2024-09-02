	package egovframework.let.sr.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.logging.log4j.core.tools.picocli.CommandLine.Help.TextTable.Cell;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

import egovframework.let.sr.service.SrVO;

/**
 * @Class Name : SrDetailExcelView.java
 * @Description : SrDetailExcelView class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.05    천종덕          최초 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 *
 *  @author 실행환경 개발팀 천종덕
 *  @since 2009.03.05
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
public class SrDetailExcelView extends AbstractXlsxView {

	/**
	 * 엑셀파일을 만들어 다운로드한다.
	 * @param model - 생성할 정보가 담긴 Map
	 * @return "엑셀파일 다운로드"
	 * @exception Exception
	 */                 
	protected void buildExcelDocument(Map model, Workbook wb,
            HttpServletRequest req, HttpServletResponse resp) throws Exception {
    	
    	//저장일
		Calendar cal = Calendar.getInstance();
    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
    	Date saveDate = sdfmt.parse(strSaveDate);
    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);
		
		String fileName = "SR리스트(상세내역)_"+strSaveDate+".xls";
		resp.setContentType("application/octetstream");
		resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

        HSSFCell cell = null;
        int idx = 0;

        Sheet sheet = wb.createSheet("SR리스트");
        //sheet.setDefaultColumnWidth((short) 12);

        // put text in first cell
//        cell = createCell(sheet, 0, 0);
//        setText(cell, "SR리스트(상세내역)");
        Row row = sheet.createRow(0);
        row.createCell(0).setCellValue("SR리스트(상세내역)");
        // set header information
//        setText(createCell(sheet, 0, idx++), "SR번호");
//        setText(createCell(sheet, 0, idx++), "제목");
//        setText(createCell(sheet, 0, idx++), "모듈");
//        setText(createCell(sheet, 0, idx++), "처리구분");
//        setText(createCell(sheet, 0, idx++), "상태");
//        setText(createCell(sheet, 0, idx++), "요청자");
//        setText(createCell(sheet, 0, idx++), "요청일시");
//        setText(createCell(sheet, 0, idx++), "완료예정일");
//        setText(createCell(sheet, 0, idx++), "담당자");
//        setText(createCell(sheet, 0, idx++), "처리완료일");
//        setText(createCell(sheet, 0, idx++), "고객확인완료일");
//        setText(createCell(sheet, 0, idx++), "요청내역");
//        setText(createCell(sheet, 0, idx++), "답변");
//        setText(createCell(sheet, 0, idx++), "실제공수");
//        setText(createCell(sheet, 0, idx++), "처리모듈");
//        setText(createCell(sheet, 0, idx++), "고객사");
        idx = 0;
        row = sheet.createRow(0);
        
        row.createCell(idx++).setCellValue("SR번호");
        row.createCell(idx++).setCellValue("제목");
        row.createCell(idx++).setCellValue("모듈");
        row.createCell(idx++).setCellValue("처리구분");
        row.createCell(idx++).setCellValue("상태");
        row.createCell(idx++).setCellValue("요청자");
        row.createCell(idx++).setCellValue("요청일시");
        row.createCell(idx++).setCellValue("완료예정일");
        row.createCell(idx++).setCellValue("담당자");
        row.createCell(idx++).setCellValue("처리완료일");
        row.createCell(idx++).setCellValue("고객확인완료일");
        row.createCell(idx++).setCellValue("요청내역");
        row.createCell(idx++).setCellValue("답변");
        row.createCell(idx++).setCellValue("실제공수");
        row.createCell(idx++).setCellValue("처리모듈");
        row.createCell(idx++).setCellValue("고객사");

        Map<String, Object> map= (Map<String, Object>) model.get("srDetailMap");
        List<Object> srDetailList = (List<Object>) map.get("srDetail");

        for (int i = 0; i < srDetailList.size(); i++) {
        	Object obj = srDetailList.get(i);
        	SrVO srDetailVO = (SrVO) obj;
            idx = 0;
            row = sheet.createRow(1+i);

            row.createCell(idx++).setCellValue(srDetailVO.getSrNo());

            row.createCell(idx++).setCellValue(srDetailVO.getSubject());

            row.createCell(idx++).setCellValue(srDetailVO.getModuleNm());

            row.createCell(idx++).setCellValue(srDetailVO.getCategoryNm());

            row.createCell(idx++).setCellValue( srDetailVO.getStatusNm());

            row.createCell(idx++).setCellValue( srDetailVO.getCustomerNm());

            row.createCell(idx++).setCellValue( srDetailVO.getSignDate());

            row.createCell(idx++).setCellValue( srDetailVO.getScheduleDate());

            row.createCell(idx++).setCellValue( srDetailVO.getRname());

            row.createCell(idx++).setCellValue( srDetailVO.getCompleteDate());
            
            row.createCell(idx++).setCellValue( srDetailVO.getTestCompleteDate());

            htmlRemove(srDetailVO);		//html 코드 제거
            row.createCell(idx++).setCellValue( srDetailVO.getComment()==null?"":srDetailVO.getComment());
//            setText(cell, srDetailVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", ""));

            row.createCell(idx++).setCellValue( srDetailVO.getAnsComment()==null?"":srDetailVO.getAnsComment());
//            setText(cell, srDetailVO.getAnsComment()==null?"":srDetailVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", ""));

            row.createCell(idx++).setCellValue( srDetailVO.getAnsRealExpectTime());
            
            row.createCell(idx++).setCellValue( srDetailVO.getAnsModuleNm());
            
            row.createCell(idx++).setCellValue( srDetailVO.getPstinstNm());

        }
    }
	
	/**
	 * html 코드 삭제
	 * @param srReportVO
	 */
	private void htmlRemove(SrVO srDetailVO) {
		//요청내용
		srDetailVO.setComment(srDetailVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));

		//답변내용
		srDetailVO.setAnsComment(srDetailVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
	
	}
}
