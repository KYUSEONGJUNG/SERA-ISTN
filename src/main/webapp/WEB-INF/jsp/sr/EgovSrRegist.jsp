<%--
  Class Name : EgovUserInsert.jsp
  Description : SR등록View JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
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
<c:set var="date" value="<%= new Date()%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
-->

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<meta http-equiv="Content-Language" content="ko">
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css"> --%>
<title><spring:message code='sr.register' /></title>
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

<!-- //Smart Editor Script -->
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
/**
 * 목록
 */
function fnListPage(){
    document.srVO.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.srVO.submit();
    document.srVO.action = "";
}
/**
 * 저장
 */
function fnInsert(){	
	$("#comment").text(setEditText(editor));
	if(validateSrVO(document.srVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			var form = $("#srVO")[0];
			var formData = new FormData(form);
			formData.delete("files");		
			var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
			for(var i in uploadFiles){
				formData.append("files",uploadFiles[i]);
			}
			$.ajax({
	      		url : "<c:url value='/sr/EgovSrRegist.do'/>",
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
}
/**
 * 임시저장
 */
function fnTempInsert(){
      
	$("#comment").text(setEditText(editor));
	if(validateSrVO(document.srVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			document.srVO.tempSaveAt.value="Y";
			var form = $("#srVO")[0];
			var formData = new FormData(form);
			formData.delete("files");		
			var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
			for(var i in uploadFiles){
				formData.append("files",uploadFiles[i]);
			}
			$.ajax({
	      		url : "<c:url value='/sr/EgovSrRegist.do'/>",
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
}

function validateSrVO(form){	
	var checkOption = {
		subject : { valid : "required,maxlength" 
					, label : "<spring:message code='sym.ems.title'/>" 
					, max : 100 }
		, pstinstCode : { valid : "required" , label : "<spring:message code='sr.client'/>"}
		, customerId : { valid : "required" , label : "<spring:message code='sr.requester'/>"}
		, email : { valid : "required,maxlength" , label : "<spring:message code='cop.emailAdres'/>", max : 100}
		, moduleCode : { valid : "required" , label : "<spring:message code='sr.module'/>"}
		, category : { valid : "required" , label : "<spring:message code='sr.processingDivision'/>"}
		, comment : { valid : "required" , label : "<spring:message code='sr.requestContent' />"}
		, hopeDate : { valid : "required" , label : "<spring:message code='sr.completeHopeDate'/>"} 
	}
	
	var hopeDate = SBUxMethod.get('hopeDate');
	var requestDate = '${srVO.signDate}'.replaceAll("-","");
	
	if(hopeDate && hopeDate < requestDate ){
		alert("<spring:message code='sr.error.msg.completionHopeDate'/>");
		return false;
	}
	
	
	if(!emailValidation(form.email.value)){
		var alertMsg = "<spring:message code='errors.email' arguments='###1'/>";
		alertMsg = alertMsg.replace('###1', form.email.value);
    	alert(alertMsg);
    	return;
    }
	
	if(validateCheck(form, checkOption)){
		return true;
	}
	
	return false;
}

// function fnSendMail(){
// 	if(confirm("<spring:message code="common.sendMail.msg" />")){
// 		oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
//     	document.srVO.action           = "<c:url value='/sr/sendMail.do'/>";
// 	    document.srVO.submit();
//     }
// }
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
var hopeDate = "<c:out value='${srVO.hopeDateView}'/>";
//날짜 체크..
function fnDateChk(sDate, hDate){
	//요청일보다 완료희망일이 과거일 경우...
	if(fn_replaceAll(sDate.value, "-", "") > fn_replaceAll(hDate.value, "-", "")){
		alert("<spring:message code='sr.error.msg.completionHopeDate'/>");
		document.getElementById('hopeDate').value = hopeDate;
		document.getElementById('hopeDateView').value = hopeDate;	
	}else{
		hopeDate = hDate.value;
	}
}

function fn_replaceAll(str,out,add) {
	 return str.split(out).join(add);
}

</script>

<script>
	var editor;
	//자바스크립트 Start
	$(document).ready(function(){
		
		var editorLanguage = "${srLanguage}";
		
		if(editorLanguage != "ko"){
			editorLanguage = "en";
		}
		
		ClassicEditor
		.create( document.querySelector( '#editor' ), {
		    language: editorLanguage //언어설정
		}).then(newEditor => {
			editor = newEditor;
			editorSetting(editor);
			
			//editor.enableReadOnlyMode("readOnlyMode");
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
	            <form action="${pageContext.request.contextPath}/sr/EgovSrRegist.do" name="srVO" id = "srVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" /> 
					<input type="hidden" name="srNo"/>
					<input type="hidden" name="pstinstCode" value="<c:out value='${srVO.pstinstCode}'/>"  />
					<input type="hidden" name="pstinstNm" value="<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value='${srVO.pstinstNm}' />
												</c:when>
												<c:otherwise>
													<c:out value='${srVO.pstinstNmEn}' />
												</c:otherwise>
											</c:choose>"  />
					<input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>">
					<input type="hidden" name="tempSaveAt" />
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
	                                	<sbux-input id="subject" name="subject" uitype="text" value="" style = "width : 100%" maxlength = '100'></sbux-input>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='sr.client' />"  ></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text16' name='th_text16' uitype='normal' class='leftText' text="<c:choose>
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
	                                    <sbux-select id="customerId" name="customerId" uitype="single">
	                                    	<c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
											<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == srVO.customerId}">selected</c:if>>
												<c:out value="${result.codeNm}" />
											</option>
										</c:forEach>
	                                    </sbux-select>
	                                </td>
	                            </tr>                       
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='cop.offTelNo' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-input id="tel1" name="tel1" uitype="text" value="${srVO.tel1}" style = "width : 100%" maxlength = '30'></sbux-input>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text5" name="th_text5" uitype="normal" text="<spring:message code='cop.mbtlNum' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-input id="tel2" name="tel2" uitype="text" value="${srVO.tel2}" style = "width : 100%" maxlength = '30'></sbux-input>
	                                </td>
	                            </tr>     
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text6" name="th_text6" uitype="normal" text="<spring:message code='cop.emailAdres' />" class="imp-label" maxlength = '100'></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-input id="email" name="email" uitype="text" value="${srVO.email}" style = "width : 100%"></sbux-input>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text10" name="th_text10" uitype="normal" text="<spring:message code='sr.module' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="moduleCode" name="moduleCode" uitype="single" init="<spring:message code='sr.choose' />">
	                                    	<option value=''><spring:message code='sr.choose' /></option>
											<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>'>
													<c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${result.codeNm}" /> <c:if test = "${not empty result.userNm}"> - <c:out value="${result.userNm}" /></c:if>
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${result.codeNmEn}" /> <c:if test = "${not empty result.userNmEn}"> - <c:out value="${result.userNmEn}" /></c:if>
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${result.codeNmCn}" /> <c:if test = "${not empty result.userNmEn}"> - <c:out value="${result.userNmEn}" /></c:if>
														</c:when>
														<c:otherwise>
															<c:out value="${result.codeNm}" /> <c:if test = "${not empty result.userNm}"> - <c:out value="${result.userNm}" /></c:if>
														</c:otherwise>
													</c:choose>
												</option>
											</c:forEach>
	                                    </sbux-select>
	                                </td>                            
	                            </tr>                            
	                            
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text11" name="th_text11" uitype="normal" text="<spring:message code='sr.processingDivision' /> " class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-select id="category" name="category" uitype="single" init="<spring:message code='sr.choose' />">
	                                    <option value=''><spring:message code='sr.choose' /></option>
									<c:forEach var="result" items="${classCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'>
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
	                                    <sbux-label id="th_text12" name="th_text12" uitype="normal" text="<spring:message code='sr.priority' />"></sbux-label>
	                                </th>
	                                <td class="leftText">
	                                    <sbux-radio id="priority1" name="priority" uitype="normal" text="<spring:message code='sr.normal' /> " value="1002" checked></sbux-radio>                                
	                                    <sbux-radio id="priority2" name="priority" uitype="normal" text="<spring:message code='sr.urgent' />" value="1001"> </sbux-radio>                                
	                                    <sbux-radio id="priority3" name="priority" uitype="normal" text="<spring:message code='sr.veryUrgent' />" value="1000"> </sbux-radio>                        
	                                </td>
	                            </tr>
	                            <tr>	                            
	                                <th>
	                                    <sbux-label id="th_text14" name="th_text14" uitype="normal" text="<spring:message code='sr.requestDate' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text15' name='th_text15' uitype='normal' class='leftText' text="<c:out value='${srVO.signDate}'/>"></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text13" name="th_text13" uitype="normal" text="<spring:message code='sr.completeHopeDate'/>" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-datepicker id="hopeDate" name="hopeDate" uitype="popup" style="width: 100px;" open-on-input-selection="true" init = "<c:out value='${srVO.hopeDate}'/>"></sbux-datepicker>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text19" name="th_text19" uitype="normal" text="<spring:message code='sr.requestContent' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<textarea name="comment" id="comment" style=" display:none;"></textarea> 			                                	
	                                	<div id="editor" >${sign}</div>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText"> 
	                                    <sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
	                                    	vertical-scroll-height="150px"
	                                    	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
	                                    	header-title="<spring:message code="cop.atchFile" />"
	                                    	drop-zone="true"
	                                    	button-add-title="<spring:message code="sr.ctsAdd" />"
	                                    	button-delete-title="<spring:message code="sr.ctsDel" />">
										</sbux-fileupload>
	                                </td>                            
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
				</form>
				 <div class="btn_buttom">   
                    <sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.tempSave" />" onclick="fnTempInsert();" class="btn-default"></sbux-button>    
                    <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnInsert();" class="btn-default"></sbux-button> 
                    <sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.reset"/>" onclick="document.srVO.reset();" class="btn-default"></sbux-button> 
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
                </div>
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>
	<%-- <div id="wrapper">
		<!-- header 시작 -->
		<div id="header">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
		</div>
		<c:import url="/sym/mms/EgovMainMenuHead.do" />
		<!-- //header 끝 -->

		<!-- container 시작 -->
		<!-- 현재위치 네비게이션 시작 -->
		<div id="contents">
			<div class="list2">
				<ul>
					<li><img src="<c:url value='/' />images/sr/icon_home.gif" /> &nbsp;<spring:message code='sr.navigation.srRegistration' /></li>
				</ul>
			</div>
			<!-- 검색 필드 박스 시작 -->
			<form:form modelAttribute="srVO" action="${pageContext.request.contextPath}/sr/EgovSrRegist.do" name="srVO" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
				<input type="hidden" name="tempSaveAt" />


				<div class="inputtb">
					<table width="980" border="0" cellpadding="0" cellspacing="0" summary="SR, 업종코드, 업무명, 업체명 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
						<tr>
							<td colspan="4" bgcolor="#0257a6" height="2"></td>
						</tr>
						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sym.ems.title' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="80%" colspan="3" class="tdleft"><form:input path="subject" id="subject" cssClass="txaIpt" size="100" maxlength="100" /> <form:errors path="subject" cssClass="error" /></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.client' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="30%" class="tdleft">
														        <c:out value='${srVO.pstinstNm}'/> <c:choose>
									<c:when test="${srLanguage == 'ko'}">
										<c:out value='${srVO.pstinstNm}' />
									</c:when>
									<c:otherwise>
										<c:out value='${srVO.pstinstNmEn}' />
									</c:otherwise>
								</c:choose> <form:hidden path="pstinstCode" /> <form:hidden path="pstinstNm" />
							</td>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.requester' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="30%" class="tdleft"><select name="customerId" id="customerId" class="select" title="요청자">
									<c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == srVO.customerId}">selected</c:if>>
											<c:out value="${result.codeNm}" />
										</option>
									</c:forEach>
							</select> <form:hidden path="customerNm" /></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='cop.offTelNo' /></th>
							<td width="30%" class="tdleft"><form:input path="tel1" id="tel1" cssClass="txaIpt" size="30" maxlength="30" /> <form:errors path="tel1" cssClass="error" /></td>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='cop.mbtlNum' /></th>
							<td width="30%" class="tdleft"><form:input path="tel2" id="tel2" cssClass="txaIpt" size="30" maxlength="30" /> <form:errors path="tel2" cssClass="error" /></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='cop.emailAdres' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="30%" class="tdleft"><form:input path="email" id="email" title="이메일주소" cssClass="txaIpt" size="50" maxlength="100" />
								<div>
									<form:errors path="email" cssClass="error" />
								</div></td>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.module' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="30%" class="tdleft"><select name="moduleCode" id="moduleCode" class="select" title="모듈코드">
									<option value=''>==
										<spring:message code='sr.choose' />==
									</option>
									<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'>
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
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.processingDivision' /> 
								<!-- kpmg 2021.07.14 -->
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
							</th>
							<td width="30%" class="tdleft"><select name="category" id="category" class="select" title="처리구분">
									<option value=''>==
										<spring:message code='sr.choose' />==
									</option>
									<c:forEach var="result" items="${classCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'>
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
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.priority' /></th>
							<td width="30%" class="tdleft"><input type="radio" name="priority" class="radio2" value="1002" checked="checked">&nbsp;<spring:message code='sr.normal' /> <input type="radio" name="priority" class="radio2" value="1001">&nbsp;&nbsp;<spring:message code='sr.urgent' /> <input type="radio" name="priority" class="radio2" value="1000">&nbsp;&nbsp;<spring:message code='sr.veryUrgent' /></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.requestDate' /></th>
							<td width="30%" class="tdleft"><c:out value='${srVO.signDate}' /> 						    	<fmt:formatDate value="${date}" type="date" pattern="yyyy-MM-dd"/> <input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>"></td>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.completeHopeDate' /></th>
							<td width="30%" class="tdleft">
														    	<form:input path="hopeDate" id="hopeDate" cssClass="txaIpt" size="30"  maxlength="30" /> 				                <form:errors path="hopeDate" cssClass="error" /> <input name="hopeDate" id="hopeDate" type="hidden" value="<c:out value='${srVO.hopeDate}'/>"> <input name="hopeDateView" id="hopeDateView" title="완료희망일" type="text" size="10" value="<c:out value='${srVO.hopeDateView}'/>" readonly="readonly"></input>
							</td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >검색키워드</th>
						    <td width="80%" colspan="3" class="tdleft">
						    	<form:input path="tcode" id="tcode" cssClass="txaIpt" size="100"  maxlength="40" />
				                <form:errors path="tcode" cssClass="error" />
						    </td>    
						  </tr>

						<tr>
							<th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='sr.requestContent' /> <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
							<td width="80%" colspan="3" class="tdleft"><input type="hidden" name="tcode"> <textarea name="comment" id="comment" rows="15" cols="50" style="width: 99%"></textarea> 						    	<form:input path="comment" id="comment" cssClass="txaIpt" size="100"  maxlength="30" /> 				                <form:errors path="comment" cssClass="error" /></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

						<tr>
							<th height="23" class="tdblue" scope="row" nowrap><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
							<td colspan="3" class="tdleft"><input name="file_1" id="egovComFileUploader" type="file" />
								<div id="egovComFileList"></div></td>
						</tr>

						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>

					</table>
				</div>

				<!-- 버튼 시작(상세지정 style로 div에 지정) -->
				<div class="list4">
					<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnTempInsert(); return false;"><spring:message code="button.tempSave" /> ▶</a></span>&nbsp; <span class="btnblue"><a href="#LINK" onclick="JavaScript:fnInsert(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp; <span class="btnblue"><a href="#LINK" onclick="javascript:document.srVO.reset();"><spring:message code="button.reset" /> ▶</a></span>&nbsp; <span class="btnblue"><a href="<c:url value='/sr/EgovSrList.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /> ▶</a></span>
					<!--                     	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnSendMail(); return false;">메일발송 ▶</a></span>&nbsp; -->
				</div>
				<!-- 버튼 끝 -->

				<!-- 검색조건 유지 -->

				<!-- 우편번호검색 -->
				<input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />

				<input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" />
				<input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" />
				<c:forEach var="vList3" items="${searchVO.searchStatus}" varStatus="vStatus3">
					<input type="hidden" name="searchStatus" value="<c:out value='${vList3}'/>">
				</c:forEach>

				<input type="hidden" name="searchConfirmDateF" value="<c:out value='${searchVO.searchConfirmDateF}'/>" />
				<input type="hidden" name="searchConfirmDateT" value="<c:out value='${searchVO.searchConfirmDateT}'/>" />
				<input type="hidden" name="searchConfirmDateFView" value="<c:out value='${searchVO.searchConfirmDateFView}'/>" />
				<input type="hidden" name="searchConfirmDateTView" value="<c:out value='${searchVO.searchConfirmDateTView}'/>" />
				<input type="hidden" name="searchCustomerNm" value="<c:out value='${searchVO.searchCustomerNm}'/>" />
				<input type="hidden" name="searchRname" value="<c:out value='${searchVO.searchRname}'/>" />
				<input type="hidden" name="searchRid" value="<c:out value='${searchVO.searchRid}'/>" />
				<input type="hidden" name="searchCompleteDateF" value="<c:out value='${searchVO.searchCompleteDateF}'/>" />
				<input type="hidden" name="searchCompleteDateT" value="<c:out value='${searchVO.searchCompleteDateT}'/>" />
				<input type="hidden" name="searchCompleteDateFView" value="<c:out value='${searchVO.searchCompleteDateFView}'/>" />
				<input type="hidden" name="searchCompleteDateTView" value="<c:out value='${searchVO.searchCompleteDateTView}'/>" />
				<input type="hidden" name="searchTcode" value="<c:out value='${searchVO.searchTcode}'/>" />
				<input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>" />
				<input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>" />
				<input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>" />
				<input type="hidden" name="searchSubject" value="<c:out value='${searchVO.searchSubject}'/>" />
				<!-- 검색조건 유지 -->

			</form:form>

		</div>
		<!-- //content 끝 -->
		<!-- //container 끝 -->
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div> --%>

	<!-- //전체 레이어 끝 -->
</body>
</html>

<!-- 멀티파일 업로드를 위한 스크립트처리 -->
<!-- <script type="text/javascript">
	// 해당 필의에 정의된 수만큼 파일 업로드가 가능하다. 값이 없을시에는 스크립트에 정의된 값으로 적용.
	var maxFileNum = 10;
	var multi_selector = new MultiSelector(document
			.getElementById('egovComFileList'), maxFileNum);
	multi_selector.addElement(document.getElementById('egovComFileUploader'));
</script> -->
<!-- //멀티파일 업로드를 위한 스크립트처리 -->
