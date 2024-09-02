<%--
  Class Name : EgovSrProcessRate.jsp
  Description : SR처리율
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 박지욱
    since    : 2009.03.23 
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
-->


<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<meta http-equiv="Content-Language" content="ko">
	<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
	<!--<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css">-->
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>

<title>월간보고서 다운로드</title> 
<script type="text/javaScript" language="javascript">

function fnExcelReport(){
	
	if(!$("#searchCompleteDateT").val() || $("#searchCompleteDateT").val().length != 6){
		alert("요청년월을 정확하게 입력해주세요.");
	}else{
		//var varForm              = document.all["Form"];
      var varForm = document.listForm;
      varForm.action           = "<c:url value='/sts/report/EgovSrReportExcelDownload.do'/>";
      varForm.submit();
      varForm.action = ""; 
		/* $.ajax({
	    	url : "<c:url value='/sts/report/EgovSrReportExcelDownload.do'/>",
	   	    type : 'POST',
	   	    data : $("#listForm").serialize(),
	   	    beforeSend : fn_loading(),
	   	    success : function(data, status, xhr){   	    	
	   	    	
	   	    	if(data.fileBinary){
	   	    		var jsonBinary = JSON.parse(data.fileBinary);
	   	    		var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/zip"});
	   	    		//var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
	   	            var url = URL.createObjectURL(blob);
	   	         	var link = document.createElement('a'); 
					link.href = url; 
					link.download = data.filename; 
					link.click();
					link.remove();
	   	    	}else{
	   	    		if(data.msg){
	   	    			alert(data.msg);
	   	    		}else{
	   	    			alert("<spring:message code='info.nodata.msg'/>");
	   	    		}
	   	    		
	   	    	} 
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	fn_closeLoading();
	   	    }
		}); */
	}
}
	
</script>
</head>
<body>
	<!-- 전체 레이어 시작 -->
	<div class="sr-contents-wrap">
		<c:import url="/sym/mms/EgovMainMenuLeft.do" />
		<!-- 현재위치 네비게이션 시작 -->
		<div class="sr-contents-area">
			<div class="sr-contents">
				<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
				
				<form name="listForm" id="listForm" action="<c:url value='/sts/prcrt/selectSrProcessRate.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<!-- 검색 필드 박스 시작 -->
					<div class="sr-table-wrap">
		                <table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
		                        <col width="*">
		                    </colgroup>
		                    <tbody>
		                    
		                    	<tr>
		                    		<th>
		                    			<sbux-label id="table_label1" name="table_label1" uitype="normal" text="요청년월(YYYYMM)"></sbux-label>
		                    		</th>
		                    		<td>
		                                <sbux-input id="searchCompleteDateT" name="searchCompleteDateT" uitype="text" maxlength="6" >
	                                
	                               		</sbux-input>
		                            </td>		                           
		                    	</tr>		                    	
		                    </tbody>
						</table>
					</div>
				</form>
				<!-- //검색 필드 박스 끝 -->
				<div class="grid_area">
	                <div class="btn_grid">
                    	<sbux-button uitype="normal" text="<spring:message code='sr.excelDownload' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fnExcelReport(); return false;"></sbux-button>                    
	                </div>	                
                </div>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->
</body>
</html>