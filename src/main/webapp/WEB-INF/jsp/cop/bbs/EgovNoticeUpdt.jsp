<%--
  Class Name : EgovNoticeUpdt.jsp
  Description : 게시물 수정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<%-- <c:set var="date" value="<%= new Date()%>" /> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>

<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css"> --%>
<title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.update' /></title>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<!-- CK Editor Script -->
<script type="text/javascript" src="<c:url value='/js/ckEditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/en.js'/>"></script>
<style>
.ck-editor__editable_inline {
    min-height: 200px;
}
</style>
<!-- CK Editor Script -->

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<%-- <validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if> --%>
<script type="text/javascript">
    function fn_egov_validateForm(obj){
        return true;
    }

    function fn_egov_regist_notice(){
        //document.board.onsubmit();
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		<c:if test="${(bdMstr.bbsId == 'BBSMSTR_000000000011') && (authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR')}">
        if(document.getElementById("pstinstCode").value==""){
            alert("<spring:message code='sr.client'/><spring:message code='errors.required'/>");
            return false;
        }
        </c:if>
        
        if (!validateBoard(document.board)){
            return;
        }
        
        if (confirm('<spring:message code="common.update.msg" />')) {
            document.board.action = "<c:url value='/cop/bbs${prefix}/updateBoardArticle.do'/>";
            document.board.submit();                    
        }
    }   
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.board.submit();    
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
        document.boardVO.action = "<c:url value='/cop/bbs/selectBoardList.do'/>";
        document.boardVO.submit();
    }
    
    /* ********************************************************
     * 수정 처리 함수
     ******************************************************** */
    function fnUpdate(){
    	$("#nttCn").text(editor.getData());
    	if ("<c:out value='${anonymous}'/>" == "true" && document.boardVO.password.value == '') {
            alert('<spring:message code='errors.required.pwInput.msg'/>');
            document.boardVO.password.focus();
            return;
        }
		
    	var form = $("#boardVO")[0];
		var formData = new FormData(form);
		formData.delete("files");		
		var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
		for(var i in uploadFiles){
			formData.append("files",uploadFiles[i]);
		}
		$.ajax({
      		url : "<c:url value='/cop/bbs/updateBoardArticle.do'/>",
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

    function validateSrVO(form){
    	var checkOption = {
    		subject : { valid : "required,maxlength" 
    					, label : "<spring:message code='sym.ems.title'/>" 
    					, max : 100 }
    		, pstinstCode : { valid : "required" , label : "<spring:message code='sr.client'/>"}
    		, customerId : { valid : "required" , label : "<spring:message code='sr.requester'/>"}
    		, email : { valid : "required" , label : "<spring:message code='cop.emailAdres'/>"}
    		, moduleCode : { valid : "required" , label : "<spring:message code='sr.module'/>"}
    		, category : { valid : "required" , label : "<spring:message code='sr.processingDivision'/>"}
    		, comment : { valid : "required" , label : "<spring:message code='sr.requestContent' />"}
    	}	
    	if(validateCheck(form, checkOption)){
    		return true;
    	}
    	return false;
    }
    /**
     * 답변저장
     */
    function fnSave(){
    	
    	document.srVO.saveSe.value="3";
    	
    	$("#ansComment").text(ansEditor.getData());	// 에디터의 내용이 textarea에 적용됩니다.
    	if(document.srVO.ansComment.value == '<p>&nbsp;</p>' || document.srVO.ansComment.value == ''){
    		alert("<spring:message code='sr.error.required.answer'/>");
            return false;
    	}
    	//해결중이후 필수항목 체크
    	if(document.srVO.status.value == '1004' || document.srVO.status.value == '1005' || document.srVO.status.value == '1006'){
    		if(document.srVO.scheduleDate.value == ''){
    			alert("<spring:message code='sr.error.required.expectedCompletionDate'/>");
    	        return false;
    		}
    	}
    	//고객확인이후 필수항목 체크
    	if(document.srVO.status.value == '1005' || document.srVO.status.value == '1006'){
    		if(document.srVO.completeDate.value == ''){
    			alert("<spring:message code='sr.processingCompletionDate'/><spring:message code='errors.required'/>");
    	        return false;
    		}
    		
    	//20201014 SHS 고객확인이후 처리구분 필수로 체크
    		//if(document.srVO.category[0].selected){
    		//	alert("처리구분<spring:message code='errors.required'/>");
    		//	return false;
    		//}
    		
    	}
    	if(document.srVO.status.value == '1006'){	//완료시 필수항목 체크
    		if(document.srVO.testAt[0].checked || document.srVO.testAt[1].checked){
    		}else{
    			alert("<spring:message code='sr.error.required.customerConfirmation'/>");
    	        return false;
    		}
    		if(document.srVO.point[0].checked || document.srVO.point[1].checked || document.srVO.point[2].checked || document.srVO.point[3].checked || document.srVO.point[4].checked){
    		}else{
    			alert("<spring:message code='sr.error.required.satisfaction'/>");
    	        return false;
    		}
    		if(confirm("<spring:message code="common.save.msg" />")){
    			$("#ansComment").text(ansEditor.getData());	// 에디터의 내용이 textarea에 적용됩니다.
     			document.srVO.answerSe.value="10";		//담당자
             	document.srVO.submit();
             	document.srVO.action = "";
     		}
    	}else{
    		if(confirm("<spring:message code="common.save.msg" />")){
    			$("#ansComment").text(ansEditor.getData());	// 에디터의 내용이 textarea에 적용됩니다.
    			document.srVO.answerSe.value="10";		//담당자
            	document.srVO.submit();
            	document.srVO.action = "";
    		}
    	}
    }
    /**
     * 답변임시저장
     */
    function fnTempUpdate(){
    	if(confirm("<spring:message code="common.save.msg" />")){
    		$("#ansComment").text(ansEditor.getData());	// 에디터의 내용이 textarea에 적용됩니다.
    		document.srVO.saveSe.value="2";
    		document.srVO.answerSe.value="10";		//담당자
    		document.srVO.submit();			
    		document.srVO.action = "";
    	}
    }

    function fnChecked() {

        var checkField = document.srVO.checkField;
        var checkId = document.srVO.checkId;
        var returnValue = "";
        
//         alert("checkField : " + document.srVO.checkField.length);

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
//         	alert("checkField.length : " + checkField.length);
//         	alert("document.srVO.checkField.checked : " + document.srVO.checkField.checked);
        	alert('<spring:message code='common.noChecked.msg'/>');
        }
//         alert("returnValue : " + returnValue);
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
     function fnSendMail(){
    		if(confirm("<spring:message code="common.sendMail.msg" />")){
//     			oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
    	    	document.srVO.action           = "<c:url value='/sr/sendMail.do'/>";
    		    document.srVO.submit();
    		    document.srVO.action = "";
    	    }
    	}
     /**
      * 데이터 삭제
      */
     function fnClear(obj) {
    	 obj.value="";
    	 obj.focus();
    	 return false;
     }
     
     
    ////////////////////////////////////////////////////////////////////////////////////////
    ///////////			날짜 Valication Check Start	////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////
      var scheduleDate = "<c:out value='${srVO.scheduleDate}'/>";
      var completeDate = "<c:out value='${srVO.completeDate}'/>";
      
      //완료 예정일 날짜 체크..
      function fnScheduleDateChk(sDate, hDate){
      	//요청일보다 완료예정일이 과거일 경우...
    	if(fn_replaceAll(sDate.value.substring(0,10), "-", "") > fn_replaceAll(hDate.value, "-", "")){
    		alert("<spring:message code='sr.error.msg.expectedCompletionDate'/>");
    		document.getElementById('scheduleDate').value = scheduleDate;
    		document.getElementById('scheduleDateView').value = scheduleDate;	
    	}else{
    		scheduleDate = hDate.value;
    	}
      }
      
      function fnCompleteDateChk(sDate, hDate){
      	//요청일보다 완료일이 과거일 경우...
    	if(fn_replaceAll(sDate.value.substring(0,10), "-", "") > fn_replaceAll(hDate.value, "-", "")){
    		alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
    		document.getElementById('completeDate').value = completeDate;
    		document.getElementById('completeDateView').value = completeDate;	
    	}else{
    		completeDate = hDate.value;
    	}
      }
    	
      function fn_replaceAll(str,out,add) {
    	return str.split(out).join(add);
      }
      
      function fn_add_cts(){
    	  	
    	  	var cnt = $("input[name='cts_numbers']").length;
    	  	
    		var html = "";
    		html += 	'<tr>';
    		html += 	'<td><span style="width:90%;" class="sbux-comp-root sbux-uuid-cts_numbers"><input id="cts_numbers_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="cts_numbers" style="width:90%;" data-sbux-model-name="cts_numbers" data-sbux-storage-data="value"></span></td>';
    		html += 	'<td><span style="width:90%;" class="sbux-comp-root sbux-uuid-cts_descs"><input id="cts_descs_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="cts_descs" style="width:90%;" data-sbux-model-name="cts_descs" data-sbux-storage-data="value"></span></td>';
    		html += 	'<td><span style="width:90%;" class="sbux-comp-root sbux-uuid-cts_owners"><input id="cts_owners_'+cnt+'" class="sbux-inp-input sbux-exist" type="text" name="cts_owners" style="width:90%;" data-sbux-model-name="cts_owners" data-sbux-storage-data="value"></span></td>';
    		html += 	'<td class="th_center"><button onclick = "javascript:fn_del_cts('+cnt+'); return false;" type="button" class="sbux-btn   sbux-exist sbux-comp-root sbux-uuid-sbux-auto_0 btn-intable" autocomplete="off" name="sbux-auto_0" data-sbux-model-name="sbux-auto_0" data-sbux-storage-data="value"><span class="sbux-btn-txt"><spring:message code='sr.ctsDel' /></span></button></td>';		
    		html += 	'</tr>';
    		
    		$('#ctsTbl > tbody:last').append(html);
    		$('#ctsChk').val("Y");
    	
    }
    	
      function fn_del_cts(cnt){
    	  tr = $("#cts_numbers_"+cnt).parent().parent().parent();
    	  tr.remove();
    	  $('#ctsChk').val("Y");
      }

</script>
<%-- <style type="text/css">
.noStyle {background:ButtonFace; BORDER-TOP:0px; BORDER-bottom:0px; BORDER-left:0px; BORDER-right:0px;}
  .noStyle th{background:ButtonFace; padding-left:0px;padding-right:0px}
  .noStyle td{background:ButtonFace; padding-left:0px;padding-right:0px}
</style>
<title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.update'/></title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style> --%>

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
		    //,toolbar : []
		}).then(newEditor => {
			editor = newEditor;
			editorSetting(editor);
			
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
		   	    data : $("#boardVO").serialize(),
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
		
		
		//답변 처리
		<c:if test="${fn:length(answerList) != 0}">
			<c:forEach var="result" items="${answerList}" varStatus="status">
				ClassicEditor
				.create( document.querySelector( '#editor'+'<c:out value="${result.answerNo}"/>' ), {
				    language: editorLanguage //언어설정	
				    ,toolbar : []
				}).then(newEditor => {
					editor = newEditor;
					//editor.enableReadOnlyMode("readOnlyMode");
					
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
				   	    	atchFileId : "${result.fileId}"
				   	    },
				   	    success : function(data){
				 	   		for(var i in data.fileList){
				 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
				 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
				 	   			data.fileList[i].size = data.fileList[i].fileMg;
				 	   		}
				 	   		SBUxMethod.refresh('fileUpload_'+ '<c:out value="${result.answerNo}"/>',{'jsondataRef':data.fileList});
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
		
		
		var cnt = $('input[name=cts_numbers]').length;
		if(cnt == 0){
			fn_add_cts();
		}
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
	            <form action="${pageContext.request.contextPath}/cop/bbs/updateBoardArticle.do" name="boardVO" id = "boardVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
					<input type="hidden" name="srNo"/>
					<input type="hidden" name="pstinstCode" value="<c:out value='${boardVO.pstinstCode}'/>"  />
					<input type="hidden" name="pstinstNm" value="<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value='${boardVO.pstinstNm}' />
												</c:when>
												<c:otherwise>
													<c:out value='${boardVO.pstinstNmEn}' />
												</c:otherwise>
											</c:choose>"  />
					<input type="hidden" name="signDate" value="<c:out value='${boardVO.signDate}'/>">
					<input type="hidden" name="tempSaveAt" />
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="returnUrl" value="<c:url value='/cop/bbs/forUpdateBoardArticle.do'/>"/>
					
					<input type="hidden" id = "atchFileId" name="atchFileId" value = "${result.atchFileId}"/>
					<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
					<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
					
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
					<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
					<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
					<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
					<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
					<input type="hidden" id="nttSj" name="nttSj" value="<c:out value='${result.nttSj}' />" />
					
					<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
					<%-- <input type="hidden" id = "fileId" name="fileId" value = "${boardVO.ansFileId}"/> --%>
					
					<c:if test="${anonymous != 'true'}">
						<input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
						<input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
					</c:if>
			
					<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
					   <input name="ntceBgnde" type="hidden" value="10000101">
					   <input name="ntceEndde" type="hidden" value="99991231">
					</c:if>
			
					<!--질문-->
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
	                                    <sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="<spring:message code='sym.ems.title'/>"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-label id="subject" name="subject" uitype="normal" class='leftText' text = "<c:out value='${result.nttSj}' />"></sbux-input>
	                                </td>                            
	                            </tr>
	                                      
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text19" name="th_text19" uitype="normal" text="<spring:message code='sr.requestContent' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<textarea name="nttCn" id="nttCn" style=" display:none;">${result.nttCn}</textarea> 			                                	
	                                	<div id="editor" >${result.nttCn}</div>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" text="<spring:message code="cop.atchFileList" />" ></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText"> 
	                                    <sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
	                                    	vertical-scroll-height="150px"
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
				</form>
				 <div class="btn_buttom">
	         		                                   
                    <c:if test="${bdMstr.authFlag == 'Y'}">
         				<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnUpdate();" class="btn-default"></sbux-button> 
         			</c:if>
                    <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
                </div>
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
	    
	    
<%-- <!-- 전체 레이어 시작 -->
<div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
    	<!-- 현재위치 네비게이션 시작 -->
        <div id="contents">
            <div class="list2">
		     	<ul>
		       	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > <spring:message code='cop.cmmnty'/> > 
		       	${brdMstrVO.bbsNm}
	  				<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${brdMstrVO.bbsNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${brdMstrVO.bbsNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${brdMstrVO.bbsNmCn}"/></c:when>
	  				</c:choose> 		       	
		       	 > <strong><spring:message code='button.update'/></strong></li>
		       </ul>
		  	</div>
		  	
            <!-- 검색 필드 박스 시작 -->
			<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="returnUrl" value="<c:url value='/cop/bbs/forUpdateBoardArticle.do'/>"/>
			
			<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
			<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
			
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
			<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
			<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
			<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
			<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
			<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
			
			<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
			
			<c:if test="${anonymous != 'true'}">
			<input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
			<input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
			</c:if>
	
			<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
			   <input name="ntceBgnde" type="hidden" value="10000101">
			   <input name="ntceEndde" type="hidden" value="99991231">
			</c:if>

            <div class="inputtb" >
            	<table width="980" border="0" cellpadding="0" cellspacing="0" summary="글제목, 글내용 등을 가지고 있는 게시글 상세조회(수정) 테이블이다.">
                	<tr>
	              		<td colspan="4" bgcolor="#0257a6" height="2"></td>
	            	</tr>
	            	<c:if test="${bdMstr.bbsId == 'BBSMSTR_000000000011'}">
						<!-- 담당자, 관리자, Admin -->
			        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							<!-- 고객자료실// -->
		            		<tr>
			                    <th width="20%" height="23" class="tdblue" nowrap="nowrap"><spring:message code='sr.client'/>
			                    	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
			                    </th>
			                    <td width="80%" nowrap class="tdleft" colspan="3">
			                      <select name="pstinstCode" id="pstinstCode" class="select" title="고객사">
					 				<option value='' >==<spring:message code='sr.choose'/>==</option>
								    <c:forEach var="pstinstList" items="${pstinstList}" varStatus="status">
										<option value='<c:out value="${pstinstList.pstinstCode}"/>'  <c:if test="${pstinstList.pstinstCode == result.pstinstCode}">selected</c:if>><c:out value="${pstinstList.pstinstNm}"/></option>
									</c:forEach>
								 </select>
			                    </td>
			                </tr>
			                <tr>
						    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						   	</tr>
			        	</c:if>	    
			        	<!-- 고객, 결재자 -->
			        	<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
			        		<input type="hidden" name="pstinstCode" value="<c:out value='${result.pstinstCode}'/>" />
			        	</c:if>        	
	            	</c:if>
                  	<tr> 
                    	<th width="20%" height="23" class="tdblue" nowrap ><spring:message code="cop.nttSj" />
                        	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
                    	</th>
                    	<td width="80%" nowrap class="tdleft" colspan="3">
	                      	<input name="nttSj" title="<spring:message code="cop.nttSj" />" type="text" size="60" value='<c:out value="${result.nttSj}" />'  maxlength="60" >
                       		<br/><form:errors path="nttSj" /> 
                    	</td>
              		</tr>
              		<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                  	<tr> 
                    	<th height="23" class="tdblue"><spring:message code="cop.nttCn" />
	                        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
                    	</th>
                    	<td colspan="3" class="tdleft">
                      		<textarea id="nttCn" name="nttCn" title="<spring:message code="cop.nttCn" />" class="textarea" cols="75" rows="20"  style="width:99%;"><c:out value="${result.nttCn}" escapeXml="false" /></textarea> 
                      		<form:errors path="nttCn" />
                    	</td>
                  	</tr>
                  	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                  	<c:if test="${bdMstr.bbsAttrbCode == 'BBSA01'}"> 
                  	<tr> 
                       	<th height="23" class="tdblue"><spring:message code="cop.noticeTerm" />
                            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
                        </th>
                        <td colspan="3" class="tdleft">
                          	<input name="ntceBgnde" type="hidden" value='<c:out value="${result.ntceBgnde}" />'>
                          	<input name="ntceBgndeView" type="text" size="10" title="ntceBgndeView" 
	                            value="${fn:substring(result.ntceBgnde, 0, 4)}-${fn:substring(result.ntceBgnde, 4, 6)}-${fn:substring(result.ntceBgnde, 6, 8)}"  readOnly
                            	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
                          		<img src="<c:url value='/images/sr/icon_calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                          	~
                          	<input name="ntceEndde" type="hidden"  value='<c:out value="${result.ntceEndde}" />'>
                          	<input name="ntceEnddeView" type="text" size="10" title="ntceEnddeView"
                            	value="${fn:substring(result.ntceEndde, 0, 4)}-${fn:substring(result.ntceEndde, 4, 6)}-${fn:substring(result.ntceEndde, 6, 8)}"  readOnly
                            	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"  >
                          		<img src="<c:url value='/images/sr/icon_calendar.gif' />"
                            	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                            	width="15" height="15" alt="calendar">
                             	<br/><form:errors path="ntceBgndeView" />    
                             	<br/><form:errors path="ntceEnddeView" />                  
                        </td>
                  	</tr>
                  	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                  	</c:if>   
                  	<c:if test="${not empty result.atchFileId}">
                    <tr> 
                        <th height="23" class="tdblue"><spring:message code="cop.atchFileList" /></th>
                        <td colspan="3" class="tdleft">
                            <c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
                                <c:param name="param_atchFileId" value="${result.atchFileId}" />
                            </c:import>
                        </td>
                  	</tr>
                  	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                  	</c:if>   
                  	<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
                   	<tr> 
                        <th height="23" class="tdblue"><label for="egovComFileUploader" ><spring:message code="cop.atchFile" /></label></th>
                        <td colspan="3" class="tdleft">
                        	<div id="file_upload_posbl"  style="display:none;" >    
                            	<input name="file_1" id="egovComFileUploader" type="file" />
                                	<div id="egovComFileList"></div>
                        	</div>
                        	<div id="file_upload_imposbl"  style="display:none;" ></div>
                        <c:if test="${empty result.atchFileId}">
                         	<input type="hidden" name="fileListCnt" value="0" />
                     	</c:if>
                        </td>         
                  	</tr>
                  	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                  	</c:if>
             	</table>
                
                <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
                <script type="text/javascript">
                    var existFileNum = document.board.fileListCnt.value;        
                    var maxFileNum = document.board.posblAtchFileNumber.value;
            
                    if (existFileNum=="undefined" || existFileNum ==null) {
                        existFileNum = 0;
                    }
                    if (maxFileNum=="undefined" || maxFileNum ==null) {
                        maxFileNum = 0;
                    }       
                    var uploadableFileNum = maxFileNum - existFileNum;
                    if (uploadableFileNum<0) {
                        uploadableFileNum = 0;
                    }               
                    if (uploadableFileNum != 0) {
                        fn_egov_check_file('Y');
                        var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
                        multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
                    } else {
                        fn_egov_check_file('N');
                    }           
                </script>
            	</c:if>
            </div>

			<!-- 버튼 시작(상세지정 style로 div에 지정) -->
         	<div class="list4">
         		<c:if test="${bdMstr.authFlag == 'Y'}">
         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_regist_notice(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
         		</c:if>
         		<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
	       	</div>
         	<!-- 버튼 끝 -->
            </form:form>
        </div>  
        <!-- //contents 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->


<!-- Smart Editor Script -->
<script type="text/javascript">
	var oEditors = [];
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "nttCn",
		sSkinURI: "<c:url value='/SmartEditor2Skin.html' />",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["nttCn"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});

	oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD", []);

	var sDefaultFont = '맑은고딕';
	var nFontSize = 24;
	oEditors.getById["nttCn"].setDefaultFont(sDefaultFont, nFontSize);
	
	function pasteHTML(filepath){ 
	
	    var sHTML = '<img src="<%=request.getContextPath()%>/' + filepath + '">'; 
	//    alert(sHTML); 
	    oEditors.getById["nttCn"].exec("PASTE_HTML", [sHTML]); 
	
	}

	function showHTML() {
		var sHTML = oEditors.getById["nttCn"].getIR();
		alert(sHTML);
	}
	
	function submitContents(elClickedObj) {
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("nttCn").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}

	function setDefaultFont() {
		var sDefaultFont = '맑은고딕';
		var nFontSize = 24;
		oEditors.getById["nttCn"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<!-- //Smart Editor Script --> --%>



</body>
</html>

