<%--
  Class Name : EgovSrList.jsp
  Description : EgovSrList 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
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

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" /> --%>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />"></script>
<meta http-equiv="Content-Language" content="ko">
<title><spring:message code='sr.menu.list' /></title>
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
var initFlag = "y";
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

	SBUxMethod.set('searchConfirmDate',"<c:out value='${searchVO.searchConfirmDateF}'/>,<c:out value='${searchVO.searchConfirmDateT}'/>");
	SBUxMethod.set('searchCompleteDate',"<c:out value='${searchVO.searchCompleteDateF}'/>,<c:out value='${searchVO.searchCompleteDateT}'/>");
	
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	fnDateChk();
    	if(!initFlag) $("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/sr/EgovSrList.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){	   	    	    	
	 	   		//Rname Setting
	   	    	if(srLanguage == 'en' || srLanguage == 'cn'){
	   	    		for(var i in data.resultList){
	   	    			data.resultList[i].rname = data.resultList[i].rnameEn;			
	   	    		}
	   	    	}
	 	   		
	 	   		if((Number(payload.pageNo)) >  (data.paginationInfo.totalRecordCount / payload.pageSize ) ){
	 	   			datagrid.setPageNo(0);
	 	   		}
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.resultList })
	 	   		$("#totalCnt").text(data.paginationInfo.totalRecordCount.toLocaleString());
	 	   		$("#realExpectTimeSum").text(data.realExpectTimeSum ? Number(data.realExpectTimeSum).toLocaleString() : 0 );	 	   		
	 	   		
	 	   		
	 	   		var statusBar = $(".pr-text02");
	 	   		
	 	   		for(var i in statusBar){
	 	   			$("#"+statusBar[i].id).html("0 <span><spring:message code='sr.msg.cnt'/></span>");
	 	   		}
	 	   		
	 	   		for(var i in data.srCntList){
	 	   			$("#status"+data.srCntList[i].status).html(data.srCntList[i].cnt + "<span><spring:message code='sr.msg.cnt'/></span>");
	 	   		}	 	   		
		 	   	
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
	    height: "450px",
	    captionHeight: 30,
	    rowHeight:36,
	    columns: [
		{ field: 'srNo', caption: "<spring:message code='sr.srNumber'/>", editable: false, type: 'text', valign: 'center' , width:8, unit:'%', colCss : "pointer" },
		{ field: 'subject', caption: "<spring:message code='cop.nttSj' />", editable: false, type: 'text', align: 'left', width:32, unit:'%', colCss : "pointer"},
		{ field: 'priority', caption: "<spring:message code='sr.priority' />", editable: false, type: 'text', width:7, unit:'%'
			,getValue : (value, field, rowItem) => {
				var text = "";
				if(value == "1002"){
					text = "<spring:message code='sr.normal' />";
				}else if(value == "1001"){
					text = "<spring:message code='sr.urgent' />";
				}else if(value == "1000"){
					text = "<spring:message code='sr.veryUrgent' />";
				}				
				return text;
			}},
		{ field: 'pstinstNm', caption: "<spring:message code='sr.client' />", editable: false, type: 'text', width:11, unit:'%'},
		{ field: 'moduleCode', caption: "<spring:message code='sr.module' />", editable: false, type: 'combo'
		 	,items : moduleData, width:6, unit:'%'},
		{ field: 'status', caption: "<spring:message code='sr.status' />", editable: false, type: 'combo'
		 	,items : statusData, width:8, unit:'%'
		 	,colCss: (data) => {
	            
	             return 'state'+data.status.substring(2);
	            
        	}},
		{ field: 'customerNm', caption: "<spring:message code='sr.requester' />", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'rname', caption: "<spring:message code='sr.charge' />", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'signDate', caption: "<spring:message code='sr.requestDate'/>", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'hopeDate', caption: "<spring:message code='sr.completeHopeDate'/>", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'scheduleDate', caption: "<spring:message code='sr.expectedCompletionDate'/>", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'testCompleteDate', caption: "<spring:message code='sr.completionDate'/>", editable: false, type: 'text', width:9, unit:'%'},
		{ field: 'tat', caption: "<spring:message code='sr.customerConfirm'/>", editable: false, type: 'text', width:80, visible : false},
		{ field: 'realExpectTime', caption: "<spring:message code='sr.realLabourHours2'/>", editable: false, type: 'text', width:5, unit:'%'},
		//{ field: 'point', caption: "<spring:message code='cop.satisfaction.stsfdg'/>", editable: false, type: 'text', width:60}   
        ],
        <c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
        showCheck:true,
		</c:if>
		showRowNo:false,
		virtualRow:false,
		resizable: {
			mode: "column",
			minWidth: 10, 
			maxWidth: 1000, 
			autoFit: ["caption", "data"]
		},
		pagerBar: {center:["pager"]},
		pageable: {
			buttonCount: 10,
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
  	                	if(command.column && (command.column.field == "srNo" || command.column.field == "subject") ){
  	  	                	var srNo = SBGrid3.getValue(grid, command.key, 'srNo');
  	  	                	if(srNo) fn_egov_detail_Sr(srNo);
  	  	                }
  	                	
  	               		if(command.event.target && command.event.target.parentElement.className.indexOf("page") != -1){
  	               			$("#pageIndex").val(command.event.target.innerText);  	               			
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
     if(initFlag) {
   		initFlag = "";
   		var pageIndex = Number($("#pageIndex").val()) - 1;
   		datagrid.setPageNo(pageIndex);
   	 }
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

function saveLanguage() {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    setCookie("saveLanguage", document.Form.language.value, expdate);
//     alert("document.Form.language.value : " + document.Form.language.value);
//     alert(getCookie("saveLanguage"));
}

// function getLanguage(form) {
// 	//임시 한국어로 고정함 wbpark  2016.06.30
//     form.language.checked = ((loginForm.language.value = getCookie("saveLanguage")) != "");
// //     form.language.checked = 'ko';
// }

// getLanguage(document.loginForm);
// saveLanguage();

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

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.listForm.submit();
    document.listForm.action = "";
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
// function fn_egov_search_Sr(){
//     sC = document.listForm.searchCondition.value;
//     sK = document.listForm.searchKeyword.value; 
//     if (sC == "1") {
//         document.listForm.searchKeyword.value = sK.replace(/\-/, "");
//     }
//     document.listForm.pageIndex.value = 1;
//     document.listForm.submit();
// }
/**
 * 검색
 */
function fn_egov_search_Sr(){
	
    document.listForm.pageIndex.value = 1;
    document.listForm.selectStatus.value = "";
    document.listForm.searchAt.value = "Y";
    
    //등록과 반려 체크 여부 확인
    var checkFieldStatus = document.listForm.searchStatus;
    var checkSearchStatusRetnrn = document.listForm.searchStatusRetnrn;
    
//     if(checkFieldStatus) {
//         if(checkFieldStatus.length > 1) {
//         	if(checkFieldStatus[1].checked){		//등록"
//         		document.listForm.searchStatus1001At.value = "Y";
//         	}else{
//         		document.listForm.searchStatus1001At.value = "N";
//         	}
//         } 
//     }    
//     if(checkSearchStatusRetnrn) {
// 	    if(checkSearchStatusRetnrn.checked == true) {
// 	    	checkFieldStatus[1].checked = true;		//반려시 등록 체크함    	
// 	    } 
//     }
//    document.listForm.submit();
	
    //selectGridData();
    //createGrid();
    //loadData(request);
    SBGrid3.reload(datagrid);
}
/**
 * 상태별 선택
 */
function fn_egov_search_SrSelect(selStatus){
    document.listForm.pageIndex.value = 1;
    document.listForm.selectStatus.value = selStatus;
    document.listForm.searchAt.value = "Y";
    SBGrid3.reload(datagrid);
    //document.listForm.submit();
    //document.listForm.action = "";
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Sr(){
//     location.href = "<c:url value='/sr/EgovSrInsertView.do'/>";
    //var varForm              = document.all["Form"];
    var varForm = document.listForm;
    varForm.action           = "<c:url value='/sr/EgovSrInsertView.do'/>";
    varForm.submit();
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Sr(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Sr(srNo){
    //var varForm              = document.all["Form"];
    var varForm = document.listForm;
    varForm.action           = "<c:url value='/sr/EgovSrSelectUpdtView.do'/>";
    varForm.srNo.value        = srNo;
    varForm.submit();
    varForm.action = "";
}
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.listForm.checkField;
//     var checkStatus = document.listForm.statusArr;
//     var checkSanctnerAt = document.listForm.sanctnerAtArr;
    
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
//                 	if(checkStatus[i].value == '1001' && (checkSanctnerAt[i].value == null || checkSanctnerAt[i].value == '')){
                    	checkField[i].checked = true;                		
//                 	}
                }
            } else {
//             	if(checkStatus.value == '1001' && (checkSanctnerAt.value == null || checkSanctnerAt.value == '')){
	                checkField.checked = true;            		
//             	}            	
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
 * 일괄결재 처리 함수
 ******************************************************** */
function fn_egov_regist_SrSanctn(){
	if(fnChecked()) {
	    if (confirm("<spring:message code='common.sanctnAll.msg'/>")) {
			$.ajax({
	      		url : "<c:url value='/sr/EgovSrSanctnAll.do'/>",
	     	    type : 'POST',
	     	    data : $("#listForm").serialize(),
	     	    beforeSend : fn_loading(),
	     	    success : function(data){
	     	    	SBGrid3.reload(datagrid);
	     	    	alert(data.msg);	     	    	
	     	    	
	     	    },
	     	    error : function(request, status, error){
	  				alert("error");   	            
	     	    },
	     	    complete:function(){
	     	    	 fn_closeLoading();
	     	    }
		  	});
			
	    }		
	}
}
/* 
/**
 * 일괄SR결재처리
 */
function fnChecked() {
// 	alert("fnChecked : ");
	var checkField = SBGrid3.getCheckedKeys(datagrid);
    //var checkField = document.listForm.checkField;
    //var checkId = document.listForm.checkId;
    var returnValue = "";
    
//     alert("checkField : " + checkField);
//     alert("checkId : " + checkId);
//     alert("checkField : " + document.listForm.checkField.length);
    var returnBoolean = false;
    //var checkCount = 0;
    if(checkField) {
//     	alert("checkField in : ");
//     	alert("checkField length : " + checkField.length);
        if(checkField.length > 0) {
            for(var i=0; i<checkField.length; i++) {
                
               if(returnValue == "")
                   returnValue = SBGrid3.getValue(datagrid, checkField[i], 'srNo');
               else 
                   returnValue = returnValue + ";" + SBGrid3.getValue(datagrid, checkField[i], 'srNo');
                
            }
            if(returnValue) 
                returnBoolean = true;
            else {
            	alert('<spring:message code='common.noChecked.msg'/>');
                returnBoolean = false;
            }
        } else {
//         	alert("checkField.length > 1 else : ");
            
            alert('<spring:message code='common.noChecked.msg'/>');
            
        }
    } else {
//     	alert("checkField.length : " + checkField.length);
//     	alert("document.listForm.checkField.checked : " + document.listForm.checkField.checked);
    	alert('<spring:message code='common.noChecked.msg'/>');
    }
//     alert("returnValue : " + returnValue);
    document.listForm.srNoSanctnAllArr.value = returnValue;
    return returnBoolean;
}
/**
 * 엑셀다운로드(월간보고서)
 */
 function fncExcelReport(){
     //var varForm              = document.all["Form"];
/*      var varForm = document.listForm;
     varForm.selectStatus.value = "";
     varForm.action = "<c:url value='/sr/EgovSrListExcelReport.do'/>";
     varForm.submit();
     varForm.action = ""; */
     document.getElementById('searchConfirmDateF').value = SBUxMethod.get('searchConfirmDate_from') ? SBUxMethod.get('searchConfirmDate_from') : "";
 	 document.getElementById('searchConfirmDateT').value = SBUxMethod.get('searchConfirmDate_to') ? SBUxMethod.get('searchConfirmDate_to') : "";
 	
 	 var searchConfirmDateF = document.getElementById('searchConfirmDateF').value;
 	 var searchConfirmDateT = document.getElementById('searchConfirmDateT').value;
 	 
 	 //if(!searchConfirmDateF) return alert("<spring:message code='sr.error.required.requestDate'/>"); 	
 	 //if(!searchConfirmDateT) return alert("<spring:message code='sr.error.required.requestDate'/>");
         
     var firstDateObj = new Date(searchConfirmDateF.substring(0, 4), searchConfirmDateF.substring(4, 6) - 1, searchConfirmDateF.substring(6, 8));
     var secondDateObj = !searchConfirmDateT ? new Date() : new Date(searchConfirmDateT.substring(0, 4), searchConfirmDateT.substring(4, 6) - 1, searchConfirmDateT.substring(6, 8));
     var betweenTime = Math.abs(secondDateObj.getTime() - firstDateObj.getTime());  
     var dayDiff = Math.floor(betweenTime / (1000 * 60 * 60 * 24));
    
     if(searchConfirmDateF && dayDiff > 366){
    	return alert("<spring:message code='sr.error.msg.over90days'/>");
     }
     
     if(!searchConfirmDateF){
    	 if(confirm("<spring:message code='sr.msg.requestDate.1year'/>")){
    		 fnExcelReportAjax();
    	 }
     }else{
    	 fnExcelReportAjax();
     }
    
 } 
 
 function fnExcelReportAjax(){
	 $.ajax({
	    	url : "<c:url value='/excel/sr/EgovSrListExcelReport.do'/>",
	   	    type : 'POST',
	   	    data : $("#listForm").serialize(),
	   	    beforeSend : fn_loading(),
	   	    success : function(data, status, xhr){   	    	
	   	    	
	   	    	 if(data.fileBinary){
	   	    		var jsonBinary = JSON.parse(data.fileBinary);
	   	    		var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/vnd.ms-excel "});
	   	    		//var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
	   	            var url = URL.createObjectURL(blob);
	   	         	var link = document.createElement('a'); 
					link.href = url; 
					link.download = data.filename; 
					link.click();
					link.remove();
	   	    	}else{
	   	    		if(data.msg){
	   	    			alert(data.msg);
	   	    		}else{
	   	    			alert("<spring:message code='info.nodata.msg'/>");
	   	    		}
	   	    		
	   	    	}  
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	fn_closeLoading();
	   	    }
		});
 }

  
 /**
  * 엑셀다운로드(상세내역)
  */
  function fncExcelDetail(){
      //var varForm              = document.all["Form"];
      /* var varForm = document.listForm;
      varForm.action           = "<c:url value='/sr/EgovSrListExcelDetail.do'/>";
      varForm.submit();
      varForm.action = ""; */
      
      $.ajax({
      		url : "<c:url value='/excel/sr/EgovSrListExcelDetail.do'/>",
     	    type : 'POST',
     	    data : $("#listForm").serialize(),
     	    beforeSend : fn_loading(),
     	    success : function(data, status, xhr){   	    	
     	    	
     	    	if(data.fileBinary){
     	    		var jsonBinary = JSON.parse(data.fileBinary);
     	    		var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/vnd.ms-excel "});
     	    		//var blob = new Blob([new Uint8Array(jsonBinary)],{"type" : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
     	            var url = URL.createObjectURL(blob);
     	         	var link = document.createElement('a'); 
	  				link.href = url; 
	  				link.download = data.filename; 
	  				link.click();
	  				link.remove();
     	    	}else{
     	    		alert("<spring:message code='info.nodata.msg'/>");
     	    	}
     	    },
     	    error : function(request, status, error){
  				alert("error");   	            
     	    },
     	    complete:function(){
     	    	fn_closeLoading();
     	    }
  	});
  } 
  /**
   * 데이터 삭제
   */
  function fnClear(obj) {
	 obj.value="";
	 obj.focus();
	 return false;
  }

  /* ********************************************************
   * 모두선택 처리 함수 - 상태
   ******************************************************** */
  function fnStatusAllCheck() {
	  
      /* var checkFieldStatus = document.listForm.searchStatus;
      if(obj.checked) {
          if(checkFieldStatus) {
              if(checkFieldStatus.length > 1) {
                  for(var i=0; i < checkFieldStatus.length; i++) {
                	  checkFieldStatus[i].checked = true;
                  }
              } else {
            	  checkFieldStatus.checked = true;
              }
          }
      } else {
          if(checkFieldStatus) {
              if(checkFieldStatus.length > 1) {
                  for(var j=0; j < checkFieldStatus.length; j++) {
                	  checkFieldStatus[j].checked = false;
                  }
              } else {
            	  checkFieldStatus.checked = false;
              }
          }
      } */
      
	  var bAllCheck = SBUxMethod.get("searchStatusAll").searchStatusAll;
      
      var checkBoxList = $("input[name='searchStatus']");
      
   	  for(var i in checkBoxList){
   		  if(bAllCheck){
   			checkBoxList[i].checked = bAllCheck; 
   			checkBoxList[i].value = checkBoxList[i].getAttribute("true-value");
   		  }else{
   			checkBoxList[i].checked = bAllCheck;  
   		  }
   		  
   	  }      
      
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check Start	////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
var fReqDate = "<c:out value='${searchVO.searchConfirmDateF}'/>";
var tReqDate = "<c:out value='${searchVO.searchConfirmDateT}'/>";
var fComDate = "<c:out value='${searchVO.searchCompleteDateF}'/>";
var tComDate = "<c:out value='${searchVO.searchCompleteDateT}'/>";
// 요청일 체크..
function fnReqDateChk(fdate, tdate){
	//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
	if(fdate.value != "" && tdate.value != ""){
		if(fdate.value > tdate.value){
			alert("<spring:message code='sr.error.msg.dateNotValid'/>");
			if(fReqDate != fdate.value){
				document.getElementById('searchConfirmDateF').value = fReqDate;
				if(fReqDate == ""){
					document.getElementById('searchConfirmDateFView').value = "";
				}else{
					document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
				}
			}
			if(tReqDate != tdate.value){
				document.getElementById('searchConfirmDateT').value = tReqDate;
				if(tReqDate == ""){
					document.getElementById('searchConfirmDateTView').value = "";
				}else{
					document.getElementById('searchConfirmDateTView').value = tReqDate.substring(0,4) + '-' + tReqDate.substring(4,6) + '-' + tReqDate.substring(6,8);	
				}
			}
			
		}else{
			//요청일과 완료일 비교.
			if(fdate.value != "" && fComDate != ""){
				if(fdate.value > fComDate){
					alert("<spring:message code='sr.error.msg.requestDate'/>");
					document.getElementById('searchConfirmDateF').value = fReqDate;
					if(fReqDate == ""){
						document.getElementById('searchConfirmDateFView').value = "";
					}else{
						document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
					}
					return;
				}
			}
			//From, To 일자 셋팅.
			fReqDate = fdate.value;
			tReqDate = tdate.value;
		}
	}else{
		//요청일과 완료일 비교.
		if(fdate.value != "" && fComDate != ""){
			if(fdate.value > fComDate){
				alert("<spring:message code='sr.error.msg.requestDate'/>");
				document.getElementById('searchConfirmDateF').value = fReqDate;
				if(fReqDate == ""){
					document.getElementById('searchConfirmDateFView').value = "";
				}else{
					document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
				}
				
			}
			return;
		}
		//From, To 일자 셋팅.
		fReqDate = fdate.value;
		tReqDate = tdate.value;
	}
}

//완료일 체크..
function fnComDateChk(fdate, tdate){
	//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
	if(fdate.value != "" && tdate.value != ""){
		if(fdate.value > tdate.value){
			alert("<spring:message code='sr.error.msg.completionDateNotValid'/>");
			if(fComDate != fdate.value){
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
			}
			
			if(tComDate != tdate.value){
				document.getElementById('searchCompleteDateT').value = tComDate;
				if(tComDate == ""){
					document.getElementById('searchCompleteDateTView').value = "";
				}else{
					document.getElementById('searchCompleteDateTView').value = tComDate.substring(0,4) + '-' + tComDate.substring(4,6) + '-' + tComDate.substring(6,8);
				}
				
			}
			
		}else{
			//요청일과 완료일 비교.
			if(fdate.value != "" && fReqDate != ""){
				if(fdate.value < fReqDate){
					alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
					document.getElementById('searchCompleteDateF').value = fComDate;
					if(fComDate == ""){
						document.getElementById('searchCompleteDateFView').value = "";
					}else{
						document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);
					}
					return;
				}
			}
			//From, To 일자 셋팅.
			fComDate = fdate.value;
			tComDate = tdate.value;
		}
	}else{
		//요청일과 완료일 비교.
		if(fdate.value != "" && fReqDate != ""){
			if(fdate.value < fReqDate){
				alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
				return;
			}
		}
		//From, To 일자 셋팅.
		fComDate = fdate.value;
		tComDate = tdate.value;
	}
	
}


//조회시 널값인 날짜 처리.
function fnDateChk(){
	document.getElementById('searchConfirmDateF').value = SBUxMethod.get('searchConfirmDate_from') ? SBUxMethod.get('searchConfirmDate_from') : "";
	document.getElementById('searchConfirmDateT').value = SBUxMethod.get('searchConfirmDate_to') ? SBUxMethod.get('searchConfirmDate_to') : "";
	document.getElementById('searchCompleteDateF').value = SBUxMethod.get('searchCompleteDate_from') ? SBUxMethod.get('searchCompleteDate_from') : "";
	document.getElementById('searchCompleteDateT').value = SBUxMethod.get('searchCompleteDate_to') ? SBUxMethod.get('searchCompleteDate_to') : "";

	/* if(document.getElementById('searchConfirmDateFView').value == ""){
		document.getElementById('searchConfirmDateF').value = "";
	}
	
	if(document.getElementById('searchConfirmDateTView').value == ""){
		document.getElementById('searchConfirmDateT').value = "";
	}
	
	if(document.getElementById('searchCompleteDateFView').value == ""){
		document.getElementById('searchCompleteDateF').value = "";
	}
	
	if(document.getElementById('searchCompleteDateTView').value == ""){
		document.getElementById('searchCompleteDateT').value = "";
	} */
}

function fnSetDate(name){
	if(name == "searchConfirmDate"){
		document.getElementById('searchConfirmDateF').value = SBUxMethod.get('searchConfirmDate_from') ? SBUxMethod.get('searchConfirmDate_from') : "";
		document.getElementById('searchConfirmDateT').value = SBUxMethod.get('searchConfirmDate_to') ? SBUxMethod.get('searchConfirmDate_to') : "";
	}else if(name == "searchCompleteDate"){
		document.getElementById('searchCompleteDateF').value = SBUxMethod.get('searchCompleteDate_from') ? SBUxMethod.get('searchCompleteDate_from') : "";
		document.getElementById('searchCompleteDateT').value = SBUxMethod.get('searchCompleteDate_to') ? SBUxMethod.get('searchCompleteDate_to') : "";
	}
}
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check End		////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
//<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>

function fnAllCharge() {
	var checkYN = SBUxMethod.getCheckbox("searchAllCharge").searchAllCharge;
	
	if(!checkYN) {
		document.getElementById('searchRid').value = "";
	} else {
		document.getElementById('searchRid').value = "${searchVO.searchRid}"
	}
}

function enterkey() {
  if (window.event.keyCode == 13) {

       // 엔터키가 눌렸을 때 실행할 내용
       fn_egov_search_Sr();
  }
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
	            <!--상태-->
	            <div class="sr_process">                
	                <div class="processBox">       
                        <p class="proline"></p>                                    
                        <div class="proIcon">                        	                        
                            <div class="proBox pro01" onclick="fn_egov_search_SrSelect('1001'); return false;">
                                <p class="pr-text01"><spring:message code='button.create' /></p>
                                <p class="pr-text02" id = "status1001"><span><spring:message code='sr.msg.cnt'/></span></p>
                            </div>
                            <p class="arrow"></p>
                            <div class="proBox pro02" onclick="fn_egov_search_SrSelect('1002'); return false;">
                                <p class="pr-text01"><spring:message code='sr.receptionWaiting' /></p>
                                <p class="pr-text02" id = "status1002"><span><spring:message code='sr.msg.cnt' /></span></p>
                            </div>
                            <p class="arrow"></p>
                            <div class="proBox pro03" onclick="fn_egov_search_SrSelect('1003'); return false;">
                                <p class="pr-text01"><spring:message code='sr.receptionCompletion' /></p>
                                <p class="pr-text02" id = "status1003" ><span><spring:message code='sr.msg.cnt' /></span></p>
                            </div>
                            <p class="arrow"></p>
                            <div class="proBox pro04" onclick="fn_egov_search_SrSelect('1004'); return false;">
                                <p class="pr-text01"><spring:message code='sr.beingResolved' /></p>
                                <p class="pr-text02" id = "status1004" ><span><spring:message code='sr.msg.cnt' /></span></p>
                            </div>
                            <p class="arrow"></p>
                            <div class="proBox pro05" onclick="fn_egov_search_SrSelect('1005'); return false;">
                                <p class="pr-text01"><spring:message code='sr.customerConfirm' /></p>
                                <p class="pr-text02" id = "status1005"><span><spring:message code='sr.msg.cnt' /></span></p>
                            </div>
                            <p class="arrow"></p>
                            <div class="proBox pro06" onclick="fn_egov_search_SrSelect('1006'); return false;">
                                <p class="pr-text01"><spring:message code='sr.completion' /></p>
                                <p class="pr-text02" id = "status1006"><span><spring:message code='sr.msg.cnt' /></span></p>
                            </div>                                     
                        </div>
                    </div>
	            </div>
	            <!--상태-->
	            <div class="btn_right_list">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fn_egov_search_Sr(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
	            <form name="listForm" id="listForm" action="<c:url value='/sr/EgovSrList.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" /> 
				<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
				<input type="hidden" id = "searchConfirmDateF" name = "searchConfirmDateF" value = "<c:out value='${searchVO.searchConfirmDateF}'/>"/>
				<input type="hidden" id = "searchConfirmDateT" name = "searchConfirmDateT" value = "<c:out value='${searchVO.searchConfirmDateT}'/>"/>
				<input type="hidden" id = "searchCompleteDateF" name = "searchCompleteDateF" value = "<c:out value='${searchVO.searchCompleteDateF}'/>"/>
				<input type="hidden" id = "searchCompleteDateT" name = "searchCompleteDateT" value = "<c:out value='${searchVO.searchCompleteDateT}'/>"/>
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
				<input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> 
				<input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> 
				<input type="hidden" name="searchStatus1001At" value="<c:out value='${searchVO.searchStatus1001At}'/>" /> 
				<input type="hidden" name="srNoSanctnAllArr" />
				<input type="hidden" name="srNo"/>
				
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
	                    <tbody>                       
	                        <tr>
	                            <th>
	                                <sbux-label id="table_label1" name="table_label1" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-datepicker name="searchConfirmDate" id="searchConfirmDate" uitype="range" open-on-input-selection="true" split-text="~" onchange="fnSetDate('searchConfirmDate')">
	                                </sbux-datepicker>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label2" name="table_label2" uitype="normal" text="<spring:message code='sr.completionDate' />"></sbux-label>
	                            </th>
	                            <td>	                            	
	                                <sbux-datepicker id="searchCompleteDate" name="searchCompleteDate" uitype="range" open-on-input-selection="true" split-text="~" onchange="fnSetDate('searchCompleteDate')">
	                                </sbux-datepicker>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label3" name="table_label3" uitype="normal" text="<spring:message code='sr.requester' />" class=""></sbux-label>
	                            </th>
	                            <td>
	                                <sbux-input id="searchCustomerNm" name="searchCustomerNm" uitype="text" style = "width:100%" value="<c:out value='${searchVO.searchCustomerNm}'/>"  onkeyup="enterkey()">
	                                
	                                </sbux-input>
	                            </td>
	                        </tr>
	                        <tr>	                            
	                            <th>
	                                <sbux-label id="table_label4" name="table_label4" uitype="normal" text="<spring:message code='sr.charge' />" class=""></sbux-label>
	                                <sbux-checkbox uitype="normal" id = "searchAllCharge" name="searchAllCharge" onclick = "fnAllCharge()" <c:if test="${not empty searchVO.searchRid}"> checked </c:if>></sbux-checkbox>
	                            </th>
	                            <td>
	                                <sbux-select id="searchRid" name="searchRid" uitype="single" init = "<spring:message code='sr.choose' />">
	                                	<c:choose>
											<c:when test="${authorCode == 'ROLE_COOPERATION'}">
												<c:forEach var="result" items="${chargerList}" varStatus="status">
													<c:if test="${result.userId == searchVO.searchRid}">
														<option value='<c:out value="${result.userId}"/>' selected>
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
															</c:choose></option>
													</c:if>
												</c:forEach>
											</c:when>
	
											<c:otherwise>
												<option value=''><spring:message code='sr.choose' /></option>
												<c:forEach var="result" items="${chargerList}" varStatus="status">
													<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == searchVO.searchRid}">selected</c:if>>
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
											</c:otherwise>
										</c:choose>
	                                </sbux-select>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label5" name="table_label5" uitype="normal" text="<spring:message code='sr.module' />"></sbux-label>
	                            </th>
	                            <td>
	                               <sbux-select id="searchModuleCode" name="searchModuleCode" uitype="single" init = "<spring:message code='sr.choose' />">
		                               <option value=''><spring:message code='sr.choose' />
										</option>
										<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
											<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == searchVO.searchModuleCode}">selected</c:if>>
												<c:choose>
													<c:when test="${srLanguage == 'ko'}">
														<c:out value="${result.codeNm}" /> <c:if test = "${not empty result.userNm and !(authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION') }"> - <c:out value="${result.userNm}" /></c:if>
													</c:when>
													<c:when test="${srLanguage == 'en'}">
														<c:out value="${result.codeNmEn}" /> <c:if test = "${not empty result.userNmEn and !(authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION')}"> - <c:out value="${result.userNmEn}" /></c:if>
													</c:when>
													<c:when test="${srLanguage == 'cn'}">
														<c:out value="${result.codeNmCn}" /> <c:if test = "${not empty result.userNmEn and !(authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION')}"> - <c:out value="${result.userNmEn}" /></c:if>
													</c:when>
													<c:otherwise>
														<c:out value="${result.codeNm}" /> <c:if test = "${not empty result.userNm and !(authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION')}"> - <c:out value="${result.userNm}" /></c:if>
													</c:otherwise>
												</c:choose>
											</option>
										</c:forEach>
	                               </sbux-select>
	                            </td>
	                            <th>
	                                <sbux-label id="table_label6" name="table_label6" uitype="normal" text="<spring:message code='sr.keyword' />"></sbux-label>
	                            </th>
	                            <td>
	                            	<sbux-select id="searchContentFlag" name="searchContentFlag" uitype="single" style = "width:175px;">
	                                	<option value=''><spring:message code='cop.nttSj'/>+<spring:message code='sr.srNumber' /></option>
	                                	<option value='Y' <c:if test = "${searchVO.searchContentFlag == 'Y'}" >selected</c:if>><spring:message code='cop.nttSj'/>+<spring:message code='sr.srNumber' />+<spring:message code='cop.nttCn' /></option>
	                                </sbux-select>
	                                <sbux-input id="searchSubject" name="searchSubject" uitype="text"  value="<c:out value='${searchVO.searchSubject}'/>" onkeyup="enterkey()"style="width : 100%">
	                                </sbux-input>
	                            </td>
	                        </tr>
	                        <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
		                        <tr>
		                            <th>
		                                <sbux-label id="table_label7" name="table_label7" uitype="normal" text="<spring:message code='sr.client'/>" class=""></sbux-label>
		                            </th>
		                            <td>
		                                <sbux-select id="searchPstinstCode" name="searchPstinstCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                	<option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${pstinstList}" varStatus="status">
												<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
											</c:forEach>
		                                </sbux-select>
		                            </td>
		                            <th>
		                                <sbux-label id="table_label8" name="table_label8" uitype="normal" text="<spring:message code='sr.status'/>"></sbux-label>
		                                <sbux-checkbox uitype="normal" id = "searchStatusAll" name="searchStatusAll" onclick = "fnStatusAllCheck()"></sbux-checkbox>
		                            </th>
		                            <td colspan = '3'>
		                                <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
											<c:set var="vChecked">
												<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">													
													<c:choose>
														<c:when test="${vList == statusCode_result.code}">checked</c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
												</c:forEach>
											</c:set>
						                   		<%-- <c:if test="${statusCode_result.code != '1000'}">
						                   			<sbux-checkbox uitype="normal" name="searchStatus" text = "<c:out value="${statusCode_result.codeDc}"/> "value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
						              				</sbux-checkbox>
						              			</c:if>	 --%>
											<!-- 반려 -->
										<%-- <c:if test="${statusCode_result.code != '1000'}"> --%>
											<c:if test="${statusCode_result.code != '1007'}">
													 <c:choose>
														<c:when test="${srLanguage == 'en'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus" text = "<c:out value="${statusCode_result.codeNmEn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:otherwise>
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN'}">
													<c:choose>
														<c:when test="${srLanguage == 'en'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmEn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:when>
														<c:otherwise>
															<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
															</sbux-checkbox>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:if>
										<%-- </c:if> --%>
										</c:forEach>
		                            </td>
		                        </tr>
	                        </c:if>
	                         <c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
                   	            <th>
	                                <sbux-label id="table_label8" name="table_label8" uitype="normal" text="<spring:message code='sr.status'/>"></sbux-label>
	                                <sbux-checkbox uitype="normal" id = "searchStatusAll" name="searchStatusAll" onclick = "fnStatusAllCheck()"></sbux-checkbox>
	                            </th>
	                            <td colspan = '5'>
	                                <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
										<c:set var="vChecked">
											<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">													
												<c:choose>
													<c:when test="${vList == statusCode_result.code}">checked</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</c:set>
					                   		<%-- <c:if test="${statusCode_result.code != '1000'}">
					                   			<sbux-checkbox uitype="normal" name="searchStatus" text = "<c:out value="${statusCode_result.codeDc}"/> "value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
					              				</sbux-checkbox>
					              			</c:if>	 --%>
										<!-- 반려 -->
									<%-- <c:if test="${statusCode_result.code != '1000'}"> --%>
										<c:if test="${statusCode_result.code != '1007'}">
												 <c:choose>
													<c:when test="${srLanguage == 'en'}">
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus" text = "<c:out value="${statusCode_result.codeNmEn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:when>
													<c:when test="${srLanguage == 'cn'}">
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:when>
													<c:otherwise>
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/>" true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:otherwise>
												</c:choose>
										</c:if>
										<c:if test="${statusCode_result.code == '1007'}">
											<!-- 현업, 결제자, admin -->
											<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN'}">
												<c:choose>
													<c:when test="${srLanguage == 'en'}">
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmEn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:when>
													<c:when test="${srLanguage == 'cn'}">
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNmCn}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:when>
													<c:otherwise>
														<sbux-checkbox uitype="normal" id = "searchStatus<c:out value='${statusCode_result.code}'/> " name="searchStatus"  text = "<c:out value="${statusCode_result.codeNm}"/> " true-value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>>
														</sbux-checkbox>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:if>
									<%-- </c:if> --%>
									</c:forEach>
	                         </c:if>	                   
	                    </tbody>
	                </table>
	            </div><!--검색조건-->
	            </form>
	            <div class="grid_area">
	                <div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/>: <span id = 'totalCnt'><c:out value="${paginationInfo.totalRecordCount}" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">         
	                    <p class="txt_pre"><spring:message code='sr.realLabourHoursSum'/>: <span id = 'realExpectTimeSum'><c:out value="${realExpectTimeSum}"/></span></p>                    
	                    <c:if test="${authorCode != 'ROLE_COOPERATION'}">
	                    	<sbux-button uitype="normal" text="<spring:message code='button.requestRegistration' />" class="btn-default" image-style="width:15px;height:13px;" onclick = "fn_egov_regist_Sr(); return false;"></sbux-button>
	                    </c:if>
	                    <c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
	                    	<sbux-button uitype="normal" text="<spring:message code='button.srAllApproval' />" class="btn-default" image-style="width:15px;height:13px;" onclick = "fn_egov_regist_SrSanctn(); return false;"></sbux-button>
	                    </c:if>
	                    <c:if test="${authorCode != 'ROLE_COOPERATION'}">
	                    	<sbux-button uitype="normal" text="<spring:message code='button.excelMonthly' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fncExcelReport(); return false;"></sbux-button>
	                    </c:if>
	                    <%-- <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
	                    	<sbux-button uitype="normal" text="<spring:message code='button.excelDetails' />" class="btn-excel" image-src="<c:url value= "/"/>images/btn_excel.png" image-style="width:15px;height:13px;" onclick = "javascript:fncExcelDetail(); return false;"></sbux-button>                    
	                	</c:if> --%>
	                </div>
	            </div>
	
	            <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
	<%-- <div id="wrapper">
		<div id="header">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
		</div>
		<c:import url="/sym/mms/EgovMainMenuHead.do" />
		<c:import url="/EgovPageLink.do?link=main/inc/incLeftmenu" />
		<div id="contents">
			<form name="listForm" id="listForm" action="<c:url value='/sr/EgovSrList.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" /> <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />

				<c:forEach var="srCntList" items="${srCntList}" varStatus="status">
					<c:if test="${srCntList.status == '1001'}">
						<c:set var="status1001">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1002'}">
						<c:set var="status1002">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1003'}">
						<c:set var="status1003">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1004'}">
						<c:set var="status1004">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1005'}">
						<c:set var="status1005">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1006'}">
						<c:set var="status1006">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
				</c:forEach>
				<c:if test="${status1001 == NULL}">
					<c:set var="status1001">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1002 == NULL}">
					<c:set var="status1002">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1003 == NULL}">
					<c:set var="status1003">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1004 == NULL}">
					<c:set var="status1004">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1005 == NULL}">
					<c:set var="status1005">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1006 == NULL}">
					<c:set var="status1006">
						<c:out value='0' />
					</c:set>
				</c:if>

				<div class="tabstate">
					<ul>
						<li class="tab01"><a href="#LINK" onclick="fn_egov_search_SrSelect('1001'); return false;"><br /> <br /> <spring:message code='button.create' /><br />(<c:out value='${status1001}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab02"><a href="#LINK" onclick="fn_egov_search_SrSelect('1002'); return false;"><br /> <br /> <spring:message code='sr.receptionWaiting' /><br />(<c:out value='${status1002}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab03"><a href="#LINK" onclick="fn_egov_search_SrSelect('1003'); return false;"><br /> <br /> <spring:message code='sr.receptionCompletion' /><br />(<c:out value='${status1003}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab04"><a href="#LINK" onclick="fn_egov_search_SrSelect('1004'); return false;"><br /> <br /> <spring:message code='sr.beingResolved' /><br />(<c:out value='${status1004}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab05"><a href="#LINK" onclick="fn_egov_search_SrSelect('1005'); return false;"><br /> <br /> <spring:message code='sr.customerConfirm' /><br />(<c:out value='${status1005}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab06"><a href="#LINK" onclick="fn_egov_search_SrSelect('1006'); return false;"><br /> <br /> <spring:message code='sr.completion' /><br />(<c:out value='${status1006}' /> <spring:message code='sr.msg.cnt' />)</a></li>
					</ul>
				</div>
				<div class="searchtb">
					<table width="980" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="5" bgcolor="#0257a6" height="2"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.requestDate' /></td>
							<td class="tdleft"><input name="searchConfirmDateF" id="searchConfirmDateF" type="hidden" value="<c:out value='${searchVO.searchConfirmDateF}'/>"> <input name="searchConfirmDateFView" id="searchConfirmDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchConfirmDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> ~ <input name="searchConfirmDateT" id="searchConfirmDateT" type="hidden" value="<c:out value='${searchVO.searchConfirmDateT}'/>" /> <input name="searchConfirmDateTView" id="searchConfirmDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchConfirmDateTView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> <form:errors path="searchConfirmDateF" /> <form:errors path="searchConfirmDateT" /></td>
							<td class="tdblue4"><spring:message code='sr.completionDate' /></td>
							<td class="tdleft"><input name="searchCompleteDateF" id="searchCompleteDateF" type="hidden" value="<c:out value='${searchVO.searchCompleteDateF}'/>"> <input name="searchCompleteDateFView" id="searchCompleteDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchCompleteDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> ~ <input name="searchCompleteDateT" id="searchCompleteDateT" type="hidden" value="<c:out value='${searchVO.searchCompleteDateT}'/>" /> <input name="searchCompleteDateTView" id="searchCompleteDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchCompleteDateTView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> <form:errors path="searchCompleteDateF" /> <form:errors path="searchCompleteDateT" /></td>
							<td rowspan="9" align="center"><a href="#LINK" onclick="fn_egov_search_Sr(); return false;"> <c:choose>
										<c:when test="${srLanguage == 'ko'}">
											<img src="<c:url value='/' />images/sr/btn_search.gif" width="86" height="65" />
										</c:when>
										<c:when test="${srLanguage == 'en'}">
											<img src="<c:url value='/' />images/sr/btn_searchEn.gif" width="86" height="65" />
										</c:when>
										<c:when test="${srLanguage == 'cn'}">
											<img src="<c:url value='/' />images/sr/btn_searchCn.gif" width="86" height="65" />
										</c:when>
										<c:otherwise>
											<img src="<c:url value='/' />images/sr/btn_search.gif" width="86" height="65" />
										</c:otherwise>
									</c:choose>
							</a></td>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.requester' /></td>
							<td class="tdleft"><input name="searchCustomerNm" type="text" size="20" value="<c:out value='${searchVO.searchCustomerNm}'/>" maxlength="30" id="F1" title="검색조건"></td>
							<td class="tdblue4"><spring:message code='sr.charge' /></td>
							<td class="tdleft"><select name="searchRid" id="searchRid" class="select" title="담당자">
									<c:choose>
										<c:when test="${authorCode == 'ROLE_COOPERATION'}">
											<c:forEach var="result" items="${chargerList}" varStatus="status">
												<c:if test="${result.userId == searchVO.searchRid}">
													<option value='<c:out value="${result.userId}"/>' selected>
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
														</c:choose></option>
												</c:if>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<option value=''>==
												<spring:message code='sr.choose' />==
											</option>
											<c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == searchVO.searchRid}">selected</c:if>>
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
										</c:otherwise>
									</c:choose>
							</select>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.module' /></td>
							<td class="tdleft"><select name="searchModuleCode" class="select" title="모듈코드">
									<option value=''>==
										<spring:message code='sr.choose' />==
									</option>
									<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == searchVO.searchModuleCode}">selected</c:if>>
																	<c:out value="${result.codeNm}"/>
											<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value="${result.codeNm}" />
												</c:when>
												<c:when test="${srLanguage == 'en'}">
													<c:out value="${result.codeNmEn}" />
												</c:when>
												<c:when test="${srLanguage == 'cn'}">
													<c:out value="${result.codeNmCn}" />
												</c:when>
												<c:otherwise>
													<c:out value="${result.codeNm}" />
												</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
							</select></td>
							<td class="tdblue4"><spring:message code='sr.keyword' /></td>
							<td class="tdleft"><input name="searchTcode" type="hidden" value="<c:out value='${searchVO.searchTcode}'/>" maxlength="30" id="F1" title="검색조건"> <input name="searchSubject" type="text" size="30" value="<c:out value='${searchVO.searchSubject}'/>" maxlength="200" id="F1" title="검색조건"></td>
						</tr>

						<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
							<tr>
								<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							</tr>
							<tr>
								<td class="tdblue4"><label for="searchPstinstNm"><spring:message code='sr.client' /></label></td>
								<td class="tdleft"><select name="searchPstinstCode" id="searchPstinstCode" class="select" title="고객사">
										<option value=''>==
											<spring:message code='sr.choose' />==
										</option>
										<c:forEach var="result" items="${pstinstList}" varStatus="status">
											<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
										</c:forEach>
								</select> 	           			<input name="searchPstinstNm" type="text" size="20" value="<c:out value='${searchVO.searchPstinstNm}'/>"  maxlength="30" id="F1" title="검색조건"> 	           			<input type="hidden" name="pstinst_url" value="<c:url value='/pstinst/EgovPstinstSearchPopup.do'/>" /> 	           			<input type="text" name="searchPstinstNm" id="searchPstinstNm" title="고객사명" size="30" maxlength="100" value="<c:out value='${searchVO.searchPstinstNm}'/>"  />                         <input name="searchPstinstCode" id="searchPstinstCode" type="hidden" size="20" value="<c:out value='${searchVO.searchPstinstCode}'/>"  maxlength="30" id="F1" title="검색조건"> <!--                         <a href="#LINK" onclick="javascript:fn_egov_PstinstSearch(document.listForm, document.listForm.searchPstinstCode, document.listForm.searchPstinstNm);"> -->                             <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(고객사 검색) <!--                         </a> --></td>
								<td class="tdblue4"><spring:message code='sr.status' /> <input type="checkbox" name="searchStatusAllCheck" value="true" <c:if test="${searchVO.searchStatusAllCheck == 'true'}">checked</c:if> onClick="javascript:fnStatusAllCheck(this);"></td>
								<td class="tdleft"><input name="searchStatus" type="hidden" value="1000" /> <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
										<c:set var="vChecked">
											<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
												<c:choose>
													<c:when test="${vList == statusCode_result.code}">checked</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</c:set>
											                   		<c:if test="${statusCode_result.code != '1000'}">
											                   			<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>><c:out value="${statusCode_result.codeDc}"/>
											              			</c:if>	     
										<c:if test="${statusCode_result.code != '1000'}">
											<!-- 반려 -->
											<c:if test="${statusCode_result.code != '1007'}">
												<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> <c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:when>
														<c:otherwise>
															<c:out value="${statusCode_result.codeNm}" />
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN'}">
													<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> 	                   					<c:out value="${statusCode_result.codeDc}"/> <c:choose>
															<c:when test="${srLanguage == 'ko'}">
																<c:out value="${statusCode_result.codeNm}" />
															</c:when>
															<c:when test="${srLanguage == 'en'}">
																<c:out value="${statusCode_result.codeNmEn}" />
															</c:when>
															<c:when test="${srLanguage == 'cn'}">
																<c:out value="${statusCode_result.codeNmCn}" />
															</c:when>
															<c:otherwise>
																<c:out value="${statusCode_result.codeNm}" />
															</c:otherwise>
														</c:choose>
												</c:if>
											</c:if>
										</c:if>
									</c:forEach></td>
							</tr>
						</c:if>

						<!-- 현업 및 결제자 -->
						<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
							<tr>
								<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							</tr>
							<tr>
								<td class="tdblue4" valign="middle"><spring:message code='sr.status' /> <input type="checkbox" name="searchStatusAllCheck" value="true" <c:if test="${searchVO.searchStatusAllCheck == 'true'}">checked</c:if> onClick="javascript:fnStatusAllCheck(this);"></td>
								<td colspan="3" class="tdleft"><input name="searchStatus" type="hidden" value="1000" /> <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
										<c:set var="vChecked">
											<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
												<c:choose>
													<c:when test="${vList == statusCode_result.code}">checked</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</c:set>
										<c:if test="${statusCode_result.code != '1000'}">
											<!-- 반려 -->
											<c:if test="${statusCode_result.code != '1007'}">
												<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> 	                   				<c:out value="${statusCode_result.codeDc}"/> <c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:when>
														<c:otherwise>
															<c:out value="${statusCode_result.codeNm}" />
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN' }">
													<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> 	                   					<c:out value="${statusCode_result.codeDc}"/> <c:choose>
															<c:when test="${srLanguage == 'ko'}">
																<c:out value="${statusCode_result.codeNm}" />
															</c:when>
															<c:when test="${srLanguage == 'en'}">
																<c:out value="${statusCode_result.codeNmEn}" />
															</c:when>
															<c:when test="${srLanguage == 'cn'}">
																<c:out value="${statusCode_result.codeNmCn}" />
															</c:when>
															<c:otherwise>
																<c:out value="${statusCode_result.codeNm}" />
															</c:otherwise>
														</c:choose>
												</c:if>
											</c:if>
										</c:if>
									</c:forEach> <!-- 반려 checkbox --> 	               		&nbsp;&nbsp;(<input type="checkbox" name="searchStatusRetnrn" value="true" <c:if test="${searchVO.searchStatusRetnrn == 'true'}">checked</c:if> >반려)</td>
							</tr>
						</c:if>
						</tr>
						<tr>
							<td colspan="5" bgcolor="#dcdcdc" height="1"></td>
						</tr>
					</table>
				</div>


				<div class="list">
					<ul>
						<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align: middle" /> <spring:message code='sr.msg.totalCnt' /> <span style="color: #F00"><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></li>
					</ul>
				</div>
				<div class="list2">
					<ul>
						<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" /> &nbsp;<spring:message code='sr.realLabourHoursSum' /> : <span style="color: #F00"><fmt:formatNumber value="${realExpectTimeSum}" pattern="##,###,###.00" /></span></li>&nbsp;&nbsp;
						<li><img src="<c:url value='/' />images/sr/icon_home.gif" style="vertical-align: middle" /> &nbsp;<spring:message code='sr.navigation.srList' /></li>
					</ul>
				</div>
				<div class="list3">
					<table width="980" border="0" cellpadding="0" cellspacing="0">

						<colgroup>
							<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
								<col width="4%">
							</c:if>
							<col width="7%">

								                    <col width="200px;" >
								<col width="*">
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<col width="7%">
									</c:if>

									<col width="7%">
										<col width="7%">
											<col width="7%">
												<col width="7%">
													<col width="8%">
														<!-- 현업 및 결제자 -->
														<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
															<col width="10%">
														</c:if>
														<col width="10%">
															<col width="10%">
																<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
																	<col width="5%">
																</c:if>
																<col width="10%">
																	<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#0257a6" height="2"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#0257a6" height="2"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#0257a6" height="2"></td>
								</c:if>
							</tr>
							<tr class="tdgrey">
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택" /></th>
								</c:if>
								<th scope="col" class="f_field" nowrap="nowrap"><spring:message code='sr.srNumber' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code="cop.nttSj" /></th>

								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<th scope="col" nowrap="nowrap"><spring:message code='sr.client' /></th>
								</c:if>

								<th scope="col" nowrap="nowrap"><spring:message code='sr.module' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.status' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.requester' /></th>
								                        <th scope="col" nowrap="nowrap"><spring:message code='sr.charge'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.charge' /></th>
								                        <th scope="col" nowrap="nowrap"><spring:message code='sr.requestDate'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.requestDate' /></th>
								<!-- 현업 및 결제자 -->
								<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									                        <th scope="col" nowrap="nowrap"><spring:message code='sr.completeHopeDate'/></th>
									<th scope="col" nowrap="nowrap"><spring:message code='sr.list.completeHopeDate' /></th>
								</c:if>
								                        <th scope="col" nowrap="nowrap"><spring:message code='sr.expectedCompletionDate'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.expectedCompletionDate' /></th>
								                        <th scope="col" nowrap="nowrap"><spring:message code='sr.completionDate'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.completionDate' /></th>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									                        	<th scope="col" nowrap="nowrap"><spring:message code='sr.customerConfirm'/></th>
									<th scope="col" nowrap="nowrap"><spring:message code='sr.list.customerConfirm' /></th>
								</c:if>
								                        <th scope="col" nowrap="nowrap"><spring:message code='sr.realLabourHours2'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.realLabourHours' /></th>
								                        <th scope="col" nowrap="nowrap"><spring:message code='cop.satisfaction.stsfdg'/></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.stsfdg' /></th>
							</tr>
							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#717171" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#717171" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#717171" height="1"></td>
								</c:if>
							</tr>
						</thead>

						<tbody>

							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
							</tr>

							<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td nowrap="nowrap" align="center"><c:if test="${resultInfo.status == '1001' && resultInfo.sanctnerAt == null}">
												<input type="checkbox" name="checkField" class="check2" title="선택" />
											</c:if> <c:if test="${resultInfo.status == '1001' && resultInfo.sanctnerAt != null}">
												<input type="checkbox" name="checkField" class="check2" title="선택" disabled="disabled" />
											</c:if> <c:if test="${resultInfo.status != '1001'}">
												<input type="checkbox" name="checkField" class="check2" title="선택" disabled="disabled" />
											</c:if> <input name="checkId" type="hidden" value="<c:out value='${resultInfo.srNo}'/>" /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><a href="#LINK" onclick="javascript:fn_egov_detail_Sr('${resultInfo.srNo}')"><c:out value='${resultInfo.srNo}' /></a></td>
									<td class="ellipsis" nowrap="nowrap">
										<a href="#LINK" onclick="javascript:fn_egov_detail_Sr('${resultInfo.srNo}')">
											<c:forEach var="classCode_result" items="${classCode_result}" varStatus="status">
												<c:if test="${resultInfo.category == classCode_result.code}">
													<c:choose>
														<c:when test="${srLanguage == 'ko'}">
															[<c:out value="${classCode_result.codeNm}" />]
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															[<c:out value="${classCode_result.codeNmEn}" />]
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															[<c:out value="${classCode_result.codeNmCn}" />]
														</c:when>
														<c:otherwise>
															[<c:out value="${classCode_result.codeNm}" />]
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:forEach>
											<c:out value='${resultInfo.subject}' />
										</a>
									</td>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.pstinstNm}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
											<c:if test="${resultInfo.moduleCode == moduleCode_result.code}">
												<c:out value="${moduleCode_result.codeNm}" />
											</c:if>
										</c:forEach></td>
									<td nowrap="nowrap" <c:choose><c:when test="${resultInfo.status == '1000'}"> class="state00"</c:when><c:when test="${resultInfo.status == '1001'}"> class="state01"</c:when><c:when test="${resultInfo.status == '1002'}"> class="state02"</c:when><c:when test="${resultInfo.status == '1003'}"> class="state03"</c:when><c:when test="${resultInfo.status == '1004'}"> class="state04"</c:when><c:when test="${resultInfo.status == '1005'}"> class="state05"</c:when><c:when test="${resultInfo.status == '1006'}"> class="state06"</c:when><c:when test="${resultInfo.status == '1007'}"> class="state07"</c:when></c:choose>><c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
											<c:if test="${resultInfo.status == statusCode_result.code}">
														                            	<c:if test="${resultInfo.status == '1001'}">	
														                            		<c:if test="${resultInfo.returnResn != '' && resultInfo.returnResn != null}">반려</c:if>
														                            		<c:if test="${resultInfo.returnResn == '' || resultInfo.returnResn == null}">
														                            			<c:out value="${statusCode_result.codeNm}"/>
														                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" />
														                            		</c:if>

														                            		<c:if test="${resultInfo.sanctnerAt == 'N'}">반려
														                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" />
														                            			<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" />
														                            		</c:if>
														                            		<c:if test="${resultInfo.sanctnerAt != 'N'}">
														                            			<c:out value="${statusCode_result.codeNm}"/>
														                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" />
														                            			<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" />
														                            		</c:if>
														                            	</c:if>
														                            	<c:if test="${resultInfo.status != '1001'}">
												<c:choose>
													<c:when test="${resultInfo.status == '1006'}">
														<spring:message code='sr.complete' />
													</c:when>
													<c:otherwise>
																                            				<c:out value="${statusCode_result.codeNm}"/>
														<c:if test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:if>
														<c:if test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:if>
														<c:if test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:if>
														<c:if test="${srLanguage != 'ko' && srLanguage != 'en' && srLanguage != 'cn'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:if>
													</c:otherwise>
												</c:choose>
															                            	<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>"  />
															                            	<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" />
														                            	</c:if>
											</c:if>
										</c:forEach></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.customerNm}' /></td>
									<td class="tdwc" nowrap="nowrap">
																    	<c:out value='${resultInfo.rname}'/> <c:choose>
											<c:when test="${srLanguage == 'ko'}">
												<c:out value="${resultInfo.rname}" />
											</c:when>
											<c:when test="${srLanguage == 'en'}">
												<c:out value="${resultInfo.rnameEn}" />
											</c:when>
											<c:when test="${srLanguage == 'cn'}">
												<c:out value="${resultInfo.rnameEn}" />
											</c:when>
											<c:otherwise>
												<c:out value="${resultInfo.rname}" />
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.signDate}' /></td>
									<!-- 현업 및 결제자 -->
									<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.hopeDate}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.scheduleDate}' /></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.testCompleteDate}' /></td>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.tat}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.realExpectTime}' /></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.point}' /></td>
								</tr>
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
								</tr>
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
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
								        	  <a href="#"><img src="<c:url value='/' />images/sr/btn_prev.gif" width="59" height="21" align="absmiddle" />&nbsp;&nbsp; 1</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a href="#">2 &nbsp;&nbsp;<img src="<c:url value='/' />images/sr/btn_next.gif" width="59" height="21" border="0" align="absmiddle" /></a> <!-- 페이지 네비게이션 시작 -->
								<div id="paging_div">
									<ul class="paging_align">
										<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
									</ul>
								</div> <!-- //페이지 네비게이션 끝 --> <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" /> <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> <input type="hidden" name="searchStatus1001At" value="<c:out value='${searchVO.searchStatus1001At}'/>" /> <input type="hidden" name="srNoSanctnAllArr" />

							</td>
						</tr>
						<tr>
							<c:if test="${authorCode != 'ROLE_COOPERATION'}">
								<td align="right" valign="bottom" height="60"><span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_Sr(); return false;"><spring:message code='button.requestRegistration' /> ▶</a></span>&nbsp;
							</c:if>
							<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
								<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_SrSanctn(); return false;"><spring:message code='button.srAllApproval' /> ▶</a></span>&nbsp;            	
            	</c:if>
							<c:if test="${authorCode != 'ROLE_COOPERATION'}">
								<span class="btnblue"><a href="#LINK" onclick="javascript:fncExcelReport(); return false;"><spring:message code='button.excelMonthly' /> ▶</a></span>&nbsp; 
	            </c:if>
							<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
								<span class="btnblue"><a href="#LINK" onclick="javascript:fncExcelDetail(); return false;"><spring:message code='button.excelDetails' /> ▶</a></span>&nbsp;
                </c:if>
							</td>
						</tr>
					</table>
				</div>




			</form>


			<form name="Form" method="post" action="<c:url value='/sr/EgovSrSelectUpdtCstmr.do'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" name="srNo"> <input type="submit" id="invisible" class="invisible" /> <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" /> <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> <c:forEach var="vList3" items="${searchVO.searchStatus}" varStatus="vStatus3">
						<input type="hidden" name="searchStatus" value="<c:out value='${vList3}'/>">
					</c:forEach> <input type="hidden" name="searchStatusAllCheck" value="<c:out value='${searchVO.searchStatusAllCheck}'/>">        			<input type="hidden" name="searchStatusRetnrn" value="<c:out value='${searchVO.searchStatusRetnrn}'/>" >        			<input type="hidden" name="searchStatus1001At" value="<c:out value='${searchVO.searchStatus1001At}'/>" > <input type="hidden" name="searchConfirmDateF" value="<c:out value='${searchVO.searchConfirmDateF}'/>" /> <input type="hidden" name="searchConfirmDateT" value="<c:out value='${searchVO.searchConfirmDateT}'/>" /> <input type="hidden" name="searchConfirmDateFView" value="<c:out value='${searchVO.searchConfirmDateFView}'/>" /> <input type="hidden" name="searchConfirmDateTView" value="<c:out value='${searchVO.searchConfirmDateTView}'/>" /> <input type="hidden" name="searchCustomerNm" value="<c:out value='${searchVO.searchCustomerNm}'/>" /> <input type="hidden" name="searchRname"
						value="<c:out value='${searchVO.searchRname}'/>"
					/> <input type="hidden" name="searchRid" value="<c:out value='${searchVO.searchRid}'/>" /> <input type="hidden" name="searchCompleteDateF" value="<c:out value='${searchVO.searchCompleteDateF}'/>" /> <input type="hidden" name="searchCompleteDateT" value="<c:out value='${searchVO.searchCompleteDateT}'/>" /> <input type="hidden" name="searchCompleteDateFView" value="<c:out value='${searchVO.searchCompleteDateFView}'/>" /> <input type="hidden" name="searchCompleteDateTView" value="<c:out value='${searchVO.searchCompleteDateTView}'/>" /> <input type="hidden" name="searchTcode" value="<c:out value='${searchVO.searchTcode}'/>" /> <input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>" /> <input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>" /> <input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>" /> <input type="hidden" name="searchSubject"
						value="<c:out value='${searchVO.searchSubject}'/>"
					/> <input type="hidden" name="language" value="<c:out value='${srLanguage}'/>" />
			</form>

		</div>
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div>
	</div> --%>

	<!-- //전체 레이어 끝 -->

</body>

</html>

<script type="text/javascript">
//다국어 적용
//saveLanguage();
// alert("cookie saveLanguage : " + getCookie("saveLanguage")) ; 
</script>