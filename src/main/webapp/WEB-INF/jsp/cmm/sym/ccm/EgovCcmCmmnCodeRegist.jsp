<%--
  Class Name : EgovCcmCmmnCodeRegist.jsp
  Description : EgovCcmCmmnCodeRegist 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<%-- <c:set var="date" value="<%= new Date()%>" /> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>

<title>공통코드 관리</title>

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
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_CmmnCode(){
    //location.href = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>";
    document.boardVO.action = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>";
    document.boardVO.submit();
    document.boardVO.action = "";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
 function fn_egov_regist_CmmnCode(form){
	 $("#codeIdDc").text(editor.getData());
		if(validateSrVO(document.searchVO)){
			if(confirm("<spring:message code="common.save.msg" />")){
				
	        	document.searchVO.submit();
	        	document.searchVO.action = "";
			}
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
/**
 * 목록
 */
function fnListPage(){
    document.searchVO.action = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>";
    document.searchVO.submit();
    document.searchVO.action = "";
}
/**
 * 저장
 */
function fnInsert(){
	//$("#codeIdDc").text(editor.getData());
	
	if(validateSrVO(document.searchVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			
			var codeId = "${result.codeId}";
			
			if(codeId){
				document.searchVO.action = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeModify.do'/>"
			}
	
        	document.searchVO.submit();
        	document.searchVO.action = "";
		}
    }
}
function validateSrVO(form){
	var checkOption = {
		codeId : { valid : "required,maxlength" , label : "코드ID", max : 6} 
		, codeIdNm : { valid : "required" , label : "코드명"}
		, codeIdDc : { valid : "required" , label : "코드ID설명"}
		, useAt : { valid : "required" , label : "사용여부"}
	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}

/**
 * 임시저장
 */
function fnTempInsert(){
	$("#codeIdDc").text(editor.getData());
	if(validateSrVO(document.boardVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			document.boardVO.tempSaveAt.value="Y";
			document.boardVO.submit();		
			document.boardVO.action = "<c:url value='/cop/bbs/insertBoardArticle.do'/>";
		}
    }
}

function fnDelete(){
    if (confirm("<spring:message code="common.delete.msg"/>")) {
    	document.searchVO.action           = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeRemove.do'/>";
        document.searchVO.submit();
    }
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
	            <form action="${pageContext.request.contextPath}/sym/ccm/cca/EgovCcmCmmnCodeRegist.do" name="searchVO" id = "searchVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                	<input type="hidden" name="clCode" value="LET"/>
            		<input type="hidden" name="cmd" value="Modify"/>
		            
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
	                                    <sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="코드ID"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-input id="codeId" name="codeId" uitype="text" value="<c:out value = "${result.codeId}"/>" maxLength = "6" <c:if test = "${not empty result.codeId}">readonly</c:if>></sbux-input>
	                                </td>                            
	                            </tr>
	                             <tr>
	                                <th>
	                                    <sbux-label id="th_text2" name="th_text2" uitype="normal" class = "imp-label" text="코드명"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-input id="codeIdNm" name="codeIdNm" uitype="text" value="<c:out value = "${result.codeIdNm}"/>" style = "width : 100%" maxlength="60"></sbux-input>
	                                </td>                            
	                            </tr>         
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text3" name="th_text3" uitype="normal" text="코드ID설명"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<sbux-textarea name="codeIdDc" id="codeIdDc" cols="100" rows="5"><c:out value = "${result.codeIdDc}"/></sbux-textarea> 
	                                </td>                            
	                            </tr>
								<tr>
	                                <th>
	                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" class = "imp-label" text="사용여부"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-select id="useAt" name="useAt" uitype="single" init="<c:out value = "${result.useAt}"/>"style = "width : auto">
		                                	<option value='Y'>Yes</option>
											<option value='N'>No</option>
		                                </sbux-select>
	                                </td>                            
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
				</form>
				 <div class="btn_buttom">   
                    <sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnInsert();" class="btn-default"></sbux-button> 
                    <c:if test="${not empty result.codeId}"> 
                    	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.delete" />" onclick="fnDelete();" class="btn-default"></sbux-button> 
					</c:if>
					<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
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
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>상세코드관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 공통코드관리 > 공통코드관리 등록</li>
			        </ul>
			    </div>	
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>상세코드관리 등록</strong></h2></div> -->
<!--                 </div> -->

                <form:form commandName="cmmnCode" name="cmmnCode" method="post">
                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                	<input type="hidden" name="clCode" value="LET"/>

                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="분류코드, 코드ID, 코드명, 코드ID설명, 사용여부를 입력하는 공통코드 등록 테이블이다.">
<!-- 						  <tr> -->
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="clCode">분류코드</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
<!-- 						    <td width="80%" nowrap colspan="3"> -->
<!-- 						        <select name="clCode" class="select" id="clCode"> -->
						            <c:forEach var="result" items="${cmmnClCode}" varStatus="status">
						                <option value='<c:out value="${result.clCode}"/>'><c:out value="${result.clCodeNm}"/></option>
						            </c:forEach>                       
<!-- 						        </select> -->
<!-- 						    </td> -->
<!-- 						  </tr>  -->
						  <tr>
				              <td colspan="2" bgcolor="#0257a6" height="2"></td>
				            </tr>
                          <tr> 
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeId">코드ID</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap colspan="3">
						      <form:input  path="codeId" size="10" maxlength="6" id="codeId"/>
						      <form:errors path="codeId"/>
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeIdNm">코드명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="codeIdNm" size="60" maxlength="60" id="codeIdNm"/>
						      <form:errors path="codeIdNm"/>
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th height="23" class="tdblue" scope="row" ><label for="codeIdDc">코드ID설명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>
						      <form:textarea path="codeIdDc" cols="100" rows="5" id="codeIdDc"/>
						      <form:errors   path="codeIdDc"/>
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="useAt">사용여부</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="30%" nowrap class="title_left" colspan="3">
						      <form:select path="useAt" id="useAt">
						          <form:option value="Y" label="Yes"/>
						          <form:option value="N" label="No"/>
						      </form:select>
						    </td>    
						  </tr>  
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				             
                        </table>
                    </div>
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_list_CmmnCode(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_CmmnCode(document.cmmnCode); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 -->  

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         목록/저장버튼  -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_list_CmmnCode(); return false;">목록</a> -->
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_regist_CmmnCode(document.cmmnCode); return false;">저장</a>  -->
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='save'/>"/>
                    <!-- 검색조건 유지 -->
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

