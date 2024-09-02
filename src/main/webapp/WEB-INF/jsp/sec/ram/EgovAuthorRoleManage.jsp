<%--
  Class Name : EgovAuthorRoleManage.jsp
  Description : EgovAuthorRoleManage 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<!--<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >-->

<title>권한별 롤 목록</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
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

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var checkRegYn = document.listForm.regYn;
    var returnValue = "";
    var returnRegYns = "";
    var checkedCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                
                    if(returnValue == "") {
                        returnValue = checkField[i].value;
                        returnRegYns = checkRegYn[i].value;
                    }
                    else { 
                        returnValue = returnValue + ";" + checkField[i].value;
                        returnRegYns = returnRegYns + ";" + checkRegYn[i].value;
                    }
                }
            }

            if(checkedCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
             if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnRegYns = checkRegYn.value;

                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue;
    document.listForm.regYns.value = returnRegYns;

    return returnBoolean;

}

function fncSelectAuthorRoleList() {
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = "1";
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorList(){
    document.listForm.searchKeyword.value = "";
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/sec/ram/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddAuthorRoleInsert() {
    if(fncManageChecked()) {
        if(confirm("등록하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>";
            document.listForm.submit();
        }
    } else return;
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
        fncSelectAuthorRoleList();
    }
}
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
	    	url : "<c:url value='/select/ram/EgovAuthorRoleList.do'/>",
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
    		id : (value) => value.roleCode + ':' + value.regYn
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
		{ field: 'roleCode', caption: "롤 ID", editable: false, type: 'text', width:15, unit:'%'},
		{ field: 'roleNm', caption: "롤 이름", editable: false, type: 'text', width:15, unit:'%'},
		{ field: 'roleTyp', caption: "롤 타입", editable: false, type: 'text', width:15, unit:'%'},
		{ field: 'roleSort', caption: "롤 Sort", editable: false, type: 'text', width:10, unit:'%'},
		{ field: 'roleDc', caption: "롤 설명", editable: false, type: 'text', width:20, unit:'%'},
		{ field: 'creatDt', caption: "등록일자", editable: false, type: 'text', width:15, unit:'%'},
		{ field: 'regYn', caption: "등록여부", editable: false, type: 'combo', width:10, unit:'%',
			items :[
				{value : 'Y', label : '등록'},
				{value : 'N', label : '미등록'},
			]}, 
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

function fncAddAuthorRoleInsert() {
    //if(fncManageChecked()) {
        if(confirm("등록하시겠습니까?")) {
        	const id = SBGrid3.getCheckedKeys(datagrid);
        	var checkedCount = 0;
        	var rolesCodes =''; 
        	var regYns = '';
        	
        	
			for(var i = 0 ; i < id.length ; i++) {
				var tempId = id[i].split(':');
				if(tempId[1] == 'N') {
					rolesCodes += ((checkedCount==0? "" : ";") + tempId[0]);
					regYns += ((checkedCount==0? "" : ";") + 'Y');
	                checkedCount++;					
				} else {
					alert("이미 등록된 권한입니다.");
					return
				}				
			}
        	$("#roleCodes").val(rolesCodes);
        	document.listForm.regYns.value = regYns;
            //document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>";
            //document.listForm.submit();
            
            var form = $("#listForm")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.reload(true);
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
            
            
        } else return
    //} else return;
}

function fncAddAuthorRoleDelete() {
    //if(fncManageChecked()) {
        if(confirm("등록 취소 하시겠습니까?")) {
        	const id = SBGrid3.getCheckedKeys(datagrid);
        	var checkedCount = 0;
        	var rolesCodes =''; 
        	var regYns = '';
			for(var i = 0 ; i < id.length ; i++) {
				var tempId = id[i].split(':');
				if(tempId[1] == 'Y') {
					rolesCodes += ((checkedCount==0? "" : ";") + tempId[0]);
					regYns += ((checkedCount==0? "" : ";") + 'N');
	                checkedCount++;					
				} else {
					alert("이미 등록 취소된 권한입니다.");
					return
				}				
			}
			$("#roleCodes").val(rolesCodes);
        	document.listForm.regYns.value = regYns;
            //document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>";
            //document.listForm.submit();
            var form = $("#listForm")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.reload(true);
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
        }else return
    //} else return;
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
           
            <form id="listForm" name="listForm" action="<c:url value='/sec/ram/EgovAuthorRoleList.do'/>" method="post">
            	<input type="hidden" id="${_csrf.parameterName }" name="${_csrf.parameterName }" value="${_csrf.token }" />
            	<input type="hidden" id="roleCodes" name="roleCodes"/>
				<input type="hidden" id="regYns" name="regYns"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${authorRoleManageVO.pageIndex}'/>"/>
				<input type="hidden" id="authorCode" name="authorCode" value="<c:out value="${authorRoleManageVO.searchKeyword}"/>"/>
				<input type="hidden" id="searchCondition" name="searchCondition"/>
				
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
								<sbux-label id="table_label1" name="table_label1" uitype="normal" text="권한명"></sbux-label>	              			
							</th>
			              <td style = "border-right : 0px">
			              	<sbux-input id="searchKeyword" name="searchKeyword" uitype="text" size="30" value="<c:out value='${authorRoleManageVO.searchKeyword}'/>" title="검색"  onkeypress="press();" readonly style="width : 100%" />
			              </td>
			              <td style = "border-right : 0px; border-left : 0px;"></td>
			              <td style = "border-left : 0px;"></td>
			            </tr>
			            </tbody>
			          </table>
                </div>             
                <!-- //검색 필드 박스 끝 -->
               </form>
               <div class="grid_area">
               
                </div>
               <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
               <div class="btn_buttom">   
                    <sbux-button id="button1" name="button1" uitype="normal" text="권한목록" onclick="fncSelectAuthorList();" class="btn-default"></sbux-button>    
                    <sbux-button id="button2" name="button2" uitype="normal" text="권한별 목록 재조회" onclick="fncSelectAuthorRoleList();" class="btn-default"></sbux-button> 
                    <sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.create"/>" onclick="fncAddAuthorRoleInsert();" class="btn-default"></sbux-button>                 
                    <sbux-button id="button4" name="button4" uitype="normal" text="등록취소" onclick="fncAddAuthorRoleDelete();" class="btn-default"></sbux-button>                 
                </div>
                
                </div>
                
				     
            </div>
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
        </div>
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>