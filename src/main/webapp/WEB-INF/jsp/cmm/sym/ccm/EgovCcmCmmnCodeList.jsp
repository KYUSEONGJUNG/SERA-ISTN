<%--
  Class Name : EgovCcmCmmnCodeList.jsp
  Description : EgovCcmCmmnCodeList 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%
 /**
  * @Class Name  : EgovCcmCmmnCodeList.jsp
  * @Description : EgovCcmCmmnCodeList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *  
  */
%>

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


<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>

<title>공통코드관리</title>
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
/* function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
    
} */
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(){
    location.href = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(codeId){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeDetail.do'/>";
    varForm.codeId.value     = codeId;
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    // 
}
function press(event) {
    if (event.keyCode==13) {
        fn_egov_select_noticeList('1');
    }
}

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
			 url : "<c:url value='/select/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>",
			 type : "POST",
			 data : $("#listForm").serialize(),
			 success :function(data) {
				 //Rename Setting
				 resolve({total: data.paginationInfo.totalRecordCount, selected: data.resultList });
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
	    pageSize: 10
	};
	
	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "480px",
	    captionHeight: 40,
	    rowHeight:40,
	    columns: [
	        { field: 'rnum', caption: "순번", editable: false, type: 'text', valign: 'center' , width:10, unit:'%', colCss : "pointer"},
	        { field: 'codeId', caption: "코드ID", editable: false, type: 'text', align: 'center', width:45, unit:'%', colCss : "pointer"},
	        { field: 'codeIdNm', caption: "코드명", editable: false, type: 'text', width:35, unit:'%'},
	        { field: 'useAt', caption: "<spring:message code='cop.useAt' />", editable: false, type: 'text', width:10, unit:'%'
	        	,getValue : (value, field, rowItem) => {
					if(value == "Y"){
						return "사용";
					}
					return "미사용";
				}},
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
	                	if(command.column && (command.column.field == "rnum" || command.column.field == "codeId") ){
	  	                	//var srNo = SBGrid3.getValue(grid, command.key, 'srNo');
	  	                	var codeId = SBGrid3.getValue(grid, command.key, 'codeId');
	  	           			if(codeId) {
	  	           				fnDetail(codeId);
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
 	SBGrid3.reload(datagrid);
} 
</script>
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
				
				<form name="listForm" id="listForm" action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
	                <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> 
	                <input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
					<%-- <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />  --%>
	                <%-- <input type="hidden" name="searchAt" value="<c:out value='${CmmnCodeVO.searchAt}'/>" /> --%>
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
		                   
		                    	<tr >
		                    		<th>
		                    			<sbux-label id="table_label1" name="table_label1" uitype="normal" text="코드ID"></sbux-label>
		                    		</th>
		                    		<td >
		                                <sbux-input name="searchCodeId" type="text" style = "width : 100%;" value='<c:out value="${searchVO.searchCodeId}"/>' maxlength="35"  title="검색어 입력">
		                            </td>
		                            <th>
		                    			<sbux-label id="table_label2" name="table_label2" uitype="normal" text="코드ID명"></sbux-label>
		                    		</th>
		                    		<td >
		                                <sbux-input name="searchCodeIdNm" type="text" style = "width : 100%;" value='<c:out value="${searchVO.searchCodeIdNm}"/>' maxlength="35"  title="검색어 입력">
		                            </td>
		                    	
		                    	
		                    	</tr>
		                    	
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
						<sbux-button uitype="normal" text="<spring:message code='button.create' />" class="btn-default"  onclick = "javascript:fnRegist(); return false;"></sbux-button>                    
	                	
	                </div>	                
                </div>
				<!-- 서비스별 결과 -->
				<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
				
				<form name="Form" method="post" action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeDetail.do'/>">
				    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				    <input type=hidden name="codeId">
				    <input type="submit" id="invisible" class="invisible"/>
				    
				    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				    <input name="searchCodeId" type="hidden" value="<c:out value='${searchVO.searchCodeId}'/>"/>
					<input name="searchCodeIdNm" type="hidden" value="<c:out value='${searchVO.searchCodeIdNm}'/>"/>
				</form>				
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>
	
<%-- <!-- 전체 레이어 시작 -->
<div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
            <form name="listForm" action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
            
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>공통코드관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="5" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">코드ID</td>
			              <td class="tdleft">
			              	<input name="searchCodeId" type="text" size="30" value="<c:out value='${searchVO.searchCodeId}'/>"  maxlength="60" id="F1" title="검색조건"> 
			              </td>
			              <td class="tdblue">코드ID명</td>
			              <td class="tdleft">
			              	<input name="searchCodeIdNm" type="text" size="40" value="<c:out value='${searchVO.searchCodeIdNm}'/>"  maxlength="60" id="F1" title="검색조건"> 
			              </td>
			              <td align="center"><a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                                
                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>공통코드 목록</strong></h2></div> -->
                        
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                 	<label for="searchCodeId">코드ID &nbsp; &nbsp;: </label> -->
                                    <input name="searchCodeId" type="text" size="30" value="<c:out value='${searchVO.searchCodeId}'/>"  maxlength="60" id="F1" title="검색조건">
<!-- 						  			<br> -->
<!--                                     <label for="searchCodeIdNm">코드ID명 : </label> -->
                                    <input name="searchCodeIdNm" type="text" size="40" value="<c:out value='${searchVO.searchCodeIdNm}'/>"  maxlength="60" id="F1" title="검색조건"> 
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
                                        <a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
<!--                                         <a href="#LINK" onclick="fnRegist(); return false;">등록</a>  -->
<!--                                     </div>                               -->
<!--                                 </li> -->
<!--                             </ul>            -->
<!--                         </div>           -->
<!--                         </fieldset> -->
<!--                 </div> -->
                <!-- //검색 필드 박스 끝 -->
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 공통코드관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="분류명, 코드ID, 코드ID명, 사용여부를 가지고있는 공통코드 목록 테이블이다." cellpadding="0" cellspacing="0">
                    <caption>공통코드 목록</caption>
                    <colgroup>
                    <col width="10%" >
                    <col width="30%" >  
                    <col width="30%" >
                    <col width="45%" >
                    <col width="15%" >
                    </colgroup>
                    <thead>
                    <tr>
		        	  <td colspan="4" bgcolor="#0257a6" height="2"></td>
		       	  </tr>
		        	<tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
<!--                         <th scope="col" nowrap="nowrap">분류명</th> -->
                        <th scope="col" nowrap="nowrap">코드ID</th>
                        <th scope="col" nowrap="nowrap">코드명</th>
                        <th scope="col" nowrap="nowrap">사용여부</th>
                    </tr>
                    <tr>
                        <td colspan="4" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.codeId}');">
						    <td nowrap="nowrap" class="tdwc"><strong><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></strong></td>
						    <td nowrap="nowrap">${resultInfo.clCodeNm}</td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.codeId}</td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.codeIdNm}</td>
						    <td nowrap="nowrap" class="tdwc"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
						</tr>   
						<tr>
						    <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                            <td colspan=4>
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
			        	  <td align="center";>
							<!-- 페이지 네비게이션 시작 -->
			                <div id="paging_div">
			                    <ul class="paging_align">
							        <ui:pagination paginationInfo = "${paginationInfo}"
							                type="image"
							                jsFunction="linkPage"
							                />
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 -->  			                
			        	  </td>
			      	  </tr>
			        	<tr>
			            	<td align="right" valign="bottom" height="60">
			                <span class="btnblue"><a href="#LINK" onclick="fnRegist(); return false;"><spring:message code="button.create" /> ▶</a></span>&nbsp;
			                </td>
			            </tr>
			        </table>
			                            
                </div>

                <!-- 페이지 네비게이션 시작 -->
<!--                 <div id="paging_div"> -->
<!--                     <ul class="paging_align"> -->
				        <ui:pagination paginationInfo = "${paginationInfo}"
				                type="image"
				                jsFunction="linkPage"
				                />
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>
            
			<form name="Form" method="post" action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeDetail.do'/>">
			    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			    <input type=hidden name="codeId">
			    <input type="submit" id="invisible" class="invisible"/>
			    
			    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			    <input name="searchCodeId" type="hidden" value="<c:out value='${searchVO.searchCodeId}'/>"/>
				<input name="searchCodeIdNm" type="hidden" value="<c:out value='${searchVO.searchCodeIdNm}'/>"/>
			</form>

            </div>
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div> --%>
    <!-- //전체 레이어 끝 -->
 </body>
</html>