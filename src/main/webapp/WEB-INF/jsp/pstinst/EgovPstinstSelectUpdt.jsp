<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
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
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->

<title>고객사 상세 및 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="pstinstVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_pstinst_bak(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
function fnListPage(){
    document.pstinstVO.action = "<c:url value='/pstinst/EgovPstinstList.do'/>";
    document.pstinstVO.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipRemove.do'/>";
        varForm.pstinstCode.value        = "${pstinstVO.pstinstCode}";
        varForm.submit();
    }
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnUpdate(){
    if(validatePstinstVO(document.pstinstVO)){
    	
    	//중복확인
    	var rows = document.getElementById("rowAddTable").rows.length;
    	var cnt = 0;	
    	
    	for(var i=rows-2;i>=0;i--){
    		for(var j=rows-2;j>=0;j--){
    			if(document.pstinstVO.elements["moduleCodes"][i].value == document.pstinstVO.elements["moduleCodes"][j].value){
    				cnt++;    				
    			}
    			
    		}
    		if(cnt > 1){
    			alert("중복된 모듈이 있습니다.");
          	 	return;
    		}
    		cnt = 0;
    	}
        document.pstinstVO.submit();
    }
}

//접속정보 추가
function fncConnAdd(index)	{
	
	var sTable = document.getElementById("connTable");

	var lastRow = sTable.rows.length;
	var rowCnt = lastRow - 2;

	var row = sTable.insertRow(lastRow);
	row.id = "rowTr"+rowCnt;
	
	row.className = "tdcenter";
	
	var cell01 = row.insertCell(0);
	cell01.className = "tdcenter";
	cell01.innerHTML ="<input type='checkbox' name='selectBox2' id='selectBox2"+rowCnt+"' />"; 
	
	var cell02 = row.insertCell(1);
	cell02.className = "tdcenter";
	cell02.innerHTML ="<input name='nameDetails' id='nameDetail"+rowCnt+"' cssClass='txaIpt' maxlength='180' style='width:90%;'/>";
	
	var cell03 = row.insertCell(2);
	cell03.className = "tdcenter";
	// cell03.innerHTML ="<input name='typeCodes' id='typeCode"+rowCnt+"' cssClass='txaIpt' maxlength='15' style='width:90%;'/>";
	cell03.innerHTML = "<select name='typeCodes' id='typeCode"+rowCnt+"' title='운영타입'><option value='' >==선택==</option><c:forEach var='result' items='${type_result}' varStatus='status'><option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option></c:forEach></select>";


	var cell04 = row.insertCell(3);
	cell04.className = "tdcenter";
	cell04.innerHTML ="<input name='sids' id='sid"+rowCnt+"' cssClass='txaIpt' maxlength='3' style='width:90%;'/>";
	
	var cell05 = row.insertCell(4);
	cell05.className = "tdcenter";
	cell05.innerHTML ="<input name='inss' id='ins"+rowCnt+"' cssClass='txaIpt' maxlength='2' style='width:90%;'/>";
	
	var cell06 = row.insertCell(5);
	cell06.className = "tdcenter";
	cell06.innerHTML ="<input name='ipAddrs' id='ipAddr"+rowCnt+"' cssClass='txaIpt' maxlength='20' style='width:90%;'/>";
	
	var cell07 = row.insertCell(6);
	cell07.className = "tdcenter";
	cell07.innerHTML ="<input name='sapIds' id='sapId"+rowCnt+"' cssClass='txaIpt' maxlength='20' style='width:90%;'/>";
	
	var cell08 = row.insertCell(7);
	cell08.className = "tdcenter";
	cell08.innerHTML ="<input name='sapPasswds' id='sapPasswd"+rowCnt+"' cssClass='txaIpt' maxlength='20' style='width:90%;'/>";
	
	var cell09 = row.insertCell(8);
	cell09.className = "tdcenter";
	cell09.innerHTML ="<input name='clients' id='client"+rowCnt+"' cssClass='txaIpt' maxlength='3' style='width:90%;'/>";
}
//접속정보 삭제
function fncConnAddDelete()	{
	
	var rows = document.getElementById("connTable").rows.length;
	
	var j=rows-3;
	var cnt = 0;

	for(var i=rows-3;i>=0;i--){
		if(document.pstinstVO.elements["selectBox2"][i].checked){
			cnt++;
		}
	}
	
    if(cnt == 0){
		alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
		return;
    }
	for(var i=rows-3;i>=0;i--){
		if(document.pstinstVO.elements["selectBox2"][i].checked){
			document.getElementById("connTable").deleteRow(i+3);
		}
	}
}


//모듈담당자 추가
var enableRowCnt = 0;
function fncAdd(index)	{
	
	var orderNum = enableRowCnt+2;
	var sTable = document.getElementById("rowAddTable");

	enableRowCnt++;
	
	var lastRow = sTable.rows.length;
	

	var row = sTable.insertRow(lastRow);
	row.id = "rowTr"+enableRowCnt;
	
	row.className = "tdcenter";
	
	var cell01 = row.insertCell(0);
	cell01.innerHTML ="&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selectBox' id='selectBox"+enableRowCnt+"' />"; 
	
	var cell02 = row.insertCell(1);
	cell02.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='moduleCodes' id='moduleCode"+enableRowCnt+"' title='모듈코드'><option value='' >==선택==</option><c:forEach var='result' items='${moduleCode_result}' varStatus='status'><option value='<c:out value="${result.code}"/>'><c:out value='${result.codeNm}'/></option></c:forEach></select>";
	
	var cell03 = row.insertCell(2);
	cell03.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='userIdAs' id='userIdA"+enableRowCnt+"' title='담당자'><option value='' >==선택==</option><c:forEach var='result' items='${chargerList}' varStatus='status'><option value='<c:out value="${result.userId}"/>'><c:out value='${result.userNm}'/></option></c:forEach></select>";
	
	var cell04 = row.insertCell(3);
	cell04.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='userIdBs' id='userIdB"+enableRowCnt+"' title='담당자'><option value='' >==선택==</option><c:forEach var='result' items='${chargerList}' varStatus='status'><option value='<c:out value="${result.userId}"/>'><c:out value='${result.userNm}'/></option></c:forEach></select>";

}



//모듈담당자 삭제
function fncAddDelete()	{
	
	var rows = document.getElementById("rowAddTable").rows.length;
	
	var j=rows-2;
	var cnt = 0;	
	
	if(j == 0) {
		if(document.pstinstVO.elements["selectBox"].checked==false){
			alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
			return;
		}else{	
			alert("첫행은 삭제할수 없습니다.");
      	 	return;
		}
	} 
	
	for(var i=rows-2;i>=0;i--){
		if(document.pstinstVO.elements["selectBox"][i].checked){
			cnt++;
		}
	}
	
    if(cnt == 0){
		alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
		return;
    }
//     if(confirm("삭제 하시겠습니까?")){
	    for(var i=rows-2;i>=0;i--){
			if(document.pstinstVO.elements["selectBox"][i].checked){
				document.getElementById("rowAddTable").deleteRow(i+1);
				cnt++;
			}
		}
		enableRowCnt--;
// 	}
}



-->

function fncConnAdd(index)	{

	var cnt = $("button[name='selectBox2']").length;
  	
	var html = "";
	
	html += '<tr>';
	//html += '<td><span class="sbux-chk-wrap sbux-comp-root sbux-uuid-selectBox2" style="padding: 0px 0 0px 0"><input id="selectBox2_'+cnt+'" type="checkbox" class="sbux-chk-input sbux-exist" data-sbux-name="selectBox2" true-value="true" style="display: none" false-value="false" value="true" text="" name="selectBox2" data-sbux-model-name="selectBox2" data-sbux-storage-data="value"><label for="selectBox2_'+cnt+'" title=""><span class="glyphicon sbux-chk-box" aria-hidden="true"></span><span class="sbux-chk-txt " style="padding:0 0px 0 0px;  " undefined="" tabindex="-1"></span></label></span></td>';
	html += '<td><button onclick = "javascript:fncConnAddDelete('+cnt+')" id="selectBox2_'+cnt+'" type="button" class="sbux-btn   sbux-exist sbux-comp-root sbux-uuid-selectBox2 btn-default add-delete-btn" autocomplete="off" name="selectBox2" data-sbux-model-name="selectBox2" data-sbux-storage-data="value"><span class="sbux-btn-txt">삭제</span></button></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-nameDetails"><input id="nameDetail_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="nameDetails" value="${pstinstVO.name}" maxlength="180" style="width:100%;" data-sbux-model-name="nameDetails" data-sbux-storage-data="value"></span></td>';
	html += '<td><select id="typeCodes_'+cnt+'" class="sbux-sel  sbux-exist sbux-comp-root sbux-uuid-typeCodes" name="typeCodes" data-sbux-model-name="typeCodes" data-sbux-storage-data="value"><c:forEach var="result" items="${type_result}"><option value="<c:out value="${result.code}"/>"<c:if test="${result.code == list.typeCode}">selected</c:if>><c:out value="${result.codeNm}"/></option></c:forEach></select></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-sids"><input id="sid_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="sids" value="" style="width:100%;" data-sbux-model-name="sids" data-sbux-storage-data="value"></span></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-inss"><input id="ins_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="inss" value="" maxlength="2" style="width:100%;" data-sbux-model-name="inss" data-sbux-storage-data="value"></span></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-ipAddrs"><input id="ipAddr_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="ipAddrs" value="" maxlength="50" style="width:100%;" data-sbux-model-name="ipAddrs" data-sbux-storage-data="value"></span></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-sapIds"><input id="sapId_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="sapIds" value="" maxlength="20" style="width:100%;" data-sbux-model-name="sapIds" data-sbux-storage-data="value"></span></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-sapPasswds"><input id="sapPasswd_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="sapPasswds" value="" maxlength="20" style="width:100%;" data-sbux-model-name="sapPasswds" data-sbux-storage-data="value"></span></td>';
	html += '<td><span style="width:100%;" class="sbux-comp-root sbux-uuid-clients"><input id="client_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="clients" value="" maxlength="3" style="width:100%;" data-sbux-model-name="clients" data-sbux-storage-data="value"></span></td>';
	html += '</tr>';
	
	$('#vpnList > tbody:last').append(html);
	//$('#ctsChk').val("Y");
}

function fncAdd(index){
	
	var cnt = $("button[name='selectBox']").length;
	
	var html = "";
	html += '<tr>';
	//html += '<td><span class="sbux-chk-wrap sbux-comp-root sbux-uuid-selectBox" style="padding: 0px 0 0px 0"><input id="selectBox_'+cnt+'" type="checkbox" class="sbux-chk-input sbux-exist" data-sbux-name="selectBox" true-value="true" style="display: none" false-value="false" value="true" text="" name="selectBox" data-sbux-model-name="selectBox" data-sbux-storage-data="value"><label for="selectBox_'+cnt+'" title=""><span class="glyphicon sbux-chk-box" aria-hidden="true"></span><span class="sbux-chk-txt " style="padding:0 0px 0 0px;  " undefined="" tabindex="-1"></span></label></span></td>';	
	html += '<td><button onclick = "javascript:fncAddDelete('+cnt+')" id="selectBox_'+cnt+'" type="button" class="sbux-btn   sbux-exist sbux-comp-root sbux-uuid-selectBox btn-default add-delete-btn" autocomplete="off" name="selectBox" data-sbux-model-name="selectBox" data-sbux-storage-data="value"><span class="sbux-btn-txt">삭제</span></button></td>';
	html += '<td><select id="moduleCode_'+cnt+'" class="sbux-sel  sbux-exist sbux-comp-root sbux-uuid-moduleCodes" name="moduleCodes" title="모듈코드" data-sbux-model-name="moduleCodes" data-sbux-storage-data="value"><option value="">선택</option><c:forEach var="result" items="${moduleCode_result}"><option value="<c:out value="${result.code}"/>"<c:if test="${result.code == list.moduleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option></c:forEach></select></td>';
	html += '<td><select id="userIdA_'+cnt+'" class="sbux-sel  sbux-exist sbux-comp-root sbux-uuid-userIdAs" name="userIdAs" title="담당자" data-sbux-model-name="userIdAs" data-sbux-storage-data="value"><option value="">선택</option><c:forEach var="result" items="${chargerList}"><option value="<c:out value="${result.userId}"/>"<c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option></c:forEach></select></td>';	
	html += '<td><select id="userIdB_'+cnt+'" class="sbux-sel  sbux-exist sbux-comp-root sbux-uuid-userIdBs" name="userIdBs" title="담당자" data-sbux-model-name="userIdBs" data-sbux-storage-data="value"><option value="">선택</option><c:forEach var="result" items="${chargerList}"><option value="<c:out value="${result.userId}"/>"<c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option></c:forEach></select></td>';	
	html += '</tr>';
	
	$('#chargeList > tbody:last').append(html);
}

//모듈담당자 삭제
function fncAddDelete(cnt)	{
	
	/* var rows = document.getElementById("chargeList").rows.length;
	
	var j=rows-2;
	var cnt = 0;	
	
	if(j == 0) {
		if(document.pstinstVO.elements["selectBox"].checked==false){
			alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
			return;
		}else{	
			alert("첫행은 삭제할수 없습니다.");
      	 	return;
		}
	} 
	
	for(var i=rows-2;i>=0;i--){
		if(document.pstinstVO.elements["selectBox"][i].checked){
			cnt++;
		}
	}
	
    if(cnt == 0){
		alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
		return;
    }
     if(confirm("삭제 하시겠습니까?")){
	    for(var i=rows-2;i>=0;i--){
			if(('#selectBox_'+i).val() == 'true'){
				document.getElementById("chargeList").deleteRow(i+1);
				cnt++;
			}
		}
		enableRowCnt--;
 	} */
 	
	tr = $("#selectBox_"+cnt).parent().parent();
	tr.remove();
}

//접속정보 삭제
function fncConnAddDelete(cnt)	{
	
	/* var rows = document.getElementById("vpnList").rows.length;
	
	var j=rows-2;
	var cnt = 0;

	for(var i=rows-1;i>=0;i--){
		if($('#selectBox2_'+i).val() == 'true'){
			cnt++;
		}
	}
	
    if(cnt == 0){
		alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
		return;
    }
	for(var i=rows-2;i>=0;i--){
		if($('#selectBox2_'+i).val() == 'true'){
			document.getElementById("vpnList").deleteRow(i+1);
		}
	} */
	
	tr = $("#selectBox2_"+cnt).parent().parent();
	tr.remove();
}

/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnUpdate(){
    if(validatePstinstVO(document.pstinstVO)){
    	
    	//중복확인
    	var rows = document.getElementById("chargeList").rows.length;
    	var cnt = 0;	
    	
    	for(var i=rows-2;i>=0;i--){
    		for(var j=rows-2;j>=0;j--){
    			if(document.pstinstVO.elements["moduleCodes"][i].value && (document.pstinstVO.elements["moduleCodes"][i].value == document.pstinstVO.elements["moduleCodes"][j].value)){
    				cnt++;    				
    			}
    			
    		}
    		if(cnt > 1){
    			alert("중복된 모듈이 있습니다.");
          	 	return;
    		}
    		cnt = 0;
    	} 
        //document.pstinstVO.submit();
        
        //console.log(document.pstinstVO);
        
        var form = $("#pstinstVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}        
        $.ajax({        	
			url : "<c:url value='/pstinst/EgovPstinstSelectUpdt.do'/>"			
			,type : "POST"
			,data : formData
	     	,contentType : false
	     	,processData : false
			,beforeSend : fn_loading()
			,success : function(data){
				alert(data.msg);
				if(data.msgType == 'S') {
					location.replace('<c:url value='/pstinst/EgovPstinstList.do'/>');
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
    }
}

function fnInsert(){
	if(validatePstinstVO(document.pstinstVO)){
		
		//중복확인
    	var rows = document.getElementById("chargeList").rows.length;
    	var cnt = 0;	
    	
    	for(var i=rows-2;i>=0;i--){
    		for(var j=rows-2;j>=0;j--){
    			if(document.pstinstVO.elements["moduleCodes"][i].value == document.pstinstVO.elements["moduleCodes"][j].value){
    				cnt++;    				
    			}
    			
    		}
    		if(cnt > 1){
    			alert("중복된 모듈이 있습니다.");
          	 	return;
    		}
    		cnt = 0;
    	} 
    	//document.pstinstVO.action = "<c:url value='/pstinst/EgovPstinstRegist.do'/>";
    	//document.pstinstVO.submit();
    	
    	var form = $("#pstinstVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}        
        $.ajax({        	
			url : "<c:url value='/pstinst/EgovPstinstSelectUpdt.do'/>"			
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
    }
}


function init(){
	if(SBUxMethod.getModalStatus("modalMenu") == 'open'){
		fn_loading();
		createGrid();
	}
}

var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];
var isOpen = "";


function fn_egov_AddrSearch() {	
	SBUxMethod.openModal('modalMenu');
	isOpen = SBUxMethod.getModalStatus("modalMenu");
	if(isOpen == 'open'){
		init();
	}
}
	
async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
		$.ajax({
			url : "<c:url value='/select/pstinst/EgovPstinstAddress.do'/>"			
			,type : "POST"
			,data : {
				${_csrf.parameterName } : '${_csrf.token }'
				, keyword : $('#keyword').val().replace(/(\s*)/g, "")
				, currentPage : Number(payload.pageNo) + 1
			}
			, success : function(data){
				if(data.message == 'error') {
					alert('없음');
				} else {
					resolve({ total: data.common.totalCount, selected: data.juso })
		   			$("#totalCnt").text(data.common.totalCount);					
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
	isOpen = SBUxMethod.getModalStatus("modalMenu");
	
	if(isOpen == 'open'){
	
	    let dsConfig = {
	   	schema: {
	   		id : (value) => value.roadAddr + ';' + value.zipNo
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
		    height: "490px",
		    captionHeight: 40,
		    rowHeight:40,
		    showCheck:false,
		    columns: [
	    	{ field: 'zipNo', caption: "우편번호", editable: false, type: 'text', width:15, unit: '%'},
	    	{ field: 'roadAddr', caption: "도로명주소", editable: false, type: 'text', width:65, unit: '%'},
			{ field: 'jibunAddr', caption: "지번주소", editable: false, type: 'text', width:20, unit: '%', visible: false}, 
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
	 	                	if(command.column){	  	                		
	  	  	                	var roadAddr = SBGrid3.getValue(grid, command.key, 'roadAddr');
	  	  	                	var zipNo = SBGrid3.getValue(grid, command.key, 'zipNo');
	  	  	                	
	  	  	                	$('#address1').val(roadAddr);
	  	  	    				$('#zipCode').val(zipNo);	
	  	  	    				SBUxMethod.closeModal('modalMenu');
	  	  	                }
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
}


function fnSearch(){
    SBGrid3.reload(datagrid);
}

function fnInsertAddr() {
	const id = SBGrid3.getCheckedKeys(datagrid);
	var address1 =''; 
	var zipCode = '';
	
	if(id.length > 1) {
		alert('한 개만 선택해주세요.');
		
	} else if (id.length < 1) {
		alert('선택한 항목이 없습니다.')
		
	} else {
		var tempId = id[0].split(';');
		address1 += tempId[0];
		zipCode += tempId[1];
		
		$('#address1').val(address1);
		$('#zipCode').val(zipCode);
		SBUxMethod.closeModal('modalMenu');
	}
	
}

function validatePstinstVO(form){

	var checkOption = {
		name : { valid : "required, maxlength" 
					, label : "<spring:message code='sr.client'/>" 
					, max : 100 }
		, ename : { valid : "required" , label : "고객사 영문명"}
		, pstinstAbrv : { valid : "required" , label : "고객사 약어"}
		, moduleCode : { valid : "required" , label : "<spring:message code='sr.module'/>"}
		, sids : { valid : "maxlength" , label : "시스템 ID", max : 3}

	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}

</script>
<script>
$(document).ready(function(){	
	
	var atchFileId = $("#atchFileId").val();
	if(atchFileId){
		$.ajax({
	    	url : "<c:url value='/cmm/fms/selectFileInfById.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#pstinstVO").serialize(),
	   	    success : function(data){
	 	   		for(var i in data.fileList){
	 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
	 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
	 	   			data.fileList[i].size = data.fileList[i].fileMg;
	 	   		}
	 	   		SBUxMethod.refresh('fileUpload',{'jsondataRef':data.fileList});
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	//fn_closeLoading();
	   	    }
		});
	}
	SBUxMethod.set('remark', $("#remarkId").val());
});

const autoHyphen = (target) => {
 target.value = target.value
   .replace(/[^0-9]/g, '')
   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}
</script>
<style>
.add-delete-btn {
	font-size: 13px;
    font-weight: normal;
    color: #0f5cac;
    border: 1px solid #3780cb;
    background: #f1f5f9;
    border-radius: 3px;
    margin-left : 5px;
}
</style>
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
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
               	<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
                <!-- 검색 필드 박스 시작 -->
		        <form modelAttribute="pstinstVO" action="${pageContext.request.contextPath}/pstinst/EgovPstinstSelectUpdt.do" id="pstinstVO" name="pstinstVO" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		        	<input type="hidden" id = "atchFileId" name="atchFileId" value="<c:out value="${pstinstVO.fileId}"/>"/>
		      		<input type="hidden" id = "remarkId" name="remarkId" value="<c:out value="${pstinstVO.remark}"/>"/>
                    <div class="sr-table-wrap" style="margin : 25px 0px">
                    
                		<table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
	                            <col width="38%">
	                            <col width="12%">
	                            <col width="38%">
		                    </colgroup>
						  <tr> 
						    <th>
								<sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="고객사명"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input uitype="text" name="name" id="name" cssClass="txaIpt" size="30"  maxlength="30" style="width:100%;" value="${pstinstVO.name}"/>
						    </td>
						    <th>
			                	<sbux-label id="th_text2" name="th_text2" uitype="normal" class = "imp-label" text="고객사 영문명"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input uitype="text" name="ename" id="ename" size="30"  maxlength="30" style="width:100%;" value="${pstinstVO.ename}"/>
						    </td>    
						  </tr>

						  <tr> 
						    <th>
								<sbux-label id="th_text3" name="th_text3" uitype="normal" text="전화번호"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input uitype="text" name="tel" id="tel" size="30"  maxlength="30" style="width : 100%;" value="${pstinstVO.tel}" oninput="autoHyphen(this)"/>
				            </td>
						    <th>
								<sbux-label id="th_text4" name="th_text4" uitype="normal" text="팩스번호"></sbux-label>						    	
						    </th>          
						    <td>
						    	<sbux-input uitype="text" name="fax" id="fax" size="30"  maxlength="30" style="width : 100%;" value="${pstinstVO.fax}"/>
						    </td>    
						  </tr>

						  <tr>
						    <th>
						    	<sbux-label id="th_text5" name="th_text5" uitype="normal" text="주소"></sbux-label>
						    </th>
						    <td colspan = '3'>
						        <hidden id="zipCode" name="zipCode" />
		                        <sbux-input name="address1" id="address1" title="주소" size="60" maxlength="255" readonly="true" style="width : 60%; float:left;" value="${pstinstVO.address1}"></sbux-input>
		                        <sbux-button id="button9" name="button9" uitype="normal" text="주소검색" class="btn-default add-delete-btn" onclick="fn_egov_AddrSearch()" style="float:right;"></sbux-button>						        
			                    <sbux-input name="zip_view" id="zip_view" uitype="hidden" title="우편번호" size="20" value="<c:out value='${pstinstVO.zipCode}'/>"  maxlength="8" readonly="readonly" />
						    </td>
						  </tr>
						  <tr>  
						    <th>
						    	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="상세주소"></sbux-label>
						    </th>
						    <td colspan="3">
						        <sbux-input uitype="text" name="address2" id="address2" title="상세주소" size="74" maxlength="255" value="${pstinstVO.address2}" style="width : 100%;"/>
						    </td>
						  </tr>
						  <tr> 
						    <th>
						    	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="결재기능"></sbux-label>
						    </th>
						    <td>
						    	<sbux-radio uitype="normal" id="settleAt1" name="settleAt" value="Y" text= "<spring:message code="pstinst.settleY" />" <c:if test="${pstinstVO.settleAt == 'Y'}"> checked="checked"</c:if>></sbux-radio>
					            <sbux-radio uitype="normal" id="settleAt2" name="settleAt" value="N" text ="<spring:message code="pstinst.settleN" />" <c:if test="${pstinstVO.settleAt == 'N'}"> checked="checked"</c:if>></sbux-radio>                                
						    </td>
						    <th>
						    	<sbux-label id="th_text8" name="th_text8" uitype="normal" text="계약공수"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="contractTime" id="contractTime"  onclick="checkNum(this);" onKeyUp="checkNum(this);commaDot(this,8,2);" size="10"  maxlength="10" value="${pstinstVO.contractTime}"></sbux-input>
				                <sbux-label uitype="normal" text="<spring:message code='sr.predictionLabourHoursEx'/>"></sbux-label>
						    </td>    
						  </tr>
						  <tr> 
						    <th>
						    	<sbux-label id="th_text9" name="th_text9" uitype="normal" text="계약방식"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input name="contractKind" id="contractKind" uitype="text" size="20"  maxlength="20" value="${pstinstVO.contractKind}" style="width:100%;"/>
						    </td>
						    <th>
						    	<sbux-label id="th_text10" name="th_text10" uitype="normal" text="업종코드"></sbux-label>
						    </th>          
						    <td>
				                  <sbux-select id="jobCode" name="jobCode" uitype="single" style="width:100%">
								    <c:forEach var="result" items="${jobCode_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == pstinstVO.jobCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								  </sbux-select>
						    </td>    
						  </tr>
						  
						  <tr> 
						    <th>
						    	<sbux-label id="th_text11" name="th_text11" uitype="normal" class = "imp-label" text="고객사 약어"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="pstinstAbrv" id="pstinstAbrv" size="2"  maxlength="2" value="${pstinstVO.pstinstAbrv}" style="width:100%"/>
						    </td> 
						    <th>
						    	<sbux-label id="th_text12" name="th_text12" uitype="normal" text="삭제여부"></sbux-label>
						    </th>
						    <td>
						    	<sbux-select id="delAt" name="delAt" class="select" title="삭제여부">
								    <c:forEach var="result" items="${delAt_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == pstinstVO.delAt}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								  </sbux-select>
						    </td>
						  </tr>
						  
						  <tr> 
						    <th>
						    	<sbux-label id="th_text13" name="th_text13" uitype="normal" text="등록일"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input name="createDate" id="createDate" size="2"  maxlength="2" value="<c:out value='${pstinstVO.createDate}'/>" style="width:100%" readonly/>
						    </td>
						    <th>
						    	<sbux-label id="th_text14" name="th_text14" uitype="normal" text="변경일"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="editDate" id="editDate" size="2"  maxlength="2" value="<c:out value='${pstinstVO.editDate}'/>" style="width:100%" readonly/>
						    </td>    
						  </tr>
						  
						  <tr> 
						    <th>
						    	<sbux-label id="th_text15" name="th_text15" uitype="normal" text="비고"></sbux-label>
						    </th>
						    <td colspan="3">
			                    <sbux-input name="note" id="note" size="105" maxlength="300" value="${pstinstVO.note}" style="width:100%"/>
							</td>
						  </tr>
						  
                        </table>
                    </div>
					
                    <div class="sr-table-wrap" style="margin : 25px 0px">
                		<table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
	                            <col width="38%">
	                            <col width="12%">
	                            <col width="38%">
		                    </colgroup>
						  <tr> 
						    <th>
						    	<sbux-label id="th_text16" name="th_text16" uitype="normal" text="접속방법"></sbux-label>
						    </th>

							<td style="border-right:0px;">
								<sbux-select id="connMethodCode" name="connMethodCode" class="select" title="접속방법">
									<c:forEach var="result" items="${connMethodCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == pstinstVO.connMethodCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</sbux-select>
							</td>
							<td style="border-right:0px; border-left:0px;"></td>
							<td style="border-left:0px;"></td>   
						  </tr>

						  <tr> 
						    <th>
						    	<sbux-label id="th_text17" name="th_text17" uitype="normal" text="VPN URL 정보"></sbux-label>
						    </th>
						    <td colspan="3">
						    	<sbux-input name="vpnUrl" id="vpnUrl" size="100"  maxlength="180" value="${pstinstVO.vpnUrl}" style="width:100%;"></sbux-input>
				            </td>
						  </tr>
						  
						  <tr> 
						    <th>
						    	<sbux-label id="th_text18" name="th_text18" uitype="normal" text="VPN IP Address"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input name="vpnAddr" id="vpnAddr" size="30" style="width:100%;" maxlength="30" value="${pstinstVO.vpnAddr}"></sbux-input>
				            </td>
						    <th>
						    	<sbux-label id="th_text19" name="th_text19" uitype="normal" text="VPN Port"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="vpnPort" id="vpnPort" size="30"  maxlength="30" style="width:100%;" value="${pstinstVO.vpnPort}"></sbux-input>
						    </td>    
						  </tr>

						  <tr> 
						    <th>
						    	<sbux-label id="th_text20" name="th_text20" uitype="normal" text="VPN ID"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input name="vpnId" id="vpnId"  size="30"  maxlength="30" value="${pstinstVO.vpnId}" style="width:100%;"></sbux-input>
				            </td>
						    <th>
						    	<sbux-label id="th_text21" name="th_text21" uitype="normal" text="VPN Password"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="vpnPasswd" id="vpnPasswd" size="30"  maxlength="30" value="${pstinstVO.vpnPasswd}" style="width:100%;"></sbux-input>
						    </td>    
						  </tr>				  
						  
						  <tr> 
						    <th>
						    	<sbux-label id="th_text22" name="th_text22" uitype="normal" text="OTP 사용여부"></sbux-label>
						    </th>
						    <td>
						    	<sbux-radio uitype="normal" id="otp1" name="otp" value="Y" text= "사용" <c:if test="${pstinstVO.otp == 'Y'}"> checked="checked"</c:if>></sbux-radio>
					            <sbux-radio uitype="normal" id="otp2" name="otp" value="N" text ="미사용" <c:if test="${pstinstVO.otp == 'N'}"> checked="checked"</c:if>></sbux-radio>
						    	<%-- 사용 : <input type="radio" name="otp" class="radio2" value="Y" <c:if test="${pstinstVO.otp == 'Y'}"> checked="checked"</c:if>>&nbsp;
					            미사용 : <input type="radio" name="otp" class="radio2" value="N" <c:if test="${pstinstVO.otp == 'N'}"> checked="checked"</c:if>> --%>                                
							</td>
						    <th>
						    	<sbux-label id="th_text23" name="th_text23" uitype="normal" text="Solman 사용여부"></sbux-label>
						    </th>
						    <td>
						    	<sbux-radio uitype="normal" id="solman1" name="solman" value="Y" text= "사용" <c:if test="${pstinstVO.solman == 'Y'}"> checked="checked"</c:if>></sbux-radio>
					            <sbux-radio uitype="normal" id="solman2" name="solman" value="N" text ="미사용" <c:if test="${pstinstVO.solman == 'N'}"> checked="checked"</c:if>></sbux-radio>
						    	<%-- 사용 : <input type="radio" name="solman" class="radio2" value="Y" <c:if test="${pstinstVO.solman == 'Y'}"> checked="checked"</c:if>>&nbsp;
					            미사용 : <input type="radio" name="solman" class="radio2" value="N" <c:if test="${pstinstVO.solman == 'N'}"> checked="checked"</c:if>>  --%>                               
						    </td>
						  </tr>

	    				  <input type="hidden" name="fileId" value="<c:out value='${pstinstVO.fileId}'/>"/>
						  <%-- <c:if test="${empty pstinstVO.fileId}"> --%>
                               <input type="hidden" name="fileListCnt" value="0" />
						  <%-- </c:if> --%>
						  <tr> 
						    <th>
						    	<sbux-label id="th_text24" name="th_text24" uitype="normal" text="<spring:message code="cop.atchFile" />"></sbux-label>
						    </th>
							<td colspan="3">
								<sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
                                   	vertical-scroll-height="100px"
                                   	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
                                   	header-title="<spring:message code="cop.atchFile" />"
                                   	drop-zone="true"
                                   	button-add-title="<spring:message code="sr.ctsAdd" />"
                                   	button-delete-title="<spring:message code="sr.ctsDel" />"
                                   	callback-click-list= "fnFileDownload" 
                                   	callback-click-delete= "fnFileDelete"
                                   	callback-delete-button-pressed="fnFileDeleteList" >
								</sbux-fileupload>
								<!-- <input name="file_1" id="egovComFileUploader" type="file" />
		                        <div id="egovComFileList"></div>
		                        <div id="file_upload_imposbl"  >
								</div> -->
							</td>
						  </tr>

                           <%-- <c:if test="${not empty pstinstVO.fileId}">
                              <tr> 
                                <th>
                                	<sbux-label id="th_text25" name="th_text25" uitype="normal" text="<spring:message code="cop.atchFileList" />"></sbux-label>                                
                                </th>
                                <td colspan="3">
                               		<sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
                                    	vertical-scroll-height="150px"
                                    	accept-file-types="txt|docx?|xls?x|pdf|gif|jpe?g|png"
                                    	header-title="<spring:message code="cop.atchFile" />"
                                    	drop-zone="true"
                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
                                    	button-delete-title="<spring:message code="sr.ctsDel" />"
                                    	callback-click-list= "fnFileDownload" 
                                    	callback-click-delete= "fnFileDelete"
                                    	callback-delete-button-pressed="fnFileDeleteList" >
									</sbux-fileupload>
									<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${pstinstVO.fileId}" />
									</c:import>
                                </td>
                              </tr>

                          </c:if>
 --%>


						  <tr> 
						    <th>
						    	<sbux-label id="th_text26" name="th_text26" uitype="normal" text="특이사항"></sbux-label>
						    </th>
							<td colspan="3" style="height:250px;">
								<sbux-textarea id="remark" name="remark"  uitype="normal" style="width:100%; height:inherit;" convert-special-code="true"><c:out value="${pstinstVO.remark}" escapeXml="true" /></sbux-textarea>                       
						    </td>
						  </tr>
						  
                        </table>
                    <!-- </div>
					<div class="sr-table-wrap"> -->
                		<table id="vpnList" name="vpnList" class="sr-table" style="margin-top : 5px">
		                    <colgroup>
		                        <col width="5%">
		                        <col width="15%">
		                        <col width="10%">
		                        <col width="10%">
		                        <col width="10%">
		                        <col width="15%">
		                        <col width="15%">
		                        <col width="15%">
		                        <col width="5%">
		                    </colgroup>
		                    <tbody>
							<tr>
								<th>
									<!-- <sbux-label id="th_text27" name="th_text27" uitype="normal" text="선택"></sbux-label> -->
									<sbux-button id="button1" name="button1" uitype="normal" text="추가" onclick="fncConnAdd()" class="btn-default add-delete-btn"></sbux-button>
								</th>
								<th>
									<sbux-label id="th_text28" name="th_text28" uitype="normal" text="고객사명(세부)"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text29" name="th_text29" uitype="normal" text="TYPE"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text30" name="th_text30" uitype="normal" text="시스템ID"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text31" name="th_text31" uitype="normal" text="인스턴스번호"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text32" name="th_text32" uitype="normal" text="IP Address"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text33" name="th_text33" uitype="normal" text="SAP ID"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text34" name="th_text34" uitype="normal" text="SAP Password"></sbux-label>
								</th>
								<th>
									<sbux-label id="th_text35" name="th_text35" uitype="normal" text="Client"></sbux-label>
								</th>
							</tr>
							<c:if test="${!empty srconnectList}">
					  			<c:set var="trIdValue" value="0"/>
						  		<c:forEach var="list" items="${srconnectList}" varStatus="status">
							  		<tr>
							  			<td>
							  				<%-- <sbux-checkbox uitype="normal" name="selectBox2" id="selectBox2_<c:out value = "${status.index}"/>" ></sbux-checkbox> --%>
							  				<sbux-button id="selectBox2_<c:out value = "${status.index}"/>" name="selectBox2" uitype="normal" text="삭제" onclick="fncConnAddDelete(<c:out value = "${status.index}"/>)" class="btn-default add-delete-btn"></sbux-button>
						  				</td>
										<td>
											<sbux-input uitype="text" name='nameDetails' id='nameDetail_<c:out value = "${status.index}"/>' maxlength='180' value="${list.nameDetail}"  style="width:100%;"></sbux-input>
										</td>
										<td>
						                  <sbux-select uitype="single" name="typeCodes" id="typeCodes_<c:out value = "${status.index}"/>">
										    <c:forEach var="result" items="${type_result}">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == list.typeCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										  </sbux-select>
									  	</td>
										 <td>
											<sbux-input uitype="text" name='sids' id='sid_<c:out value = "${status.index}"/>' value="${list.sid}" style="width:100%;"></sbux-input>
										</td>
										<td>
											<sbux-input uitype="text" name='inss' id='ins_<c:out value = "${status.index}"/>' maxlength='2' value="${list.ins}" style="width:100%;"></sbux-input>
										</td>
										<td>
											<sbux-input uitype="text" name='ipAddrs' id='ipAddr_<c:out value = "${status.index}"/>' maxlength='50' value="${list.ipAddr}" style="width:100%;"></sbux-input>
										</td>
										<td>
											<sbux-input uitype="text" name='sapIds' id='sapId_<c:out value = "${status.index}"/>' maxlength='20' value="${list.sapId}" style="width:100%;"></sbux-input>
										</td>
										<td>
											<sbux-input uitype="text" name='sapPasswds' id='sapPasswd_<c:out value = "${status.index}"/>' maxlength='20' value="${list.sapPasswd}" style="width:100%;"></sbux-input>
										</td>
										<td>
											<sbux-input uitype="text" name='clients' id='client_<c:out value = "${status.index}"/>' maxlength='3' value="${list.client}" style="width:100%;"></sbux-input>
										</td> 
							  		</tr>
					  			<c:set var="trIdValue" value="${trIdValue+1}"/>
						  		</c:forEach>
						  	</c:if>
						  	</tbody>
                    	</table>
                    	
                    	
                    	
					</div>
					<div class="btn_buttom">  
                    	<!-- <sbux-button id="button1" name="button1" uitype="normal" text="접속정보추가" onclick="fncConnAdd()" class="btn-default"></sbux-button>
                    	<sbux-button id="button2" name="button2" uitype="normal" text="접속정보삭제" onclick="fncConnAddDelete()" class="btn-default"></sbux-button>  -->              
	                </div>
	                
                    <div class="sr-table-wrap" style="margin : 25px 0px">
                		<table id="chargeList" name="chargeList" class="sr-table">
		                    <colgroup>
		                        <col width="5%">
		                        <col width="15%">
		                        <col width="40%">
		                        <col width="40%">
		                    </colgroup>
		                    <tbody>
						  <tr>
						    <th>
						    	<!-- <sbux-label id="th_text36" name="th_text36" uitype="normal" text="선택"></sbux-label> -->
						    	<sbux-button id="button3" name="button3" uitype="normal" text="추가" onclick="fncAdd()" class="btn-default add-delete-btn"></sbux-button>
						    </th>
						    <th>
						    	<sbux-label id="th_text37" name="th_text37" uitype="normal" text="모듈" class = "imp-label"></sbux-label>
						    </th>          
						    <th>
						    	<sbux-label id="th_text38" name="th_text38" uitype="normal" text="정"></sbux-label>
						    </th>
						    <th>
						    	<sbux-label id="th_text39" name="th_text39" uitype="normal" text="부"></sbux-label>
						    </th>
						  </tr>
						  <c:choose>
						  	<c:when test="${!empty srchargerList}">
						  		<c:set var="trIdValue" value="0"/>
						  		<c:forEach var="list" items="${srchargerList}" varStatus="status">
						  		<tr>
						  			<td>
						  				<%-- <sbux-checkbox uitype="normal" id="selectBox_<c:out value = "${status.index}"/>" name="selectBox" id="selectBox${status.index}" value="" ></sbux-checkbox> --%>
						  				<sbux-button id="selectBox_<c:out value = "${status.index}"/>" name="selectBox" uitype="normal" text="삭제" onclick="fncAddDelete(<c:out value = "${status.index}"/>);" class="btn-default add-delete-btn"></sbux-button>
					  				</td>	
						  			<td>
										<sbux-select name="moduleCodes" id="moduleCode_<c:out value = "${status.index}"/>" uitype="single" title="모듈코드">
											<option value='' >선택</option>
										    <c:forEach var="result" items="${moduleCode_result}">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == list.moduleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>
						  			<td>
						  				<sbux-select name="userIdAs" id="userIdA_<c:out value = "${status.index}"/>" uitype="single" title="담당자">
						  					<option value='' >선택</option>
										    <c:forEach var="result" items="${chargerList}">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdA}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>
						  			<td>
						  				<sbux-select name="userIdBs" id="userIdB_<c:out value = "${status.index}"/>" uitype="single" title="담당자">
						  					<option value='' >선택</option>
										    <c:forEach var="result" items="${chargerList}">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>		
						  		</tr>	
						  		<c:set var="trIdValue" value="${trIdValue+1}"/>
						  		</c:forEach>
						  		
						  	</c:when>
						  	<c:otherwise>
						  		<c:set var="trIdValue" value="0"/>
						  		<tr>
						  			<td>
						  				<%-- <sbux-checkbox uitype="normal" name="selectBox" id="selectBox${trIdValue}" value=""  ></sbux-checkbox> --%>
						  				<sbux-button id="selectBox_0" name="selectBox" uitype="normal" text="삭제" onclick="fncAddDelete(0);" class="btn-default add-delete-btn"></sbux-button>
					  				</td>		
						  			<td>
										<sbux-select name="moduleCodes" id="moduleCode${trIdValue}" uitype="single" title="모듈코드">
											<option value='' >선택</option>
										    <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == list.moduleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>
						  			<td>
						  				<sbux-select name="userIdAs" id="userIdA${trIdValue}" uitype="single" title="담당자">
						  					<option value='' >선택</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdA}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>
						  			<td>
						  				<sbux-select name="userIdBs" id="userIdB${trIdValue}" uitype="single" title="담당자">
						  					<option value='' >선택</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </sbux-select>
						  			</td>	
						  		</tr>
						  	</c:otherwise>
						  				
						  </c:choose> 
						  </tbody>
                        </table>
                        
                        
                    </div>
                    
                     

 			        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
<!-- 			        <input name="checkedIdForDel" type="hidden" /> -->
			        <!-- 검색조건 유지 -->
			        
		        	<%-- <form:hidden path="pstinstCode" id="pstinstCode" /> --%>
		        	<input type="hidden" name="pstinstCode" value="<c:out value='${pstinstVO.pstinstCode}'/>"/>
			        <input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>"/>
			        <input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>"/>
			        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        <!-- 우편번호검색 -->
			        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />
					<input type="hidden" name="returnUrl" value="<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>"/>	
					<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
                </form>
                <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="btn_buttom_fixed">  
                    	<!-- <sbux-button id="button3" name="button3" uitype="normal" text="담당자추가" onclick="fncAdd()" class="btn-default"></sbux-button>
                    	<sbux-button id="button4" name="button4" uitype="normal" text="담당자삭제" onclick="fncAddDelete();" class="btn-default"></sbux-button> -->
                    	
                    	<c:if test="${!empty pstinstVO.name}">               
                    		<sbux-button id="button5" name="button5" uitype="normal" text="<spring:message code="button.save" />" onclick="fnUpdate(); return false;" class="btn-default"></sbux-button>
                    	</c:if>
                    	
                    	<c:if test="${empty pstinstVO.name}">               
                    		<sbux-button id="button6" name="button6" uitype="normal" text="신규 등록" onclick="fnInsert()" class="btn-default"></sbux-button>
                    	</c:if>
                    	               
                    	<sbux-button id="button8" name="button8" uitype="normal" text="<spring:message code="button.reset" />" onclick="document.pstinstVO.reset();" class="btn-default"></sbux-button>
                    	<sbux-button id="button7" name="button7" uitype="normal" text="<spring:message code="button.list" />" onclick="fnListPage(); return false;" class="btn-default"></sbux-button>               
                    	               
	                </div>
                    <!-- 버튼 끝 -->  
                	<div style="width:100%; height:40px; display:block;"></div>
            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
    </div>
</div>
<!-- //전체 레이어 끝 -->

<!-- 주소검색 Modal -->
<sbux-modal id="modalMenu" name="modalMenu" 
			uitype="middle" 
			header-title="주소검색" 
			body-html-id="modalBody"
			></sbux-button>'>

</sbux-modal>
<div id="modalBody" style= "height : 600px;">
	<div class="sr-contents-wrap" style = "min-width : 0px;">
		<div class="sr-contents-area" style = "left:0px; width: 100%; position: relative; max-width : 100%; max-height:100%; overflow-x : hidden; overflow-y : hidden;">
	        <div class="sr-contents">
	        
	        	<div class="btn_right" style="margin-top: -20px">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch()" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>
            
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
		                                <sbux-label id="table_label1" name="table_label1" uitype="normal" text="도로명 주소"></sbux-label>
		                            </th>
		                            <td colspan="3">
		                                <sbux-input id="keyword" name="keyword" uitype="text" style = "width:100%" value="">
		                                </sbux-input>
		                            </td>
		                        </tr>               
		                    </tbody>
		                </table>
		            </div><!--검색조건-->
	            </form>
	            
	            <div class="grid_txt">
                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
                </div>
	            
	            <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>           
	            
            </div>
        </div>
    </div>
</div>	    	    

</body>
</html>

<!-- 멀티파일 업로드를 위한 스크립트처리 -->
<script type="text/javascript">
// 해당 필의에 정의된 수만큼 파일 업로드가 가능하다. 값이 없을시에는 스크립트에 정의된 값으로 적용.
/*    var maxFileNum = 10;
   var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
   multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) ); */        
</script>
<!-- //멀티파일 업로드를 위한 스크립트처리 -->


<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* function dchk2(num) {
	   num = num.toString();
	   var dot = 0;
	   var dottmp = new Array();
	   dot = ( num.indexOf(".") != -1 )? num.length - num.indexOf("."): 0;
	   var vlen = num.length - dot ;
	   var c = 1;
	   var tmp = new Array();
	   for ( i = vlen ; i > -1; i-- ) {
	      c++;
	      tmp[i] = ( ( c%3 == 0 ) && ( i != vlen - 1) )? num.charAt(i) + "," : num.charAt(i);
	   }
	   if ( dot > 1 ) {
	      num = num.split(".");
	      if ( num != null ) {
	         for ( i = 0; i < tmp.length; i++ ) {
	            dottmp[i] = tmp[i];
	         }
	         dottmp[tmp.length-1] = dottmp[tmp.length-1] + num[1];
	         return dottmp ;
	      }
	   }
	   return tmp;
	}
function CommaIns(val, intLen, dotLen) {
	   var vals = "";
	   vals = val.toString();
	   
	   if ( vals.indexOf(".") != -1 ) {
	      var dotpos = vals.split(".");
	      if ( dotpos[1].length > dotLen ) {
	         vals = vals.substring( 0, vals.length - 1);
	         return vals;
	      }
	   }else{
		   if ( vals.replace(/,/gi,'').length > intLen ) {
			   vals = vals.substring( 0, vals.length - 1);
		       return vals;
		   }
	   }
	   
	   
	   var pas = "";
	   comma=/,/gi;
	   var sol = dchk2(vals.replace(comma,''));
	   for ( i=0; i<sol.length; i++ ) {
	      pas += sol[i];
	   }
	   return pas;
	}
	

function commaDot(obj) {
		key = event.keyCode;
	    if( ( key == 13 )||( key == 9 ))
	    {
	       return;
	    }
	    if ( ( obj.value.length == 2 ) && ( obj.value.charAt(0) == '0' ) ) {
	        if ( (obj.value.substring(0, 2) == "00") || ( obj.value.substring(0, 2) != "0." ) ) {
	           obj.value = "";
	           return;
	        }
	    }
	    obj.value = CommaIns(obj.value);
	}

function checkNum(obj) {
	 var word = obj.value;
	 var str = "1234567890.";
	 for (i=0;i< word.length;i++){
		 if(str.indexOf(word.charAt(i)) < 0){
			 alert("숫자만 입력 가능합니다.");
			 obj.value="";
			 obj.focus();
			 return false;
		 }
	 }
}  */

</script>

					