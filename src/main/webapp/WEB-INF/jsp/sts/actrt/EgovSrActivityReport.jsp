<%--
  Class Name : EgovSrActivityReport.jsp
  Description : SR Activity Report
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

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" /> --%>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />"></script>
<meta http-equiv="Content-Language" content="ko">

<title>SR Activity Report</title>
<script type="text/javaScript" language="javascript">
 
//그리드 1
SBGrid3.$(document).ready(function () {
    init(); 
})
var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];
var moduleData = [];
var statusData = []; 
var srLanguage = "<c:out value = '${srLanguage}'/>";

function init(){
	//Module Text	
	<c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
		moduleData.push({ value: '${moduleCode_result.code}', label: '${moduleCode_result.codeNm}' });
	</c:forEach>
	
	//Status Text
	<c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
		<c:if test="${srLanguage == 'en'}">
			statusData.push({ value: '${statusCode_result.code}', label: '${statusCode_result.codeNmEn}' });
		</c:if>
		<c:if test="${srLanguage == 'cn'}">
			statusData.push({ value: '${statusCode_result.code}', label: '${statusCode_result.codeNmCn}' });
		</c:if>
		<c:if test="${srLanguage != 'en' && srLanguage != 'cn'}">
			statusData.push({ value: '${statusCode_result.code}', label: '${statusCode_result.codeNm}' });
		</c:if>
	</c:forEach>
	
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {    	
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/sts/actrt/selectSrActivityReport.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){
	   	    	gridData = data.resultList;   	    	
	 	   		//Rname Setting
	   	    	if(srLanguage == 'en' || srLanguage == 'cn'){
	   	    		for(var i in gridData){
	   	    			gridData[i].rname = gridData[i].rnameEn;			
	   	    		}
	   	    	}	 	   		
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.resultList })
	 	   		$("#totalCnt").text(data.paginationInfo.totalRecordCount.toLocaleString('ko-KR'));
	 	   		$("#realExpectTimeSum").text(data.realExpectTimeSum ? data.realExpectTimeSum : 0 );
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	fn_closeLoading();
	   	    }
		});
	});
}

 function createGrid() {
     let dsConfig = {
		ajax: {
	       // 해당 소스를 추가해주시면 됩니다.
	       select: async(request) => {
	         return await loadData(request);
	       },
             // 해당 부분이 받아온 response data의 protorype name 입니다. 데이터 형식은 최하단에 첨부하겠습니다.
             // 기존 같은 경우 data: 데이터 객체를 넣었겠지만 ajax.selected가 설정되어 있으면 그 적용 값으로 됩니다.
		},
       /**
        * 서버에서 페이징을 처리할지 지정 (default : false)
        * - true : 서버에서 페이징 후 필요한 데이터만 반환
        * - false : 클라이언트 데이터를 이용해서 페이징 (처음 로드시 모든 데이터를 가져와야 함)
        */
       serverPaging: true, 
       /**
        * server-paging시 새로운 페이지로 이동할때 기본 페이지의 데이터를 삭제할지 여부.
        */
       cachePaging: true,
       /**
        * 서버에서 소팅을 처리할지 지정 (default : false)
        * - true : 서버에서 소팅 후 결과 데이터만 반환
        * - false : 클라이언트 데이터를 이용해서 소팅 (처음 로드시 모든 데이터를 가져와야 함)
        */
       serverSorting: true,
       /**
        * 한 페이지에 보여질 행의 개수
        */
       pageSize: 10,
       //data : gridData
     };
 
	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "480px",
	    captionHeight: 40,
	    rowHeight:40,
	    columns: [
		{ field: 'compayName', caption: "<spring:message code='sr.client' />", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'signDate', caption: "<spring:message code='sr.requestDate'/>", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'scheduleDate', caption: "<spring:message code='sr.expectedCompletionDate'/>", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'subject', caption: "<spring:message code='cop.nttSj' />", editable: false, type: 'text', align: 'left', width:20, unit:'%'},
		{ field: 'srNo', caption: "<spring:message code='sr.srNumber'/>", editable: false, type: 'text', valign: 'center' , width:5, unit:'%' },
		{ field: 'requesterName', caption: "<spring:message code='sr.requester' />", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'realExpectTime', caption: "<spring:message code='sr.realLabourHours2'/>", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'moduleName', caption: "<spring:message code='sr.module' />", editable: false, type: 'text', width:5, unit:'%'},
		{ field: 'responserName', caption: "<spring:message code='sr.charge' />", editable: false, type: 'text', width:6, unit:'%'},
		{ field: 'completeDate', caption: "해결일자", editable: false, type: 'text', width:6, unit:'%'},
				
        ],
		showRowNo:false,
		virtualRow:false,
		resizable: {
			mode: "column",
			minWidth: 10, 
			maxWidth: 300, 
			autoFit: ["caption", "data"]
		},
		pagerBar: {center:["pager"]},
		pageable: {
			buttonCount: 5,
			numeric: true,
			previousNext: true,
		},
		doCommand: (grid, name, command) => {
  	        switch(name) {
  	            case 'event' : {
  	                if (command.event.type == 'dblclick') {
  	                   // cell을 dblclick하면 더블클릭 메시지 띄우기
  	                    
  	                }
  	                else if(command.event.type == 'click'){
  	                	
  	                	if(command.column && (command.column.field == "srNo" || command.column.field == "subject") ){
  	  	                	var srNo = SBGrid3.getValue(grid, command.key, 'srNo');
  	      	             	fn_egov_detail_Sr(srNo);
  	  	                }
  	                }
  	                else if (command.event.type == 'keydown') {
  	                   // cell에 입력했을 때 키 다운 메세지 띄우기
  	                  
  	                }
  	                
  	            }
  	            case 'updated' : {
  	                // updated인 경우 TODO
  	            }
  	            case 'edit' : {
  	                // edit인 경우 TODO
  	            }
  	            case 'focus' : {//click
  	                // focus인 경우 TODO 
  	                
  	            }   
  	            case 'menu' : {
  	                // menu인 경우 TODO
  	            }
  	            case 'captionCheck' : {
  	                // captionCheck인 경우 TODO
  	            }
  	        }
		},
     };
     
     datagrid = SBGrid3.createGrid(gridConfig);
     datagrid.refresh();
 } 
 
 function setCookie (name, value, expires) {
		document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
	}
	
	function getCookie(Name) {
	    var search = Name + "="
	    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
	        offset = document.cookie.indexOf(search)
	        if (offset != -1) { // 쿠키가 존재하면
	            offset += search.length
	            // set index of beginning of value
	            end = document.cookie.indexOf(";", offset)
	            // 쿠키 값의 마지막 위치 인덱스 번호 설정
	            if (end == -1)
	                end = document.cookie.length
	            return unescape(document.cookie.substring(offset, end))
	        }
	    }
	    return "";
	}
	
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check Start	////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
var fReqDate = "<c:out value='${searchVO.searchDateF}'/>";
var tReqDate = "<c:out value='${searchVO.searchDateT}'/>";
var fComDate = "<c:out value='${searchVO.searchCompleteDateF}'/>";
var tComDate = "<c:out value='${searchVO.searchCompleteDateT}'/>";
//요청일 체크..
function fnReqDateChk(fdate, tdate) {
		//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
		if (fdate.value != "" && tdate.value != "") {
			if (fdate.value > tdate.value) {
				alert("<spring:message code='sr.error.msg.dateNotValid'/>");
				if (fReqDate != fdate.value) {
					document.getElementById('searchDateF').value = fReqDate;
					if (fReqDate == "") {
						document.getElementById('searchDateFView').value = "";
					} else {
						document.getElementById('searchDateFView').value = fReqDate
								.substring(0, 4)
								+ '-'
								+ fReqDate.substring(4, 6)
								+ '-'
								+ fReqDate.substring(6, 8);
					}
				}
				if (tReqDate != tdate.value) {
					document.getElementById('searchDateT').value = tReqDate;
					if (tReqDate == "") {
						document.getElementById('searchDateTView').value = "";
					} else {
						document.getElementById('searchDateTView').value = tReqDate
								.substring(0, 4)
								+ '-'
								+ tReqDate.substring(4, 6)
								+ '-'
								+ tReqDate.substring(6, 8);
					}
				}

			} else {
				//요청일과 완료일 비교.
				if(fdate.value != "" && fComDate != ""){
					if(fdate.value > fComDate){
						alert("<spring:message code='sr.error.msg.requestDate'/>");
						document.getElementById('searchDateF').value = fReqDate;
						if(fReqDate == ""){
							document.getElementById('searchDateFView').value = "";
						}else{
							document.getElementById('searchDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
						}
						return;
					}
				}
				//From, To 일자 셋팅.
				fReqDate = fdate.value;
				tReqDate = tdate.value;
			}
		} else {
			//요청일과 완료일 비교.
			if(fdate.value != "" && fComDate != ""){
				if(fdate.value > fComDate){
					alert("<spring:message code='sr.error.msg.requestDate'/>");
					document.getElementById('searchDateF').value = fReqDate;
					if(fReqDate == ""){
						document.getElementById('searchDateFView').value = "";
					}else{
						document.getElementById('searchDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
					}
					
				}
				return;
			}
			//From, To 일자 셋팅.
			fReqDate = fdate.value;
			tReqDate = tdate.value;
		}
	}

//완료일 체크..
function fnComDateChk(fdate, tdate){
	//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
	if(fdate.value != "" && tdate.value != ""){
		if(fdate.value > tdate.value){
			alert("<spring:message code='sr.error.msg.completionDateNotValid'/>");
			if(fComDate != fdate.value){
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
			}
		
			if(tComDate != tdate.value){
				document.getElementById('searchCompleteDateT').value = tComDate;
				if(tComDate == ""){
					document.getElementById('searchCompleteDateTView').value = "";
				}else{
					document.getElementById('searchCompleteDateTView').value = tComDate.substring(0,4) + '-' + tComDate.substring(4,6) + '-' + tComDate.substring(6,8);
				}
				
			}
		
		}else{
			//요청일과 완료일 비교.
			if(fdate.value != "" && fReqDate != ""){
				if(fdate.value < fReqDate){
					alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
					document.getElementById('searchCompleteDateF').value = fComDate;
					if(fComDate == ""){
						document.getElementById('searchCompleteDateFView').value = "";
					}else{
						document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);
					}
					return;
				}
			}
			//From, To 일자 셋팅.
			fComDate = fdate.value;
			tComDate = tdate.value;
		}
	}else{
		//요청일과 완료일 비교.
		if(fdate.value != "" && fReqDate != ""){
			if(fdate.value < fReqDate){
				alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
				return;
			}
		}
		//From, To 일자 셋팅.
		fComDate = fdate.value;
		tComDate = tdate.value;
	}
}

//조회시 널값인 날짜 처리.
function fnDateChk(){
	
	document.getElementById('searchDateF').value = SBUxMethod.get('searchDate_from') ? SBUxMethod.get('searchDate_from') : "";
	document.getElementById('searchDateT').value = SBUxMethod.get('searchDate_to') ? SBUxMethod.get('searchDate_to') : "";

	document.getElementById('searchCompleteDateF').value = SBUxMethod.get('searchCompleteDate_from') ? SBUxMethod.get('searchCompleteDate_from') : "";
	document.getElementById('searchCompleteDateT').value = SBUxMethod.get('searchCompleteDate_to') ? SBUxMethod.get('searchCompleteDate_to') : "";
	
	/* if(document.getElementById('searchConfirmDateFView').value == ""){
		document.getElementById('searchConfirmDateF').value = "";
	}
	
	if(document.getElementById('searchConfirmDateTView').value == ""){
		document.getElementById('searchConfirmDateT').value = "";
	}
	
	if(document.getElementById('searchCompleteDateFView').value == ""){
		document.getElementById('searchCompleteDateF').value = "";
	}
	
	if(document.getElementById('searchCompleteDateTView').value == ""){
		document.getElementById('searchCompleteDateT').value = "";
	} */
}
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check End		////////////////////////////////////////


/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchAt.value = "Y";
    document.listForm.action = "<c:url value='/sts/actrt/selectSrActivityReport.do'/>";
    document.listForm.submit();
}

/*********************************************************
 * 조회 처리 
 *********************************************************/
/* function fnSearch(){
    var fromDate = document.listForm.searchDateF.value;
    var toDate = document.listForm.searchDateT.value;

    /* if (fromDate == "") {
        alert("기간 시작일자를 입력하세요");
        return;
    } else if (toDate == "") {
        alert("기간 종료일자를 입력하세요");
        return;
    } */

/*     document.listForm.pageIndex.value = 1;
    document.listForm.searchAt.value = "Y";
	document.listForm.action = "<c:url value='/sts/actrt/selectSrActivityReport.do'/>";
    document.listForm.submit();
} */ 

function fnSearch(){
	fnDateChk();
	
    document.listForm.pageIndex.value = 1;
    document.listForm.selectStatus.value = "";
    document.listForm.searchAt.value = "Y";
    
    //등록과 반려 체크 여부 확인
    var checkFieldStatus = document.listForm.searchStatus;
    var checkSearchStatusRetnrn = document.listForm.searchStatusRetnrn;
    

    SBGrid3.reload(datagrid);
}
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

  	if (document.listForm.searchDateF.value != "" && document.listForm.searchDateT.value != "") {
        var fromDate = document.listForm.searchDateF.value;
        var toDate = document.listForm.searchDateT.value;
        document.listForm.searchDateFView.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
        document.listForm.searchDateTView.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
    }
	//완료일
  	if (document.listForm.searchCompleteDateF.value != "" && document.listForm.searchCompleteDateT.value != "") {
        var fromCompleteDate = document.listForm.searchCompleteDateF.value;
        var toCompleteDate = document.listForm.searchCompleteDateT.value;
        document.listForm.searchCompleteDateFView.value = fromCompleteDate.substring(0, 4) + "-" + fromCompleteDate.substring(4, 6) + "-" + fromCompleteDate.substring(6, 8);
        document.listForm.searchCompleteDateTView.value = toCompleteDate.substring(0, 4) + "-" + toCompleteDate.substring(4, 6) + "-" + toCompleteDate.substring(6, 8);
    }
}

/**
 * 엑셀다운로드
 */
 function fnExcelReport(){
     document.listForm.action = "<c:url value='/sts/actrt/EgovActivityExcelReport.do'/>";
     document.listForm.submit();
 } 
</script>
<script>
	//jquery Start
	$(document).ready(
			function() {
				SBUxMethod.set("searchDate", "<c:out value='${searchVO.searchDateF}'/>,<c:out value='${searchVO.searchDateT}'/>")
				$('#searchDateFView').datepicker(
						{
							dateFormat : "yy-mm-dd",
							altFormat : "yymmdd",
							altField : "#searchDateF",
							onSelect : function(dateText) {
								fnReqDateChk(
										document.listForm.searchDateF,
										document.listForm.searchDateT);
							}
						});
				$('#searchDateTView').datepicker(
						{
							dateFormat : "yy-mm-dd",
							altFormat : "yymmdd",
							altField : "#searchDateT",
							onSelect : function(dateText) {
								fnReqDateChk(
										document.listForm.searchDateF,
										document.listForm.searchDateT);
							}
						});
				SBUxMethod.set("searchCompleteDate", "<c:out value='${searchVO.searchCompleteDateF}'/>,<c:out value='${searchVO.searchCompleteDateT}'/>")
				$('#searchCompleteDateFView').datepicker(
						{
							dateFormat : "yy-mm-dd",
							altFormat : "yymmdd",
							altField : "#searchCompleteDateF",
							onSelect : function(dateText) {
								fnReqDateChk(
										document.listForm.searchDateF,
										document.listForm.searchDateT);
							}
						});
				$('#searchCompleteDateTTView').datepicker(
						{
							dateFormat : "yy-mm-dd",
							altFormat : "yymmdd",
							altField : "#searchCompleteDateT",
							onSelect : function(dateText) {
								fnReqDateChk(
										document.listForm.searchDateF,
										document.listForm.searchDateT);
							}
						});
			});
</script>
</head>
<body onload="javascript:fnInitAll()">
<!--  <body>-->
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<div class="sr-contents-wrap">
        <c:import url="/sym/mms/EgovMainMenuLeft.do" />
        <%-- <c:import url="/EgovPageLink.do?link=main/inc/incLeftmenu" /> --%>
        <div class="sr-contents-area">
	        <div class="sr-contents">
	            <div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
	            
	            <!--상태-->
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
	            <form name="listForm" id="listForm" action="<c:url value='/sts/actrt/selectSrActivityReport.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
       			<input type="hidden" id = "searchDateF" name = "searchDateF" value = "<c:out value='${searchVO.searchDateF}'/>"/>
				<input type="hidden" id = "searchDateT" name = "searchDateT" value = "<c:out value='${searchVO.searchDateT}'/>"/>
				<input type="hidden" id = "searchCompleteDateF" name = "searchCompleteDateF" value = "<c:out value='${searchVO.searchCompleteDateF}'/>"/>
				<input type="hidden" id = "searchCompleteDateT" name = "searchCompleteDateT" value = "<c:out value='${searchVO.searchCompleteDateT}'/>"/>
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
				<input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> 
				<input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> 
				<%-- <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>" /> --%>
				<input type="hidden" name="srNo"/> 
				
       			 <div class="sr-table-wrap">
	                <table class="sr-table">
	                    <colgroup>
	                        <col width="12%">
	                        <col width="29%">
	                        <col width="12%">
	                        <col width="49%">
	                    </colgroup>
	                    <tbody>
	                     <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
		                                           
	                        <tr>
	                        	<th>
		                            <sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.client'/>" class=""></sbux-label>
		                         </th>
		                         <td>
		                                <sbux-select id="pstinstCode" name="pstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                	<option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${pstinstList}" varStatus="status">
												<option value='<c:out value="${result.pstinstCode}"/>'  <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}"/></option>
											</c:forEach>
		                                </sbux-select>
		                        </td> 
	                            <th>
	                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-datepicker name="searchDate" id="searchDate" uitype="range" open-on-input-selection="true" split-text="~" init="yyyy/mm/dd">
	                                </sbux-datepicker>
	                            </td>
	                         
	                        </tr>                      
	                     </c:if>
	                      <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
		                
	                     <tr>
	                     	 <th>
		                                <sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.status'/>"></sbux-label>
		                            </th>
		                            <td>
		                                <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
											<c:set var="vChecked">
												<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
													
													<c:choose>
														<c:when test="${vList == statusCode_result.code}">checked</c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
												</c:forEach>
											</c:set>
						                   		<%-- <c:if test="${statusCode_result.code != '1000'}">
						                   			<sbux-checkbox uitype="normal" name="searchStatus" text = "<c:out value="${statusCode_result.codeDc}"/> "value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
						              				</sbux-checkbox>
						              			</c:if>	 --%>
											<!-- 반려 -->
										<c:if test="${statusCode_result.code != '1000'}">
											<c:if test="${statusCode_result.code != '1007'}">
													 <c:choose>
														<c:when test="${srLanguage == 'en'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus" text = "<c:out value="${statusCode_result.codeNmEn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:otherwise>
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN'}">
													<c:choose>
														<c:when test="${srLanguage == 'en'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmEn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:otherwise>
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:if>
										</c:if>
										</c:forEach>
		                            </td>
		                            <th>
		                                <sbux-label id="table_label4" name="table_label4" uitype="normal" text="<spring:message code='sr.completionDate' />"></sbux-label>
		                            </th>
		                            <td>
		                                <sbux-datepicker id="searchCompleteDate" name="searchCompleteDate" uitype="range" open-on-input-selection="true" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
		                            </td>
	                     </tr> 
	                     </c:if>   
	                     <tr>
	                     	<th>
	                     		<sbux-label id="table_label5" name="table_label5" uitype="normal" text="<spring:message code='sr.condition'/>"></sbux-label>
	                     	</th>
	                     	<td>
	                     		
	                     			
		                   			<input type="radio" name="searchCondition" class="radio2" value="R" <c:if test="${'R' == searchVO.searchCondition}">checked="checked"</c:if>>&nbsp;담당자별
						            <input type="radio" name="searchCondition" class="radio2" value="N" <c:if test="${'R' != searchVO.searchCondition}">checked="checked"</c:if>>&nbsp;SR번호별
	                     		
	                     	</td>
	                     	<th>
	                                <sbux-label id="table_label6" name="table_label6" uitype="normal" text="<spring:message code='sr.module' />"></sbux-label>
	                            </th>
	                            <td>
	                               <sbux-select id="searchModuleCode" name="searchModuleCode" uitype="single" init = "<spring:message code='sr.choose' />">
		                               <option value=''><spring:message code='sr.choose' />
										</option>
							   		 <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == searchVO.searchModuleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
								
										<c:choose>
													<c:when test="${srLanguage == 'ko'}">
														<c:out value="${result.codeNm}" />
													</c:when>
													<c:when test="${srLanguage == 'en'}">
														<c:out value="${result.codeNmEn}" />
													</c:when>
													<c:when test="${srLanguage == 'cn'}">
														<c:out value="${result.codeNmCn}" />
													</c:when>
													<c:otherwise>
														<c:out value="${result.codeNm}" />
													</c:otherwise>
												</c:choose>
									</option>
								</c:forEach>
	                               </sbux-select>
	                            </td>
	                            
	                            
	                        </tr>            
	                    </tbody>
	                </table>
	            </div><!--검색조건-->
	            </form>
	            
	      		<div class="grid_area">
	                <div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/>: <span id = 'totalCnt'><c:out value="${paginationInfo.totalRecordCount}" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">         
	                    	<sbux-button uitype="normal" text="<spring:message code='sr.excelDownload' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fnExcelReport(); return false;"></sbux-button>                    
	                	
	                </div>
	            </div>
				<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
	           
            </div> 
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
	    
<!-- 전체 레이어 시작 -->
<%-- <div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
        <!-- 현재위치 네비게이션 시작 -->
        <div id="contents">
	        <form name="listForm" action="<c:url value='/sts/actrt/selectSrActivityReport.do'/>" method="post">
	        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	        <input type="submit" id="invisible" class="invisible"/>
	        <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
                
            <!-- 검색 필드 박스 시작 -->
            <div id="searchtb">
				<table width="980" border="0" cellpadding="0" cellspacing="0">
            		<tr>
              			<td colspan="5" bgcolor="#0257a6" height="2"></td>
            		</tr>
            		<!-- 담당자, 관리자, Admin -->
			        <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
            		<tr>
						<td class="tdblue">고객사</td>
						<td class="tdleft" width="270px;">
							<select name="pstinstCode" id="pstinstCode" class="select" title="고객사">
				 				<option value='' >==선택==</option>
							    <c:forEach var="result" items="${pstinstList}" varStatus="status">
									<option value='<c:out value="${result.pstinstCode}"/>'  <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}"/></option>
								</c:forEach>
							 </select>	 
<%-- 							<input type="hidden" name="pstinst_url" value="<c:url value='/pstinst/EgovPstinstSearchPopup.do'/>" /> --%>
<%-- 		                    <input type="hidden" name="pstinstCode" id="pstinstCode" value='${searchVO.pstinstCode}'/> --%>
<%-- 		                    <input type="text" name="pstinstNm" id="pstinstNm" value='${searchVO.pstinstNm}' title="고객사명" cssClass="txaIpt" size="20" maxlength="100" readonly="true" /> --%>
<!-- 	                            <a href="#LINK" onclick="javascript:fn_egov_PstinstSearch(document.listForm, document.listForm.pstinstCode, document.listForm.pstinstNm);"> -->
<%-- 	                                <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(고객사 검색) --%>
<!-- 	                            </a> -->
<!-- 	                        <div><form:errors path="pstinstCode" cssClass="error" /></div> -->
<%-- 						</td>
                   		<td class="tdblue">요청일</td>
                   		<td class="tdleft" width="270px;">
                  			<input name="searchDateF" type="hidden" value="<c:out value='${searchVO.searchDateF}'/>" />
                        	<input name="searchDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchDateFView}'/>"  readonly="readonly"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateF, document.listForm.searchDateFView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
                        	<img src="<c:url value='/images/calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateF, document.listForm.searchDateFView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                        	~
                        	<input name="searchDateT" type="hidden" value="<c:out value='${searchVO.searchDateT}'/>" />
                        	<input name="searchDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchDateTView}'/>"  readonly="readonly"
	                            onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateT, document.listForm.searchDateTView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"  >
                        	<img src="<c:url value='/images/calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateT, document.listForm.searchDateTView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                        	<br/><form:errors path="searchDateF" />
                        	<br/><form:errors path="searchDateT" />
		                </td>
                   		<td rowspan="5" align="center">
                   			<a href="#noscript" onclick="fnSearch(); return false;"><img src="<c:url value='/' />images/sr/btn_search.gif" /></a>
						</td> 		
                   	</tr>
                   	</c:if>
                   	
                   	<!-- 현업 및 결제자 -->
					<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
					<tr>
                   		<td class="tdblue">요청일</td>
                   		<td class="tdleft" colspan="3">
                   			<input type="hidden" name="pstinstCode" id="pstinstCode" value='${searchVO.pstinstCode}'/>
                  			<input name="searchDateF" type="hidden" value="<c:out value='${searchVO.searchDateF}'/>" />
                        	<input name="searchDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchDateFView}'/>"  readonly="readonly"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateF, document.listForm.searchDateFView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
                        	<img src="<c:url value='/images/calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateF, document.listForm.searchDateFView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                        	~
                        	<input name="searchDateT" type="hidden" value="<c:out value='${searchVO.searchDateT}'/>" />
                        	<input name="searchDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchDateTView}'/>"  readonly="readonly"
	                            onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateT, document.listForm.searchDateTView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"  >
                        	<img src="<c:url value='/images/calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateT, document.listForm.searchDateTView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                        	<br/><form:errors path="searchDateF" />
                        	<br/><form:errors path="searchDateT" />
		                </td>
                   		<td rowspan="5" align="center">
                   			<a href="#noscript" onclick="fnSearch(); return false;"><img src="<c:url value='/' />images/sr/btn_search.gif" /></a>
						</td> 		
                   	</tr>
					</c:if>
                   	<tr>
			        	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
			        </tr>
                   	<tr>
                   		<td class="tdblue">상태</td>
                   		<td class="tdleft" colspan="3">
                   			<c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
                           		<c:set var="vChecked">
                            		<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
                            			<c:choose>
                            				<c:when test="${vList == statusCode_result.code}">checked</c:when>
                            					<c:otherwise></c:otherwise>
                            				</c:choose>
                            			</c:forEach>
                           			</c:set>
                           			<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>><c:out value="${statusCode_result.codeNm}"/>
			            	</c:forEach>
                   		</td>
                   	</tr>
                   	<tr>
			        	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
			        </tr>
			        <tr>
                   		<td class="tdblue">조회조건</td>
                   		<td class="tdleft" width="270px;">
                   			<input type="radio" name="searchCondition" class="radio2" value="R" <c:if test="${'R' == searchVO.searchCondition}">checked="checked"</c:if>>&nbsp;담당자별
				            <input type="radio" name="searchCondition" class="radio2" value="N" <c:if test="${'R' != searchVO.searchCondition}">checked="checked"</c:if>>&nbsp;SR번호별
						</td>
						<td class="tdblue">모듈</td>
                   		<td class="tdleft" width="270px;">
                   			<select name="searchModuleCode" class="select" title="모듈코드">
								<option value='' >==선택==</option>
							    <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == searchVO.searchModuleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
								</c:forEach>
							 </select>
                   		</td>
                   	</tr>
                   	<tr>
			        	<td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			        </tr>
               	</table>
			</div>          
            <!-- //검색 필드 박스 끝 -->
            
			<div class="list">
        	<ul>
            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value='${paginationInfo.totalRecordCount}'/>건</span></li>
            </ul>
		    </div>
		    <div class="list2">
		    <ul>
		       	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 통계 > SR Activity Report</li>
		    </ul>
		    </div>
			
			<!-- 서비스별 결과 -->
       		<div class="list3">
      			<table width="980" border="0" cellpadding="0" cellspacing="0">
        		<colgroup>
                	<col width="10%" >
                 	<col width="10%" >  
                 	<col width="10%" >
                 	<col width="350PX;" >
                 	<col width="10%" >
                 	<col width="10%" >
                 	<col width="10%" >
                 	<col width="10%" >
                 	<col width="10%" >
                 	<col width="10%" >
               	</colgroup>
                <thead>
                	<tr>
                		<td colspan="10" bgcolor="#0257a6" height="2"></td>
                	</tr>
                	<tr class="tdgrey">
                     	<th scope="col" nowrap="nowrap">고객사명</th>
                     	<th scope="col" nowrap="nowrap">요청일</th>
                     	<th scope="col" nowrap="nowrap">완료예정일</th>
                     	<th scope="col" width="350PX;" nowrap="nowrap">SR제목</th>
                     	<th scope="col" nowrap="nowrap">관련산출물<br>(SR번호)</th>
                     	<th scope="col" nowrap="nowrap">요청자성명</th>
                     	<th scope="col" nowrap="nowrap">실적공수(H)</th>
                     	<th scope="col" nowrap="nowrap">모듈<br>(분야)</th>
                     	<th scope="col" nowrap="nowrap">담당자<br>(처리자)</th>
                     	<th scope="col" nowrap="nowrap">해결일자<br>(완료일)</th>
                 	</tr>
                 	<tr>
                 		<td colspan="10" bgcolor="#717171" height="1"></td>
                 	</tr>
                 </thead>
                 <tbody>
                 	<tr>
                 		<td colspan="10" bgcolor="#cdcdcd" height="1"></td>
                 	</tr>
                 	
                 	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                   	<tr>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.compayName}</td>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.signDate}</td>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.scheduleDate}</td>
	                 	<td class="tdwl"  width="350PX;" nowrap="nowrap" >${resultInfo.subject}</td>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.srNo}</td>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.requesterName}</td>
	                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.realExpectTime}</td>
                 		<td class="tdwc"  nowrap="nowrap">${resultInfo.moduleName}</td>
                 		<td class="tdwc"  nowrap="nowrap">${resultInfo.reponserName}</td>
                 		<td class="tdwc"  nowrap="nowrap">${resultInfo.completeDate}</td>
                   	</tr>
                   	<tr>
	                    <td colspan="10" bgcolor="#cdcdcd" height="1"></td>
			       	</tr>
                  	</c:forEach>
                  	<c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                        	<td colspan="10">
	                        	<spring:message code="common.nodata.msg" />
	                        </td>
                        </tr>                                              
                	</c:if>
                </tbody>
               	</table>
                 
               	<table width="980" border="0" cellpadding="0" cellspacing="0">
        			<tr>
        	  			<td height="30"></td>
      	  			</tr>
        			<tr>
        	  			<td align="center">
							<!-- 페이지 네비게이션 시작 -->
			                <div id="paging_div">
			                    <ul class="paging_align">
							        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" />
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 -->  
		                	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		                	<input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>"/>
		        	  	</td>
      	  			</tr>
      	  			<tr>
		            	<td align="right" valign="bottom" height="60">
		                	<span class="btnblue"><a href="#LINK" onclick="javascript:fnExcelReport(); return false;">엑셀다운로드 ▶</a></span>&nbsp;
		                </td>
		            </tr>
        		</table>
        	</form>
        </div> 
        <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>  --%>
    <!-- //전체 레이어 끝 -->
  
 </body>
</html>