<%--
  Class Name : EgovMenuManage.jsp
  Description : 메뉴관리 조회 화면
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
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon";
  String imagePath_button = "/images/egovframework/sym/mpm/button";
%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->

<title>메뉴목록관리</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.menuManageForm.checkField;
    if(document.menuManageForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var checkField = document.menuManageForm.checkField;
    var menuNo = document.menuManageForm.checkMenuNo;
    var checkMenuNos = "";
    var checkedCount = 0;
    
    if(checkField) {
		
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = menuNo.value;
                checkedCount++
            }
        }
        
        if (checkedCount >= 1) {		           	
		    document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
		    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
		    document.menuManageForm.submit(); 
        }else{
        	alert('<spring:message code='common.noChecked.msg'/>');
        }
    }   
    

}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//  document.menuManageForm.searchKeyword.value = 
    document.menuManageForm.pageIndex.value = pageNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuManageList() { 
    document.menuManageForm.pageIndex.value = 1;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
}

/* ********************************************************
 * 일괄처리 화면호출 함수
 ******************************************************** */
/* function bndeInsertMenuManage() {
        document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>";
        document.menuManageForm.submit();   
    }
 */
function bndeInsertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
    document.menuManageForm.submit();
} 
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
    document.menuManageForm.req_menuNo.value = menuNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
}
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuManageSelect(){ 
    document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->


SBGrid3.$(document).ready(function () {
    init(); 
})
var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];

function init(){	
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/mnu/mpm/EgovMenuManageSelect.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#menuManageForm").serialize(),
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
    		id : (value) => value.menuNo
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
	    showCheck:true,
	    columns: [
		{ field: 'menuNo', caption: "메뉴번호", editable: false, type: 'text', width:15, unit:'%', colCss : "pointer"},
		{ field: 'menuNm', caption: "메뉴명", editable: false, type: 'text', width:20, unit:'%', colCss : "pointer"}, 
		{ field: 'progrmFileNm', caption: "프로그램 파일명", editable: false, type: 'text', width:25, unit:'%'}, 
		{ field: 'menuDc', caption: "메뉴설명", editable: false, type: 'text', width:25, unit:'%'}, 
		{ field: 'upperMenuId', caption: "상위메뉴번호", editable: false, type: 'text', width:15, unit:'%'},
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
  	                	if(command.column && (command.column.field == "menuNo" || command.column.field == "menuNm") ){
  	                		
  	  	                	var menuNo = SBGrid3.getValue(grid, command.key, 'menuNo');
  	  	                	if(menuNo) {
  	  	                		selectUpdtMenuManageDetail(menuNo);
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
    SBGrid3.reload(datagrid);
}


/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
	$('#req_menuNo').val('empty');
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
}

/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var menuNos = SBGrid3.getCheckedKeys(datagrid);
    var checkMenuNos = "";
    var checkedCount = 0;
    

    if(menuNos.length > 1) {
        for(var i=0; i < menuNos.length; i++) {
           checkMenuNos += ((checkedCount==0? "" : ",") + menuNos[i]);
           checkedCount++
        }
    } else {
         checkMenuNos = menuNos[0];
         checkedCount++
    }
    
    if (checkedCount >= 1) {		           	
	  document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
	  //document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
	  //document.menuManageForm.submit();
	  
		var form = $("#menuManageForm")[0];
		var formData = new FormData(form);
		              
		$.ajax({        	
			url : "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>"			
			,type : "POST"
			,data : formData
			,contentType : false
			,processData : false
			,beforeSend : fn_loading()
			,success : function(data){
			
				alert(data.msg);
				if(data.msgType == 'S') {
					location.replace("<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>");
				} else {
					location.reload(true);				
				}
			 	
			},
			error : function(request, status, error){
				alert("error");   	            
			},
			complete:function(){
				fn_closeLoading();
			}
		});
	  
	  
    }else{
    	alert('<spring:message code='common.noChecked.msg'/>');
    }
    
}

/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
    document.menuManageForm.req_menuNo.value = menuNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
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
    	<div class="sr-contents-area"> 
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
            
            <div class="sr-breadcrumb-area">                
                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
            </div>
            <div class="btn_right">
                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
            </div>
            
            <form id="menuManageForm" name="menuManageForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" method="post">
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            	<input type="submit" id="invisible" class="invisible"/>
            	<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input id="checkedMenuNoForDel" name="checkedMenuNoForDel" type="hidden" />
				<input id="req_menuNo" name="req_menuNo" type="hidden"  />

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
			              	<sbux-label id="table_label1" name="table_label1" uitype="normal" text="메뉴번호"></sbux-label>
			              </th>
			              <td>
			              	<sbux-input id="searchMenuNo" name="searchMenuNo" uitype="text" size="30" value="<c:out value='${searchVO.searchMenuNo}'/>" style="width:100%" maxlength="60" title="검색조건"/>
			              </td>
			              <th>
			              	<sbux-label id="table_label2" name="table_label2" uitype="normal" text="메뉴명"></sbux-label>
			              </th>
			              <td>
			              	<sbux-input id="searchMenuNm" name="searchMenuNm" uitype="text" size="40" value="<c:out value='${searchVO.searchMenuNm}'/>" style="width:100%" maxlength="60" title="검색조건"/>
			              </td>
			            </tr>
			            <tr>
			              <th>
			              	<sbux-label id="table_label3" name="table_label3" uitype="normal" text="프로그램파일명"></sbux-label>
			              </th>
			              <td colspan="3">
			              	<sbux-input id="searchProgrmFileNm" name="searchProgrmFileNm" uitype="text" size="40" value="<c:out value='${searchVO.searchProgrmFileNm}'/>" style="width:100%"  maxlength="60" title="검색조건"/>
			              </td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
             </form>
                <div class="grid_area">
					<div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">  
		               	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.create" />" onclick="insertMenuManage()" class="btn-default"></sbux-button>
		               	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.delete" />" onclick="fDeleteMenuList()" class="btn-default"></sbux-button>
		            </div>               
                </div>
                
                
                <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
            </div>
            
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
        <!-- //footer 끝 -->
        </div>
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>