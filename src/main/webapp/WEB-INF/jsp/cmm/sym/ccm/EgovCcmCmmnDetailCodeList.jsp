<%--
  Class Name : EgovCcmCmmnDetailCodeList.jsp
  Description : EgovCcmCmmnDetailCodeList 화면
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

<title>상세코드관리</title>
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
			 url : "<c:url value='/select/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>",
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
	        { field: 'rnum', caption: "순번", editable: false, type: 'text', valign: 'center' , width:5, unit:'%', colCss : "pointer"},
	        { field: 'codeId', caption: "코드ID", editable: false, type: 'text', align: 'center', width:20, unit:'%', colCss : "pointer"},
	        { field: 'codeIdNm', caption: "코드ID명", editable: false, type: 'text', align: 'center', width:25, unit:'%', colCss : "pointer"},
	        { field: 'code', caption: "코드", editable: false, type: 'text', align: 'center', width:20, unit:'%', colCss : "pointer"},
	        { field: 'codeNm', caption: "코드명", editable: false, type: 'text', width:25, unit:'%'},
	        { field: 'useAt', caption: "<spring:message code='cop.useAt' />", editable: false, type: 'text', width:5, unit:'%'
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
	                	if(command.column && (command.column.field == "rnum" || command.column.field == "codeId" || command.column.field == "code" || command.column.field == "codeIdNm" || command.column.field == "codeNm") ){
	  	                	//var srNo = SBGrid3.getValue(grid, command.key, 'srNo');
	  	                	var codeId = SBGrid3.getValue(grid, command.key, 'codeId');
	  	                	var code = SBGrid3.getValue(grid, command.key, 'code');
	  	                	if(codeId) {
	  	                		fnDetail(codeId,code);
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
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fnSearch(){
   /*  document.listForm.pageIndex.value = 1;
    document.listForm.submit(); */
	SBGrid3.reload(datagrid);
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(){
	var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do'/>";
    varForm.submit();
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
function fnDetail(codeId, code){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeDetail.do'/>";
    varForm.codeId.value     = codeId;
    varForm.code.value       = code;
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    // 
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
				
				<form name="listForm" id="listForm" action="<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
	                <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" /> 
	                <input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
	                <input type="hidden" name="cmd" value=""/>
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
		                    			<sbux-label id="table_label2" name="table_label2" uitype="normal" text="코드"></sbux-label>
		                    		</th>
		                    		<td >
		                                <sbux-input name="searchCode" type="text" style = "width : 100%;" value='<c:out value="${searchVO.searchCode}"/>' maxlength="35"  title="검색어 입력">
		                            </td>		                    	
		                    	</tr>
		                    	<tr>
		                    		<th>
		                    			<sbux-label id="table_label3" name="table_label3" uitype="normal" text="코드명"></sbux-label>
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
				<form name="Form" method="post" >
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	                <input type=hidden name="codeId">
	                <input type=hidden name="code">
	                <input type=hidden name="cmd">
	                <input type="submit" id="invisible" class="invisible"/>
	                
	                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				    <input name="searchCodeId" type="hidden" value="<c:out value='${searchVO.searchCodeId}'/>"/>
				    <input name="searchCode" type="hidden" value="<c:out value='${searchVO.searchCode}'/>"/>
					<input name="searchCodeIdNm" type="hidden" value="<c:out value='${searchVO.searchCodeIdNm}'/>"/>
           		</form>	
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
            <form name="listForm" action="<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>상세공통코드관리</strong></li> -->
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
			              <td class="tdblue">코드</td>
			              <td class="tdleft">
			              	<input name="searchCode" type="text" size="30" value="<c:out value='${searchVO.searchCode}'/>"  maxlength="60" id="F1" title="검색조건">
			              </td>
			              <td rowspan="3" align="center"><a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">코드명</td>
			              <td width="270" class="tdleft" colspan="3">
			              	<input name="searchCodeIdNm" type="text" size="40" value="<c:out value='${searchVO.searchCodeIdNm}'/>"  maxlength="60" id="F1" title="검색조건">
			              </td>
			            <tr>
			              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
                
                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>상세코드관리 목록</strong></h2></div> -->
					
					
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                     <label for="searchCodeId">코드ID : </label> -->
                                    <input name="searchCodeId" type="text" size="30" value="<c:out value='${searchVO.searchCodeId}'/>"  maxlength="60" id="F1" title="검색조건">
<!-- 						  			<br> -->
<!--                                     <label for="searchCode">코드 &nbsp;&nbsp;&nbsp;: </label> -->
                                    <input name="searchCode" type="text" size="30" value="<c:out value='${searchVO.searchCode}'/>"  maxlength="60" id="F1" title="검색조건">
<!--                                     <br> -->
<!--                                     <label for="searchCodeIdNm">코드명 : </label> -->
                                    <input name="searchCodeIdNm" type="text" size="40" value="<c:out value='${searchVO.searchCodeIdNm}'/>"  maxlength="60" id="F1" title="검색조건"> 
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="position:absolute;left:870px;top:185px;"> -->
                                        <a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
<!--                                         <a href="#LINK" onclick="fnRegist(); return false;">등록</a> -->
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
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 상세코드관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="코드ID, 코드, 코드명, 사용여부를 나타내는 공통상세코드 목록 테이블이다." cellpadding="0" cellspacing="0">
                    <caption>상세코드관리 목록</caption>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="30%" >
                    <col width="30%" >
                    <col width="10%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="5" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">코드ID</th>
                        <th scope="col" nowrap="nowrap">코드</th>
                        <th scope="col" nowrap="nowrap">코드명</th>
                        <th scope="col" nowrap="nowrap">사용여부</th>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.codeId}','${resultInfo.code}');">
						    <td nowrap="nowrap" class="tdwc"><strong><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></strong></td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.codeId}</td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.code}</td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.codeNm}</td>
						    <td nowrap="nowrap" class="tdwc"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
						</tr>   
						<tr>
						    <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                            <td colspan=5>
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
			        	  <a href="#"><img src="<c:url value='/' />images/sr/btn_prev.gif" width="59" height="21" align="absmiddle" />&nbsp;&nbsp; 1</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a href="#">2 &nbsp;&nbsp;<img src="<c:url value='/' />images/sr/btn_next.gif" width="59" height="21" border="0" align="absmiddle" /></a>
							
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
				        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>
            
            <form name="Form" method="post" >
                <input type=hidden name="codeId">
                <input type=hidden name="code">
                <input type="submit" id="invisible" class="invisible"/>
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			    <input name="searchCodeId" type="hidden" value="<c:out value='${searchVO.searchCodeId}'/>"/>
			    <input name="searchCode" type="hidden" value="<c:out value='${searchVO.searchCode}'/>"/>
				<input name="searchCodeIdNm" type="hidden" value="<c:out value='${searchVO.searchCodeIdNm}'/>"/>
            </form>

            </div>
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
    <a href="http://stt.catholic.ac.kr/common/juso/AjaxRequestXML.jsp">aaa</a>  --%>
 </body>
</html>