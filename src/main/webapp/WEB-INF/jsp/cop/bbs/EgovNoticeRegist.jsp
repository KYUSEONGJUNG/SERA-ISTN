<%--
  Class Name : EgovNoticeRegist.jsp
  Description : 게시물  생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.24   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.24
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css"> --%>

<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css"> --%>
<title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.create' /></title>
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
	document.boardVO.action = "<c:url value='/cop/bbs/selectBoardList.do'/>";
    document.boardVO.submit();
}
/**
 * 저장
 */
function fnInsert(){
	$("#nttCn").text(editor.getData());
	if(validateSrVO(document.boardVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			
			var form = $("#boardVO")[0];
			var formData = new FormData(form);
			formData.delete("files");		
			var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
			for(var i in uploadFiles){
				formData.append("files",uploadFiles[i]);
			}
			$.ajax({
	      		url : "<c:url value='/cop/bbs/insertBoardArticle.do'/>",
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
        	//document.boardVO.submit();
        	//document.boardVO.action = "";
		}
    }
}
/**
 * 임시저장
 */
function fnTempInsert(){
	$("#nttCn").text(editor.getData());
	if(validateSrVO(document.boardVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			document.boardVO.tempSaveAt.value="Y";
			var form = $("#boardVO")[0];
			var formData = new FormData(form);
			formData.delete("files");		
			var uploadFiles = SBUxMethod.getFileUpdateData('fileUpload');
			for(var i in uploadFiles){
				formData.append("files",uploadFiles[i]);
			}
			$.ajax({
	      		url : "<c:url value='/cop/bbs/insertBoardArticle.do'/>",
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
			//document.boardVO.submit();		
			//document.boardVO.action = "<c:url value='/cop/bbs/insertBoardArticle.do'/>";
		}
    }
}

function validateSrVO(form){	
	var checkOption = {
		subject : { valid : "required,maxlength" 
					, label : "<spring:message code='sym.ems.title'/>" 
					, max : 100 }
		
		, comment : { valid : "required" , label : "<spring:message code='sr.requestContent' />"}
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
		})
		.catch( error => {
		    console.error( error );
		} );
		
		
		
	});
</script>




<!-- <script type="text/javascript">
    function fn_egov_validateForm(obj) {
        return true;
    }
    
    function fn_egov_regist_notice() {
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
        <c:if test="${bdMstr.bbsAttrbCode == 'BBSA02'}">
        if(document.getElementById("egovComFileUploader").value==""){
            alert("Images <spring:message code='cop.atchFile'/> <spring:message code='errors.required'/>");
            return false;
        }
        </c:if>
        
        if (confirm('<spring:message code="common.regist.msg" />')) {
            //document.board.onsubmit();
            document.board.action = "<c:url value='/cop/bbs${prefix}/insertBoardArticle.do'/>";
            document.board.submit();
        }
    }
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>"+ "?bbsId=" +"<c:out value='${bdMstr.bbsId}'/>";
        document.board.submit();
    }
    
</script> -->
		
<%-- <style type="text/css">
.noStyle {background:ButtonFace; BORDER-TOP:0px; BORDER-bottom:0px; BORDER-left:0px; BORDER-right:0px;}
  .noStyle th{background:ButtonFace; padding-left:0px;padding-right:0px}
  .noStyle td{background:ButtonFace; padding-left:0px;padding-right:0px}
</style>
<title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.create'/></title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style> --%>


</head>

<!-- body onload="javascript:editor_generate('nttCn');"-->
<!-- <body onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.board.nttSj.focus();"> -->
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<!-- 전체 레이어 시작 -->
	<div class="sr-contents-wrap">
        <c:import url="/sym/mms/EgovMainMenuLeft.do" />
        <%-- <c:import url="/EgovPageLink.do?link=main/inc/incLeftmenu" /> --%>
        <div class="sr-contents-area">
	        <div class="sr-contents">
	            <div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
	            <form action="${pageContext.request.contextPath}/cop/bbs/insertBoardArticle.do" name="boardVO" id = "boardVO" method="post" enctype="multipart/form-data">
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
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		            <input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
		            <input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
		            <input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
		            <input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
		            <input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
		            <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
		            <input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
		            <input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
		            
		            <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
            		<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
            		
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
	                                	<sbux-input id="nttSj" name="nttSj" uitype="text" value="" style = "width : 100%"></sbux-input>
	                                </td>                            
	                            </tr>
	                                      
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text19" name="th_text19" uitype="normal" text="<spring:message code='sr.requestContent' />"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<textarea name="nttCn" id="nttCn" style=" display:none;"></textarea> 			                                	
	                                	<div id="editor" ></div>
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text20" name="th_text20" uitype="normal" text="<spring:message code="cop.atchFile" />" ></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText"> 
	                                    <sbux-fileupload id="fileUpload" name="fileUpload" uitype="multipleExt" style = "width: 100% "  
	                                    	vertical-scroll-height="100px"
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
                     <sbux-button id="button2" name="button1" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnInsert();" class="btn-default"></sbux-button> 
					<sbux-button id="button4" name="button2" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
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
		       	 > <strong><spring:message code='button.create'/></strong></li>
		       </ul>
		  	</div>

            <!-- 검색 필드 박스 시작 -->
            <form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            <input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
            <input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
            <input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
            <input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
            <input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
            <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
            <input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
            <input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
            
            <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
            <input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
            
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
			                    <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
			                    </th>
			                    <td width="80%" nowrap class="tdleft" colspan="3">
			                      <select name="pstinstCode" id="pstinstCode" class="select" title="고객사">
					 				<option value='' >==<spring:message code='sr.choose'/>==</option>
								    <c:forEach var="result" items="${pstinstList}" varStatus="status">
										<option value='<c:out value="${result.pstinstCode}"/>'  <c:if test="${result.pstinstCode == board.pstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}"/></option>
									</c:forEach>
								 </select>
			                    </td>
			                </tr>
			                <tr>
						    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						   	</tr>
			        	</c:if>	      	
	            	</c:if>
	                <tr>
	                    <th width="20%" height="23" class="tdblue" nowrap="nowrap"><label for="nttSj"><spring:message code="cop.nttSj" /></label>
	                        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
	                    </th>
	                    <td width="80%" nowrap class="tdleft" colspan="3">
	                      <input id="nttSj" name="nttSj" type="text" size="60" value=""  maxlength="60" > 
	                      <br/><form:errors path="nttSj" />
	                    </td>
	                </tr>
	                <tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
	                <tr> 
	                    <th height="23" class="tdblue"><label for="nttCn"><spring:message code='cop.nttCn'/></label>
	                        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
	                    </th>
	                    <td colspan="3" class="tdleft">
	                    	<textarea name="nttCn" id="nttCn" cols="75" rows="20"  style="width:99%;"></textarea>
	                   	
	                      <textarea id="nttCn" name="nttCn" class="textarea" cols="75" rows="20" style="width:99%;"></textarea> 
	                      <form:errors path="nttCn" />
	                   
	                    </td>
	                </tr>
	                <tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
	                <c:choose>
	                	<c:when test="${bdMstr.bbsAttrbCode == 'BBSA01'}">
	                    	<tr> 
	                        	<th height="23" class="tdblue"><label for="ntceBgndeView"><spring:message code="cop.noticeTerm" /></label><label for="ntceEnddeView" class="invisible"><spring:message code="cop.noticeTerm" /></label>
	                        		<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required" />
	                        	</th>
	                        	<td colspan="3" class="tdleft">
	                          		<input name="ntceBgnde" type="hidden" >
	                          		<input name="ntceBgndeView" title="게시시작일" type="text" size="10" value=""  readonly="readonly"
	                            		onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
	                          			<img src="<c:url value='/images/sr/icon_calendar.gif' />"
			                            onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
	                            		width="15" height="15" alt="calendar">
	                          		~
	                          		<input name="ntceEndde" type="hidden"  />
	                          		<input name="ntceEnddeView" title="게시종료일" type="text" size="10" value=""  readonly="readonly"
	                            		onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"  >
	                          			<img src="<c:url value='/images/sr/icon_calendar.gif' />"
	                            		onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
	                            		width="15" height="15" alt="calendar">
	                            	<br/><form:errors path="ntceBgnde" />
	                            	<br/><form:errors path="ntceEndde" />
	                            
	                        	</td>
	                      	</tr>
	                      	<tr>
						    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						   	</tr>   
	                 	</c:when>
	                    <c:otherwise>
	                    
	                    </c:otherwise>
	                </c:choose>
	            
	                <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">          
	                  	<tr>
	                    	<th height="23" class="tdblue"><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
	                    	<td colspan="3" class="tdleft">
	                          	<input name="file_1" id="egovComFileUploader" type="file" />
	                            	<div id="egovComFileList"></div>
	                    	</td>
	                  	</tr>
	                  	<tr>
					    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					   	</tr>
	              	</c:if>
	            </table>
                        
                <!-- 멀티파일 업로드를 위한 스크립트처리 -->
                <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
                <script type="text/javascript">
                	// 초기값은 LETTNBBSMASTER Table의 [ATCH_POSBL_FILE_NUMBER] 의 값으로 셋팅된다.
                	// 해당 필의에 정의된 수만큼 파일 업로드가 가능하다. 값이 없을시에는 스크립트에 정의된 값으로 적용.
                    var maxFileNum = document.board.posblAtchFileNumber.value;
                    if(maxFileNum==null || maxFileNum==""){
                        maxFileNum = 5;
                    } 
                    var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
                    multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );         
                </script>
                </c:if>
                <!-- //멀티파일 업로드를 위한 스크립트처리 -->
          	</div>

            <!-- 버튼 시작(상세지정 style로 div에 지정) -->
         	<div class="list4">
         		<c:if test="${bdMstr.authFlag == 'Y'}">
         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_regist_notice(); return fasle;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
         		</c:if>
         		<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_select_noticeList(); return fasle;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
	       	</div>
         	<!-- 버튼 끝 -->  
            </form:form>
        </div>  
        <!-- //contents 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 --> --%>



<!-- Smart Editor Script -->
<%-- <script type="text/javascript">
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
</script> --%>
<!-- //Smart Editor Script -->

</body>
</html>

