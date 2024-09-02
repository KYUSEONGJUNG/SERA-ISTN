<%--
  Class Name : EgovStsfdgSttus.jsp
  Description : 만족도현황
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

<title><spring:message code='sr.satisfactionStatus' /></title>
<script type="text/javaScript" language="javascript">

//그리드 1
SBGrid3.$(document).ready(function() {
	init();
});

 var datagrid; // 그리드 객체 전역으로 선언	
 var gridData = []
 var srLanguage = "<c:out value = '${srLanguage}'/>";
 
 function init() {		
	fn_loading();
	createGrid();
	 
 }
 
 async function loadData(payload = {}, dataType = "json") {
	 return new Promise((resolve, reject) => {
		 $("#pageIndex").val(Number(payload.pageNo) + 1);
		 $.ajax({				 
			 url : "<c:url value='/select/sts/stsfdg/selectStsfdgSttus.do'/>",
			 type : "POST",
			 data : $("#listForm").serialize(),
			 success :function(data) {
				 //Rename Setting
				 resolve({selected: data.resultList });
				 $("#totalCnt").text(data.paginationInfo.totalRecordCount.toLocaleString('ko-KR'));
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
	        select : async(request) => {
	       	 return await loadData(request);
	        },
	    },
	    serverPaging : false,
	    cachePaging : false,
	    serverSorting :false,
	};
	
	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "600px",
	    captionHeight: 40,
	    rowHeight:40,
	    columns: [
	        { field: 
	        	<c:choose>
					<c:when test="${srLanguage == 'en'}">
						'moduleNameEn'
					</c:when>
					<c:when test="${srLanguage == 'cn'}">
						'moduleNameCn'
					</c:when>
					<c:otherwise>
						'moduleName'
					</c:otherwise>
				</c:choose>
	        	, caption: "<spring:message code='sr.module' />", editable: false, type: 'text', valign: 'center' , width:12.5, unit:'%'},
	        { field: 'completeCount', caption: "<spring:message code='sr.completionCnt' />", editable: false, type: 'text', align: 'center', width:12.5, unit:'%'},
	        { field: 'value5', caption: "<spring:message code='sr.5point' />", editable: false, type: 'text', width:12.5, unit:'%'},
	        { field: 'value4', caption: "<spring:message code='sr.4point' />", editable: false, type: 'text', width:12.5, unit:'%'},
	        { field: 'value3', caption: "<spring:message code='sr.3point' />", editable: false, type: 'text', width:12.5, unit:'%'},
	        { field: 'value2', caption: "<spring:message code='sr.2point' />", editable: false, type: 'text', width:12.5, unit:'%'},
	        { field: 'value1', caption: "<spring:message code='sr.1point' />", editable: false, type: 'text', width:12.5, unit:'%'},
	        { field: 'avgValue', caption: "<spring:message code='sr.average' />", editable: false, type: 'text', width:12.5, unit:'%'}
	    ],
	    showRowNo:false,
	 	virtualRow:false,
		resizable: {
		     mode: "column",
		     minWidth: 10, 
		     maxWidth: 300, 
		     autoFit: ["caption", "data"]
		},
		pageBar: {center:["pager"]},
		doCommand : (grid, name, command) => {
			switch(name) {
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

//조회시 널값인 날짜 처리.
function fnDateChk() {
	document.getElementById('searchDateF').value = SBUxMethod.get('searchDate_from') ? SBUxMethod.get('searchDate_from') : "";
	document.getElementById('searchDateT').value = SBUxMethod.get('searchDate_to') ? SBUxMethod.get('searchDate_to') : "";

}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>";
    document.listForm.submit();
}

/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(){
	
//     document.listForm.pageIndex.value = 1;
	fnDateChk()
	document.listForm.searchAt.value = "Y";
	//document.listForm.action = "<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>";
    //document.listForm.submit();
    
    SBGrid3.reload(datagrid);
} 


/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

    // 시작일자, 종료일자
    if (document.listForm.searchDateF.value != "" && document.listForm.searchDateT.value != "") {
        var fromDate = document.listForm.searchDateF.value;
        var toDate = document.listForm.searchDateT.value;
        document.listForm.searchDateFView.value = searchDateF.substring(0, 4) + "-" + searchDateF.substring(4, 6) + "-" + searchDateF.substring(6, 8);
        document.listForm.searchDateTView.value = searchDateT.substring(0, 4) + "-" + searchDateT.substring(4, 6) + "-" + searchDateT.substring(6, 8);
    }
}


/**
 * 엑셀다운로드
 */
 function fnExcelReport(){
     document.listForm.action = "<c:url value='/sts/stsfdg/EgovStsfdgSttusExcelReport.do'/>";
     document.listForm.submit();
 }
 
 /**
  * 데이터 삭제
  */
 function fnClear(obj) {
	 obj.value="";
	 obj.focus();
	 return false;
 }
//조회시 널값인 날짜 처리.
/*  function fnDateChk(){
 	if(document.getElementById('searchDateFView').value == ""){
 		document.getElementById('searchDateF').value = "";
 	}
 	
 	if(document.getElementById('searchDateTView').value == ""){
 		document.getElementById('searchDateT').value = "";
 	}
 } */
 
	////////////////////////////////////////////////////////////////////////////////////////
	///////////			날짜 Valication Check Start	////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////
	var fReqDate = "<c:out value='${searchVO.searchDateF}'/>";
	var tReqDate = "<c:out value='${searchVO.searchDateT}'/>";
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
				//From, To 일자 셋팅.
				fReqDate = fdate.value;
				tReqDate = tdate.value;
			}
		} else {
			//From, To 일자 셋팅.
			fReqDate = fdate.value;
			tReqDate = tdate.value;
		}
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
			});
</script>


</head>
<body onload="javascript:fnInitAll()">
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	
		<!-- 전체 레이어 시작 -->
	<div class="sr-contents-wrap">
		<c:import url="/sym/mms/EgovMainMenuLeft.do" />
		<!-- 현재위치 네비게이션 시작 -->
		<div class="sr-contents-area">
			<div class="sr-contents">
				<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
				
				<form name="listForm" id="listForm" action="<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
	                <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> 
	                <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />
	                <input type="hidden" name="searchDateF" id="searchDateF" value="<c:out value='${searchVO.searchDateF}'/>" />
	                <input type="hidden" name="searchDateT" id="searchDateT" value="<c:out value='${searchVO.searchDateT}'/>" />
					<!-- 검색 필드 박스 시작 -->
					<div class="sr-table-wrap">
		                <table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
		                        <col width="29%">
		                        <col width="12%">
		                        <col width="49%">
		                    </colgroup>
		                    <tbody>
		                    <!-- 담당자, 관리자, Admin -->
		                    <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							
		                    	<tr>
		                    		<th>
		                    			<sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.completionDate' />"></sbux-label>
		                    		</th>
		                    		<td>
		                                <sbux-datepicker name="searchDate" id="searchDate" uitype="range" open-on-input-selection="true" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
		                            </td>
		                            
		                    		<th>
		                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="<spring:message code='sr.client'/>" class=""></sbux-label>
		                            </th>
		                            <td >
		                            	<sbux-select id="pstinstCode" name="pstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                	<option value=''><spring:message code='sr.choose' /></option>
		                                	<c:forEach var="result" items="${pstinstList}" varStatus="status">
												<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
											</c:forEach>
		                                </sbux-select>
		                            </td>
		                    	
		                    	</tr>
		                    	</c:if>
		                    	
		                    	<!-- 현업 및 결제자 -->
		                    	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
		                    	<tr>
		                    		<th>
		                    			<sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
		                    		</th>
		                    		<td colspan="3">
		                                <sbux-datepicker name="searchDate" id="searchDate" uitype="range" open-on-input-selection="true" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
		                            </td>
		                    	</tr>
		                    	</c:if>
		                    </tbody>
						</table>
					</div>
				</form>
				<!-- //검색 필드 박스 끝 -->
				<div class="grid_area">
					<div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/>: <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">
                    	<sbux-button uitype="normal" text="<spring:message code='sr.excelDownload' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fnExcelReport(); return false;"></sbux-button>                    
	                </div>	                
                </div>
				<!-- 서비스별 결과 -->
				<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
				<%-- <table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center">
			        	  <div id="paging_div">
								<ul class="paging_align">
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
								</ul>
							</div> <!-- //페이지 네비게이션 끝 --> 						

						</td>
					</tr>
				</table> --%>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>
	
	
	<!-- 전체 레이어 시작 -->
<%-- 	<div id="wrapper">
		<!-- header 시작 -->
		<div id="header">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
		</div>
		<c:import url="/sym/mms/EgovMainMenuHead.do" />
		<!-- //header 끝 -->
		<!-- 현재위치 네비게이션 시작 -->
		<div id="contents">
			<form name="listForm" action="<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" /> <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />

				<!-- 검색 필드 박스 시작 -->
				<div class="searchtb">
					<table width="980" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="5" bgcolor="#0257a6" height="2"></td>
						</tr>
						<!-- 담당자, 관리자, Admin -->
						<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							<tr>
								<td class="tdblue"><spring:message code='sr.completionDate' /></td>
								<td class="tdleft" width="270px;"><input name="searchDateF" id="searchDateF" type="hidden" value="<c:out value='${searchVO.searchDateF}'/>" /> <input name="searchDateFView" id="searchDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> ~ <input name="searchDateT" id="searchDateT" type="hidden" value="<c:out value='${searchVO.searchDateT}'/>" /> <input name="searchDateTView" id="searchDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchDateTView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> <form:errors path="searchDateF" /> <form:errors path="searchDateT" /></td>
								<td class="tdblue"><spring:message code='sr.client' /></td>
								<td class="tdleft" width="270px;"><select name="pstinstCode" id="pstinstCode" class="select" title="고객사">
										<option value=''>==
											<spring:message code='sr.choose' />==
										</option>
										<c:forEach var="result" items="${pstinstList}" varStatus="status">
											<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
										</c:forEach>
								</select> 							<input type="hidden" name="pstinst_url" value="<c:url value='/pstinst/EgovPstinstSearchPopup.do'/>" /> 		                    <input type="hidden" name="pstinstCode" id="pstinstCode" value='${searchVO.pstinstCode}'/> 		                    <input type="text" name="pstinstNm" id="pstinstNm" value='${searchVO.pstinstNm}' title="고객사명" cssClass="txaIpt" size="20" maxlength="100" readonly="true" /> <!-- 	                            <a href="#LINK" onclick="javascript:fn_egov_PstinstSearch(document.listForm, document.listForm.pstinstCode, document.listForm.pstinstNm);"> --> 	                                <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(고객사 검색) <!-- 	                            </a> --> <!-- 	                        <div><form:errors path="pstinstCode" cssClass="error" /></div> --></td>

								<td align="center"><a href="#noscript" onclick="fnSearch(); return false;"> <c:choose>
											<c:when test="${srLanguage == 'ko'}">
												<img src="<c:url value='/' />images/sr/btn_search2.gif" />
											</c:when>
											<c:when test="${srLanguage == 'en'}">
												<img src="<c:url value='/' />images/sr/btn_search2En.gif" />
											</c:when>
											<c:when test="${srLanguage == 'cn'}">
												<img src="<c:url value='/' />images/sr/btn_search2Cn.gif" />
											</c:when>
											<c:otherwise>
												<img src="<c:url value='/' />images/sr/btn_search2.gif" />
											</c:otherwise>
										</c:choose>
								</a></td>
							</tr>
						</c:if>

						<!-- 현업 및 결제자 -->
						<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
							<tr>
								<td class="tdblue"><spring:message code='sr.completionDate' /></td>
								<td class="tdleft" width="430px;" colspan="3"><input type="hidden" name="pstinstCode" id="pstinstCode" value='${searchVO.pstinstCode}' /> <input name="searchDateF" id="searchDateF" type="hidden" value="<c:out value='${searchVO.searchDateF}'/>" /> <input name="searchDateFView" id="searchDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateF, document.listForm.searchDateFView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"> ~ <input name="searchDateT" id="searchDateT" type="hidden" value="<c:out value='${searchVO.searchDateT}'/>" /> <input name="searchDateTView" id="searchDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchDateTView}'/>" readonly="readonly"
									onClick="javascript:fnClear(this);javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchDateT, document.listForm.searchDateTView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
								> <form:errors path="searchDateF" /> <form:errors path="searchDateT" /></td>
								<td align="center"><a href="#noscript" onclick="fnSearch(); return false;"> 								<img src="<c:url value='/' />images/sr/btn_search2.gif"/> <c:choose>
											<c:when test="${srLanguage == 'ko'}">
												<img src="<c:url value='/' />images/sr/btn_search2.gif" />
											</c:when>
											<c:when test="${srLanguage == 'en'}">
												<img src="<c:url value='/' />images/sr/btn_search2En.gif" />
											</c:when>
											<c:when test="${srLanguage == 'cn'}">
												<img src="<c:url value='/' />images/sr/btn_search2Cn.gif" />
											</c:when>
											<c:otherwise>
												<img src="<c:url value='/' />images/sr/btn_search2.gif" />
											</c:otherwise>
										</c:choose>
								</a></td>
							</tr>
						</c:if>
						<tr>
							<td colspan="5" bgcolor="#dcdcdc" height="1"></td>
						</tr>
					</table>
				</div>
				<!-- //검색 필드 박스 끝 -->

				<div class="list">
					<ul>
						<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align: middle" /> <spring:message code='sr.msg.totalCnt' /> <span style="color: #F00"><c:out value='${paginationInfo.totalRecordCount}' /></span> <spring:message code='sr.msg.cnt' /></li>
					</ul>
				</div>
				<div class="list2">
					<ul>
						<li><img src="<c:url value='/' />images/sr/icon_home.gif" /> &nbsp;<spring:message code='sr.navigation.statSatisfactionStatus' /></li>
					</ul>
				</div>
				<!-- 서비스별 결과 -->
				<div class="list3">
					<table width="980" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="*">
							<col width="13%">
							                 	<col width="10%" >
							                 	<col width="10%" >
							<col width="13%">
							<col width="13%">
							<col width="13%">
							<col width="13%">
							<col width="13%">
							<col width="13%">
						</colgroup>
						<thead>
							<tr>
								<td colspan="8" bgcolor="#0257a6" height="2"></td>
							</tr>
							<tr class="tdgrey">
								<th scope="col" nowrap="nowrap"><spring:message code='sr.module' /></th>
								<!--                      	<th scope="col" nowrap="nowrap">전체건수</th> -->
								<th scope="col" nowrap="nowrap"><spring:message code='sr.completionCnt' /></th>
								<!--                      	<th scope="col" nowrap="nowrap">미완료건수</th> -->
								<th scope="col" nowrap="nowrap"><spring:message code='sr.5point' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.4point' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.3point' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.2point' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.1point' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.average' /></th>
							</tr>
							<tr>
								<td colspan="8" bgcolor="#717171" height="1"></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="8" bgcolor="#cdcdcd" height="1"></td>
							</tr>
							<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<c:if test="${resultInfo.moduleCode != '9999'}">
									<tr>
								</c:if>
								<c:if test="${resultInfo.moduleCode == '9999'}">
									<tr class="tdgrey">
								</c:if>
								<td class="tdwc" nowrap="nowrap">
										                 	${resultInfo.moduleName} <c:choose>
										<c:when test="${srLanguage == 'ko'}">${resultInfo.moduleName}</c:when>
										<c:when test="${srLanguage == 'en'}">${resultInfo.moduleNameEn}</c:when>
										<c:when test="${srLanguage == 'cn'}">${resultInfo.moduleNameCn}</c:when>
										<c:otherwise>${resultInfo.moduleName}</c:otherwise>
									</c:choose>
								</td>
									                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.totalCount}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.completeCount}</td>
									                 	<td class="tdwc"  nowrap="nowrap">${resultInfo.unCompleteCount}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.value5}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.value4}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.value3}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.value2}</td>
								<td class="tdwc" nowrap="nowrap">${resultInfo.value1}</td>
								<td class="tdwc" nowrap="nowrap"><fmt:formatNumber value="${resultInfo.avgValue}" pattern="0.00" /></td>
								</tr>
								<tr>
									<td colspan="8" bgcolor="#cdcdcd" height="1"></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="8" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
								</tr>
								<tr>
									<td colspan="8" bgcolor="#cdcdcd" height="1"></td>
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
								<!-- 페이지 네비게이션 시작 --> <!-- 			                <div id="paging_div"> --> <!-- 			                    <ul class="paging_align"> --> 							        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" /> <!-- 			                    </ul> --> <!-- 			                </div>                           --> <!-- //페이지 네비게이션 끝 --> <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom" height="60"><span class="btnblue"><a href="#LINK" onclick="javascript:fnExcelReport(); return false;"><spring:message code='sr.excelDownload' /> ▶</a></span>&nbsp;</td>
						</tr>
					</table>
			</form>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div> --%>
	<!-- //전체 레이어 끝 -->
</body>
</html>