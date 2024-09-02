package egovframework.let.sr.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
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
public class SrReportExcelView extends AbstractXlsxView {

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

			String fileName = "SR리스트(월간보고서용)_"+strSaveDate+".xlsx";
			resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

	        sheet = wb.createSheet("SR리스트");
	        //sheet.setDefaultColumnWidth((short) 12);
	        
	        // put text in first cell
//	        cell = getCell(sheet, 0, 0);
//	        setText(cell, "SR리스트(월간보고서용)");
	        Row row = sheet.createRow(0);
	        row.createCell(0).setCellValue("SR리스트(월간보고서용)");
	        // set header information
	        idx = 0;
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
	        row.createCell(idx++).setCellValue("전체공수");
	        row.createCell(idx++).setCellValue("ABAP공수");
	        row.createCell(idx++).setCellValue("만족도");
	        //row.createCell(idx++).setCellValue("요청내역");
	        //row.createCell(idx++).setCellValue("답변");
	        row.createCell(idx++).setCellValue("고객사");			
			
    	}else if("en".equals((String)req.getSession().getAttribute("language"))){

			String fileName = "Excel Download(For the monthly report)_"+strSaveDate+".xlsx";
			resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

			sheet = wb.createSheet("SR List");
	        //sheet.setDefaultColumnWidth((short) 12);

	        // put text in first cell
//	        cell = createCell(sheet, 0, 0);
//	        setText(cell, "Excel Download(For the monthly report)");
	        Row row = sheet.createRow(0);
	        row.createCell(0).setCellValue("Excel Download(For the monthly report)");
	        // set header information
	        idx = 0;
	        row.createCell(idx++).setCellValue("SR Number");
	        row.createCell(idx++).setCellValue("Title");
	        row.createCell(idx++).setCellValue("Module");
	        row.createCell(idx++).setCellValue("Processing division");
	        row.createCell(idx++).setCellValue("Status");
	        row.createCell(idx++).setCellValue("Requester");
	        row.createCell(idx++).setCellValue("Request date");
	        row.createCell(idx++).setCellValue("Expected completion date");
	        row.createCell(idx++).setCellValue("The person in charge");
	        row.createCell(idx++).setCellValue("Processing completion date");
	        row.createCell(idx++).setCellValue("Customers confirmation Completion Date");
	        row.createCell(idx++).setCellValue("Real labour hours");
	        row.createCell(idx++).setCellValue("ABAP labour hours");
	        row.createCell(idx++).setCellValue("Satisfaction");
	        //row.createCell(idx++).setCellValue("Request content");
	        //row.createCell(idx++).setCellValue("Answers");
	        row.createCell(idx++).setCellValue("Client");    		
    		
    	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
    		
			String fileName = "下载文件（月报表）_"+strSaveDate+".xlsx";
			resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

			sheet = wb.createSheet("系統需求清单");
	        //sheet.setDefaultColumnWidth((short) 12);

	        // put text in first cell
//	        cell = createCell(sheet, 0, 0);
//	        setText(cell, "下载文件（月报表）");
	        Row row = sheet.createRow(0);
	        row.createCell(0).setCellValue("下载文件（月报表）");
	        // set header information
	        idx = 0;
	        row.createCell(idx++).setCellValue("系统需求编码");
	        row.createCell(idx++).setCellValue("标题");
	        row.createCell(idx++).setCellValue("模块");
	        row.createCell(idx++).setCellValue("处理状态");
	        row.createCell(idx++).setCellValue("状态");
	        row.createCell(idx++).setCellValue("提交者");
	        row.createCell(idx++).setCellValue("提交日期");
	        row.createCell(idx++).setCellValue("预计完成日期");
	        row.createCell(idx++).setCellValue("负责人");
	        row.createCell(idx++).setCellValue("处理完成日期");
	        row.createCell(idx++).setCellValue("客户确认日期");
	        row.createCell(idx++).setCellValue("实际处理小时数");
	        row.createCell(idx++).setCellValue("ABAP开发工时");
	        row.createCell(idx++).setCellValue("满意度");
	        //row.createCell(idx++).setCellValue("提交内容");
	        //row.createCell(idx++).setCellValue("处理内容");
	        row.createCell(idx++).setCellValue("客户"); 
    		
    	}else{
    		
			String fileName = "SR리스트(월간보고서용)_"+strSaveDate+".xlsx";
			resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

			sheet = wb.createSheet("SR리스트");
	        //sheet.setDefaultColumnWidth((short) 12);

	        // put text in first cell
//	        cell = createCell(sheet, 0, 0);
//	        setText(cell, "SR리스트(월간보고서용)");
	        Row row = sheet.createRow(0);
	        row.createCell(0).setCellValue("SR리스트(월간보고서용)");
	        // set header information
	        idx = 0;
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
	        row.createCell(idx++).setCellValue("전체공수");
	        row.createCell(idx++).setCellValue("ABAP공수");
	        row.createCell(idx++).setCellValue("만족도");
	        //row.createCell(idx++).setCellValue("요청내역");
	        //row.createCell(idx++).setCellValue("답변");
	        row.createCell(idx++).setCellValue("고객사");
	        
    	}

        Map<String, Object> map= (Map<String, Object>) model.get("srReportMap");
        List<Object> srReportList = (List<Object>) map.get("srReport");
        Row row = null;
        for (int i = 0; i < srReportList.size(); i++) {
        	Object obj = srReportList.get(i);
        	SrVO srReportVO = (SrVO) obj;
            idx = 0;
            row = sheet.createRow(1+i);
            
            row.createCell(idx++).setCellValue(srReportVO.getSrNo());

            row.createCell(idx++).setCellValue(srReportVO.getSubject());

            //cell = createCell(sheet, 1 + i, idx++);
//            setText(cell, srReportVO.getModuleNm());
            if("ko".equals((String)req.getSession().getAttribute("language"))){
            	row.createCell(idx++).setCellValue( srReportVO.getModuleNm());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getModuleNmEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getModuleNmCn());
        	}else{
        		row.createCell(idx++).setCellValue( srReportVO.getModuleNm());
        	}

            //cell = createCell(sheet, 1 + i, idx++);
//            setText(cell, srReportVO.getCategoryNm());
    		if("ko".equals((String)req.getSession().getAttribute("language"))){
    			row.createCell(idx++).setCellValue( srReportVO.getCategoryNm());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getCategoryNmEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getCategoryNmCn());
        	}else{
        		row.createCell(idx++).setCellValue( srReportVO.getCategoryNm());
        	}

            //cell = createCell(sheet, 1 + i, idx++);
//            row.createCell(idx++).setCellValue( srReportVO.getStatusNm());
    		if("ko".equals((String)req.getSession().getAttribute("language"))){
    			row.createCell(idx++).setCellValue( srReportVO.getStatusNm());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getStatusNmEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getStatusNmCn());
        	}else{
        		row.createCell(idx++).setCellValue( srReportVO.getStatusNm());
        	}

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getCustomerNm());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getSignDate());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getScheduleDate());

            //cell = createCell(sheet, 1 + i, idx++);
//            row.createCell(idx++).setCellValue( srReportVO.getRname());
    		if("ko".equals((String)req.getSession().getAttribute("language"))){
    			row.createCell(idx++).setCellValue( srReportVO.getRname());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getRnameEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getRnameEn());
        	}else{
        		row.createCell(idx++).setCellValue( srReportVO.getRname());
        	}               

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getCompleteDate());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getTestCompleteDate());

            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getRealExpectTime());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getAbapRealExpectTime());
            
            //cell = createCell(sheet, 1 + i, idx++);
            row.createCell(idx++).setCellValue( srReportVO.getPoint());

            htmlRemove(srReportVO);		//html 코드 제거
            //cell = createCell(sheet, 1 + i, idx++);      
            //row.createCell(idx++).setCellValue( srReportVO.getComment()==null?"":srReportVO.getComment());

            //cell = createCell(sheet, 1 + i, idx++);
            //row.createCell(idx++).setCellValue( srReportVO.getAnsComment()==null?"":srReportVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
            //row.createCell(idx++).setCellValue( srReportVO.getAnsComment()==null?"":srReportVO.getAnsComment());

            //cell = createCell(sheet, 1 + i, idx++);
//            row.createCell(idx++).setCellValue( srReportVO.getPstinstNm());
    		if("ko".equals((String)req.getSession().getAttribute("language"))){
    			row.createCell(idx++).setCellValue( srReportVO.getPstinstNm());
        	}else if("en".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getPstinstNmEn());
        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
        		row.createCell(idx++).setCellValue( srReportVO.getPstinstNmEn());
        	}else{
        		row.createCell(idx++).setCellValue( srReportVO.getPstinstNm());
        	}            
        }
    }

	/**
	 * html 코드 삭제
	 * @param srReportVO
	 */
	private void htmlRemove(SrVO srReportVO) {
		//요청내용
		srReportVO.setComment(srReportVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("behavior:url","").replaceAll(";", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("#default#VML","").replaceAll(":* ", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("<!--","").replaceAll("/* Font Definitions */", "").replaceAll("@font-face", "").replaceAll("font-family:", "").replaceAll("맑은 고딕", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("panose-1:2 11 5 3 2 0 0 2 0 4;","").replaceAll("/* Style Definitions */", "").replaceAll("p.MsoNormal, li.MsoNormal, div.MsoNormal", "").replaceAll("margin:0cm;", "").replaceAll("margin-bottom:.0001pt;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("text-align:justify;","").replaceAll("text-justify:inter-ideograph;", "").replaceAll("text-autospace:none;", "").replaceAll("word-break:break-hangul;", "").replaceAll("font-size:10.0pt;", ""));

		//		srReportVO.setComment(srReportVO.getComment().replaceAll("font-family:","").replaceAll("a:link, span.MsoHyperlink", "").replaceAll("mso-style-priority:99;", "").replaceAll("color:blue;;", "").replaceAll("text-decoration:underline;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("a:visited, span.MsoHyperlinkFollowed","").replaceAll("color:purple;", "").replaceAll("p.MsoAcetate, li.MsoAcetate, div.MsoAcetate", "").replaceAll("mso-style-link:", "").replaceAll("풍선 도움말 텍스트 Char", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("margin:0cm;","").replaceAll("font-size:9.0pt;", "").replaceAll("p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph", "").replaceAll("mso-style-priority:34;", "").replaceAll("margin-top:0cm;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("margin-right:0cm;","").replaceAll("margin-bottom:0cm;", "").replaceAll("margin-left:40.0pt;", "").replaceAll("mso-para-", "").replaceAll("margin-left:4.0gd;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("span.EmailStyle17","").replaceAll("mso-style-type:personal-compose;", "").replaceAll("color:windowtext;", "").replaceAll("span.Char", "").replaceAll("mso-style-name:", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("mso-style-priority:99;","").replaceAll("풍선 도움말 텍스트", "").replaceAll(".MsoChpDefault", "").replaceAll("mso-style-type:export-only;", "").replaceAll("/* Page Definitions */", ""));

		//		srReportVO.setComment(srReportVO.getComment().replaceAll("@page Section1","").replaceAll("size:612.0pt 792.0pt;", "").replaceAll("margin:3.0cm 72.0pt 72.0pt 72.0pt;", "").replaceAll("div.Section1", "").replaceAll("page:Section1;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("/* List Definitions */","").replaceAll("@list l0", "").replaceAll("mso-list-id:1315643567;", "").replaceAll("mso-list-type:hybrid;", "").replaceAll("mso-list-template-ids:-1611736774 -986394214 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll(":level1","").replaceAll("mso-level-tab-stop:none;", "").replaceAll("mso-level-number-position:left;", "").replaceAll("margin-left:38.0pt;", "").replaceAll("text-indent:-18.0pt;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("@list l1","").replaceAll("mso-list-id:1589344224;", "").replaceAll("mso-list-template-ids:-1070802474 655280038 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;", "").replaceAll("@list l2", "").replaceAll("mso-list-id:2077821313;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("mso-list-template-ids:-2035009888 -1382143528 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;","").replaceAll("Cambria Math", "").replaceAll("panose-1:2 4 5 3 5 4 6 3 2 4;", "").replaceAll("@page WordSection1", "").replaceAll("div.WordSection1", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("page:WordSection1;","").replaceAll("&#10;", "").replaceAll("&#13;", "").replaceAll("바탕;", "").replaceAll("panose-1:2 3 6 0 0 1 1 1 1 1;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("굴림;","").replaceAll("panose-1:2 11 6 0 0 1 1 1 1 1;", "").replaceAll("@굴림", "").replaceAll("@바탕", "").replaceAll("Tahoma;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("panose-1:2 11 6 4 3 5 4 4 2 4;","").replaceAll("span.EmailStyle19", "").replaceAll("mso-style-type:personal;", "").replaceAll("span.EmailStyle20", "").replaceAll("mso-style-type:personal-reply;", ""));
//		srReportVO.setComment(srReportVO.getComment().replaceAll("color:#1F497D;","").replaceAll(".shape",""));
		
		//답변내용
		srReportVO.setAnsComment(srReportVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
	
	}
}
