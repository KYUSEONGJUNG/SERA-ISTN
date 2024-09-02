<%--
  Class Name : EgovMenuCreatManage.jsp
  Description : 메뉴생성관리 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >

<title>메뉴권한관리</title>

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
var menuList = [];
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
	    	url : "<c:url value='/select/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#menuCreatManageForm").serialize(),
	   	    success : function(data){	   	    	
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
		{ field: 'authorCode', caption: "권한코드", editable: false, type: 'text', valign: 'center' , width:30, unit:'%'},
		{ field: 'authorNm', caption: "권한명", editable: false, type: 'text', width:20, unit:'%', colCss : "pointer"},
		{ field: 'authorDc', caption: "권한설명", editable: false, type: 'text', width : 30, unit:'%'},
		{ field: 'chkYeoBu', caption: "권한설정여부", editable: false, type: 'text', width:10, unit:'%'
			,getValue : (value, field, rowItem) => {
				if(value > 0){
					return "Y";
				}
				return "N";
			}
        },
		{ field: 'setting', caption: "권한설정", editable: false, type: 'text', width:10, unit:'%' ,colCss: "pointer"
        	,getValue : (value, field, rowItem) => {
				return "설정";
			} 
       	}
        ],
		showRowNo:false,
		virtualRow:false,
		resizable: {
			mode: "column",
			minWidth: 10, 
			maxWidth: 700, 
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
  	                	if(command.column && command.column.field == "setting"){
  	                		var authorCode = SBGrid3.getValue(grid, command.key, 'authorCode');
  	                		var authorNm = SBGrid3.getValue(grid, command.key, 'authorNm');
  	                		if(authorCode) selectMenuCreat(authorCode,authorNm);
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

/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){ 
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.menuCreatManageForm.pageIndex.value = pageNo;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() { 
    document.menuCreatManageForm.pageIndex.value = 1;
    //document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    //document.menuCreatManageForm.submit();
    
    SBGrid3.reload(datagrid);
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat_bak(vAuthorCode) {
    document.menuCreatManageForm.authorCode.value = vAuthorCode;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
    window.open("#", "_menuCreat", "scrollbars = yes, top=100px, left=100px, height=700px, width=850px");    
    document.menuCreatManageForm.target = "_menuCreat";
    document.menuCreatManageForm.submit();  
}

function selectMenuCreat(authorCode,authorNm){
	$("#authorCode").val(authorCode);
	$("#authorNm").val(authorNm);
	
	$.ajax({
    	url : "<c:url value='/select/sym/mnu/mcm/EgovMenuCreatSelect.do'/>",
   	    type : 'POST',
   	    //dataType : "json",
   	    //contentType:"application/json",
   	    data : {
   	    	"${_csrf.parameterName }" : "${_csrf.token }"
   	    	,"authorCode" : authorCode
   	    },
   	    success : function(data){
   	    	menuList = data.resultList;
   	    	
   	    	for(var i in menuList){   	    		
   	    		menuList[i].checked = menuList[i].chkYeoBu == 1;
   	    	}
   	    	SBUxMethod.refresh('menuTree');
 	   		SBUxMethod.openModal('modalMenu'); 		
   	    },
   	    error : function(request, status, error){
			alert("error");   	            
   	    },
   	    complete:function(){
   	    	
   	    }
	});
	
	/* var url = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode="+vAuthorCode;
	var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=1000,height=700,left=0,top=0";
	window.open(url,"_menuCreat", openParam); */
}
function fnTreeChange(){
	var status = SBUxMethod.getTreeStatus('menuTree')[0];
	for(var i in menuList){
		if(menuList[i].menuNo == status.id){
			menuList[i].chkYeoBu = status.checked ? 1 : 0;
			break;
		}	
	}
}
function fInsertMenuCreat() {
    
    var checkMenuNos = "";
    var checkedCount = 0;
    
    
    for(var i in menuList){
    	if(menuList[i].chkYeoBu) {
    		if(checkMenuNos) checkMenuNos += ",";
    		checkMenuNos += menuList[i].menuNo;
    	}
    }
    
    document.modalMenuForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.modalMenuForm.checkedAuthorForInsert.value=document.modalMenuForm.authorCode.value;
    
    $.ajax({
    	url : "<c:url value='/insert/sym/mnu/mcm/EgovMenuCreatInsert.do'/>",
   	    type : 'POST',
   	    //dataType : "json",
   	    //contentType:"application/json",
   	    data : $("#modalMenuForm").serialize(),
   	    beforeSend : function(){
   	    	fn_loading();
   	    },
   	    success : function(data){
   	    	alert(data.resultMsg);
   	    	SBGrid3.reload(datagrid);
   	    },
   	    error : function(request, status, error){
			alert("error");   	            
   	    },
   	    complete:function(){
   	    	SBUxMethod.closeModal("modalMenu");
   	    	fn_closeLoading();
   	    }
	});
}


</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
	<div class="sr-contents-wrap">
        <c:import url="/sym/mms/EgovMainMenuLeft.do" />
        <%-- <c:import url="/EgovPageLink.do?link=main/inc/incLeftmenu" /> --%>
        <div class="sr-contents-area">
	        <div class="sr-contents">
	            <div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="selectMenuCreatManageList()" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
	            <form name="menuCreatManageForm" id="menuCreatManageForm" action="<c:url value='/sr/EgovSrList.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />  
				
	            <div class="sr-table-wrap">
	                <table class="sr-table">
	                    <colgroup>
	                        <col width="15%">
	                        <col width="35%">
	                        <col width="15%">
	                        <col width="35%">
	                    </colgroup>
	                    <tbody>                       
	                        <tr>
	                            <th>
	                                <sbux-label id="table_label1" name="table_label1" uitype="normal" text="권한코드"></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-input id="searchAuthorCode" name="searchAuthorCode" uitype="text" style = "width:100%" value="<c:out value='${searchVO.searchAuthorCode}'/>">
	                                </sbux-input>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="권한명" class=""></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-input id="searchAuthorNm" name="searchAuthorNm" uitype="text" style = "width:100%" value="<c:out value='${searchVO.searchAuthorNm}'/>">
	                                </sbux-input>
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
	            </div>
	
	            <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
<!-- Menu Tree Modal -->
<sbux-modal id="modalMenu" name="modalMenu" 
			uitype="middle" 
			header-title="권한설정" 
			body-html-id="modalBody"
			footer-html='<sbux-button uitype="normal" text="저장" class="btn-default" image-style="width:15px;height:13px;" style ="margin-right : 5px;" onclick = "fInsertMenuCreat();"></sbux-button>'>

</sbux-modal>
<div id="modalBody">
	<div class="sr-contents-wrap" style = "min-width : 0px;">
		<div class="sr-contents-area" style = "left:0px; width: 100%; position: relative; max-width : 100%; max-height:100%; overflow-x : hidden; overflow-y : hidden;">
	        <div class="sr-contents">
	            <form name="modalMenuForm" id="modalMenuForm"  method="post">
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input name="checkedMenuNoForInsert" type="hidden" >
				<input name="checkedAuthorForInsert"  type="hidden" >
	            <div class="sr-table-wrap">
	                <table class="sr-table">
	                    <colgroup>
	                        <col width="15%">
	                        <col width="35%">
	                        <col width="15%">
	                        <col width="35%">
	                    </colgroup>
	                    <tbody>                       
	                        <tr>
	                            <th>
	                                <sbux-label id="table_label1" name="table_label1" uitype="normal" text="권한코드"></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-input id="authorCode" name="authorCode" uitype="text" style = "width:100%" value="" readonly>
	                                </sbux-input>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="권한명" class=""></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-input id="authorNm" name="authorNm" uitype="text" style = "width:100%" value="" readonly>
	                                </sbux-input>
	                            </td>
	                        </tr>
	                        <tr >
	                        	<th>
	                        		<sbux-label id="table_label1" name="table_label1" uitype="normal" text="메뉴"></sbux-label>
	                        	</th>
	                        	<td colspan = '3'>
	                        		<sbux-tree id="menuTree" name="menuTree" uitype="checkbox" jsondata-ref="menuList"  style = "max-height: 500px; overflow-y: scroll;"
	                        			jsondata-text="menuNm"
	                        			jsondata-value="menuNo"
	                        			jsondata-order="menuOrdr"
	                        			jsondata-id="menuNo"
	                        			jsondata-pid="upperMenuId"
	                        			is-expand="true"
	                        			show-parent-checkbox="true"
	                        			traverse-up-check="false"
	                        			onchange="fnTreeChange(menuList)">
									</sbux-tree>
	                        	</td>
	                        	
	                        </tr>                
	                    </tbody>
	                </table>
	            </div><!--검색조건-->
	            </form>
            </div>
        </div>
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
            <form name="menuCreatManageForm" action ="<c:url value='/sym/mpm/EgovMenuCreatManageSelect.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>메뉴관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>메뉴권한관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>메뉴권한관리</strong></h2></div> -->
					
<!-- 						<input name="checkedMenuNoForDel" type="hidden" /> -->
<!-- 						<input name="authorCode"          type="hidden" /> -->
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                     <label for="searchAuthorCode">권한코드 : </label> -->
                                    <input name="searchAuthorCode" type="text" size="40" value="<c:out value='${searchVO.searchAuthorCode}'/>"  maxlength="60" title="검색조건"/>                                    
<!--                                     <br> -->
<!--                                     <label for="searchAuthorNm">권한명 &nbsp;&nbsp;&nbsp;: </label> -->
                                    <input name="searchAuthorNm" type="text" size="40" value="<c:out value='${searchVO.searchAuthorNm}'/>"  maxlength="60" title="검색조건"/> 
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
                                        <a href="#LINK" onclick="javascript:selectMenuCreatManageList(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
<!--                                     </div>                               -->
<!--                                 </li> -->
<!--                             </ul>            -->
<!--                         </div>           -->
<!--                         </fieldset> -->
<!--                 </div> -->
                <!-- //검색 필드 박스 끝 -->
                
                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="5" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">권한코드</td>
			              <td class="tdleft">
			              	<input name="searchAuthorCode" type="text" size="40" value="<c:out value='${searchVO.searchAuthorCode}'/>"  maxlength="60" title="검색조건"/> 
			              </td>
			              <td class="tdblue">권한명</td>
			              <td class="tdleft">
			              	<input name="searchAuthorNm" type="text" size="40" value="<c:out value='${searchVO.searchAuthorNm}'/>"  maxlength="60" title="검색조건"/> 
			              </td>
			              <td align="center"><a href="#LINK" onclick="javascript:selectMenuCreatManageList(); return false;"><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
                
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			                
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 메뉴권한관리</li>
			        </ul>
			      </div> 
                
                <!-- table add start -->
                <div class="list3">
                    <table width="980" summary="메뉴생성관리  목록화면으로 권한코드, 권한명, 권한설명, 메뉴생성여부, 메뉴생성으로 구성됨" cellpadding="0" cellspacing="0">
                    <caption>메뉴생성관리 목록</caption>
                    <colgroup>
                    <col width="20%" >
                    <col width="20%" >  
                    <col width="20%" >
                    <col width="20%" >
                    <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
			        	  <td colspan="5" bgcolor="#0257a6" height="2"></td>
			       	  </tr>
                    <tr class="tdgrey">
                        <th scope="col" nowrap="nowrap">권한코드</th>
                        <th scope="col" nowrap="nowrap">권한명</th>
                        <th scope="col" nowrap="nowrap">권한설명</th>
                        <th scope="col" nowrap="nowrap">권한설정여부</th>
                        <th scope="col" nowrap="nowrap">권한설정</th>
                    </tr>
                    <tr>
			        	  <td colspan="5" bgcolor="#717171" height="1"></td>
			       	  </tr>
			          <tr>
			        	  <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
			       	  </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${list_menumanage}" varStatus="status">
                    <!-- loop 시작 -->   
                      <c:if test="${result.authorCode != 'ROLE_ANONYMOUS'}">    
	                      <tr>
						    <td class="tdwc" nowrap="nowrap"  ><c:out value="${result.authorCode}"/></td>
						    <td class="tdwc" nowrap="nowrap"  ><c:out value="${result.authorNm}"/></td>
						    <td class="tdwc" nowrap="nowrap"  ><c:out value="${result.authorDc}"/></td>
						    <td class="tdwc" nowrap="nowrap"  >
						          <c:if test="${result.chkYeoBu > 0}">Y</c:if>
						          <c:if test="${result.chkYeoBu == 0}">N</c:if>
						    </td>
						    <td class="tdwc" nowrap="nowrap" >
	                            <a href="<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode='<c:out value="${result.authorCode}"/>'"  onclick="selectMenuCreat('<c:out value="${result.authorCode}"/>'); return false;">설정</a>
						    </td>
	                      </tr>
                          <tr>
				        	  <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
				       	  </tr>                         
                      </c:if>
                     </c:forEach>   
                     <c:if test="${fn:length(list_menumanage) == 0}">
                      <tr>
                        <td nowrap colspan="5"><spring:message code="common.nodata.msg" /></td>  
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
			        </table>
                    
                    
                </div>

                <!-- 페이지 네비게이션 시작 -->
<!--                 <div id="paging_div"> -->
<!--                     <ul class="paging_align"> -->
                        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  

                <input type="hidden" name="req_menuNo">
                
				<input name="checkedMenuNoForDel" type="hidden" />
				<input name="authorCode"          type="hidden" />
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>     
				           
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