<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : SR상세조회, 수정 JSP
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>

<title><spring:message code='sr.srDetailEdit'/></title>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>

<!-- CK Editor Script -->
<script type="text/javascript" src="<c:url value='/js/ckEditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/en.js'/>"></script>
<style>
.ck-editor__editable_inline {
    min-height: 200px;
}
.ck-read-only {
    min-height: 0px;
}
</style>
<!-- CK Editor Script -->

<script type="text/javaScript" language="javascript" defer="defer">


/* ********************************************************
 * 새로고침 방지
 ******************************************************** */
function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_pstinst_bak(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
function fnListPage(){
    document.srVO.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.srVO.submit();
}
/* ********************************************************
 * 추가요청 삭제 처리 함수
 ******************************************************** */
function fnDeleteAnswer(){
	if(fnChecked()) {
	    if (confirm("<spring:message code='common.delete.msg'/>")) {
	        //var varForm              = document.all["srVO"];
	        //varForm.action           = "<c:url value='/sr/EgovSrDeleteAnswer.do'/>";
	//         varForm.srNo.value        = "${srVO.srNo}";
	        //varForm.submit();
	        //varForm.action = "";
	        var form = $("#srVO")[0];
			var formData = new FormData(form);
			$.ajax({
	      		url : "<c:url value='/sr/EgovSrDeleteAnswer.do'/>",
	     	    type : 'POST',
	     	    data : formData,
	     	    contentType : false,
	     	    processData : false,
	     	    beforeSend : fn_loading(),
	     	    success : function(data){
	     	    	alert(data.msg);
	     	    	if(data.msgType == "S"){
	     	    		//fnListPage();
	     	    		location.reload(true);
	     	    	}
	     	    },
	     	    error : function(request, status, error){
	  				alert("error");   	            
	     	    },
	     	    complete:function(){
	     	    	//fn_closeLoading();
	     	    }
		  	});
	    }		
	}
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
// function fnUpdate(){
//     if(validateSrVO(document.srVO)){
//         document.srVO.submit();
//     }
// }
/**
 * 저장
 */
 function fnUpdate(){
	if(confirm("<spring:message code="common.save.msg" />")){
		document.srVO.saveSe.value="4";
		var form = $("#srVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('ansFileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}
		$.ajax({
      		url : "<c:url value='/sr/EgovSrSelectUpdt.do'/>",
     	    type : 'POST',
     	    data : formData,
     	    contentType : false,
     	    processData : false,
     	    beforeSend : fn_loading(),
     	    success : function(data){
     	    	alert(data.msg);
     	    	if(data.msgType == "S"){
     	    		location.reload(true);
     	    	}
     	    },
     	    error : function(request, status, error){
  				alert("error");   	            
     	    },
     	    complete:function(){
     	    	//fn_closeLoading();
     	    }
	  	});
		//document.srVO.submit();
		//document.srVO.action = "";
	}
}
 function fnUpdateTest(){
	 
	//고객확인여부 필수 체크 
	if(document.srVO.testAt[0].checked || document.srVO.testAt[1].checked){
	}else{		
		alert("<spring:message code='sr.error.required.customerConfirmation'/>");
        return false;
	}

	//kpmg 전용 2021.07.13 박원배
	if(document.srVO.testContent.value == ''){	//고객확인 완료시 만족도 입력 체크
		alert("<spring:message code='sr.error.required.particularsConfirm'/>");
        return false;
	}
	
	//고객확인 완료시 만족도 입력 체크
	if(document.srVO.testAt[0].checked){	
		if(document.srVO.point[0].checked || document.srVO.point[1].checked || document.srVO.point[2].checked || document.srVO.point[3].checked || document.srVO.point[4].checked){
		}else{
			alert("<spring:message code='sr.error.required.satisfaction'/>");
	        return false;
		}		
	}

	if(confirm("<spring:message code="common.save.msg" />")){
		if(document.srVO.testAt[0].checked){			
			document.srVO.tat.value="Y";		//고객확인
		}
		document.srVO.saveSe.value="4";		//고객의견
		var form = $("#srVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('ansFileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}
		$.ajax({
      		url : "<c:url value='/sr/EgovSrSelectUpdt.do'/>",
     	    type : 'POST',
     	    data : formData,
     	    contentType : false,
     	    processData : false,
     	    beforeSend : fn_loading(),
     	    success : function(data){
     	    	alert(data.msg);
     	    	if(data.msgType == "S"){
     	    		location.reload(true);
     	    	}
     	    },
     	    error : function(request, status, error){
  				alert("error");   	            
     	    },
     	    complete:function(){
     	    	//fn_closeLoading();
     	    }
	  	});
		//document.srVO.submit();
    	//document.srVO.action = "";
	}
 }	
 /**
  * 추가요청저장
  */
 function fnSave(){
 	
 	document.srVO.saveSe.value="3";		//저장구분(1:수정, 2: 답변임시저장, 3: 답변저장)
 	document.srVO.answerSe.value="20";		//답변 구분 : 요청자
 	
 	$("#ansComment").text(setEditText(ansEditor));	// 에디터의 내용이 textarea에 적용됩니다.
 	if(document.srVO.ansComment.value == '<p>&nbsp;</p>' || document.srVO.ansComment.value == ''){
 		alert("<spring:message code='sr.error.required.addRequest'/>");
         return false;
 	}
	if(confirm("<spring:message code="common.save.msg" />")){
		$("#ansComment").text(setEditText(ansEditor));	// 에디터의 내용이 textarea에 적용됩니다.	
		var form = $("#srVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('ansFileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}
		$.ajax({
      		url : "<c:url value='/sr/EgovSrSelectUpdt.do'/>",
     	    type : 'POST',
     	    data : formData,
     	    contentType : false,
     	    processData : false,
     	    beforeSend : fn_loading(),
     	    success : function(data){
     	    	alert(data.msg);
     	    	if(data.msgType == "S"){
     	    		location.reload(true);
     	    	}
     	    },
     	    error : function(request, status, error){
  				alert("error");   	            
     	    },
     	    complete:function(){
     	    	//fn_closeLoading();
     	    }
	  	});
		//document.srVO.submit();
       	//document.srVO.action = "";
	}
 }
 /**
  * 추가요청임시저장
  */
 function fnTempUpdate(){
 	if(confirm("<spring:message code="common.save.msg" />")){
 		$("#ansComment").text(setEditText(ansEditor));	// 에디터의 내용이 textarea에 적용됩니다.
 		document.srVO.saveSe.value="2";
 		document.srVO.answerSe.value="20";		//요청자 	
 		
 		var form = $("#srVO")[0];
		var formData = new FormData(form);		
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('ansFileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}
		
		$.ajax({
      		url : "<c:url value='/sr/EgovSrSelectUpdt.do'/>",
     	    type : 'POST',
     	    data : formData,
     	    contentType : false,
     	    processData : false,
     	    beforeSend : fn_loading(),
     	    success : function(data){
     	    	alert(data.msg);
     	    	if(data.msgType == "S"){
     	    		location.reload(true);
     	    	}
     	    },
     	    error : function(request, status, error){
  				alert("error");   	            
     	    },
     	    complete:function(){
     	    	//fn_closeLoading();
     	    }
	  	});
 		//document.srVO.submit();			
 		//document.srVO.action = "";
 	}
 }

 /* ********************************************************
  * 삭제 처리 함수
  ******************************************************** */
 function fnDelete(){
     if (confirm("<spring:message code='common.delete.msg'/>")) {
    	 var form = $("#srVO")[0];
 		var formData = new FormData(form);
 		$.ajax({
       		url : "<c:url value='/sr/EgovSrRemove.do'/>",
      	    type : 'POST',
      	    data : formData,
      	    contentType : false,
      	    processData : false,
      	    beforeSend : fn_loading(),
      	    success : function(data){
      	    	alert(data.msg);
      	    	if(data.msgType == "S"){
      	    		fnListPage();
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
function fnChecked() {

    var checkField = document.srVO.checkField;
    var checkId = document.srVO.checkId;
    var returnValue = "";
    
//     alert("checkField : " + document.srVO.checkField.length);

    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
            	alert('<spring:message code='common.noChecked.msg'/>');
                returnBoolean = false;
            }
        } else {
            if(document.srVO.checkField.checked == false) {
                returnBoolean = false;
                alert('<spring:message code='common.noChecked.msg'/>');
            } else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
//     	alert("checkField.length : " + checkField.length);
//     	alert("document.srVO.checkField.checked : " + document.srVO.checkField.checked);
    	alert('<spring:message code='common.noChecked.msg'/>');
    }
//     alert("returnValue : " + returnValue);
    document.srVO.answerNoDelArr.value = returnValue;
    return returnBoolean;
}
/**
 * 첨부파일
 */
 function fn_egov_downFile(atchFileId, fileSn){
     window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
 }   
 
 function fn_egov_deleteFile(atchFileId, fileSn) {
	 if(confirm("<spring:message code='sr.msg.attachmentFileDelete'/>")){
	     forms = document.getElementsByTagName("form");
	
	     for (var i = 0; i < forms.length; i++) {
	         if (typeof(forms[i].atchFileId) != "undefined" &&
	                 typeof(forms[i].fileSn) != "undefined" &&
	                 typeof(forms[i].fileListCnt) != "undefined") {
	             form = forms[i];
	         }
	     }
	     //form = document.forms[0];
	     form.atchFileId.value = atchFileId;
	     form.fileSn.value = fileSn;
	     form.action = "<c:url value='/cmm/fms/deleteFileInfs.do'/>";
	     form.submit();
	     form.action = "";
	 }
 }
 
 function fn_egov_check_file(flag) {
     if (flag=="Y") {
         document.getElementById('file_upload_posbl').style.display = "block";
         document.getElementById('file_upload_imposbl').style.display = "none";          
     } else {
         document.getElementById('file_upload_posbl').style.display = "none";
         document.getElementById('file_upload_imposbl').style.display = "block";
     }
 }
 
/*  //고객의견 입력 필드를 보여준다.
 function fnShowComment(){
	 document.getElementById('cstmrComment').style.display = 'block';
	 document.getElementById('cstmrCommentLine').style.display = 'block';
 }
 
 //고객의견 입력 필드를 숨겨준다.
 function fnHideComment(){
	 document.getElementById('cstmrComment').style.display = 'none';
	 document.getElementById('cstmrCommentLine').style.display = 'none';
 } */
 function fnTop(){
		$(".sr-contents-area").scrollTop(0);
}

function fnBottom(){
	$(".sr-contents-area").scrollTop(999999);
}

function checkNum(obj) {
	console.log(obj)
	 var word = obj.value;
	 var str = "1234567890.";
	 for (i=0;i< word.length;i++){
		 if(str.indexOf(word.charAt(i)) < 0){
			 alert("<spring:message code='errors.number'/>");
			 obj.value="";
			 obj.focus();
			 return false;
		 }
	 }
} 
</script>
<script>
	//jquery Start
	var editor;
	var ansEditor;
	//자바스크립트 Start
	$(document).ready(function(){
		var editorLanguage = "${srLanguage}";
		
		if(editorLanguage != "ko"){
			editorLanguage = "en";
		}
		
		ClassicEditor
		.create( document.querySelector( '#editor' ), {
		    language: editorLanguage //언어설정	
		    ,toolbar : []
		}).then(newEditor => {
			editor = newEditor;
			editor.enableReadOnlyMode("readOnlyMode");
			
		})
		.catch( error => {
		    console.error( error );
		} );		
		
		var atchFileId = $("#atchFileId").val();
		if(atchFileId){
			$.ajax({
		    	url : "<c:url value='/cmm/fms/selectFileInfById.do'/>",
		   	    type : 'POST',
		   	    //dataType : "json",
		   	    //contentType:"application/json",
		   	    //data : $("#srVO").serialize(),
		   	    data : {
		   	    	"${_csrf.parameterName }" : "${_csrf.token }"
		   	    	,atchFileId : $("#atchFileId").val()
		   	    	,creatDt : "<c:out value='${srVO.signDate}'/>"
		   	    },
		   	    success : function(data){
		 	   		for(var i in data.fileList){
		 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
		 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
		 	   			data.fileList[i].size = data.fileList[i].fileMg;
		 	   		}
		 	   		SBUxMethod.refresh('fileUpload',{'jsondataRef':data.fileList});
		 	   		$("#fileUpload .sbux-upl-tit h3").text("<spring:message code="cop.atchFile" />(" +data.fileList.length+ " <spring:message code="sr.msg.cnt" />)");
		   	    },
		   	    error : function(request, status, error){
					alert("error");   	            
		   	    },
		   	    complete:function(){
		   	    	//fn_closeLoading();
		   	    }
			});
		}
		
		
		//답변 처리
		<c:if test="${fn:length(answerList) != 0}">
			<c:forEach var="result" items="${answerList}" varStatus="status">
				var editor<c:out value="${result.answerNo}"/>;
				ClassicEditor
				.create( document.querySelector( '#editor_<c:out value="${result.answerNo}"/>' ), {
				    language: editorLanguage //언어설정	
				    ,toolbar : []
				}).then(newEditor => {
					editor<c:out value="${result.answerNo}"/> = newEditor;
					editor<c:out value="${result.answerNo}"/>.enableReadOnlyMode("readOnlyMode");
					
				})
				.catch( error => {
				    console.error( error );
				} );
				
				<c:if test="${not empty result.fileId}">
					$.ajax({
				    	url : "<c:url value='/cmm/fms/selectFileInfById.do'/>",
				   	    type : 'POST',
				   	    //dataType : "json",
				   	    //contentType:"application/json",
				   	    data : {
				   	    	"${_csrf.parameterName }" : "${_csrf.token }"
				   	    	,atchFileId : "${result.fileId}"
				   	    	,creatDt : '<c:out value="${result.signDate}"/>'
				   	    },
				   	    success : function(data){
				 	   		for(var i in data.fileList){
				 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
				 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
				 	   			data.fileList[i].size = data.fileList[i].fileMg;
				 	   		}
				 	   		SBUxMethod.refresh('fileUpload_'+ '<c:out value="${result.answerNo}"/>',{'jsondataRef':data.fileList});
				 	   		$("#fileUpload_<c:out value='${result.answerNo}'/> .sbux-upl-tit h3").text("<spring:message code="cop.atchFile" />(" +data.fileList.length+ " <spring:message code="sr.msg.cnt" />)");
				   	    },
				   	    error : function(request, status, error){
							alert("error");   	            
				   	    },
				   	    complete:function(){
				   	    	//fn_closeLoading();
				   	    }
					});
				</c:if>
			</c:forEach>
		</c:if>
		
		var ansFileId = $("#ansFileId").val();
		if(ansFileId){
			$.ajax({
		    	url : "<c:url value='/cmm/fms/selectFileInfById.do'/>",
		   	    type : 'POST',
		   	    //dataType : "json",
		   	    //contentType:"application/json",
		   	    data : {
		   	    	"${_csrf.parameterName }" : "${_csrf.token }"
		   	    	,atchFileId : $("#ansFileId").val()
		   	    },
		   	    success : function(data){
		 	   		for(var i in data.fileList){
		 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
		 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
		 	   			data.fileList[i].size = data.fileList[i].fileMg;
		 	   		}
		 	   		SBUxMethod.refresh('ansFileUpload',{'jsondataRef':data.fileList});
		 	   	$("#ansFileUpload .sbux-upl-tit h3").text("<spring:message code="cop.atchFile" />(" +data.fileList.length+ " <spring:message code="sr.msg.cnt" />)");
		   	    },
		   	    error : function(request, status, error){
					alert("error");   	            
		   	    },
		   	    complete:function(){
		   	    	//fn_closeLoading();
		   	    }
			});
		}
		
		//현재 답변		
		ClassicEditor
		.create( document.querySelector( '#ansEditor' ), {
		    language: editorLanguage //언어설정	
		    //,toolbar : []
		}).then(newEditor => {
			ansEditor = newEditor;
			editorSetting(ansEditor);
			
		})
		.catch( error => {
		    console.error( error );
		} );
		
		
	});
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
	            <form action="${pageContext.request.contextPath}/sr/EgovSrSelectUpdt.do" name="srVO" id = "srVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
					<input type="hidden" name="srNo" value = "<c:out value='${srVO.srNo}'/>"/>
					<input type="hidden" name="pstinstCode" value="<c:out value='${srVO.pstinstCode}'/>"  />
					<input type="hidden" name="pstinstNm" value="<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value='${srVO.pstinstNm}' />
												</c:when>
												<c:otherwise>
													<c:out value='${srVO.pstinstNmEn}' />
												</c:otherwise>
											</c:choose>"  />
											
		            <input type="hidden" name="customerNm" value="<c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
					            	<c:if test="${result.code == srVO.customerId}"><c:out value="${result.codeNm}"/></c:if>
					            </c:forEach>"  />
					<input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>">
					<input type="hidden" name="tempSaveAt" />
					<input type="hidden" id = "atchFileId" name="atchFileId" value = "${srVO.fileId}"/>
					<input type="hidden" id = "settleAt" name="settleAt" value = "${srVO.settleAt}"/>
					<input type="hidden" id = "answerSe" name="answerSe" value = "${srVO.answerSe}"/>
					<input type="hidden" id = "ctsChk" name="ctsChk" value = "N"/>
					<input type="hidden" name="saveSe" />
					<input type="hidden" name="answerNoDelArr" />
					<input type="hidden" name="tat" />
					<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
					<input type="hidden" name="returnUrl" value="<c:url value='/sr/EgovSrSelectUpdtView.do'/>" />
					<input type="hidden" name="email" value="<c:out value='${srVO.email}'/>" />
					<input type="hidden" name="subject" value="[<c:out value='${srVO.srNo}' />] <c:out value='${srVO.subject}' />" />
					<input type="hidden" name="searchConfirmDateF" value="<c:out value='${searchVO.searchConfirmDateF}'/>" />
					<input type="hidden" name="searchConfirmDateT" value="<c:out value='${searchVO.searchConfirmDateT}'/>" />
					<input type="hidden" name="searchCustomerNm" value="<c:out value='${searchVO.searchCustomerNm}'/>" />
					<input type="hidden" name="searchRid" value="<c:out value='${searchVO.searchRid}'/>" />
					<input type="hidden" name="searchCompleteDateF" value="<c:out value='${searchVO.searchCompleteDateF}'/>" />
					<input type="hidden" name="searchCompleteDateT" value="<c:out value='${searchVO.searchCompleteDateT}'/>" />
					<input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>" />
					<input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>" />
					<input type="hidden" name="searchSubject" value="<c:out value='${searchVO.searchSubject}'/>" />
					<input type="hidden" name="searchContentFlag" value="<c:out value='${searchVO.searchContentFlag}'/>" />	
					<c:forEach var="searchStatus" items="${searchVO.searchStatus}" varStatus="vStatus2">													
						<input type="hidden" name="searchStatus" value="<c:out value='${searchStatus}'/>" />
					</c:forEach>
					<input type="hidden" name="searchAt" value="Y" />
					<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" /> 
					
					<!--질문-->
	                <div class="sr-table-wrap">
	                    <table class="sr-table">
	                        <colgroup>
	                            <col width="10%">
		                        <col width="21%">
		                        <col width="10%">
		                        <col width="21%">
		                        <col width="10%">
		                        <col width="28%">
	                        </colgroup>
	                        <tbody>                       
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="<spring:message code='sym.ems.title'/>"></sbux-label>
	                                </th>
	                                <td colspan="5">
	                                	<sbux-label name="subject" uitype="normal" class='leftText' text = "[<c:out value='${srVO.srNo}' />] <c:out value='${srVO.subject}' />"></sbux-label>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='sr.client' />"  ></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text24' name='th_text24' uitype='normal' class='leftText' text="<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value='${srVO.pstinstNm}' />
												</c:when>
												<c:otherwise>
													<c:out value='${srVO.pstinstNmEn}' />
												</c:otherwise>
											</c:choose>">	                                    	                                    
	                                    </sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text3" name="th_text3" uitype="normal" text="<spring:message code='sr.requester' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id="customerId" name="customerId" uitype="normal" 
	                                    	text = "<c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
														<c:if test="${result.code == srVO.customerId}">
															<c:out value="${result.codeNm}" />
														</c:if>
													</c:forEach>" class='leftText'>
	                                    </sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text6" name="th_text6" uitype="normal" text="<spring:message code='cop.emailAdres' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="email" name="email" uitype="normal" text="${srVO.email}" class='leftText' ></sbux-label>
	                                </td>
	                            </tr>
	                            <c:if test="${srVO.settleAt == 'Y'}">
									<tr>
										<th><sbux-label id="th_text" name="th_text" uitype="normal" text="<spring:message code='sr.sanctnerNm' />"></sbux-label> </th>
										<td colspan="5">											
											<sbux-label id="sanctnerNm" name="sanctnerNm" uitype="normal" text="<c:out value='${srVO.sanctnerNm}' />" class='leftText'></sbux-label>
										</td>
									</tr>
							  	</c:if>                       
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='cop.offTelNo' />"></sbux-label>
	                                </th>
	                                <td colspan='3'>
	                                    <sbux-label id="tel1" name="tel1" uitype="normal" text="${srVO.tel1}" class='leftText'></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text5" name="th_text5" uitype="normal" text="<spring:message code='cop.mbtlNum' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id="tel2" name="tel2" uitype="normal" text="${srVO.tel2}" class='leftText'></sbux-label>
	                                </td>
	                            </tr>     
	                            <tr>
	                                	                                                           
	                            </tr>
	                            <tr>	                            
	                                <th>
	                                    <sbux-label id="th_text7" name="th_text7" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text8' name='th_text8' uitype='normal' class='leftText' text="<c:out value='${srVO.signDate}'/>"></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text9" name="th_text9" uitype="normal" text="<spring:message code='sr.receptionDate' />"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="th_text10" name="th_text10" uitype="normal" class='leftText' init = "<c:out value='${srVO.confirmDate}'/>"></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text14" name="th_text14" uitype="normal" text="<spring:message code='sr.priority' />"></sbux-label>
	                                </th>
	                                <td class="leftText">
	                                    <sbux-radio id="priority1" name="priority" uitype="normal" text="<spring:message code='sr.normal' /> " value="1002" <c:if test = "${srVO.priority == '1002'}">checked</c:if>></sbux-radio>                                
	                                    <sbux-radio id="priority2" name="priority" uitype="normal" text="<spring:message code='sr.urgent' />" value="1001" <c:if test = "${srVO.priority == '1001'}">checked</c:if>> </sbux-radio>                                  
	                                    <sbux-radio id="priority3" name="priority" uitype="normal" text="<spring:message code='sr.veryUrgent' />" value="1000" <c:if test = "${srVO.priority == '1000'}">checked</c:if>> </sbux-radio>                        
	                                </td>
	                            </tr>
	                             <tr>
	                                <th>
	                                    <sbux-label id="th_text11" name="th_text11" uitype="normal" text="<spring:message code='sr.status' /> " class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="status" name="status" uitype="single" init="<spring:message code='sr.choose' />" readonly>
		                                    <option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${statusCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == srVO.status}">selected</c:if>>							
													<c:choose>
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
	                                    </sbux-select>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text12" name="th_text12" uitype="normal" text="<spring:message code='sr.module' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="moduleCode" name="moduleCode" uitype="single" init="<spring:message code='sr.choose' />">
		                                    <option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == srVO.moduleCode}">selected</c:if>>													
													<c:choose>
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
	                                    </sbux-select>                        
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" text="<spring:message code='sr.charge' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="rid" name="rid" uitype="single" init="<spring:message code='sr.choose' />"  style="width: calc(100% - 110px);">
	                                        <option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == srVO.rid}">selected</c:if>>
													<c:choose>
														<c:when test="${srLanguage == 'en'}">
															<c:out value='${result.userNmEn}' />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value='${result.userNmEn}' />
														</c:when>
														<c:otherwise>
															<c:out value="${result.userNm}" />
														</c:otherwise>
													</c:choose>
												</option>
											</c:forEach>
	                                   </td>
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text13" name="th_text13" uitype="normal" text="<spring:message code='sr.processingDivision' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="category" name="category" uitype="single" init="<spring:message code='sr.choose' />">
	                                    <option value=''><spring:message code='sr.choose' /></option>
									<c:forEach var="result" items="${classCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == srVO.category}">selected</c:if>>
											<c:choose>
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
	                                    </sbux-select>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text18" name="th_text18" uitype="normal" text="<spring:message code='sr.predictionLabourHours' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-input id="expectTime" name="expectTime" uitype="text" style="width: 70px;" value = "<c:out value='${srVO.expectTime}'/>" oninput="checkNum(this)" maxlength = '10'></sbux-input><span class="t_intext"><spring:message code='sr.predictionLabourHoursEx' /></span>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text19" name="th_text19" uitype="normal" text="<spring:message code='sr.realLabourHours' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-input id="realExpectTimeDisp" name="realExpectTimeDisp" uitype="text" style="width: 70px;" placeholder="0.00" value = "<c:out value='${srVO.realExpectTime}'/>" readonly></sbux-input>
	                                    <span class="t_intext"> Hr (<spring:message code='sr.abapLabourHours' /></span>
	                                    <sbux-input id="abapRealExpectTime" name="abapRealExpectTime" uitype="text" style="width: 70px;" value = "<c:out value='${srVO.abapRealExpectTime}'/>" oninput="checkNum(this)" maxlength = '10'></sbux-input>
	                                    <span class="t_intext">Hr)</span>
	                                    <span class="t_intext">ABAP 담당자 : </span>
	                                    <sbux-select id="abapRid" name="abapRid" uitype="single" init="<spring:message code='sr.choose' />"  style="width: calc(100% - 110px);">
	                                        <option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == srVO.abapRid}">selected</c:if>>
													<c:choose>
														<c:when test="${srLanguage == 'en'}">
															<c:out value='${result.userNmEn}' />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value='${result.userNmEn}' />
														</c:when>
														<c:otherwise>
															<c:out value="${result.userNm}" />
														</c:otherwise>
													</c:choose>
												</option>
											</c:forEach>
	                                    </sbux-select>
	                                </td>
	                            </tr>
	                            <tr>	                            
	                                <th>
	                                    <sbux-label id="th_text15" name="th_text15" uitype="normal" text="<spring:message code='sr.completeHopeDate'/>"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text16' name='th_text16' uitype='normal' class='leftText' text="<c:out value='${srVO.hopeDate}'/>"></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text17" name="th_text17" uitype="normal" text="<spring:message code='sr.expectedCompletionDate'/>"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-datepicker id="scheduleDate" name="scheduleDate" uitype="popup" style="width: 100px;" date-format="yyyy-mm-dd" open-on-input-selection="true" init = "<c:out value='${srVO.scheduleDate}'/>"></sbux-datepicker>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text21" name="th_text21" uitype="normal" text="<spring:message code='sr.processingCompletionDate' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-datepicker id="completeDate" name="completeDate" uitype="popup" style="width: 100px;" open-on-input-selection="true" date-format="yyyy-mm-dd" init = "<c:out value='${srVO.completeDate}'/>"></sbux-datepicker>
	                                </td>
	                            </tr>
	                             <tr>
	                                
	                            </tr>
	                            <tr>
	                                
	                                
	                            </tr>                            
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text22" name="th_text22" uitype="normal" text="<spring:message code='sr.requestContent' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="5" class="tdText">
	                                	<textarea name="comment" id="comment" style=" display:none;">${srVO.comment}</textarea> 			                                	
	                                	<div id="editor" >
	                                	${srVO.comment}
	                                	</div>
	                                </td>                            
	                            </tr>
	                            <c:if test="${not empty srVO.fileId}">
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text23" name="th_text23" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
	                                </th>
	                                <td colspan="5" class="tdText"> 
	                                    <sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
	                                    	vertical-scroll-height="100px"
	                                    	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
	                                    	header-title="<spring:message code="cop.atchFile" />"
	                                    	drop-zone="false"
	                                    	button-add-status="none"
	                                    	button-delete-status="none"
	                                    	list-checkbox-status="hidden"
	                                    	list-delete-status="hidden"
	                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
	                                    	button-delete-title="<spring:message code="sr.ctsDel" />"
	                                    	callback-click-list= "fnFileDownload" >
										</sbux-fileupload>
	                                </td>                            
	                            </tr>
	                            </c:if>
	                        </tbody>
	                    </table>	                    
	                </div><!--질문-->
	                
	                <!--답변-->
	                <!-- 저장된 답변(추가요청)이 있을때 답변 목록 화면 Display -->
				<c:if test="${fn:length(answerList) != 0}">
					<c:set var="trIdValue" value="0" />
					<c:forEach var="result" items="${answerList}" varStatus="status">				
						<input type="hidden" name="answerNoArr" value="<c:out value="${result.answerNo}"/>"/>						
						<div class="srlist-area" id = "div_<c:out value="${result.answerNo}"/>">
						<c:if test="${result.answerSe == '10'}">
						<!--답변-->		                
		                    <div class="sr-table-wrap-aw">              
		                        <div class="answer_ic"><img src="<c:url value='/images/ic_answer.png'/>"/></div>              
		                        <table class="sr-table-aw">
		                            <colgroup>
		                                <col width="12%"/>
		                                <col width="38%"/>
		                                <col width="12%"/>
		                                <col width="38%"/>
		                            </colgroup>
		                            <tbody>                       
		                                <tr>
		                                    <th>
		                                        <sbux-label id="th_text1_<c:out value="${result.answerNo}"/>" name="th_text1_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code='sr.realLabourHours' />"></sbux-label>
		                                    </th>
		                                    <td>
		                                        <sbux-label id='a_text1_<c:out value="${result.answerNo}"/>' name='a_text1_<c:out value="${result.answerNo}"/>' uitype='normal' class='leftText' 
		                                        text="<c:out value = "${result.realExpectTime}"/><spring:message code='sr.predictionLabourHoursEx' />"></sbux-label>
		                                    </td>
		                                    <th>
		                                        <sbux-label id="th_text2_<c:out value="${result.answerNo}"/>" name="th_text2_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code='sr.processors' />"></sbux-label>
		                                    </th>
		                                    <td>
		                                        <sbux-label id='a_text2_<c:out value="${result.answerNo}"/>' name='a_text2_<c:out value="${result.answerNo}"/>' uitype='normal' class='leftText' 
		                                        text="<c:forEach var="chargerList" items="${chargerList}" varStatus="status">
														<c:if test="${chargerList.userId == result.rid}">
															<c:choose>
																<c:when test="${srLanguage == 'en'}">
																	<c:out value='${chargerList.userNmEn}'/><c:out value="${result.signDate}" />
																</c:when>
																<c:when test="${srLanguage == 'cn'}">
																	<c:out value='${chargerList.userNmEn}' /><c:out value="${result.signDate}" />
																</c:when>
																<c:otherwise>
																	<c:out value="${chargerList.userNm}" /><c:out value="${result.signDate}" />
																</c:otherwise>
															</c:choose>
														</c:if>
													</c:forEach>"></sbux-label>
		                                    </td>
		                                </tr>                       
		                                <tr>
		                                    <th>
		                                        <sbux-label id="th_text3_<c:out value="${result.answerNo}"/>" name="th_text3_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code='sr.processingDivision' />"></sbux-label>
		                                    </th>
		                                    <td>
		                                        <sbux-label id='a_text3_<c:out value="${result.answerNo}"/>' name='a_text3_<c:out value="${result.answerNo}"/>' uitype='normal' class='leftText' 
		                                        text="<c:forEach var="classCode_result" items="${classCode_result}" varStatus="status">
														<c:if test="${result.category == classCode_result.code}">
															<c:choose>
																<c:when test="${srLanguage == 'en'}">
																	<c:out value="${classCode_result.codeNmEn}" />
																</c:when>
																<c:when test="${srLanguage == 'cn'}">
																	<c:out value="${classCode_result.codeNmCn}" />
																</c:when>
																<c:otherwise>
																	<c:out value="${classCode_result.codeNm}" />
																</c:otherwise>
															</c:choose>
														</c:if>
													</c:forEach>"></sbux-label>
		                                    </td>
		                                    <th>
		                                        <sbux-label id="th_text4_<c:out value="${result.answerNo}"/>" name="th_text4_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code='sr.module' />"></sbux-label>
		                                    </th>
		                                    <td>
		                                        <sbux-label id='a_text4_<c:out value="${result.answerNo}"/>' name='a_text4_<c:out value="${result.answerNo}"/>' uitype='normal' class='leftText' 
		                                        text="<c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
														<c:if test="${result.moduleCode == moduleCode_result.code}">
															<c:choose>
																<c:when test="${srLanguage == 'en'}">
																	<c:out value="${moduleCode_result.codeNmEn}" />
																</c:when>
																<c:when test="${srLanguage == 'cn'}">
																	<c:out value="${moduleCode_result.codeNmCn}" />
																</c:when>
																<c:otherwise>
																	<c:out value="${moduleCode_result.codeNm}" />
																</c:otherwise>
															</c:choose>
														</c:if>
													</c:forEach>"></sbux-label>
		                                    </td>
		                                </tr>     
		                                <tr>	
		                                    <!--체크박스가 없는 경우-->
		                                    <th>                               
		                                        <sbux-label id="th_text25_<c:out value="${result.answerNo}"/>" name="th_text19_<c:out value="${result.answerNo}"/>" uitype="normal" text="답변"></sbux-label>
		                                    </th>
			                                <td colspan="3" class="tdText">
			                                	<textarea name="comment_<c:out value="${result.answerNo}"/>" id="comment_<c:out value="${result.answerNo}"/>" style=" display:none;"></textarea> 			                                	
			                                	<div id="editor_<c:out value="${result.answerNo}"/>" >
			                                	${result.comment}
			                                	</div>
			                                </td>                            
			                            </tr>
			                            <c:if test="${not empty result.fileId}">
			                            <tr>
			                                <th>
			                                    <sbux-label id="th_text6_<c:out value="${result.answerNo}"/>" name="th_text6_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
			                                </th>
			                                <td colspan="3" class="tdText"> 
			                                    <sbux-fileupload id="fileUpload_<c:out value="${result.answerNo}"/>" name="fileUpload_<c:out value="${result.answerNo}"/>" uitype="multipleExt" style = "width: 100% "  
			                                    	vertical-scroll-height="60px"
			                                    	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
			                                    	header-title="<spring:message code="cop.atchFile" />"
			                                    	drop-zone="false"
			                                    	button-add-status="none"
			                                    	button-delete-status="none"
			                                    	list-checkbox-status="hidden"
			                                    	list-delete-status="hidden"
			                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
			                                    	button-delete-title="<spring:message code="sr.ctsDel" />"
			                                    	callback-click-list= "fnFileDownload" >
												</sbux-fileupload>
			                                </td>                            
			                            </tr>
			                            </c:if>			                            
		                            </tbody>
		                        </table>
		                    </div>		                
		                <!--답변-->
						</c:if> 
						<c:if test="${result.answerSe == '20'}">
						<!--추가 요청-->
						<input type="hidden" name="checkId" value="<c:out value="${result.answerNo}"/>"/>
		                <div class="sr-table-wrap">
		                    <table class="sr-table">
		                        <colgroup>
		                            <col width="12%">
		                            <col width="38%">
		                            <col width="12%">
		                            <col width="38%">
		                        </colgroup>
		                        <tbody>                       
		                            <tr>
		                                <th>
		                                    <sbux-label id="th_text1_<c:out value="${result.answerNo}"/>" name="th_text1_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code='sr.addRequestDate' />"></sbux-label>
		                                </th>
		                                <td colspan="3">
		                                	<sbux-label id='th_text2_<c:out value="${result.answerNo}"/>' name='th_text2_<c:out value="${result.answerNo}"/>' uitype='normal' class='leftText' text="<c:out value="${result.signDate}" />"></sbux-label>
		                                </td>                            
		                            </tr>   
		                            <tr>
		                                <!--체크박스가 있는경우-->
		                                <th class="case-answer">
		                                    
		                                    <sbux-checkbox id="add-chkbox_norm_<c:out value="${result.answerNo}"/>" name="checkField" uitype="normal" text="<spring:message code='sr.addRequest' />"></sbux-label>                     
		                                </th>
		
		                                <!--체크박스가 없는 경우-->
		                                <!--th>                               
		                                    <sbux-label id="add_text25" name="add_text19" uitype="normal" text="추가요청"  class="imp-label"></sbux-label>
		                                </th-->
		                                <td colspan="3" class="tdText">
		                                	<textarea name="comment_<c:out value="${result.answerNo}"/>" id="comment_<c:out value="${result.answerNo}"/>" style=" display:none;"></textarea> 			                                	
		                                	<div id="editor_<c:out value="${result.answerNo}"/>" >
		                                	${result.comment}
		                                	</div>
		                                </td>                          
		                            </tr>
		                            <c:if test="${not empty result.fileId}">
		                            <tr>
		                                <th>
		                                    <sbux-label id="th_text6_<c:out value="${result.answerNo}"/>" name="th_text6_<c:out value="${result.answerNo}"/>" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
		                                </th>
		                                <td colspan="3" class="tdText"> 
		                                    <sbux-fileupload id="fileUpload_<c:out value="${result.answerNo}"/>" name="fileUpload_<c:out value="${result.answerNo}"/>" uitype="multipleExt" style = "width: 100% "  
		                                    	vertical-scroll-height="60px"
		                                    	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
		                                    	header-title="<spring:message code="cop.atchFile" />"
		                                    	drop-zone="false"
		                                    	button-add-status="none"
		                                    	button-delete-status="none"
		                                    	list-checkbox-status="hidden"
		                                    	list-delete-status="hidden"
		                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
		                                    	button-delete-title="<spring:message code="sr.ctsDel" />"
		                                    	callback-click-list= "fnFileDownload" >
											</sbux-fileupload>
		                                </td>                            
		                            </tr>
		                            </c:if>	
		                        </tbody>
		                    </table>
		                </div>
		                <!--추가 요청-->
						</c:if>
						</div>	
						<c:set var="trIdValue" value="${trIdValue+1}" />
					</c:forEach>
				</c:if>
				<c:if test="${srVO.status != '1006'}">
					<!-- 완료시에만 제외 -->
					<!--추가요청-->				
	                <div class="srlist-area">
	                <c:if test="${fn:length(answerListTemp) != 0}"><c:set var="answerResult" value = "${answerListTemp[0]}"/></c:if>
	                <input type="hidden" name="answerNo" value="<c:out value="${empty answerResult.answerNo ? 0 : answerResult.answerNo}"/>"/>
	                <input type="hidden" id = "ansFileId" name="ansFileId" value="<c:out value="${answerResult.ansFileId}"/>"/>
	                    <div class="send-mail" style = "padding-left :0px;">
	                        <sbux-checkbox id="emailSendAt" name="emailSendAt" uitype="normal" text="<spring:message code='sr.sendEmail' />" true-value="on" checked></sbux-checkbox> 
	                    </div>
	                    <div class="sr-table-wrap">                           
	                        <table class="sr-table">
	                            <colgroup>
	                                <col width="12%"/>
	                                <col width="38%"/>
	                                <col width="12%"/>
	                                <col width="38%"/>
	                            </colgroup>
	                            <tbody>      
	                                <tr>	
	                                    <!--체크박스가 없는 경우-->
	                                    <th>                               
	                                        <sbux-label id="th_text25" name="th_text19" uitype="normal" text="<spring:message code='sr.addRequest' />"  class="imp-label"></sbux-label>
	                                    </th>
		                                <td colspan="3" class="tdText">
		                                	<textarea name="ansComment" id="ansComment" style=" display:none;"></textarea> 			                                	
		                                	<div id="ansEditor" >
		                                	<c:if test = "${not empty answerResult.ansComment}">${answerResult.ansComment}</c:if>
	                                		<c:if test = "${empty answerResult.ansComment}">${sign}</c:if>
		                                	</div>
		                                </td>                            
		                            </tr>
		                            <tr>
		                                <th>
		                                    <sbux-label id="th_text1_answer" name="th_text1_answer" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
		                                </th>
		                                <td colspan="3" class="tdText"> 
		                                    <sbux-fileupload id="ansFileUpload" name="ansFileUpload" uitype="multipleExt" style = "width: 100%"  
		                                    	vertical-scroll-height="60px"
		                                    	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
		                                    	header-title="<spring:message code="cop.atchFile" />"
		                                    	drop-zone="true"
		                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
		                                    	button-delete-title="<spring:message code="sr.ctsDel" />"
		                                    	callback-click-list= "fnFileDownload"
	                                    		callback-click-delete= "fnFileDelete"
	                                    		callback-delete-button-pressed="fnFileDeleteList" >
											</sbux-fileupload>
		                                </td>                            
		                            </tr>		                            
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	                <!--추가요청-->
				</c:if>
				 <!--CTS-->
				 <c:if test="${!empty cts_result}">
                 <div class="srlist-area">
                    <div class="sr-table-wrap-aw">              
                        <div class="answer_ic"><img src="<c:url value='/images/ic_answer.png'/>"></div>              
                        <table id = "ctsTbl" class="sr-table-aw">
                            <colgroup>
                                <col width="20%">
                                <col width="60%">
                                <col width="20%">
                            </colgroup>
                            <tbody>                       
                                <tr>
                                    <th class="th_center">
                                        <sbux-label id="th_text100" name="th_text100" uitype="normal" text="CTS Number"></sbux-label>
                                    </th>
                                    <th class="th_center">
                                        <sbux-label id="th_text200" name="th_text200" uitype="normal" text="Description"></sbux-label>
                                    </th>
                                    <th class="th_center">
                                        <sbux-label id="th_text300" name="th_text300" uitype="normal" text="Owner"></sbux-label>
                                    </th>
                                </tr>                       
                                <c:forEach var="cts_result" items="${cts_result}" varStatus="status">
									<tr>
										<td><sbux-input uitype="text" style=" width:100%;" id = "cts_numbers_<c:out value = "${status.index}"/>" name="cts_numbers" value='${cts_result.cts_number}'/></td>
										<td><sbux-input uitype="text" style=" width:100%;" id = "cts_descs_<c:out value = "${status.index}"/>" name="cts_descs" value="${cts_result.cts_desc}"/></td>
										<td><sbux-input uitype="text" style=" width:100%;" id = "cts_owners_<c:out value = "${status.index}"/>" name="cts_owners" value="${cts_result.cts_owner}"/></td>
									</tr> 							
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                </c:if>
                <!--CTS-->
                <c:if test="${srVO.status == '1005' || srVO.status == '1006'}">
                <!--고객확인-->
                <div class="sr-table-wrap">
                    <table class="sr-table">
                        <colgroup>
                            <col width="12%">
                            <col width="38%">
                            <col width="12%">
                            <col width="38%">
                        </colgroup>
                        <tbody>                       
                            <tr>
                                <th>
                                    <sbux-label id="customer01" name="customer01" uitype="normal" text="<spring:message code='sr.customerConfirmSe' />" class="imp-label"></sbux-label>
                                </th>
                                <td>
                                    <sbux-radio id="rdo_norm4" name="testAt" uitype="normal"  text="<spring:message code='sr.completion' /> " value="Y" <c:if test="${srVO.testAt == 'Y'}"> checked</c:if>></sbux-radio>                                
                                    <sbux-radio id="rdo_norm5" name="testAt" uitype="normal"  text="<spring:message code='sr.incomplete' />"  value="N" <c:if test="${srVO.testAt == 'N'}"> checked</c:if>> </sbux-radio>      
                                </td>
                                <th>
                                    <sbux-label id="customer02" name="customer02" uitype="normal" text="<spring:message code='sr.customersConfirmationCompletionDate' />" ></sbux-label>
                                </th>
                                <td>                                	
                                   <sbux-label id="testCompleteDate" name="testCompleteDate" uitype="normal" text = ""></sbux-label>
                                </td>
                            </tr>     
                            <tr>
                                <th>                               
                                    <sbux-label id="customer04" name="customer04" uitype="normal" text="<spring:message code='sr.particularsConfirm' />"  class="imp-label"></sbux-label>
                                </th>
                                <td colspan="3"> 
                                    <sbux-input id="testContent" name="testContent" uitype="text" style = "width: 100%" value = "<c:out value='${srVO.testContent}'/>"></sbux-input>                                    
                                </td>                            
                            </tr>   
                        
                        </tbody>
                    </table>
                </div><!--고객확인-->
                 <!--만족도-->
                 <div class="sr-table-wrap">
                    <table class="sr-table">
                        <colgroup>
                            <col width="12%">
                            <col width="88%">
                        </colgroup>
                        <tbody>                       
                            <tr>
                                <th>
                                    <sbux-label id="customer05" name="customer05" uitype="normal" text="<spring:message code='cop.satisfaction.stsfdg' />" class="imp-label"></sbux-label>
                                </th>
                                <td>
                                    <sbux-radio id="rdo_5" name="point" uitype="normal"  text="<spring:message code='sr.5point' />" value="5" <c:if test="${srVO.point == '5'}"> checked</c:if>></sbux-radio>                                
                                    <sbux-radio id="rdo_4" name="point" uitype="normal" text="<spring:message code='sr.4point' />" value="4" <c:if test="${srVO.point == '4'}"> checked</c:if>> </sbux-radio>      
                                    <sbux-radio id="rdo_3" name="point" uitype="normal"  text="<spring:message code='sr.3point' />" value="3" <c:if test="${srVO.point == '3'}"> checked</c:if>></sbux-radio>                                
                                    <sbux-radio id="rdo_2" name="point" uitype="normal" text="<spring:message code='sr.2point' />" value="2" <c:if test="${srVO.point == '2'}"> checked</c:if>> </sbux-radio>     
                                    <sbux-radio id="rdo_1" name="point" uitype="normal" text="<spring:message code='sr.1point' />" value="1" <c:if test="${srVO.point == '1'}"> checked</c:if>> </sbux-radio>     
                                </td>    
                            </tr>     
                            <tr>
                                <th>
                                    <sbux-label id="customer06" name="customer06" uitype="normal" text="<spring:message code='sr.otherOpinions' />"></sbux-label>
                                </th>
                                <td>
                                    <sbux-input id="pointContent" name="pointContent" uitype="text" style = "width: 100%" value = "<c:out value='${srVO.pointContent}'/>"></sbux-input>      
                                </td>                           
                            </tr>                           
                        </tbody>
                    </table>
                </div><!--만족도-->
                </c:if>
				</form>
				 <div class="btn_buttom_fixed">
				 	<sbux-button id="topBtn" name="topBtn" uitype="normal" text="<spring:message code="button.top"/>" onclick="fnTop();" class="btn-default"></sbux-button>                
                    <sbux-button id="botBtn" name="botBtn" uitype="normal" text="<spring:message code="button.bottom"/>" onclick="fnBottom();" class="btn-default"></sbux-button>                
                    
				 <c:if test="${srVO.status != '1006'}">
                    <sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.addRequestTempSave"/>" onclick="fnTempUpdate();" class="btn-default"></sbux-button>                
                    <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.addRequestSave"/>" onclick="fnSave();" class="btn-default"></sbux-button>                
                    <sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.addRequestDelete"/>" onclick="fnDeleteAnswer();" class="btn-default"></sbux-button>                
                 </c:if>
                 <c:if test="${srVO.status == '1005'}">
                 	<sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnUpdateTest();" class="btn-default"></sbux-button>
                 </c:if>
                                    
                    <c:if test="${srVO.status == '1001' || srVO.status == '1002'}">  
                    	<sbux-button id="button6" name="button6" uitype="normal" text="<spring:message code="button.delete"/>" onclick="fnDelete();" class="btn-default"></sbux-button>                
                    </c:if>
                    <sbux-button id="button7" name="button7" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
                </div>
                <div style = "width:100%; height:40px; display:block;"></div>               
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
<!-- 전체 레이어 시작 -->
<%-- <div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />       
    <!-- //header 끝 --> 
    <!-- container 시작 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;<spring:message code='sr.navigation.srDetailEdit'/></li>
			        </ul>
			    </div>
                <!-- 검색 필드 박스 시작 -->
		        <form:form commandName="srVO" action="${pageContext.request.contextPath}/sr/EgovSrSelectUpdt.do" name="srVO" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="SR, 업종코드, 업무명, 업체명 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
						  <tr>
				              <td colspan="4" bgcolor="#0257a6" height="2"></td>
				          </tr>
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sym.ems.title'/>
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td colspan="3" class="tdleft">
						    	[<c:out value='${srVO.srNo}'/>] <c:out value='${srVO.subject}'/>
						    	<form:hidden path="subject" />
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.client'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" class="tdleft">
						        <c:out value='${srVO.pstinstNm}'/>
                            	<c:choose>
				  					<c:when test="${srLanguage == 'ko'}"><c:out value='${srVO.pstinstNm}'/></c:when>
				  					<c:when test="${srLanguage == 'en'}"><c:out value='${srVO.pstinstNmEn}'/></c:when>
				  					<c:when test="${srLanguage == 'cn'}"><c:out value='${srVO.pstinstNmEn}'/></c:when>
				  					<c:otherwise><c:out value='${srVO.pstinstNm}'/></c:otherwise>
				  				</c:choose>  						        
						        <form:hidden path="pstinstCode" />
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requester'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
				                <c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
					            	<c:if test="${result.code == srVO.customerId}"><c:out value="${result.codeNm}"/></c:if>
					            </c:forEach>
					            <form:hidden path="customerNm" />
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 

					      <!-- kpmg 2021.07.14 -->
					      <!-- 결재자(승인권자) -->
					  	  <c:if test="${srVO.settleAt == 'Y'}">
							<tr>
								<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.sanctnerNm' /></th>
								<td colspan="3" class="tdleft"><c:out value='${srVO.sanctnerNm}' /> <form:hidden path="sanctnerNm" /></td>
							</tr>  
						  	<tr>
								<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							</tr>							
					  	  </c:if>
						  						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='cop.offTelNo'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.tel1}'/>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='cop.mbtlNum'/></th>          
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.tel2}'/>
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='cop.emailAdres'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" colspan="3" class="tdleft">
						    	<c:out value='${srVO.email}'/>
						    	<form:hidden path="email" />
						    </td>  
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requestDate'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.signDate}'/>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.receptionDate'/></th>          
						    <td width="30%" class="tdleft">
				                <c:out value='${srVO.confirmDate}'/>
				                <input name="confirmDate" type="hidden" value="<c:out value='${srVO.confirmDate}'/>" >
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr>						    
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.status'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
						    	<input type="hidden" name="status" id="status" value="${srVO.status}"/>
						    	<c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
		                            <c:if test="${statusCode_result.code == srVO.status}">
		                            	<c:out value="${statusCode_result.codeNm}"/>
						  				<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value="${statusCode_result.codeNm}"/></c:when>
						  					<c:when test="${srLanguage == 'en'}"><c:out value="${statusCode_result.codeNmEn}"/></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><c:out value="${statusCode_result.codeNmCn}"/></c:when>
						  					<c:otherwise><c:out value="${statusCode_result.codeNm}"/></c:otherwise>
						  				</c:choose>  		                            	
		                            </c:if>
		                        </c:forEach>
						    </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.module'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
						    	<c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
		                            <c:if test="${moduleCode_result.code == srVO.moduleCode}">
		                            	<c:out value="${moduleCode_result.codeNm}"/>
		                            	<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value="${moduleCode_result.codeNm}"/></c:when>
						  					<c:when test="${srLanguage == 'en'}"><c:out value="${moduleCode_result.codeNmEn}"/></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><c:out value="${moduleCode_result.codeNmCn}"/></c:when>
						  					<c:otherwise><c:out value="${moduleCode_result.codeNm}"/></c:otherwise>
						  				</c:choose>  	
		                            </c:if>
		                        </c:forEach>
						    </td>    
						  </tr>  
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.processingDivision'/>
						    	<!-- kpmg 2021.07.14 -->
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" class="tdleft">
						    	<c:forEach var="classCode_result" items="${classCode_result}" varStatus="status">
		                            <c:if test="${classCode_result.code == srVO.category}">
		                            	<c:out value="${classCode_result.codeNm}"/>
		                            	<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value="${classCode_result.codeNm}"/></c:when>
						  					<c:when test="${srLanguage == 'en'}"><c:out value="${classCode_result.codeNmEn}"/></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><c:out value="${classCode_result.codeNmCn}"/></c:when>
						  					<c:otherwise><c:out value="${classCode_result.codeNm}"/></c:otherwise>
						  				</c:choose>  	
		                            </c:if>
		                        </c:forEach>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.priority'/></th>          
						    <td width="30%" class="tdleft">
						    	<input type="radio" name="priority" class="radio2" value="1002" <c:if test="${srVO.priority == '1002'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.normal'/>
				                <input type="radio" name="priority" class="radio2" value="1001" <c:if test="${srVO.priority == '1001'}"> checked="checked"</c:if>>&nbsp;&nbsp;<spring:message code='sr.urgent'/>
				                <input type="radio" name="priority" class="radio2" value="1000" <c:if test="${srVO.priority == '1000'}"> checked="checked"</c:if>>&nbsp;&nbsp;<spring:message code='sr.veryUrgent'/> 
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr>  
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.completeHopeDate'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.hopeDate}'/>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.expectedCompletionDate'/></th>          
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.scheduleDate}'/>
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.predictionLabourHours'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.expectTime}'/>&nbsp;<spring:message code='sr.predictionLabourHoursEx'/>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.realLabourHours'/></th>          
						    <td width="30%" class="tdleft">
						    	<input type="text" name="realExpectTimeDisp" id="realExpectTimeDisp" style="text-align:right;" class="tdwr" size="6" disabled readonly="readonly">&nbsp;Hr (ABAP <spring:message code='sr.labourHours'/>&nbsp;<fmt:formatNumber value="${srVO.abapRealExpectTime}" pattern="##,###,##0.00"/>&nbsp;Hr)
						    	<input type="hidden" name="realExpectTime" id="realExpectTime" value="${srVO.realExpectTime}"/>
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.charge'/></th>
						    <td width="30%" class="tdleft">
						    	<c:forEach var="chargerList" items="${chargerList}" varStatus="status">
		                            <c:if test="${chargerList.userId == srVO.rid}">
		                            	<c:out value="${chargerList.userNm}"/>
		                            	<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value="${chargerList.userNm}"/></c:when>
						  					<c:when test="${srLanguage == 'en'}"><c:out value='${chargerList.userNmEn}'/></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><c:out value='${chargerList.userNmEn}'/></c:when>
						  					<c:otherwise><c:out value="${chargerList.userNm}"/></c:otherwise>
						  				</c:choose>  			                            	
		                            </c:if>
		                        </c:forEach>
		                        <input type="hidden" name="rid" id="rid" value="${srVO.rid}"/>
						    </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.processingCompletionDate'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.completeDate}'/>
						    	<input name="completeDate" type="hidden" value="<c:out value='${srVO.completeDate}'/>" >
				            </td>
						  </tr>	
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requestContent'/>
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3" class="tdleft">
						    	<c:out value="${srVO.comment}" escapeXml="false" />
<!-- 						    	<textarea id="comment" name="comment"  cols="50" rows="15"  style="width:99%" readonly="readonly" title="글내용"> -->
                               		<c:out value="${srVO.comment}" escapeXml="true" />
<!--                                 </textarea> -->
						    </td>    
						  </tr>	
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						  </tr>
						  
						  <c:if test="${not empty srVO.fileId}">
                              <tr> 
                                <th height="23" class="tdblue" scope="row" nowrap><spring:message code="cop.atchFileList" /></th>
                                <td colspan="3" class="tdleft">
                                    <c:import url="/cmm/fms/selectFileInfsSr.do" charEncoding="utf-8">
                                        <c:param name="param_atchFileId" value="${srVO.fileId}" />
                                    </c:import>
                                </td>
                              </tr>
                              
                              <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							  </tr> 
                          </c:if>
						  
                        </table>
                    
                    
                    <!-- 저장된 답변이 있을때 답변 목록 화면 Display -->
                    <c:if test="${fn:length(answerList) != 0}">
                    
	                    <c:set var="trIdValue" value="0"/>
	                    <c:forEach var="result" items="${answerList}" varStatus="status">
	                    
	                    <br>
	                    <div class="inputtb" >
	                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="답변 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
	                        
	                        	  <input type="hidden" name="answerNoArr" id="answerNoArr" value='<c:out value="${result.answerNo}"/>'>
								  <tr>
						              <td colspan="4" bgcolor="#0257a6" height="2"></td>
								  </tr>
								  
								  <c:if test="${result.answerSe == '10'}">	<!-- 답변 -->
									  <tr> 
									  	<th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.realLabourHours'/></th>
									    <td width="30%" class="tdleft">
									    	&nbsp;<fmt:formatNumber value="${result.realExpectTime}" pattern="##,###,##0.00"/> &nbsp;<spring:message code='sr.predictionLabourHoursEx'/>
									    	<input type="hidden" name="realExpectTimeSaved" id="realExpectTimeSaved" value="<c:out value='${result.realExpectTime}'/>" >
									    </td>  
									    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.processors'/></th>
									    <td width="30%" class="tdleft">
									    	<c:out value="${result.rname}"/>

											<c:forEach var="chargerList" items="${chargerList}" varStatus="status">                             
					                            <c:if test="${chargerList.userId == result.rid}">                                      
					                            	<c:choose>                                                                          
									  					<c:when test="${srLanguage == 'ko'}"><c:out value="${chargerList.userNm}"/></c:when>          
									  					<c:when test="${srLanguage == 'en'}"><c:out value='${chargerList.userNmEn}'/></c:when>        
									  					<c:when test="${srLanguage == 'cn'}"><c:out value='${chargerList.userNmEn}'/></c:when>        
									  					<c:otherwise><c:out value="${chargerList.userNm}"/></c:otherwise>                             
									  				</c:choose>  			                            	                                                
					                            </c:if>                                                                               
					                        </c:forEach>             
									    	
									    	&nbsp;&nbsp;<c:out value="${result.signDate}"/>
									    </td>
									  </tr>	
									  
									  <tr>
							              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
									  </tr> 
									  
									  <tr> 
									    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.processingDivision'/></th>
									    <td width="30%" class="tdleft">
									    	<c:forEach var="classCode_result" items="${classCode_result}" varStatus="status">
					                            <c:if test="${result.category == classCode_result.code}">
					                            <c:out value="${classCode_result.codeNm}"/>
						                            <c:choose>                                                                                      
									  					<c:when test="${srLanguage == 'ko'}"><c:out value="${classCode_result.codeNm}"/></c:when>                 
									  					<c:when test="${srLanguage == 'en'}"><c:out value="${classCode_result.codeNmEn}"/></c:when>               
									  					<c:when test="${srLanguage == 'cn'}"><c:out value="${classCode_result.codeNmCn}"/></c:when>               
									  					<c:otherwise><c:out value="${classCode_result.codeNm}"/></c:otherwise>                                    
									  				</c:choose>  	 
					                            </c:if>
					                        </c:forEach>
							            </td>
									    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.module'/>
									    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
									    </th>          
									    <td width="30%" class="tdleft">
									    	<c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
					                            <c:if test="${result.moduleCode == moduleCode_result.code}">
					                            <c:out value="${moduleCode_result.codeNm}"/>
						                            <c:choose>                                                                                      
									  					<c:when test="${srLanguage == 'ko'}"><c:out value="${moduleCode_result.codeNm}"/></c:when>                 
									  					<c:when test="${srLanguage == 'en'}"><c:out value="${moduleCode_result.codeNmEn}"/></c:when>               
									  					<c:when test="${srLanguage == 'cn'}"><c:out value="${moduleCode_result.codeNmCn}"/></c:when>               
									  					<c:otherwise><c:out value="${moduleCode_result.codeNm}"/></c:otherwise>                                    
									  				</c:choose>  
					                            </c:if>
					                        </c:forEach>
									    </td>    
									  </tr> 
									  
									  <tr>
							              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
									  </tr> 								  
								  </c:if>
								  
								  <c:if test="${result.answerSe == '20'}">	<!-- 추가요청 -->
									  <tr> 
									    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.addRequestDate'/></th>
									    <td width="80%" colspan="3" class="tdleft">
									    	<c:out value="${result.signDate}"/>
									    </td>
									  </tr>	
									  
									  <tr>
							              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
									  </tr> 								  
								  </c:if>
								  
								  <tr> 
								    <th width="20%" height="23" class="tdblue" scope="row" nowrap >
								    	<c:if test="${result.answerSe == '10'}">
									    	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
									    		<c:if test="${result.afterCnt == '0'}">
											    	<input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
											    	<input type="hidden" name="checkId" value="<c:out value="${result.answerNo}"/>" />
									    		</c:if>
									    	</c:if>
									    	<spring:message code='sr.answers'/>
								    	</c:if>
								    	<c:if test="${result.answerSe == '20'}">
								    		<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_USER_MEMBER'}">
										    	<c:if test="${result.afterCnt == '0'}">
											    	<input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
											    	<input type="hidden" name="checkId" value="<c:out value="${result.answerNo}"/>" />
										    	</c:if>
									    	</c:if>
									    	<spring:message code='sr.addRequest'/>
								    	</c:if>
										<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
								    </th>
								    <td width="80%" colspan="3" class="tdleft">
								    	<c:out value="${result.comment}" escapeXml="false" />
								    	<textarea id="commentArr${trIdValue}" name="commentArr"  cols="50" rows="10"  style="width:99%" readonly="readonly" title="글내용">
		                               		<c:out value="${result.comment}" escapeXml="true" />
<!-- 		                                </textarea> -->
								    </td>    
								  </tr>	
								  
								  <tr>
						              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
								  </tr> 
								  
								  
								  <c:if test="${not empty result.fileId}">
		                              <tr> 
		                                <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code="cop.atchFileList" /></th>
		                                <td width="80%" colspan="3" class="tdleft">
		                                    <c:import url="/cmm/fms/selectFileInfsSr.do" charEncoding="utf-8">
		                                        <c:param name="param_atchFileId" value="${result.fileId}" />
		                                    </c:import>
		                                </td>
		                              </tr>
		                              
		                              <tr>
							              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
									  </tr> 
		                          </c:if>
		               
		                          	<c:if test="${result.cstmrComment != ''}">
		                          		<tr> 
										    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='cop.customerOpinion'/></th>
										    <td width="80%" colspan="3" class="tdleft">
									    		<textarea name="cstmrCommentArr" id="cstmrCommentArr" cols="50" rows="5" style="width:99%" title="글내용"><c:out value="${result.cstmrComment}" escapeXml="true" /></textarea>
										    </td>    
										  </tr>
										  <tr>
								              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
										  </tr> 
		                          	</c:if>								  
		                        </table>
		                    </div>
		                    
		                <c:set var="trIdValue" value="${trIdValue+1}"/>
						</c:forEach>
						
					</c:if>
					
					
					
					
					<!-- 임시저장된 답변이 없을때 신규 답변 화면 Display -->
					<c:if test="${fn:length(answerListTemp) == 0}">
						<c:if test="${srVO.status != '1006'}">		<!-- 완료시에만 제외 -->
							<br>
		                    <div class="inputtb" >
		                    	<font color="blue"><b>※ <spring:message code='sr.sendEmail'/></b></font> <input type="checkbox" name="emailSendAt" id="emailSendAt" checked >
		                        <table width="980" border="0" cellpadding="0" cellspacing="0"summary="답변 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
								  <tr>
						              <td colspan="5" bgcolor="#0257a6" height="2"></td>
						          </tr>
								  
								  <tr> 
								    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.addRequest'/>
										<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
								    </th>
								    <td width="80%" colspan="3" class="tdleft">
						                <textarea id="ansComment" name="ansComment"  cols="75" rows="10"  style="width:99%" readonly="readonly" title="글내용"><c:out value="${srVO.ansComment}" escapeXml="true" /></textarea>
								    </td>    
								  </tr>	
								  
								  <tr>
						              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
								  <tr> 
								  <input type="hidden" name="ansFileId" value="<c:out value='${srVO.ansFileId}'/>"/>
								  <tr>
		                             <th height="23" class="tdblue" scope="row" nowrap><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
		                             <td colspan="3" class="tdleft">
		                             	<input name="file_1" id="egovComFileUploader" type="file" />
		                                <div id="egovComFileList"></div>
		                             </td>
		                           </tr>
		                           
		                           <tr>
						              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
								  </tr> 	
		                           
		                        </table>
		                    </div>
							<br>
						</c:if>
                    
					</c:if>
					
					
					<!-- 임시저장된 추가요청이 있을때 임시 추가요청 화면 Display -->
					<c:if test="${fn:length(answerListTemp) != 0}">
					
						<c:forEach var="result" items="${answerListTemp}" varStatus="status">
							
						 <br>
	                     <div class="inputtb" >
	                     	
	                     	<font color="blue"><b>※ <spring:message code='sr.sendEmail'/></b></font> <input type="checkbox" name="emailSendAt" id="emailSendAt" checked >
	                        <table width="980" border="0" cellpadding="0" cellspacing="0"summary="답변 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
	                        
							  	  <input type="hidden" name="answerNo" id="answerNo" value='<c:out value="${result.answerNo}"/>'>
								  <tr>
						              <td colspan="5" bgcolor="#0257a6" height="2"></td>
						          </tr>
								  
								  <tr> 
								    <th width="20%" height="23" class="tdblue" scope="row" nowrap >
								    	<input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
								    	<input type="hidden" name="checkId" value="<c:out value="${result.answerNo}"/>" />
								    	<spring:message code='sr.tempAddRequest'/>
										<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
								    </th>
								    <td width="80%" colspan="3" class="tdleft">
								    	<textarea id="ansComment" name="ansComment"  cols="75" rows="10"  style="width:99%" readonly="readonly" title="글내용"><c:out value="${result.ansComment}" escapeXml="true" /></textarea>
								    </td>    
								  </tr>	
								  
								  <tr>
						              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
								  </tr> 
								  <!-- 임시저장된 첨부파일 Display -->
								  <input type="hidden" name="ansFileId" value="<c:out value='${result.ansFileId}'/>"/>
								  <c:if test="${not empty result.ansFileId}">
		                              <tr> 
		                                <th height="23" class="tdblue" scope="row" nowrap><spring:message code="cop.atchFileList" /></th>
		                                <td colspan="3" class="tdleft">
		                                    <c:import url="/cmm/fms/selectFileInfsForUpdateAns.do" charEncoding="utf-8">
		                                        <c:param name="param_atchFileId" value="${result.ansFileId}" />
		                                    </c:import>
		                                </td>
		                              </tr>
		                              
		                              <tr>
							              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
									  </tr> 
		                          </c:if>
		                          
								  <tr>
		                             <th height="23" class="tdblue" scope="row" nowrap><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
		                             <td colspan="3" class="tdleft">
		                             	<div id="file_upload_posbl"  style="display:none;" >
		                             		<input name="file_1" id="egovComFileUploader" type="file" />
		                                <div id="egovComFileList"></div>
		                             	</div>
		                             	<div id="file_upload_imposbl"  style="display:none;" >
		                             	</div>
		                             	<c:if test="${empty result.ansFileId}">
			                                <input type="hidden" name="fileListCnt" value="0" />
			                            </c:if>
		<!--                                          <input name="file_1" id="egovComFileUploader" type="file" /> -->
		<!--                                              <div id="egovComFileList"></div> -->
		                             </td>
		                           </tr>	
		                           
		                           <tr>
						              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
								  </tr> 	                          
	                    
		                        </table>
		                    </div>
						
						</c:forEach>
						
					</c:if>
					
					
					
                    
                    <c:if test="${srVO.status == '1005' || srVO.status == '1006'}">
	                    <br>
	                    <div class="inputtb" >
	                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="테스트여부 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
							  <tr>
					              <td colspan="5" bgcolor="#0257a6" height="2"></td>
							  </tr>
							  <tr> 
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.customerConfirm'/>
									<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
							    </th>
							    <td width="30%" class="tdleft">
							    	<input type="radio" name="testAt" class="radio2" value="Y" <c:if test="${srVO.testAt == 'Y'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.completion'/>
						            <input type="radio" name="testAt" class="radio2" value="N" <c:if test="${srVO.testAt == 'N'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.incomplete'/>						            
							    </td>    
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.customersConfirmationCompletionDate'/>
							    </th>
							    <td width="30%" class="tdleft">
							    	<c:out value='${srVO.testCompleteDate}'/>
						            <form:hidden path="testCompleteDate" id="testCompleteDate" />
							    </td>    
							  </tr>	
							  
							  <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							  </tr> 
							  
	                          <tr> 
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.particularsConfirm'/>
							    	<!-- kpmg 2021.07.14 -->
							    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
							    </th>
							    <td width="80%" colspan="3" class="tdleft">
							    	<form:input path="testContent" id="testContent" cssClass="txaIpt"  size="80"  maxlength="2000" />
					                <form:errors path="testContent" cssClass="error" />
							    </td>    
							  </tr>	
							  
							  <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							  </tr> 
							  
	                        </table>
	                    </div>
	                    
	                    <br>
	                    <div class="inputtb" >
	                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="만족도 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
							  <tr>
					              <td colspan="5" bgcolor="#0257a6" height="2"></td>
							  </tr>
							  <tr> 
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='cop.satisfaction.stsfdg'/>
									<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
							    </th>
							    <td width="80%" colspan="3" class="tdleft">
						            <input type="radio" name="point" class="radio2" value="5" <c:if test="${srVO.point == '5'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.5point'/>
						            <input type="radio" name="point" class="radio2" value="4" <c:if test="${srVO.point == '4'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.4point'/>
						            <input type="radio" name="point" class="radio2" value="3" <c:if test="${srVO.point == '3'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.3point'/>
						            <input type="radio" name="point" class="radio2" value="2" <c:if test="${srVO.point == '2'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.2point'/>
							    	<input type="radio" name="point" class="radio2" value="1" <c:if test="${srVO.point == '1'}"> checked="checked"</c:if>>&nbsp;<spring:message code='sr.1point'/>
							    </td>    
							  </tr>	
							  
							  <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							  </tr> 
							  
	                          <tr> 
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.otherOpinions'/></th>
							    <td width="80%" colspan="3" class="tdleft">
							    	<form:input path="pointContent" id="pointContent" cssClass="txaIpt" size="80"  maxlength="2000" />
					                <form:errors path="pointContent" cssClass="error" />
							    </td>    
							  </tr>	
							  
							  <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							  </tr> 
							  
	                        </table>
	                    </div>
                    </c:if>
                 
                 </div>   
                    
				
				<!-- CTS 정보 위치 TODO SHS -->
				<c:if test="${!empty cts_result}">
					<br/>
					<div class="inputtb">				
						<table id="ctsTbl" width="980" border="0" cellpadding="0" cellspacing="0" summary="CTS 정보 Display 테이블이다">
							<colgroup>
								<col width='20%' />
								<col width='55%'/>
								<col width='25%'/>
							</colgroup>
							<tr>
								<td colspan="3" bgcolor="#0257a6" height="2"></td>
							</tr>
							<tr class="tdblue">
								<th>CTS Number</th>
								<th>Description</th>
								<th>Owner</th>
							</tr>
							<tr>
				              <td colspan="3" bgcolor="#dcdcdc" height="1"></td>
						    </tr> 
							<c:forEach var="cts_result" items="${cts_result}" varStatus="status">
								<tr>
									<td><input type="text" style="border: none; width:90%;" name="cts_numbers" value='${cts_result.cts_number}' readonly /></td>
									<td><input type="text" style="border: none; width:90%;" name="cts_descs" value="${cts_result.cts_desc}" readonly/></td>
									<td><input type="text" style="border: none; width:90%;" name="cts_owners" value="${cts_result.cts_owner}" readonly/></td>
								</tr>
								<tr>
					              <td colspan="3" bgcolor="#dcdcdc" height="1"></td>
							    </tr> 							
							</c:forEach>  
							
	
						</table>
	 				</div>				
				</c:if>
				

                    
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<c:if test="${srVO.status != '1006'}">
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnTempUpdate(); return false;"><spring:message code='button.addRequestTempSave'/> ▶</a></span>&nbsp;
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnSave(); return false;"><spring:message code='button.addRequestSave'/> ▶</a></span>&nbsp;
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnDeleteAnswer(); return false;"><spring:message code='button.addRequestDelete'/> ▶</a></span>&nbsp;
                    	</c:if>
                    	
                    	<c:if test="${srVO.status == '1005'}">
                    		<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnUpdateTest(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;	                    	
                    	<c:if test="${srVO.status != '1005' && srVO.status != '1006' && (fn:length(answerList) != 0)}">
                    		<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnUpdate(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    	</c:if>
                    	                    	
                    		<span class="btnblue"><a href="#LINK" onclick="javascript:document.srVO.reset();"><spring:message code="button.reset" /> ▶</a></span>&nbsp;
                    	</c:if>
                    	<c:if test="${srVO.status == '1001' || srVO.status == '1002'}">                    	
                    		<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnDelete(); return false;"><spring:message code='button.delete'/> ▶</a></span>&nbsp;
                    	</c:if>                    	
                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnListPage(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 --> 
                      
                    

 			        <!-- 상세정보 SR 삭제시 prameter 전달용 input -->
<!-- 			        <input name="checkedIdForDel" type="hidden" /> -->
			        <!-- 검색조건 유지 -->
			        
		        	<form:hidden path="srNo" id="srNo" />
		        	
		        	<input type="hidden" name="saveSe" />
		        	<input type="hidden" name="tempSaveAt" />
		        	<input type="hidden" name="tat" />
		        	<input type="hidden" name="answerNoDelArr"/>
		        	<input type="hidden" name="answerSe"/>
		        	
		        	<input type="hidden" name="returnUrl" value="<c:url value='/sr/EgovSrSelectUpdtView.do'/>"/>		        	
		        	<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
					
		        	<input type="hidden" name="atchFileId" value="${atchFileId}"/>
					<input type="hidden" name="fileSn" />
					<input type="hidden" name="fileListCnt" value="${fileListCnt}"/>	      
								        
			        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        
			        <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>"/>
			        <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>"/>
			        <c:forEach var="vList3" items="${searchVO.searchStatus}" varStatus="vStatus3">
	           			<input type="hidden" name="searchStatus" value="<c:out value='${vList3}'/>" />
	       			</c:forEach>
	       						        
			        <input type="hidden" name="searchConfirmDateF" value="<c:out value='${searchVO.searchConfirmDateF}'/>"/>
					<input type="hidden" name="searchConfirmDateT" value="<c:out value='${searchVO.searchConfirmDateT}'/>"/>
					<input type="hidden" name="searchConfirmDateFView" value="<c:out value='${searchVO.searchConfirmDateFView}'/>"/>
					<input type="hidden" name="searchConfirmDateTView" value="<c:out value='${searchVO.searchConfirmDateTView}'/>"/>
					<input type="hidden" name="searchCustomerNm" value="<c:out value='${searchVO.searchCustomerNm}'/>"/>
					<input type="hidden" name="searchRname" value="<c:out value='${searchVO.searchRname}'/>"/>
					<input type="hidden" name="searchRid" value="<c:out value='${searchVO.searchRid}'/>"/>
					<input type="hidden" name="searchCompleteDateF" value="<c:out value='${searchVO.searchCompleteDateF}'/>"/>
					<input type="hidden" name="searchCompleteDateT" value="<c:out value='${searchVO.searchCompleteDateT}'/>"/>
					<input type="hidden" name="searchCompleteDateFView" value="<c:out value='${searchVO.searchCompleteDateFView}'/>"/>
					<input type="hidden" name="searchCompleteDateTView" value="<c:out value='${searchVO.searchCompleteDateTView}'/>"/>
					<input type="hidden" name="searchTcode" value="<c:out value='${searchVO.searchTcode}'/>"/>
					<input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>"/>
					<input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>"/>
					<input type="hidden" name="searchSubject" value="<c:out value='${searchVO.searchSubject}'/>"/>
					
					<input type="hidden" name="ctsChk" id="ctsChk" value="N"/>
                </form:form>
                
            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div> --%>
<!-- //전체 레이어 끝 -->
</body>
</html>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function dchk2(num) {
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
/* 합계 function */
function fncTimeSum() {
	
	var timeArr = 0;
	var ansTime = 0;
	var timeTotal = 0;
	
	if (typeof document.srVO.realExpectTimeSaved.length == 'undefined'){
// 		alert("undefined..");
		timeArr = document.srVO.realExpectTimeSaved.value;
		timeTotal += Number(timeArr.replace(/,/gi,''));
// 		alert("timeArr.." + timeArr);
// 		alert("timeTotal.." + timeTotal);
	}else{
// 		alert("defined..");
		for (var i = 0; i < document.srVO.realExpectTimeSaved.length; i++) {
			timeArr = document.srVO.realExpectTimeSaved[i].value;
			timeTotal += Number(timeArr.replace(/,/gi,''));
		}
	}
// 	alert(document.srVO.realExpectTimeSaved.length);
	
// 	ansTime = document.srVO.ansRealExpectTime.value;
// 	timeTotal += Number(ansTime.replace(/,/gi,''));
	var result = CommaIns(Number(timeTotal).toFixed(2),8,2);

	document.srVO.realExpectTimeDisp.value = result;
	document.srVO.realExpectTime.value = result;
	
}

//onLoad 실제공수 합계 fnc 호출
//fncTimeSum();

-->
</script>


