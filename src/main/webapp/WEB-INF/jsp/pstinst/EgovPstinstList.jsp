<%--
  Class Name : EgovPstinstList.jsp
  Description : EgovPstinstList 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />" ></script>
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->

<title>고객사관리</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/pstinst/EgovPstinstList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
// function fn_egov_search_Pstinst(){
//     sC = document.listForm.searchCondition.value;
//     sK = document.listForm.searchKeyword.value; 
//     if (sC == "1") {
//         document.listForm.searchKeyword.value = sK.replace(/\-/, "");
//     }
//     document.listForm.pageIndex.value = 1;
//     document.listForm.submit();
// }
function fn_egov_search_Pstinst(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Pstinst(){
    location.href = "<c:url value='/psinst/EgovPsinstInsertView.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Pstinst(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Pstinst(pstinstCode){
    var varForm              = document.all["Form"];
    varForm.pstinstCode.value        = pstinstCode;
    varForm.submit();
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
-->

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
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/pstinst/EgovPstinstSearchList.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){
	 	   		//Rname Setting
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.resultList })
	 	   		$("#totalCnt").text(data.paginationInfo.totalRecordCount);
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
    	schema: {
    		id : (value) => value.pstinstCode
    	}	 
		,ajax: {
	       // 해당 소스를 추가해주시면 됩니다.
	       select: async(request) => {
	         return await loadData(request);
	       },
             // 해당 부분이 받아온 response data의 protorype name 입니다. 데이터 형식은 최하단에 첨부하겠습니다.
             // 기존 같은 경우 data: 데이터 객체를 넣었겠지만 ajax.selected가 설정되어 있으면 그 적용 값으로 됩니다.
		},
      
       serverPaging: true, 
       cachePaging: true,
       serverSorting: true,
       pageSize: 10,
     };

	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "479px",
	    captionHeight: 40,
	    rowHeight:40,
	    columns: [
		{ field: 'pstinstCode', caption: "회사코드", editable: false, type: 'text', width:5, unit:'%', visible : false},
		{ field: 'name', caption: "고객사명", editable: false, type: 'text', width:10, unit:'%', colCss : 'pointer'}, 
		{ field: 'address1', caption: "주소1", editable: false, type: 'text', width:5, unit:'%', visible : false}, 
		{ field: 'address2', caption: "주소2", editable: false, type: 'text', width:5,unit:'%', visible : false}, 
		{ field: 'address', caption: "주소", editable: false, type: 'text', width:75, unit:'%',
			calc : {
				require : ['address1', 'address2'],
				eval : function (data) {
					return data.address1 + " " + data.address2  
				}
			}}
        ],
        editable: true,
		showRowNo:true,
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
  	                	if(command.column && (command.column.field == "name") ){
  	                		
  	  	                	var pstinstCode = SBGrid3.getValue(grid, command.key, 'pstinstCode');
  	  	                	
  	  	                	if(pstinstCode) {
  	  	                		fn_egov_detail_Pstinst(pstinstCode);
  	  	                	}
  	  	                	
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

function fnSearch(){
    //document.listForm.pageIndex.value = 1;
    //document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    //document.listForm.submit();
    SBGrid3.reload(datagrid);
}

function fn_egov_detail_Pstinst(pstinstCode){
    var varForm              = document.all["Form"];
    //var varForm              = $("#Form").serialize();
    var pstinstCode = pstinstCode;
    var searchPstinstCode = $('#searchPstinstCode').val();
    
    varForm.pstinstCode.value        = pstinstCode;
    varForm.pstinst.value        = pstinstCode;
    varForm.searchPstinstCode.value        = searchPstinstCode;
    //varForm.searchDelAt.value        = 'N';
    varForm.submit();
}

function fn_egov_regist_Pstinst(){
	document.listForm.action = "<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>";
    document.listForm.submit();
}

</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div class="sr-contents-wrap">
    <!-- header 시작 -->
    <c:import url="/sym/mms/EgovMainMenuLeft.do" />
    <!-- //header 끝 --> 
    <!-- container 시작 -->
    <div class="sr-contents-area">
        <!-- 좌측메뉴 시작 -->
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
            
            <div class="sr-breadcrumb-area">                
                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
            </div>
            <div class="btn_right">
                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
            </div>
            
            <form id="registForm" name="registForm" action="<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>" method="post">
            	  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            </form>
            
            <form id="listForm" name="listForm" action="<c:url value='/pstinst/EgovPstinstList.do'/>" method="post">
                <input type="hidden" id="${_csrf.parameterName }" name="${_csrf.parameterName }" value="${_csrf.token }" />
                <input type="submit" id="invisible" class="invisible"/>
                <input id="selectedId" name="selectedId" type="hidden" />
		        <input id="checkedIdForDel" name="checkedIdForDel" type="hidden" />
		        <input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		        <input id="pstinstCode" name="pstinstCode" type="hidden" value="<c:out value='${searchVO.pstinstCode}'/>"/>
                
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
			            <th>
			            	<sbux-label id="table_label1" name="table_label1" uitype="normal" text="고객사"></sbux-label>
			            </th>
						<td style="border-right:0px;">
							<sbux-select name="searchPstinstCode" id="searchPstinstCode" class="select" title="고객사">
				 				<option value='' >선택</option>
							    <c:forEach var="result" items="${pstinstList}" varStatus="status">
									<option value='<c:out value="${result.pstinstCode}"/>'  <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}"/></option>
								</c:forEach>
							 </sbux-select>
						</td>
						<td style="border-right:0px; border-left:0px;">
						</td>
						<td style="border-left:0px;">
						</td>
			            </tr>
			          </table>
                </div>
               </form>
               <div class="grid_area">
					<div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">
                    	<sbux-button uitype="normal" text="등록" class="btn-default"  onclick = "fn_egov_regist_Pstinst(); return false;"></sbux-button>                    
	                </div>	                
                </div>
                
                <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>               
                
            

			<form id="Form" name="Form" method="post" action="<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>">
				<input type="hidden" id="${_csrf.parameterName }" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" id="pstinstCode" name="pstinstCode">
				<input type="hidden" id="pstinst" name="pstinst">
				<input type="hidden" id="searchDelAt" name="searchDelAt">
			    <input type="submit" id="invisible" class="invisible"/>
			    <input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			    <input type="hidden" id="searchPstinstCode" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>">	
			    <input type="hidden" id="searchPstinstNm" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>"/>		    
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