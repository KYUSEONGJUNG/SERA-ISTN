<%--
  Class Name : EgovNoticeList.jsp
  Description : 게시물 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
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

<%-- <c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>
<c:choose> 
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
    function press(event) {
    }

    function fn_egov_addNotice() {
    }
    
    function fn_egov_select_noticeList(pageNo) {
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {      
    }
//-->
</script>
</c:when>
<c:otherwise> --%>
<script type="text/javascript">


    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }

    function fn_egov_addNotice() {
        document.listForm.action = "<c:url value='/cop/bbs/addBoardArticle.do'/>";
        document.listForm.submit();
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.listForm.pageIndex.value = pageNo;
        document.listForm.action = "<c:url value='/cop/bbs/selectBoardList.do'/>";
        document.listForm.submit();  
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {
        document.listForm.nttId.value = nttId;
        document.listForm.bbsId.value = bbsId;
        document.listForm.action = "<c:url value='/cop/bbs/selectBoardArticle.do'/>";
        document.listForm.submit();          
    }
//

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
			 url : "<c:url value='/select/cop/bbs/selectBoardList.do'/>",
			 type : "POST",
			 data : $("#listForm").serialize(),
			 success :function(data) {
				 //Rename Setting
				 resolve({selected: data.resultList });
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
	    ajax: {
	        select : async(request) => {
	       	 return await loadData(request);
	        },
	    },
	    serverPaging : true,
	    cachePaging : true,
	    serverSorting :true,
	    pageSize: 10,
	};
	
	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "400px",
	    captionHeight: 40,
	    rowHeight:40,
	    columns: [
	        { field: 'rowNo', caption: "<spring:message code='cop.number' />", editable: false, type: 'text', valign: 'center' , width:10, unit:'%', colCss : "pointer"},
	        { field: 'nttSj', caption: "<spring:message code='cop.nttSj' />", editable: false, type: 'text', align: 'center', width:60, unit:'%', colCss : "pointer"},
	        { field: 'frstRegisterNm', caption: "<spring:message code='cop.ntcrNm' />", editable: false, type: 'text', width:10, unit:'%'},
	        { field: 'frstRegisterPnttm', caption: "<spring:message code='cop.dateCreated' />", editable: false, type: 'text', width:10, unit:'%'},
	        { field: 'inqireCo', caption: "<spring:message code='cop.hits' />", editable: false, type: 'text', width:10, unit:'%'},
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
		doCommand : (grid, name, command) => {
			switch(name) {
			case 'event' : {
	                if (command.event.type == 'dblclick') {
	                   // cell을 dblclick하면 더블클릭 메시지 띄우기
	                    
	                }
	                else if(command.event.type == 'click'){
	                	if(command.column && (command.column.field == "rowNo" || command.column.field == "nttSj") ){
	  	                	//var srNo = SBGrid3.getValue(grid, command.key, 'srNo');
	  	                	var nttId = SBGrid3.getValue(grid, command.key, 'nttId');
	  	                	var bbsId = SBGrid3.getValue(grid, command.key, 'bbsId');
	  	                	
	  	                	if(nttId) {
	  	                		fn_egov_inqire_notice(nttId,bbsId);
	  	                	}
	  	                	
	  	                }
	                }
	                else if (command.event.type == 'keydown') {
	                   // cell에 입력했을 때 키 다운 메세지 띄우기
	                  
	                }
	                
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
	document.listForm.pageIndex.value = 1;
	//document.listForm.searchAt.value = "Y";
 //document.listForm.submit();
 	SBGrid3.reload(datagrid);
} 

</script>
<%-- </c:otherwise>
</c:choose> --%>
<title><spring:message code='cop.notice'/></title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    

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
				
				<form name="listForm" id="listForm" action="<c:url value='/cop/bbs/selectBoardList.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
	                <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> 
	                <input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
					<input type="hidden" name="nttId"  value="0" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
					<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
					<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />  
					<%-- <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />  --%>
					<%-- <input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>" />
					<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/> --%>
            		<!-- <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" /> -->
					
				<!-- 검색 필드 박스 시작 -->
					<div class="sr-table-wrap">
		                <table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
		                        <col width="38%">
		                        <col width="12%">
		                        <col width="38%">
		                    </colgroup>
		                    <tbody>
		                    <!-- 담당자, 관리자, Admin -->
		                    <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							
		                    	<tr>
		                    		<th>
		                    			<sbux-select id="searchCnd" name="searchCnd" uitype="single" init = "<spring:message code='sr.choose' />" style="background-color : #f8f8f8; border-color: #f8f8f8;">
		                           
											
							        	<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code='cop.nttSj'/></option>
							           	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code='cop.nttCn'/></option>             
							           	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code='cop.ntcrNm'/></option>
										
	                               </sbux-select>
		                    		</th>
		                    		<td colspan="8">
		                                <sbux-input name="searchWrd" type="text" style = "width : 60%;" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
		                            </td>
		                            
		                    	
		                    	
		                    	</tr>
		                    	</c:if>
		                    	
		                    	<!-- 현업 및 결제자 -->
		                    	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
		                    	<tr>
		                    		<th>
		                    			<sbux-select id="searchCnd" name="searchCnd" uitype="single" init = "<spring:message code='sr.choose' />">
		                               <option value=''><spring:message code='sr.choose' /></option>
											
							        	<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code='cop.nttSj'/></option>
							           	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code='cop.nttCn'/></option>             
							           	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code='cop.ntcrNm'/></option>
										
	                               </sbux-select>
		                    		</th>
		                    		<td colspan="8">
		                                <sbux-input name="searchWrd" type="text" style = "width : 60%;" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
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
	                    <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
	                    	<sbux-button uitype="normal" text="<spring:message code='button.create' />" class="btn-default" onclick = "javascript:fn_egov_addNotice(); return false;"></sbux-button>                    
	                	</c:if>
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
				</table>  --%>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>

<!-- 전체 레이어 시작 -->
<%-- <div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
        <!-- 현재위치 네비게이션 시작 -->
        <div id="contents">
        	<form name="frm" action ="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
			<input type="hidden" name="nttId"  value="0" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
			<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />

            <!-- 검색 필드 박스 시작 -->
            <div id="search_field">
            	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
					<!-- 담당자, 관리자, Admin -->
		        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
						<!-- 고객자료실// -->
						<table width="980" border="0" cellpadding="0" cellspacing="0">
			        		<tr>
			          			<td colspan="5" bgcolor="#0257a6" height="2"></td>
			        		</tr>
			        		<tr>
			          			<td class="tdblue">
			          				<select name="searchCnd" class="select" title="검색조건 선택">
							        	<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code='cop.nttSj'/></option>
							           	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code='cop.nttCn'/></option>             
							           	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code='cop.ntcrNm'/></option>            
							    	</select>
								</td>
			          			<td class="tdleft" width="400px;">
			          				<input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
			          			</td>
			                    <th height="23" class="tdblue" nowrap="nowrap"><spring:message code='sr.client'/></th>
			                    <td class="tdleft" width="400px;">
			                      <select name="searchPstinstCode" id="searchPstinstCode" class="select" title="고객사">
					 				<option value='' >==<spring:message code='sr.choose'/>==</option>
								    <c:forEach var="result" items="${pstinstList}" varStatus="status">
										<option value='<c:out value="${result.pstinstCode}"/>'  <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}"/></option>
									</c:forEach>
								 </select>
			                    </td>
			          			<td align="center">
			          				<a href="#LINK" onclick="fn_egov_select_noticeList('1'); return false;">
			          					<img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" />
			          					<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" /></c:when>
						  					<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_search2En.gif" alt="search" /></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_search2Cn.gif" alt="search" /></c:when>
						  				</c:choose>
			          				</a>
								</td> 
			          		</tr>
			          		<tr>
					        	<td colspan="5" bgcolor="#dcdcdc" height="1"></td>
					        </tr>
		          		</table>
		        	</c:if>	  
		        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
		        		<table width="980" border="0" cellpadding="0" cellspacing="0">
			        		<tr>
			          			<td colspan="3" bgcolor="#0257a6" height="2"></td>
			        		</tr>
			        		<tr>
			          			<td class="tdblue">
			          				<select name="searchCnd" class="select" title="검색조건 선택">
							        	<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code='cop.nttSj'/></option>
							           	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code='cop.nttCn'/></option>             
							           	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code='cop.ntcrNm'/></option>            
							    	</select>
								</td>
			          			<td class="tdleft" width="690px;">
			          				<input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
			          			</td>
			          			<td align="center">
			          				<a href="#LINK" onclick="fn_egov_select_noticeList('1'); return false;">
			          					<img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" />
			          					<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" /></c:when>
						  					<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_search2En.gif" alt="search" /></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_search2Cn.gif" alt="search" /></c:when>
						  				</c:choose>			          					
			          				</a>
								</td> 
			          		</tr>
			          		<tr>
					        	<td colspan="3" bgcolor="#dcdcdc" height="1"></td>
					        </tr>
		          		</table>
		        	</c:if>    	
            	</c:if>
            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
	            	<table width="980" border="0" cellpadding="0" cellspacing="0">
		        		<tr>
		          			<td colspan="3" bgcolor="#0257a6" height="2"></td>
		        		</tr>
		        		<tr>
		          			<td class="tdblue">
		          				<select name="searchCnd" class="select" title="검색조건 선택">
						        	<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code='cop.nttSj'/></option>
						           	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code='cop.nttCn'/></option>             
						           	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code='cop.ntcrNm'/></option>            
						    	</select>
							</td>
		          			<td class="tdleft" width="690px;">
		          				<input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
		          			</td>
		          			<td align="center">
		          				<a href="#LINK" onclick="fn_egov_select_noticeList('1'); return false;">
		          					<img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" />
		          					<c:choose>
					  					<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_search2.gif" alt="search" /></c:when>
					  					<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_search2En.gif" alt="search" /></c:when>
					  					<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_search2Cn.gif" alt="search" /></c:when>
					  				</c:choose>
		          				</a>
							</td> 
		          		</tr>
		          		<tr>
				        	<td colspan="3" bgcolor="#dcdcdc" height="1"></td>
				        </tr>
	          		</table>
            	</c:if>
          	</div>
            <!-- //검색 필드 박스 끝 -->
			</form>
			<!-- </form> -->
			
			<div class="list">
        	<ul>
            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> <spring:message code='sr.msg.totalCnt'/> <span style="color:#F00"><c:out value='${paginationInfo.totalRecordCount}'/></span> <spring:message code='sr.msg.cnt'/></li>
            </ul>
		    </div>
		    <div class="list2">
		    <ul>
		       	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > <spring:message code='cop.cmmnty'/> > <strong>
	  				<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${brdMstrVO.bbsNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${brdMstrVO.bbsNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${brdMstrVO.bbsNmCn}"/></c:when>
	  				</c:choose> 		       	
		       		
		       	</strong></li>
		    </ul>
		    </div>

			<!-- 서비스별 결과 -->
       		<div class="list3">
      			<table width="980" border="0" cellpadding="0" cellspacing="0">
        		<colgroup>
                	<col width="10%" >
                    <col width="*" >  
                 	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
	                    <col width="20%" >
	                    <col width="20%" >
				    </c:if>
                    <c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
						<!-- 담당자, 관리자, Admin -->
			        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							<col width="10%" >
			        	</c:if>	      	
	            	</c:if>
				    <c:if test="${anonymous != 'true'}">
	                    <col width="20%" >
				    </c:if>
                    <col width="15%" >
                    <col width="8%" >
               	</colgroup>
                <thead>
                	<tr>
                		<c:choose>
				            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
				            	<td colspan="7" bgcolor="#0257a6" height="2"></td>
				            </c:when>
				            <c:otherwise>
				                <c:choose>
				                    <c:when test="${anonymous == 'true'}">
				                        <td colspan="4" bgcolor="#0257a6" height="2"></td>
				                    </c:when>
				                    <c:otherwise>
				                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
											<!-- 고객자료실 : 담당자, 관리자, Admin -->
								        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
												<td colspan="6" bgcolor="#0257a6" height="2"></td>
								        	</c:if>
								        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
								        		<td colspan="5" bgcolor="#0257a6" height="2"></td>
								        	</c:if>
						            	</c:if>
						            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
						            		<td colspan="5" bgcolor="#0257a6" height="2"></td>
						            	</c:if>				                        
				                    </c:otherwise>
				                </c:choose>     
				            </c:otherwise>
				        </c:choose>
                	</tr>
                	<tr class="tdgrey">
                     	<th scope="col" class="f_field" nowrap="nowrap"><spring:message code='cop.number'/></th>
                        <th scope="col" nowrap="nowrap"><spring:message code='cop.nttSj'/></th>
                        <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
	                        <th scope="col" nowrap="nowrap"><spring:message code='cop.ntceBgnde'/></th>
	                        <th scope="col" nowrap="nowrap"><spring:message code='cop.ntceEndde'/></th>
					    </c:if>
					    <c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
							<!-- 고객자료실 : 담당자, 관리자, Admin -->
				        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
								<th scope="col" nowrap="nowrap"><spring:message code='sr.client'/></th>
				        	</c:if>	      	
		            	</c:if>
					    <c:if test="${anonymous != 'true'}">
                            <th scope="col" nowrap="nowrap"><spring:message code='cop.ntcrNm'/></th>
                        </c:if>
                        <th scope="col" nowrap="nowrap"><spring:message code='cop.dateCreated'/></th>
                        <th scope="col" nowrap="nowrap"><spring:message code='cop.hits'/></th>
                 	</tr>
                 	<tr>
                 		<c:choose>
				            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
				            	<td colspan="7" bgcolor="#717171" height="1"></td>
				            </c:when>
				            <c:otherwise>
				                <c:choose>
				                    <c:when test="${anonymous == 'true'}">
				                        <td colspan="4" bgcolor="#717171" height="1"></td>
				                    </c:when>
				                    <c:otherwise>
				                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
											<!-- 고객자료실 : 담당자, 관리자, Admin -->
								        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
												<td colspan="6" bgcolor="#717171" height="1"></td>
								        	</c:if>
								        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
								        		<td colspan="5" bgcolor="#717171" height="1"></td>
								        	</c:if>
						            	</c:if>
						            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
						            		<td colspan="5" bgcolor="#717171" height="1"></td>
						            	</c:if>
				                    </c:otherwise>
				                </c:choose>     
				            </c:otherwise>
				        </c:choose>
                 	</tr>
               	</thead>
               	<tbody>
                	<tr>
                 		<c:choose>
				            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
				            	<td colspan="7" bgcolor="#cdcdcd" height="1"></td>
				            </c:when>
				            <c:otherwise>
				                <c:choose>
				                    <c:when test="${anonymous == 'true'}">
				                        <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
				                    </c:when>
				                    <c:otherwise>
				                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
											<!-- 고객자료실 : 담당자, 관리자, Admin -->
								        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
												<td colspan="6" bgcolor="#cdcdcd" height="1"></td>
								        	</c:if>
								        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
								        		<td colspan="5" bgcolor="#cdcdcd" height="1"></td>
								        	</c:if>
						            	</c:if>
						            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
						            		<td colspan="5" bgcolor="#cdcdcd" height="1"></td>
						            	</c:if>
				                    </c:otherwise>
				                </c:choose>     
				            </c:otherwise>
				        </c:choose>
                 	</tr>
                 	
                 	<c:forEach items="${resultList}" var="result" varStatus="status">
                 	<!-- loop 시작 -->   
				      	<tr>
				        	<td class="tdwc"  nowrap="nowrap">
				        		<c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
				        		<c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/>
				        	</td>            
				        	<td class="tdwc"  nowrap="nowrap">
				            <form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
				            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				            	<c:if test="${result.replyLc!=0}">
				                	<c:forEach begin="0" end="${result.replyLc}" step="1">
				                    	&nbsp;
				                	</c:forEach>
				                	<img src="<c:url value='/images/reply_arrow.gif'/>" alt="reply arrow">
				            	</c:if>
				            	<c:choose>
					                <c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
				                    	<c:out value="${result.nttSj}" />
				                	</c:when>
				                	<c:otherwise>
				                        <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
				                        <input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
				                        <input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
				                        <input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
				                        <input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
				                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				                        <span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${result.nttSj}"/>"></span>
				                	</c:otherwise>
				            	</c:choose>
				            </form>
				        	</td>
				        	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
				            	<td class="tdwc"  nowrap="nowrap"><c:out value="${result.ntceBgnde}"/></td>
				            	<td class="tdwc"  nowrap="nowrap"><c:out value="${result.ntceEndde}"/></td>
				        	</c:if>
				        	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
								<!-- 고객자료실 : 담당자, 관리자, Admin -->
					        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
									<td class="tdwc"  nowrap="nowrap"><c:out value="${result.pstinstNm}"/></td>
					        	</c:if>	      	
			            	</c:if>
				        	<c:if test="${anonymous != 'true'}">
				            	<td class="tdwc"  nowrap="nowrap"><c:out value="${result.frstRegisterNm}"/></td>
				        	</c:if>
				        	<td class="tdwc"  nowrap="nowrap"><c:out value="${result.frstRegisterPnttm}"/></td>
				        	<td class="tdwc"  nowrap="nowrap"><c:out value="${result.inqireCo}"/></td>
				    	</tr>
				    	<tr>
				    		<c:choose>
					            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
					            	<td colspan="7" bgcolor="#cdcdcd" height="1"></td>
					            </c:when>
					            <c:otherwise>
					                <c:choose>
					                    <c:when test="${anonymous == 'true'}">
					                        <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
					                    </c:when>
					                    <c:otherwise>
					                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
												<!-- 고객자료실 : 담당자, 관리자, Admin -->
									        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
													<td colspan="6" bgcolor="#cdcdcd" height="1"></td>
									        	</c:if>
									        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									        		<td colspan="5" bgcolor="#cdcdcd" height="1"></td>
									        	</c:if>
							            	</c:if>
							            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
							            		<td colspan="5" bgcolor="#cdcdcd" height="1"></td>
							            	</c:if>
					                    </c:otherwise>
					                </c:choose>     
					            </c:otherwise>
					        </c:choose>
			       		</tr>
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
					    	<c:choose>
					            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
					                <td colspan="7" class="tdwc" nowrap="nowrap"><spring:message code="common.nodata.msg" /></td>
					            </c:when>
					            <c:otherwise>
					                <c:choose>
					                    <c:when test="${anonymous == 'true'}">
					                        <td colspan="4" class="tdwc" nowrap="nowrap"><spring:message code="common.nodata.msg" /></td>
					                    </c:when>
					                    <c:otherwise>
					                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
												<!-- 고객자료실 : 담당자, 관리자, Admin -->
									        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
													 <td colspan="6" class="tdwc" nowrap="nowrap"><spring:message code="common.nodata.msg" /></td>
									        	</c:if>
									        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									        		 <td colspan="5" class="tdwc" nowrap="nowrap"><spring:message code="common.nodata.msg" /></td>
									        	</c:if>
							            	</c:if>
							            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
							            		 <td colspan="5" class="tdwc" nowrap="nowrap"><spring:message code="common.nodata.msg" /></td>
							            	</c:if>
					                    </c:otherwise>
					                </c:choose>     
					            </c:otherwise>
					        </c:choose>       
				          </tr>    
				          <tr>
				    		<c:choose>
					            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
					            	<td colspan="7" bgcolor="#cdcdcd" height="1"></td>
					            </c:when>
					            <c:otherwise>
					                <c:choose>
					                    <c:when test="${anonymous == 'true'}">
					                        <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
					                    </c:when>
					                    <c:otherwise>
					                    	<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000011'}">
												<!-- 고객자료실 : 담당자, 관리자, Admin -->
									        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
													 <td colspan="6" bgcolor="#cdcdcd" height="1"></td>
									        	</c:if>
									        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									        		 <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
									        	</c:if>
							            	</c:if>
							            	<c:if test="${boardVO.bbsId != 'BBSMSTR_000000000011'}">
							            		 <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
							            	</c:if>
					                    </c:otherwise>
					                </c:choose>     
					            </c:otherwise>
					        </c:choose>
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
			                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />  
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 --> 
		        	  	</td>
      	  			</tr>
      	  			<c:if test="${brdMstrVO.authFlag == 'Y'}">
      	  			<tr>
		            	<td align="right" valign="bottom" height="60">
		            		<span class="btnblue"><a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>?bbsId=<c:out value="${boardVO.bbsId}"/>"><spring:message code='button.create'/> ▶</a></span>&nbsp;
		                </td>
		            </tr>
		            </c:if>
        		</table>
        	
        	
        	
        </div>
        <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div> --%>
    <!-- //전체 레이어 끝 -->
 </body>
</html>




