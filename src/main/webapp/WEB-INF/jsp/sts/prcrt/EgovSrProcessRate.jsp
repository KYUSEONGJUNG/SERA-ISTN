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

<title><spring:message code='sr.processingRatio' /></title> 
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
				 url : "<c:url value='/select/prcrt/EgovSrProcessRate.do'/>",
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
				, caption: "<spring:message code='sr.module' />", editable: false, type: 'text', valign: 'center' , width:20, unit:'%'},
		        { field: 'srTotalCnt', caption: "<spring:message code='sr.requestCnt' />", editable: false, type: 'text', align: 'center', width:10, unit:'%'},
		        { field: 'signCnt', caption: "<spring:message code='sr.receiptCnt' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'resolveCnt', caption: "<spring:message code='sr.beingSolvedCnt' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'testAtCnt', caption: "<spring:message code='sr.customerConfirmCnt' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'completeCnt', caption: "<spring:message code='sr.completionCnt' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'completeRate', caption: "<spring:message code='sr.completionRatio' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'evalCnt', caption: "<spring:message code='sr.evaluationCnt' />", editable: false, type: 'text', width:10, unit:'%'},
		        { field: 'evalPoint', caption: "<spring:message code='sr.evaluationReceipt' />", editable: false, type: 'text', width:10, unit:'%'}
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



	/* ********************************************************
	 * 페이징 처리 함수
	 ******************************************************** */
	function fn_egov_pageview(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/sts/prcrt/selectSrProcessRate.do'/>";
		document.listForm.submit();
		document.listForm.action = "";
	}

	/*********************************************************
	 * 조회 처리 
	 *********************************************************/
	function fnSearch() {
		//     document.listForm.pageIndex.value = 1;
		fnDateChk();
		document.listForm.searchAt.value = "Y";
		//document.listForm.action = "<c:url value='/sts/prcrt/selectSrProcessRate.do'/>";
		//document.listForm.submit();
		SBGrid3.reload(datagrid);
	}
	//조회시 널값인 날짜 처리.
	function fnDateChk() {
		document.getElementById('searchDateF').value = SBUxMethod.get('searchDate_from') ? SBUxMethod.get('searchDate_from') : "";
		document.getElementById('searchDateT').value = SBUxMethod.get('searchDate_to') ? SBUxMethod.get('searchDate_to') : "";
		
	}
	/*********************************************************
	 * 초기화
	 *********************************************************/
	function fnInitAll() {

		//요청일 시작일자, 종료일자
		if (document.listForm.searchDateF.value != ""
				&& document.listForm.searchDateT.value != "") {
			var fromDate = document.listForm.searchDateF.value;
			var toDate = document.listForm.searchDateT.value;
			document.listForm.searchDateFView.value = fromDate
					.substring(0, 4)
					+ "-"
					+ fromDate.substring(4, 6)
					+ "-"
					+ fromDate.substring(6, 8);
			document.listForm.searchDateTView.value = toDate.substring(
					0, 4)
					+ "-"
					+ toDate.substring(4, 6)
					+ "-"
					+ toDate.substring(6, 8);
		}

	}

	/**
	 * 엑셀다운로드
	 */
	function fnExcelReport() {
		document.listForm.action = "<c:url value='/sts/prcrt/EgovProcessRateExcelReport.do'/>";
		document.listForm.submit();
	}

	/**
	 * 데이터 삭제
	 */
	function fnClear(obj) {
		obj.value = "";
		obj.focus();
		return false;
	}
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
<body>
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
				
				<form name="listForm" id="listForm" action="<c:url value='/sts/prcrt/selectSrProcessRate.do'/>" method="post">
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
		                    
		                    	<tr>
		                    		<th>
		                    			<sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
		                    		</th>
		                    		<td>
		                                <sbux-datepicker name="searchDate" id="searchDate" uitype="range" open-on-input-selection="true" split-text="~" init="yyyy/mm/dd">
		                                </sbux-datepicker>
		                            </td>
		                            <th>
		                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="<spring:message code='sr.charge' />"></sbux-label>
		                            </th>
		                            <td>
		                            <sbux-select id="rid" name="rid" uitype="single" init = "<spring:message code='sr.choose' />">
										<option value=''><spring:message code='sr.choose' /></option>
										<c:forEach var="result" items="${chargerList}" varStatus="status">										
												<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == searchVO.rid}">selected</c:if>>
													<c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${result.userNm}" />
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${result.userNmEn}" />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${result.userNmEn}" />
														</c:when>
														<c:otherwise>
															<c:out value="${result.userNm}" />
														</c:otherwise>
													</c:choose>
												</option>								
										</c:forEach>								
									</sbux-select>
		                            </td>
		                    	</tr>
		                    	<!-- 담당자, 관리자, Admin -->
		                    	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
		                    	<tr>
		                    		<th>
		                                <sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.client'/>" class=""></sbux-label>
		                            </th>
		                            <td style="border-right:0px;">
		                            	<sbux-select id="pstinstCode" name="pstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                	<option value=''><spring:message code='sr.choose' /></option>
		                                	<c:forEach var="result" items="${pstinstList}" varStatus="status">
												<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
											</c:forEach>
		                                </sbux-select>
		                            </td>
		                            <th style="border-left:0px; border-right:0px; background:#ffffff"></th>
		                            <td style="border-left:0px;"></td>
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
				
				</table>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->
</body>
</html>