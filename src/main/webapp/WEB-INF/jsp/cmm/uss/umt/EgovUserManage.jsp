<%--
  Class Name : EgovUserManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.boxpadding{
	padding : 0px;
}
</style>
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />" ></script>
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->
<title>사용자관리</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
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
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
        //alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
            document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
            document.listForm.submit();
            document.listForm.action = "";
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];    
    }
    document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();
      
}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnViewCheck(){ 
    if(insert_msg.style.visibility == 'hidden'){
        insert_msg.style.visibility = 'visible';
    }else{
        insert_msg.style.visibility = 'hidden';
    }
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
	    	url : "<c:url value='/select/umt/user/EgovUserManage.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){
	 	   		//Rname Setting   		
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.resultList })
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
    	schema: {
    		id : (value) => value.userTy + ':' + value.uniqId
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
	    height: "480px",
	    captionHeight: 40,
	    rowHeight:40,
	    showCheck:true,
	    columns: [
		{ field: 'userId', caption: "아이디", editable: false, type: 'text', width:10, unit:'%', colCss : "pointer boxpadding"},
		{ field: 'userNm', caption: "이름", editable: false, type: 'text', width:13, unit:'%', colCss : "pointer boxpadding"},
		{ field: 'pstinstNm', caption: "고객사", editable: false, type: 'text', width:15, unit:'%'},
		{ field: 'authorNm', caption: "권한", editable: false, type: 'text', width:8, unit:'%'},
		{ field: 'emailAdres', caption: "이메일", editable: false, type: 'text', width:14, unit:'%'},
		{ field: 'moblphonNo', caption: "전화번호", editable: false, type: 'text', width:10, unit:'%'},
		{ field: 'frstRegistPnttm', caption: "등록일", editable: false, type: 'text', width:10, unit:'%'},
		{ field: 'delAt', caption: "삭제여부", editable: false, type: 'combo', width:5, unit:'%',
			items :[
				{value : 'Y', label : '삭제'},
				{value : 'N', label : '미삭제'},
			]},  
		{ field: 'uniqId', caption: "uniqId", editable: false, type: 'text', width:5, unit:'%', visible : false},  
		{ field: 'userTy', caption: "userTy", editable: false, type: 'text', width:5, unit:'%', visible : false},
		{ field: 'emailYn', caption: "관리자 알림", editable: false, type: 'text', width:5, unit:'%', 
			getValue : (value, field, rowItem) => {
				if (rowItem.data.authorCode == "ROLE_MNGR" ) {
					return value == 'Y' ? '사용' : '미사용';
				} else {
					return '해당없음';
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
  	                	if(command.column && (command.column.field == "userId" || command.column.field == "userNm") ){
  	  	                	var userId = SBGrid3.getValue(grid, command.key, 'userId');
  	  	                	fnSelectUser(userId);
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

function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];    
    }
    //document.listForm.selectedId.value = userId;
    //document.listForm.uniqId.value = userId;
    $("#selectedId").val(id);
    $("#uniqId").val(id);
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();
      
}

function fnDeleteUser() {
    var checkField = SBGrid3.getCheckedKeys(datagrid);
    //var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                //if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + checkField[i]);
                    checkedCount++;
                //}
            }
        } else {
            //if(checkField.checked) {
                checkedIds = checkField[0];
            //}
        }
    }
    if(checkedIds.length > 0) {
        //alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
            document.listForm.checkedIdForDel.value=checkedIds;
            /* document.listForm.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
            document.listForm.submit();
            document.listForm.action = ""; */
            var form = $("#listForm")[0];
    		var formData = new FormData(form);
            $.ajax({        	
    			url : "<c:url value='/uss/umt/user/EgovUserDelete.do'/>"			
    			,type : "POST"
    			,data : formData
    	     	,contentType : false
    	     	,processData : false
    			,beforeSend : fn_loading()
    			,success : function(data){
    				alert(data.msg);
    				if(data.msgType == 'S') {
    					location.replace("<c:url value='/uss/umt/user/EgovUserManage.do'/>"); 
    				} else {
    					location.reload(true);				
    				}
    				 	
    	   	    },
    	   	    error : function(request, status, error){
    				alert("error");
    				location.replace("<c:url value='/uss/umt/user/EgovUserManage.do'/>"); 
    	   	    },
    	   	    complete:function(){
    	   	    	fn_closeLoading();
    	   	    }
    		}); 
        }
    }

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
				<form id="listForm" name="listForm" action="<c:url value='/uss/umt/user/EgovUserManage.do'/>" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible"/>
					<input id="selectedId" name="selectedId" type="hidden" />
					<input id="uniqId" name="uniqId" type="hidden" />
			        <input id="checkedIdForDel" name="checkedIdForDel" type="hidden" />
			        <input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
					  
                <!-- 검색 필드 박스 시작 -->
                <div class="sr-table-wrap">
                	<table class="sr-table">
		                    <colgroup>
		                        <col width="10%">
		                        <col width="23%">
		                        <col width="10%">
		                        <col width="23%">
		                        <col width="10%">
		                        <col width="24%">
		                    </colgroup>
			            <tr>
							<th>
								<sbux-label id="table_label1" name="table_label1" uitype="normal" text="아이디"></sbux-label>
							</th>
							<td>
								<sbux-input name="searchEmplyrId" uitype="text" size="20" value="<c:out value='${searchVO.searchEmplyrId}'/>"  maxlength="60" id="searchEmplyrId" title="검색조건" style="width:100%"/>
							</td>
							<th>
								<sbux-label id="table_label2" name="table_label2" uitype="normal" text="이름"></sbux-label>
							</th>
							<td>
								<sbux-input name="searchUserNm" uitype="text" size="30" value="<c:out value='${searchVO.searchUserNm}'/>"  maxlength="60" id="searchUserNm" title="검색조건" style="width:100%">
							</td>
							<th>
								<sbux-label id="table_label5" name="table_label5" uitype="normal" text="권한" class=""></sbux-label>
							</th>
							<td>
								<sbux-select name="authorCode" id="authorCode" uitype="single" init="<spring:message code='sr.choose' />">
					 				<option value=''><spring:message code='sr.choose' /></option>
		                           	<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
										<option value='<c:out value="${authorManage.authorCode}"/>'><c:out value="${authorManage.authorNm}" /></option>
									</c:forEach>
								 </sbux-select>
							</td>
			            </tr>
			            <tr>
			              <th>
                              <sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.client'/>" class=""></sbux-label>
                          </th>
						<td class="tdleft" width="270px;">
							<sbux-select name="searchPstinstCode" id="searchPstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
				 				<option value=''><spring:message code='sr.choose' /></option>
	                           	<c:forEach var="result" items="${pstinstList}" varStatus="status">
									<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
								</c:forEach>
							 </sbux-select>	
						</td>
			              <th>
                              <sbux-label id="table_label4" name="table_label4" uitype="normal" text="삭제여부" class=""></sbux-label>
                          </th>
			              <td>
			              	<sbux-select name="searchDelAt" id="searchDelAt" uitype="single">
							    <option value="N" selected="selected">미삭제</option>
							    <option value="Y">삭제</option>
							</sbux-select>	
			              </td>
							<th>
								<sbux-label id="table_label6" name="table_label6" uitype="normal" text="관리자 알림" class=""></sbux-label>
							</th>
							<td>
								<sbux-select name="emailYn" id="emailYn" uitype="single">
							    <option value="" selected="selected">선택</option>
							    <option value="N">미사용</option>
							    <option value="Y">사용</option>
							    <option value="X">해당없음</option>
							</sbux-select>
							</td>
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
                    	<sbux-button uitype="normal" text="등록" class="btn-default"  onclick = "javascript:fnAddUserView(); return false;"></sbux-button>                    
                    	<sbux-button uitype="normal" text="삭제" class="btn-default" onclick = "javascript:fnDeleteUser(); return false;"></sbux-button>                    
	                </div>	                
                </div>                 
                <!-- table add start -->
                <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>             

            </div>
            <c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
           </div>
            <!-- //content 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>