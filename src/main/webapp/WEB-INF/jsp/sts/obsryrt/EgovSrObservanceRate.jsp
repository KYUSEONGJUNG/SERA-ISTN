<%--
  Class Name : EgovSrObservanceRate.jsp
  Description : EgovSrObservanceRate 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2014.08.21   박원배              최초 생성
 
    author   : SR 개발팀 박원배
    since    : 2014.08.21
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<!--<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css">-->
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>

<title><spring:message code='sr.receptionAndCompleteOnTime'/></title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 새로고침 방지
 ******************************************************** */
function noEvent() {
    if (event.keyCode == 116) {		// function F5
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))		//ctrl+N , ctrl+R
    {
        return false;
    }
}
document.onkeydown = noEvent;
/**
 * 데이터 삭제
 */
function fnClear(obj) {
	 obj.value="";
	 obj.focus();
	 return false;
}
function fnSearch(){
	fnDateChk();
	document.listForm.searchAt.value = "Y";
	document.listForm.action = "<c:url value='/sts/obsryrt/EgovSrObservanceRate.do'/>";
    document.listForm.submit();
    document.listForm.action = "";
}
//조회시 널값인 날짜 처리.
function fnDateChk(){
	if(document.getElementById('searchConfirmDateFView').value == ""){
		document.getElementById('searchConfirmDateF').value = "";
	}
	
	if(document.getElementById('searchConfirmDateTView').value == ""){
		document.getElementById('searchConfirmDateT').value = "";
	}
}
/**
 * 엑셀다운로드
 */
 function fnExcelReport(){
     document.listForm.action = "<c:url value='/sts/obsryrt/EgovSrObservanceRateExcelReport.do'/>";
     document.listForm.submit();
     document.listForm.action = "";
 }
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
//조회시 널값인 날짜 처리.
function fnDateChk(){
	//if(document.getElementById('searchConfirmDateFView').value == ""){
		//document.getElementById('searchConfirmDateF').value = "";
	//}
	
	//if(document.getElementById('searchConfirmDateTView').value == ""){
		//document.getElementById('searchConfirmDateT').value = "";
	//}


	document.getElementById('searchConfirmDateF').value = SBUxMethod.get('searchConfirmDate_from') ? SBUxMethod.get('searchConfirmDate_from') : "";
	document.getElementById('searchConfirmDateT').value = SBUxMethod.get('searchConfirmDate_to') ? SBUxMethod.get('searchConfirmDate_to') : "";
}



function fnSearch(){
	fnDateChk();
	document.listForm.searchAt.value = "Y";
	//document.listForm.action = "<c:url value='/sts/obsryrt/EgovSrObservanceRate.do'/>";
    //document.listForm.submit();
    SBGrid3.reload(datagrid);
}


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
			 $("#searchConfirmDateFView").val($("#searchConfirmDateF").val());
			 $("#searchConfirmDateTView").val($("#searchConfirmDateT").val());
			 $.ajax({
				 url : "<c:url value='/select/obsryrt/EgovSrObservanceRate.do'/>",
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
		        { field: 'signCnt', caption: "<spring:message code='sr.requestCnt' />", editable: false, type: 'text', align: 'center', width:12.5, unit:'%'},
		        { field: 'confirmCnt', caption: "<spring:message code='sr.receiptCnt' />", editable: false, type: 'text', width:12.5, unit:'%'},
		        { field: 'inConfirmCnt', caption: "<spring:message code='sr.dayReceptCnt' />", editable: false, type: 'text', width:12.5, unit:'%'},
		        { field: 'inConfirmRate', caption: "<spring:message code='sr.dayRecpetPercent' />", editable: false, type: 'text', width:12.5, unit:'%'},
		        { field: 'completeCnt', caption: "<spring:message code='sr.completionCnt' />", editable: false, type: 'text', width:12.5, unit:'%'},
		        { field: 'inCompleteCnt', caption: "<spring:message code='sr.completeOnTimeCnt' />건", editable: false, type: 'text', width:12.5, unit:'%'},
		        { field: 'inCompleteRate', caption: "<spring:message code='sr.completeOnTimePercent' />", editable: false, type: 'text', width:12.5, unit:'%'}
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



</script>

<script>
//jquery Start
$(document).ready(function(){
	SBUxMethod.set("searchConfirmDate", "<c:out value='${searchVO.searchConfirmDateF}'/>,<c:out value='${searchVO.searchConfirmDateT}'/>")
	$('#searchConfirmDateFView').datepicker({
		dateFormat:"yy-mm-dd",
		altFormat: "yymmdd",
		altField: "#searchConfirmDateF",
		onSelect: function(dateText){

		}
	});
	
	$('#searchConfirmDateTView').datepicker({
		dateFormat:"yy-mm-dd",
		altFormat: "yymmdd",
		altField: "#searchConfirmDateT",
		onSelect: function(dateText){
		}
	});
});
</script>

</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<!-- 전체 레이어 시작 -->
	<div class="sr-contents-wrap">
		<c:import url="/sym/mms/EgovMainMenuLeft.do" />
		<!-- container 시작 -->
		<div class="sr-contents-area">
		<!-- 현재위치 네비게이션 시작 -->
		<div class="sr-contents">
		
			<div class="sr-breadcrumb-area">                
                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
            </div>
            <div class="btn_right">
                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
            </div>
	            
			<form id="listForm" name="listForm" action="<c:url value='/sts/obsryrt/EgovSrObservanceRate.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" /> 
				<input type="hidden" if="cal_url" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> 
				<input type="hidden" id="searchAt" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />
				<input type="hidden" id="searchConfirmDateT" name="searchConfirmDateT"/>
				<input type="hidden" id="searchConfirmDateF" name="searchConfirmDateF"/>

				<!-- 검색 필드 박스 시작 -->
				<div class="sr-table-wrap">
	                <table class="sr-table">
	                	<colgroup>
	                        <col width="12%">
	                        <col width="29%">
	                        <col width="12%">
	                        <col width="49%">
	                    </colgroup>
							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									<th>
										<sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.list.requestDate' />"></sbux-label>
									</th>
									<td style="border-right:0px;">
										<sbux-datepicker name="searchConfirmDate" id="searchConfirmDate" open-on-input-selection="true" uitype="range" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
									</td>
									<td style="border-left:0px; border-right:0px;"></td>
									<td style="border-left:0px;"></td>
								</c:if>
								<!-- 담당자, 관리자, Admin -->
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
									<th>
										<sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.list.requestDate' />"></sbux-label>
									</th>
									<td>
										<sbux-datepicker name="searchConfirmDate" id="searchConfirmDate" open-on-input-selection="true" uitype="range" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
									</td>								
									<th>
										<sbux-label id="table_label2" name="table_label2" uitype="normal" text="고객사"></sbux-label>
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
					</table>
				</div>
			</form>
				<!-- //검색 필드 박스 끝 -->

			<div class="grid_area">
				<div class="grid_txt">
                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
                </div>
                 <div class="btn_grid">                    
                   	<sbux-button uitype="normal" text="<spring:message code='sr.excelDownload' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fnExcelReport(); return false;"></sbux-button>                    
               	 </div>	    
			</div>
			<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
			<!-- table add start -->

			<input name="selectedId" type="hidden" /> <input name="checkedIdForDel" type="hidden" />
				

			<form name="Form" method="post" action="<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" />
			</form>

		</div>
		
		<!-- //content 끝 -->
		<!-- //container 끝 -->
		<!-- footer 시작 -->
		<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>
	</div>
	<!-- //전체 레이어 끝 -->
</body>
</html>