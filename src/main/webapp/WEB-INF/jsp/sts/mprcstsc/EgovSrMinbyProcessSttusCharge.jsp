<%--
  Class Name : EgovSrMinbyProcessSttuCharge.jsp
  Description : 담당자별 SR월별 처리현황
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 박지욱
    since    : 2009.03.23 
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<!--  <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >-->
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>

<title><spring:message code='sr.monthlyProcessingStatusCharge'/></title>
<script type="text/javaScript" language="javascript">

/* ********************************************************
 *  라디오 버튼 변수
 ******************************************************** */
var totalJsonData = [
	{ text : "&nbsp;<spring:message code='sr.requestDateStandard'/>&nbsp;"  , value : "R"   , checked : ${'R' == searchVO.searchDateCondition} ? "checked" : "" },
	{ text : "&nbsp;<spring:message code='sr.customerConfirmationDateStandard'/>"  , value : "C" , checked : ${'R' != searchVO.searchDateCondition} ? "checked" : ""}
];	

var aggregateJsonData = [
	{ text : "&nbsp;<spring:message code='sr.number'/>&nbsp;"  , value : "C"   , checked : ${'C' == searchVO.searchCountCondition} ? "checked" : "" },
	{ text : "&nbsp;<spring:message code='sr.labourHours'/>"  , value : "T" , checked : ${'C' != searchVO.searchCountCondition} ? "checked" : ""}
];

/* ********************************************************
 *  그리드 생성
 ******************************************************** */	
//그리드 1
	SBGrid3.$(document).ready(function() {
		init();
	});
	
	 var datagrid; // 그리드 객체 전역으로 선언	
	 var gridData = []
	 var moduleData = []
	 var statusData = []
	 var srLanguage = "<c:out value = '${srLanguage}'/>";
	 
	 function init() {	
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
			 $("#searchAt").val("Y");
			 $.ajax({				 
				 url : "<c:url value='/select/mprcstsc/selectSrMinbyProcessSttusCharge.do'/>",
				 type : "POST",
				 data : $("#listForm").serialize(),
				 success :function(data) {
					 //Rename Setting
					 resolve({selected: data.resultList });
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
		        	, caption: "<spring:message code='sr.module' />", editable: false, type: 'text', valign: 'center' , width:12, unit:'%'},
		        { field:'rname', caption:"<spring:message code='sr.charge' />", editable: false, type: 'text', valign: 'center' , width:13, unit:'%'},
		        {caption: "<spring:message code='sr.number' />", columns  :  [
		        	{ field: 'jan', caption: "<spring:message code='sr.january' />", editable: false, type: 'text', align: 'center', width:7, unit:'%'},
			        { field: 'feb', caption: "<spring:message code='sr.february' />", editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'mar', caption: "<spring:message code='sr.march' />", editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'apr', caption: "<spring:message code='sr.april' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'may', caption: "<spring:message code='sr.may' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'jun', caption: "<spring:message code='sr.june' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'jul', caption: "<spring:message code='sr.july' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'aug', caption: "<spring:message code='sr.august' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'sep', caption: "<spring:message code='sr.september' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'oct', caption: "<spring:message code='sr.october' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'nov', caption: "<spring:message code='sr.november' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'dec', caption: "<spring:message code='sr.december' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'total', caption: "<spring:message code='sr.total' />",editable: false, type: 'text', width:7, unit:'%'},
		        ] },
		        {caption: "<spring:message code='sr.labourHours' />", columns  :  [
			        { field: 'jan1', caption: "<spring:message code='sr.january' />",editable: false, type: 'text', align: 'center', width:7, unit:'%'},
			        { field: 'feb1', caption: "<spring:message code='sr.february' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'mar1', caption: "<spring:message code='sr.march' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'apr1', caption: "<spring:message code='sr.april' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'may1', caption: "<spring:message code='sr.may' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'jun1', caption: "<spring:message code='sr.june' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'jul1', caption: "<spring:message code='sr.july' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'aug1', caption: "<spring:message code='sr.august' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'sep1', caption: "<spring:message code='sr.september' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'oct1', caption: "<spring:message code='sr.october' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'nov1', caption: "<spring:message code='sr.november' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'dec1', caption: "<spring:message code='sr.december' />",editable: false, type: 'text', width:7, unit:'%'},
			        { field: 'total1', caption: "<spring:message code='sr.total' />",editable: false, type: 'text', width:7, unit:'%'},	
		        ]},
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
	     console.log(gridConfig);
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
	

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchAt.value = "Y";
    document.listForm.action = "<c:url value='/sts/mprcstsc/selectSrMinbyProcessSttusCharge.do'/>";
    document.listForm.submit();
}

/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(){
//     document.listForm.pageIndex.value = 1;
    document.getElementById('searchYear').value = SBUxMethod.get('searchYear') ? SBUxMethod.get('searchYear') : "";
    //SBGrid3.reload(datagrid);
    //document.listForm.searchAt.value = "Y";
	//document.listForm.action = "<c:url value='/sts/mprcsts/selectSrMinbyProcessSttus.do'/>";
    //document.listForm.submit();
    SBGrid3.reload(datagrid);
}
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

}

/**
 * 엑셀다운로드
 */
 function fnExcelReport(){
     document.listForm.action = "<c:url value='/sts/mprcstsc/EgovMinbyProcessSttusChargeExcelReport.do'/>";
     document.listForm.submit();
 }
</script>
</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<!-- 전체 레이어 시작 -->
<div class="sr-contents-wrap">
    <!-- header 시작 -->
    <c:import url="/sym/mms/EgovMainMenuLeft.do" />       
    <!-- //header 끝 --> 
        <!-- 현재위치 네비게이션 시작 -->
        <div class="sr-contents-area">
        	<div class="sr-contents">
        		<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
	            
	            <form id="listForm" name="listForm" action="<c:url value='/sts/mprcstsc/selectSrMinbyProcessSttusCharge.do'/>" method="post">
		            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		            <input type="submit" id="invisible" class="invisible" />
		            <input type="hidden" id="cal_url" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
		            <!-- <input type="hidden" id="searchYear" name="searchYear"/> -->
		            <input type="hidden" id="searchAt" name="searchAt"/>
	            <!-- 검색 필드 박스 시작 -->
		            <div class="sr-table-wrap">
		            	<table class="sr-table">
		            		<colgroup>
		                        <col width="12%">
		                        <col width="29%">
		                        <col width="12%">
		                        <col width="49%">
		                    </colgroup>
		            		<!-- 담당자, 관리자, Admin -->
		            		<tbody>					        
			            		<tr>	            			
			              			<th>
			              				<sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.viewYear'/>"></sbux-label>	              			
		              				</th>
			              			<td>
			              			<sbux-select id="searchYear" name="searchYear" uitype="single" init="">
		            					<c:forEach var="i" begin="0" end="5" items="${year_list}" varStatus="status">
											<option value='<c:out value="${i}"/>'  <c:if test="${i == searchVO.searchYear}">selected</c:if>><c:out value="${i}"/></option>
										</c:forEach>
				                  	</sbux-select>
					               	</td>
					               	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
					               	<th>
		                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="<spring:message code='sr.client'/>"></sbux-label>
		                            </th>
									<td>
										<sbux-select id="pstinstCode" name="pstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                	<option value=''><spring:message code='sr.choose' /></option>
		                                	<c:forEach var="result" items="${pstinstList}" varStatus="status">
												<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
											</c:forEach>
		                                </sbux-select>
									</td>
									</c:if>
								</tr>
								<tr>
									<th>
	                                <sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.module' />"></sbux-label>
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
			                  	<!-- 	<th>
		                               	<sbux-label id="table_label4" name="table_label4" uitype="normal" text="<spring:message code='sr.aggregateTarget'/>" class=""></sbux-label>
		                            </th>
			                  		<td>
			                  			<sbux-radio id="searchCountCondition" name="searchCountCondition" uitype="normal" jsondata-ref="aggregateJsonData"></sbux-radio>
			                  		</td>
			                  		 -->
								</tr>
							</tbody>
						</table>
					</div>
				</form>
				 <!-- //검색 필드 박스 끝 -->
				<div class="grid_area">
					<div class="grid_txt">
	                </div>
	                <div class="btn_grid">
                    	<sbux-button uitype="normal" text="<spring:message code='sr.excelDownload' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fnExcelReport(); return false;"></sbux-button>                    
					</div>
				</div>
					<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
				</div>
				<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			</div>
		</div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>