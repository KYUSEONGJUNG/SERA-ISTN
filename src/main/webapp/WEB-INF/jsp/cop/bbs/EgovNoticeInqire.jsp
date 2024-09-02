<%--
  Class Name : EgovNoticeInqire.jsp
  Description : 게시물 조회 화면
  Modification Information
 
      수정일      수정자              수정내용
     ----------  --------    ---------------------------
     2009.03.23   이삼섭        최초 생성
     2009.06.26   한성곤        2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31   JJY       	경량환경 버전 생성
     2013.05.23   이기하       	상세보기 오류수정
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.23
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
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css"> --%>

<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css"> --%>
<%-- <title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.inquire' /></title> --%>
<title><spring:message code='cop.notice' /> - <spring:message code='button.inquire' /></title>
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



<%-- <script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if> --%>
<script type="text/javascript">
    function onloading() {
        if ("<c:out value='${msg}'/>" != "") {
            alert("<c:out value='${msg}'/>");
        }
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_delete_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('<spring:message code='errors.required.pwInput.msg'/>');
            document.frm.password.focus();
            return;
        }
        
        if (confirm('<spring:message code="common.delete.msg" />')) {
            document.frm.action = "<c:url value='/cop/bbs${prefix}/deleteBoardArticle.do'/>";
            document.frm.submit();
        }   
    }
    
    function fn_egov_moveUpdt_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('<spring:message code='errors.required.pwInput.msg'/>');
            document.frm.password.focus();
            return;
        }

        document.frm.action = "<c:url value='/cop/bbs${prefix}/forUpdateBoardArticle.do'/>";
        document.frm.submit();          
    }
    
    function fn_egov_addReply() {
        document.frm.action = "<c:url value='/cop/bbs${prefix}/addReplyBoardArticle.do'/>";
        document.frm.submit();          
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
     * 삭제 처리 함수
     ******************************************************** */
    function fnDelete(){
    	if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('<spring:message code='errors.required.pwInput.msg'/>');
            document.boardVO.password.focus();
            return;
        }
    	
        if (confirm("<spring:message code='common.delete.msg'/>")) {
            //var varForm              = document.boardVO;
            
            $.ajax({
          		url : "<c:url value='/cop/bbs/deleteBoardArticle.do'/>",
         	    type : 'POST',
         	    data : $("#boardVO").serialize(),
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
            //varForm.action           = "<c:url value='/cop/bbs/deleteBoardArticle.do'/>";
            //varForm.boardVO.value        = "${srVO.srNo}";
            //varForm.submit();
            //varForm.action = "";
        }
    }


    /* ********************************************************
     * 답변 삭제 처리 함수
     ******************************************************** */
    function fnDeleteAnswer(){
    	if(fnChecked()) {
    	    if (confirm("<spring:message code='common.delete.msg'/>")) {
    	        var varForm              = document.all["srVO"];
    	        varForm.action           = "<c:url value='/sr/EgovSrDeleteAnswer.do'/>";
    	//         varForm.srNo.value        = "${srVO.srNo}";
    	        varForm.submit();
    	        varForm.action = "";
    	    }		
    	}
    }
    /* ********************************************************
     * 수정 처리 함수
     ******************************************************** */
    function fnUpdate(){
    	if ("<c:out value='${anonymous}'/>" == "true" && document.boardVO.password.value == '') {
            alert('<spring:message code='errors.required.pwInput.msg'/>');
            document.boardVO.password.focus();
            return;
        }

        document.boardVO.action = "<c:url value='/cop/bbs/forUpdateBoardArticle.do'/>";
        document.boardVO.submit(); 
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
					editor.enableReadOnlyMode("readOnlyMode");
					
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


<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useComment == 'true'}">
<c:import url="/cop/bbs/selectCommentList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/bbs/selectSatisfactionList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
    function fn_egov_addScrap() {
        document.frm.action = "<c:url value='/cop/bbs/addScrap.do'/>";
        document.frm.submit();          
    }
</script>
</c:if>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<title><c:out value='${result.bbsNm}'/> - <spring:message code='button.inquire'/></title>

<!-- <style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style> -->

</head>
<body onload="onloading();">
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
	            <form action="${pageContext.request.contextPath}/cop/bbs/selectBoardArticle.do" name="boardVO" id = "boardVO" method="post" enctype="multipart/form-data">
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
            		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					
					<input type="hidden" id = "atchFileId" name="atchFileId" value = "${result.atchFileId}"/>
					<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
		            <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
		            <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
		            <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
		            <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
		            <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
		            <input type="submit" id="invisible" class="invisible"/>
					<%-- <input type="hidden" id = "fileId" name="fileId" value = "${boardVO.ansFileId}"/> --%>
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
	                                	<textarea name="comment" id="comment" style=" display:none;">${result.nttCn}</textarea> 			                                	
	                                	<div id="editor" >${result.nttCn}</div>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" text="<spring:message code="cop.atchFileList" />" ></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText"> 
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
	                        </tbody>
	                    </table>
	                </div>
				</form>
				 <div class="btn_buttom">
	         		<!-- Admin, 담당자, 관리자,  -->
		        	<c:if test="${result.frstRegisterId == sessionUniqId || authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">   
                    	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.update"/>" onclick="fnUpdate();" class="btn-default"></sbux-button>                
                    	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.delete"/>" onclick="fnDelete();" class="btn-default"></sbux-button>                
                    </c:if>
                    <c:if test="${result.replyPosblAt == 'Y'}">
	         			<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.comment"/>" onclick="fn_egov_addReply();" class="btn-default"></sbux-button>                
	         			</c:if>
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
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
		       		<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;home > <spring:message code='cop.cmmnty'/> > 
	  				<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${brdMstrVO.bbsNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${brdMstrVO.bbsNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${brdMstrVO.bbsNmCn}"/></c:when>
	  				</c:choose> 		       		
		       		 > <strong><spring:message code='button.inquire'/></strong></li>
		       	</ul>
		  	</div>

	        <!-- 검색 필드 박스 시작 -->
	        <form name="frm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>">
	        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />    
            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
            <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
            <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
            <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
            <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
            <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
            <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
            <input type="submit" id="invisible" class="invisible"/>
	
			<div class="inputtb" >
          		<table width="980" border="0" cellpadding="0" cellspacing="0" summary="글제목, 글내용 등을 가지고 있는 게시글 상세조회(수정) 테이블이다.">
                	<tr>
	              		<td colspan="6" bgcolor="#0257a6" height="2"></td>
	            	</tr>
	            	<c:if test="${result.bbsId == 'BBSMSTR_000000000011'}">
						<!-- Admin, 담당자, 관리자,  -->
			        	<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
							<!-- 고객자료실// -->
		            		<tr>
			                    <th width="15%" height="23" class="tdblue" nowrap ><spring:message code='sr.client'/></th>
			                    <td width="85%" colspan="5" class="tdleft" nowrap="nowrap"><c:out value="${result.pstinstNm}" /></td>
			                </tr>
			                <tr>
						    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
						   	</tr>
			        	</c:if>	
			        	<input type="hidden" name="pstinstCode" value="<c:out value='${result.pstinstCode}'/>" >
	            	</c:if>
	            	
	            	<tr> 
	                    <th width="15%" height="23" class="tdblue" nowrap ><spring:message code='cop.nttSj'/></th>
	                    <td width="85%" colspan="5" class="tdleft" nowrap="nowrap"><c:out value="${result.nttSj}" /></td>
	              	</tr>
	              	<tr>
				    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
	              	<tr> 
	                   	<th width="15%" height="23" class="tdblue" nowrap ><spring:message code='cop.ntcrNm'/></th>
	                    <td width="15%" class="tdleft" nowrap="nowrap">
	                    <c:choose>
	                        <c:out value="${result.frstRegisterNm}" />
	                        <c:when test="${anonymous == 'true'}">
	                            ******
	                        </c:when>
	                        <c:when test="${result.ntcrNm == ''}">
	                            <c:out value="${result.frstRegisterNm}" />
	                        </c:when>
	                        <c:otherwise>
	                            <c:out value="${result.ntcrNm}" />
	                        </c:otherwise>
	                    </c:choose>
	                    </td>
	                    <th width="15%" height="23" class="tdblue" nowrap ><spring:message code='cop.dateCreated'/></th>
	                    <td width="15%" class="tdleft" nowrap="nowrap"><c:out value="${result.frstRegisterPnttm}" />
	                    </td>
	                    <th width="15%" height="23" class="tdblue" nowrap ><spring:message code='cop.hits'/></th>
	                    <td width="15%" class="tdleft" nowrap="nowrap"><c:out value="${result.inqireCo}" />
	                    </td>
	               	</tr>
	               	<tr>
				    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
	               	<tr> 
	                    <th height="23" class="tdblue"><spring:message code='cop.nttCn'/></th>
	                    <td colspan="5" class="tdleft">
	                     	<div id="bbs_cn">
	                       		<textarea id="nttCn" name="nttCn"  cols="75" rows="20"  style="width:99%" readonly="readonly" title="글내용"/>
		                       		<c:out value="${result.nttCn}" escapeXml="true" />
	                       		</textarea>
	                     	</div>
	                    </td>
	             	</tr>
	             	<tr>
				    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
	              	<c:if test="${not empty result.atchFileId}">
	                	<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
	                   	<tr> 
	                        <th height="23" class="tdblue"><spring:message code='cop.attachedImages'/></th>
	                        <td colspan="5" class="tdleft">
	                        	<c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
	                            	<c:param name="atchFileId" value="${result.atchFileId}" />
	                          	</c:import>
	                        </td>
	                  	</tr>
	                  	<tr>
					    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
					   	</tr>
	                	</c:if>
	                   	<tr> 
	                        <th height="23" class="tdblue"><spring:message code='cop.atchFileList'/></th>
	                        <td colspan="5" class="tdleft">
	                            <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
	                                <c:param name="param_atchFileId" value="${result.atchFileId}" />
	                            </c:import>
	                        </td>
	                  	</tr>
	                  	<tr>
					    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
					   	</tr>
	                  	</c:if>
	                  	<c:if test="${anonymous == 'true'}">
	                  	<tr> 
	                    	<th height="23" class="tdblue"><label for="password"><spring:message code="cop.password" /></label></th>
	                    	<td colspan="5" class="tdleft">
	                        	<input name="password" title="암호" type="password" size="20" value="" maxlength="20" >
	                    	</td>
	                  	</tr>
	                  	<tr>
					    	<td colspan="6" bgcolor="#dcdcdc" height="1"></td>
					   	</tr>
	                  	</c:if>   
	                </table>
	            </div>
	
				<!-- 버튼 시작(상세지정 style로 div에 지정) -->
	         	<div class="list4">
	         		<!-- Admin, 담당자, 관리자,  -->
		        	<c:if test="${result.frstRegisterId == sessionUniqId || authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
	         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_moveUpdt_notice(); return false;"><spring:message code='button.update'/>  ▶</a></span>&nbsp;
	         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_delete_notice(); return false;"><spring:message code='button.delete'/>  ▶</a></span>&nbsp;
		        	</c:if>
	         		<c:if test="${result.replyPosblAt == 'Y'}">
	         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_addReply(); return false;"><spring:message code='button.comment'/><spring:message code='button.create'/>  ▶</a></span>&nbsp;
	         		</c:if>
	         		<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_select_noticeList('1'); return false;"><spring:message code='button.list'/>  ▶</a></span>&nbsp;
		       	</div>
	         	<!-- 버튼 끝 -->
	        </form>
	
	    </div>  
        <!-- //contents 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
<!-- <script type="text/javascript">
	alert(document.getElementById("nttCn").value);

</script> -->
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
			bUseToolbar : false,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//읽기전용(ReadOnly 모드로 변환)
			var iframe = document.getElementsByTagName('iframe')[0]; 
		    var doc = iframe.contentWindow.document; 
		    var iframe2 = doc.getElementsByTagName('iframe')[0]; 
		    var doc2 = iframe2.contentWindow.document; 
		    doc2.body.contentEditable= 'false';
		},
		fCreator: "createSEditor2"
	});
	
</script> --%>
<!-- //Smart Editor Script -->
 
</body>
</html>

