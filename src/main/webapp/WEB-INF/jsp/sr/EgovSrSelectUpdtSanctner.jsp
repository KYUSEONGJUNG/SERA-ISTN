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
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Language" content="ko" >
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
</style>
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
function fnListPage(){
    document.srVO.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.srVO.submit();
}

/**
 * 결재
 */
function fnSanctn(){
	if(confirm("<spring:message code="common.sanctn.msg" />")){
		document.srVO.sanctnerAt.value="Y";
    	/* document.srVO.submit();
    	document.srVO.action = ""; */    	
    	var form = $("#srVO")[0];
    	var formData = new FormData(form);
    	$.ajax({
         		url : "<c:url value='/sr/EgovSrSelectUpdtSanctner.do'/>",
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

/**
 * 반려
 */
function fnReturn(){
	
	
	if(document.srVO.returnResn.value == ''){
		alert("<spring:message code="common.returnResn.msg" />");
	}else{	
		if(confirm("<spring:message code="common.return.msg" />")){
			document.srVO.sanctnerAt.value="N";
			var form = $("#srVO")[0];
	    	var formData = new FormData(form);
	    	$.ajax({
	         		url : "<c:url value='/sr/EgovSrSelectUpdtSanctner.do'/>",
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
/**
 * 첨부파일
 */
function fn_egov_check_file(flag) {
    if (flag=="Y") {
        document.getElementById('file_upload_posbl').style.display = "block";
        document.getElementById('file_upload_imposbl').style.display = "none";          
    } else {
        document.getElementById('file_upload_posbl').style.display = "none";
        document.getElementById('file_upload_imposbl').style.display = "block";
    }
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
		   	    data : $("#srVO").serialize(),
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
	            <form action="${pageContext.request.contextPath}/sr/EgovSrSelectUpdtSanctner.do" name="srVO" id = "srVO" method="post" enctype="multipart/form-data">
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
					<input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>">
					<input type="hidden" name="tempSaveAt" />
					<input type="hidden" id = "atchFileId" name="atchFileId" value = "${srVO.fileId}"/>
					<input type="hidden" id = "fileId" name="fileId" value = "${srVO.fileId}"/>
					<input type="hidden" id = "sanctnerAt" name="sanctnerAt" value = "${srVO.sanctnerAt}"/>
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
	                                	<sbux-label name="subject" uitype="normal" class='leftText' text = "[<c:out value='${srVO.srNo}' />] <c:out value='${srVO.subject}' />"></sbux-label>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='sr.client' />"  ></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id='th_text3' name='th_text3' uitype='normal' class='leftText' text="<c:choose>
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
	                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='sr.requester' />" class="imp-label"></sbux-label>
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
	                            </tr>
	                            <c:if test="${srVO.settleAt == 'Y'}">
									<tr>
										<th><sbux-label id="th_text5" name="th_text5" uitype="normal" text="<spring:message code='sr.sanctnerNm' />"></sbux-label> </th>
										<td colspan="3">											
											<sbux-label id="sanctnerNm" name="sanctnerNm" uitype="normal" text="<c:out value='${srVO.sanctnerNm}' />" class='leftText'></sbux-label>
										</td>
									</tr>
							  	</c:if>                       
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text6" name="th_text6" uitype="normal" text="<spring:message code='cop.offTelNo' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id="tel1" name="tel1" uitype="normal" text="${srVO.tel1}" class='leftText'></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text7" name="th_text7" uitype="normal" text="<spring:message code='cop.mbtlNum' />"></sbux-label>
	                                </th>
	                                <td>
	                                    <sbux-label id="tel2" name="tel2" uitype="normal" text="${srVO.tel2}" class='leftText'></sbux-label>
	                                </td>
	                            </tr>     
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text8" name="th_text8" uitype="normal" text="<spring:message code='cop.emailAdres' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="email" name="email" uitype="normal" text="${srVO.email}" class='leftText'></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text10" name="th_text10" uitype="normal" text="<spring:message code='sr.module' />" class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="moduleCode" name="moduleCode" uitype="normal" 
	                                	text="<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
	                                			<c:if test="${result.code == srVO.moduleCode}">
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
												</c:if>
											</c:forEach>" class='leftText'></sbux-label>
	                                </td>                            
	                            </tr>                            
	                            
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text11" name="th_text11" uitype="normal" text="<spring:message code='sr.processingDivision' /> " class="imp-label"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="category" name="category" uitype="normal" 
	                                	text="<c:forEach var="result" items="${classCode_result}" varStatus="status">
													<c:if test="${result.code == srVO.category}">
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
													</c:if>
											</c:forEach>" class='leftText'></sbux-label>
	                                </td>
	                                <th>
	                                    <sbux-label id="th_text12" name="th_text12" uitype="normal" text="<spring:message code='sr.priority' />"></sbux-label>
	                                </th>
	                                <td class="leftText">
	                                    <sbux-radio id="priority1" name="priority" uitype="normal" text="<spring:message code='sr.normal' /> " value="1002" <c:if test = "${srVO.priority == '1002'}">checked</c:if> readonly></sbux-radio>                                
	                                    <sbux-radio id="priority2" name="priority" uitype="normal" text="<spring:message code='sr.urgent' />" value="1001" <c:if test = "${srVO.priority == '1001'}">checked</c:if> readonly> </sbux-radio>                                  
	                                    <sbux-radio id="priority3" name="priority" uitype="normal" text="<spring:message code='sr.veryUrgent' />" value="1000" <c:if test = "${srVO.priority == '1000'}">checked</c:if> readonly> </sbux-radio>                        
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
	                                    <sbux-label id="th_text13" name="th_text13" uitype="normal" text="<spring:message code='sr.completeHopeDate'/>"></sbux-label>
	                                </th>
	                                <td>
	                                	<sbux-label id="hopeDate" name="hopeDate" uitype="normal" text = "<c:out value='${srVO.hopeDate}'/>"></sbux-label>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text19" name="th_text19" uitype="normal" text="<spring:message code='sr.requestContent' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<textarea name="comment" id="comment" style=" display:none;"></textarea> 			                                	
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
	                            </c:if>
	                            <tr>
	                            	<th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" class = "imp-label" text="<spring:message code='sr.reasonReturn'/>"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<c:if test = "${not empty srVO.returnResn}">
	                                		<sbux-label id="returnResn" name="returnResn" uitype="normal" style = "width : 100%" text = "${srVO.returnResn}" ></sbux-label> 
	                                	</c:if>
	                                	<c:if test = "${empty srVO.returnResn}"> 
	                                		<sbux-input id="returnResn" name="returnResn" uitype="text" style = "width : 100%" value = "" ></sbux-input>
	                                	</c:if>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
				</form>
				 <div class="btn_buttom"> 
					 <c:if test="${srVO.sanctnerAt == '' || srVO.sanctnerAt == NULL}">   
	                    <sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code='sr.approval'/>" onclick="fnSanctn();" class="btn-default"></sbux-button>    
	                    <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code='sr.return'/>" onclick="fnReturn();" class="btn-default"></sbux-button>    
	                    <sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.delete" />" onclick="fnDelete();" class="btn-default"></sbux-button>    
                    </c:if>                    
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
                </div>
                <div style = "width:100%; height:10px; display:block;"></div>  
            </div>
           	<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
			<!-- //footer 끝 -->
	        </div>
	    </div>        
<!-- 전체 레이어 시작 -->
<<%-- div id="wrapper">
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
		        <form:form modelAttribute="srVO" action="${pageContext.request.contextPath}/sr/EgovSrSelectUpdtSanctner.do" name="srVO" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="SR, 업종코드, 업무명, 업체명 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
						  <tr>
				              <td colspan="5" bgcolor="#0257a6" height="2"></td>
				            </tr>
						  <tr> 
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sym.ems.title'/>
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3" class="tdleft">
						    	[<c:out value='${srVO.srNo}'/>] <c:out value='${srVO.subject}'/>
						    	<form:hidden path="subject" />
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.client'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" class="tdleft">
						        <c:out value='${srVO.pstinstNm}'/>
				  				<c:choose>
				  					<c:when test="${srLanguage == 'ko'}"><c:out value='${srVO.pstinstNm}'/></c:when>
				  					<c:otherwise><c:out value='${srVO.pstinstNmEn}'/></c:otherwise>
				  				</c:choose> 
						        <form:hidden path="pstinstCode" />
						        <form:hidden path="pstinstNm" />
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requester'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
				                <c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
					            	<c:if test="${result.code == srVO.customerId}">
						            	<c:out value="${result.codeNm}"/>
					            	</c:if>
					            </c:forEach>	
					            <form:hidden path="customerNm" />
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 

					  	<!-- kpmg 2021.07.14 -->
					  	<!-- 결재자(승인권자) -->
					  	<form:hidden path="settleAt" />
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
				                <form:hidden path="tel1" />
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='cop.mbtlNum'/></th>          
						    <td width="30%" class="tdleft">
				                <c:out value='${srVO.tel2}'/>
				                <form:hidden path="tel2" />
						    </td>    
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap><spring:message code='cop.emailAdres'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.email}'/>
						    	<form:hidden path="email" />
						    </td>  
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.module'/>
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
								 <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
					            	<c:if test="${result.code == srVO.moduleCode}">
					            		<c:out value="${result.codeNm}"/>
							  				<c:choose>
							  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.codeNm}"/></c:when>
							  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.codeNmEn}"/></c:when>
							  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.codeNmCn}"/></c:when>
							  					<c:otherwise><c:out value="${result.codeNm}"/></c:otherwise>
							  				</c:choose>  
					            	</c:if>
					            </c:forEach>	
					            <form:hidden path="moduleCode" />
						    </td>    
						  </tr>  
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.processingDivision'/>
						    	<!-- kpmg 2021.07.14 -->
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%" class="tdleft">
								 <c:forEach var="result" items="${classCode_result}" varStatus="status">
					            	<c:if test="${result.code == srVO.category}"><c:out value="${result.codeNm}"/></c:if>
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
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requestDate'/></th>
						    <td width="30%" class="tdleft">
						    	<c:out value='${srVO.signDate}'/>
						    	<fmt:formatDate value="${date}" type="date" pattern="yyyy-MM-dd"/>
						    	<input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>">
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.completeHopeDate'/></th>          
						    <td width="30%" class="tdleft">
                                <c:out value='${srVO.hopeDate}'/>
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >검색키워드</th>
						    <td width="80%" colspan="3" class="tdleft">
				                <c:out value='${srVO.tcode}'/>
						    </td>    
						  </tr>	
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.requestContent'/>
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3" class="tdleft">
						    	<c:out value="${srVO.comment}" escapeXml="false" />
<!-- 				                <textarea id="comment" name="comment"  cols="75" rows="15"  style="width:99%" readonly="readonly" title="글내용"> -->
                               		<c:out value="${srVO.comment}" escapeXml="true" />
<!--                                 </textarea> -->
						    </td>    
						  </tr>	
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
                           
                           <c:if test="${not empty srVO.fileId}">
                              <tr> 
                                <th height="23" class="tdblue" scope="row" nowrap><spring:message code="cop.atchFileList" /></th>
                                <td colspan="3" class="tdleft">
                                    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
                                        <c:param name="param_atchFileId" value="${srVO.fileId}" />
                                    </c:import>
                                </td>
                              </tr>
                              
                              <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
							  <tr> 
						  
                          </c:if>
                           
                           <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><spring:message code='sr.reasonReturn'/>
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3"class="tdleft">
						    	<form:input path="returnResn" id="returnResn" cssClass="txaIpt" size="100"  maxlength="255" />
				                <form:errors path="returnResn" cssClass="error" />
						    </td>    
						  </tr>	
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				            </tr>
						  <tr> 
						  
                        </table>
                    </div>
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<c:if test="${srVO.sanctnerAt == '' || srVO.sanctnerAt == NULL}">
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnSanctn(); return false;"><spring:message code='sr.approval'/> ▶</a></span>&nbsp;
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnReturn(); return false;"><spring:message code='sr.return'/> ▶</a></span>&nbsp;      
	                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnDelete(); return false;"><spring:message code="button.delete" /> ▶</a></span>&nbsp;              	
                    	</c:if>
                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnListPage(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 --> 

 			        <!-- 상세정보 SR 삭제시 prameter 전달용 input -->
<!-- 			        <input name="checkedIdForDel" type="hidden" /> -->
			        <!-- 검색조건 유지 -->
			        
		        	<form:hidden path="srNo" id="srNo" />
		        	<input type="hidden" name="sanctnerAt" />
		        	
		        	<input type="hidden" name="returnUrl" value="<c:url value='/sr/EgovSrSelectUpdtView.do'/>"/>		        	
		        	<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
			        
			        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        
			        <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>"/>
			        <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>"/>
			        <c:forEach var="vList3" items="${searchVO.searchStatus}" varStatus="vStatus3">
	           			<input type="hidden" name="searchStatus" value="<c:out value='${vList3}'/>" >
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
					<input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>"/>
					<input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>"/>
					<input type="hidden" name="searchSubject" value="<c:out value='${searchVO.searchSubject}'/>"/>
                </form:form>
                
            </div>  
            <!-- //content 끝 -->    
    <!-- //container 끝 -->
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div> --%>
<!-- //전체 레이어 끝 -->

</body>
</html>