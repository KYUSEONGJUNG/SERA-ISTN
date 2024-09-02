<%--
  Class Name : EgovUserInsert.jsp
  Description : 사용자등록View JSP
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
<!--<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>-->
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Language" content="ko" >
<!--<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >-->

<title>사용자 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnIdCheck(){
    var retVal;
    var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.userManageVO.emplyrId.value;
    var openParam = "dialogWidth:400px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.userManageVO.emplyrId.value = retVal;
        document.userManageVO.id_view.value = retVal;
    }
}
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>"; 
    document.userManageVO.submit();
}
function fnInsert(){
    if(validateUserManageVO(document.userManageVO)){
    	if(document.userManageVO.password.value == ''){
    		alert("<spring:message code="uss.umt.password" /><spring:message code="common.required.msg" />");
            return;
    	}else if(document.userManageVO.password.value != document.userManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.userManageVO.submit();
    }
}
function fnPstinstSearch() {
//     var url = '/uat/uia/EgovGpkiRegist.do';
//     var popupwidth = '500';
//     var popupheight = '400';
//     var title = '인증서';

//     Top = (window.screen.height - popupheight) / 3;
//     Left = (window.screen.width - popupwidth) / 2;
//     if (Top < 0) Top = 0;
//     if (Left < 0) Left = 0;
//     Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
//     PopUpWindow = window.open(url, title, Future)
//     PopUpWindow.focus();
}



-->
$(document).ready(function() {
	changeAuthorCode()
});


function validateuserManageVO(form){	
	var checkOption = {
		emplyrId : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.id'/>" 
			, max : 20 }
		, emplyrNm : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='cop.ncrdNm'/>"
			, max : 60}
		, emplyrNmEn : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='cop.ncrdNmEn'/>"
			, max : 60}
		, password : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.password' />"
			,max : 20}
		, password2 : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.password' />"
			,max : 20}
		, passwordCnsr : 
			{valid : "maxlength"
			, max : 100}
		, offmTelno : 
			{valid : "maxlength"
			, max : 15}
		, moblphonNo : 
			{valid : "maxlength"
			, max : 15}
		, emailAdres : 
			{ valid : "required, maxlength" 
			, label : "<spring:message code='cop.emailAdres' />"
			, max : 50}
		, pstinstCode : { valid : "required" , label : "<spring:message code='sr.client' />"}
		, note : 
			{valid : "maxlength"
			, max : 300}
	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}

function fnIdCheck(){
	$("emplyrId").val();
	$.ajax({				 
		url : "<c:url value='/select/umt/cmm/EgovIdDplctCnfirm.do'/>",
		type : "POST",
		data : $("#listForm").serialize(),
		
		success :function(data) {
			//Rename Setting

			$("#checkResult").val(data.result);
			$("#checkResultId").val(data.id);
			alert(data.message);
		},
		
		error : function(request, status, error){
			alert("error");   	            
		}
	});
	 	
}


function fnTempInsert() {
	fnIdValidation();
	if(validateuserManageVO(document.userManageVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			document.userManageVO.tempSaveAt.value="Y";
			document.userManageVO.submit();		
			document.userManageVO.action = "";
		}
    }
}

function fnInsert() {	
	if(validateuserManageVO(document.userManageVO)){
		
		if($("#checkResult").val() == 'fail' || $("#checkResult").val() == "" || $("#checkResult").val() == null){
			alert("아이디 중복 확인을 진행하세요.");
		} else if ($("#checkResultId").val() != $("#emplyrId").val()) {
			alert("아이디 중복 검사를 다시 진행하세요.");
		}else if(document.userManageVO.password.value != document.userManageVO.password2.value){
	        alert("<spring:message code="fail.user.passwordUpdate2" />");
	    }else if(!emailValidation(document.userManageVO.emailAdres.value)){
	    	alert('유효한 이메일이 아닙니다.');
	    }else {
	    	//document.userManageVO.submit();		
			//document.userManageVO.action = "";
			var form = $("#listForm")[0];
			var formData = new FormData(form);        
	        $.ajax({        	
				url : "<c:url value='/uss/umt/user/EgovUserInsert.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
					alert(data.msg);
					if(data.msgType == 'S') {
						document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>"; 
					    document.userManageVO.submit();
					} else {
						location.reload(true);				
					}
					 	
		   	    },
		   	    error : function(request, status, error){
					alert("error");
					document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>"; 
				    document.userManageVO.submit();
		   	    },
		   	    complete:function(){
		   	    	fn_closeLoading();
		   	    }
			});
		}	
		
	}
	
	
}

function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>"; 
    document.userManageVO.submit();
}

function autoHyphen(target) {
 target.value = target.value
   .replace(/[^0-9]/g, '')
   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}
function changeAuthorCode() {
	if(SBUxMethod.get('authorCode') == 'ROLE_MNGR'){
		$('#emailYn')[0].disabled = false;
	} else {
		$('#emailYn')[0].checked = false;
		$('#emailYn')[0].disabled = true;	
	}
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
    <div class="sr-contents-area">
    <!-- container 시작 -->
            <!-- 현재위치 네비게이션 시작 -->
		<div class="sr-contents">
			<div class="sr-breadcrumb-area">                
				<sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
			</div>
			   
                <!-- 검색 필드 박스 시작 -->
		        <form modelAttribute="userManageVO" id="listForm" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserInsert.do" name="userManageVO" method="post" >
		            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		            <!-- 우편번호검색 -->
		            <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />
		            <input type="password" style="width:0px; height:0px; position : absolute; left : -500px; top : -500px;" />
					
                    <div class="sr-table-wrap">
				         <table class="sr-table">
	                        <colgroup>
	                            <col width="12%">
	                            <col width="38%">
	                            <col width="12%">
	                            <col width="38%">
	                        </colgroup>
				            <tr> 
				                <th>
				                	<sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="아이디"></sbux-label>
				                </th>
				                <td>
				                	<sbux-input id="emplyrId" name="emplyrId" uitype="text" value="${userManageVO.emplyrId}" style = "width : 350px; float:left;"></sbux-input>
			                		<sbux-button id="button5" name="button5" uitype="normal" text="중복아이디 검사" onclick="fnIdCheck();" class="add-delete-btn" style = "float:right;"></sbux-button> 
				                	<input type="hidden" id="checkResult" name="checkResult"/>
				                	<input type="hidden" id="checkResultId" name="checkResultId"/>
				                </td>
				                	
				                <th>
				                	<sbux-label id="th_text2" name="th_text2" uitype="normal" text="이름"  class = "imp-label"></sbux-label>
                                </th>
                                <td>
                                    <sbux-input id="emplyrNm" name="emplyrNm" uitype="text" value="${userManageVO.emplyrNm}" style = "width : 100%"></sbux-input>
                                </td>
				            </tr>
					        
					        <tr> 
				                <th>
                                    <sbux-label id="th_text3" name="th_text3" uitype="normal" text="이름 영문명"  class = "imp-label"></sbux-label>
                                </th>
                                <td style="border-right : 0px;">
                                	<sbux-input id="emplyrNmEn" name="emplyrNmEn" uitype="text" value="${userManageVO.emplyrNmEn}" style = "width : 100%"></sbux-input>
                                </td>
                                <td style="border-right : 0px; border-left : 0px;">
                                </td>
                                <td style="border-left : 0px;">
                                </td>
				            </tr>
				            <tr> 
				                <th>
                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" text="비밀번호"  class = "imp-label"></sbux-label>
                                </th>
				                <td>
				                    <sbux-input id="password" name="password" uitype="password" value="${userManageVO.password}" style = "width : 100%"></sbux-input>
				                </td>
				                <th>
				                	<sbux-label id="th_text5" name="th_text5" uitype="normal" text="비밀번호 확인"  class = "imp-label"></sbux-label>
                                </th>
				                <td>
				                	<sbux-input id="password2" name="password2" uitype="password" value="" style = "width : 100%"></sbux-input>
				                </td>
				            </tr>
				            <tr> 
				                <th>
				                	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="비밀번호 힌트" ></sbux-label>
				                </th>
				                <td>
				                    <sbux-select path="passwordHint" id="passwordHint" name="passwordHint" title="비밀번호힌트">
				                        <option value="" label="선택하세요"/>
				                        <options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm">
				                        	<c:forEach var="result" items="${passwordHint_result}" varStatus="status">
				                        		<option value='<c:out value="${result.code}"/>'  ><c:out value="${result.codeNm}"/></option>
				                        	</c:forEach>
				                        </options>
				                    </sbux-select>
				                </td>
				                <th>
				                	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="비밀번호 정답"></sbux-label>
				                </th>
				                <td>
				                	<sbux-input id="passwordCnsr" name="passwordCnsr" uitype="text" value="${userManageVO.passwordCnsr}" style = "width : 100%"></sbux-input>
				                </td>
				            </tr>
				            <tr>                                 
                                <th>
                                	<sbux-label id="th_text8" name="th_text8" uitype="normal" text="이동전화번호"></sbux-label>
                                </th>
                                <td>
                                	<sbux-input id="moblphonNo" name="moblphonNo" uitype="text" value="${userManageVO.moblphonNo}" style = "width : 100%" oninput="autoHyphen(this)"></sbux-input>
                                </td>
                                <th>
                                	<sbux-label id="th_text9" name="th_text9" uitype="normal" text="사무실전화번호"></sbux-label>
                                </th>
				                <td>
				                	<sbux-input id="offmTelno" name="offmTelno" uitype="text" value="${userManageVO.offmTelno}" style = "width : 100%" oninput="autoHyphen(this)"></sbux-input>
				                </td>
				            </tr>
				            <tr>
                                <th>
                                	<sbux-label id="th_text10" name="th_text10" uitype="normal" text="이메일주소"  class = "imp-label"></sbux-label>
                                </th>
                                <td style="border-right : 0px;">
                                	<sbux-input id="emailAdres" name="emailAdres" uitype="text" value="${userManageVO.emailAdres}" style = "width : 100%"></sbux-input>
                                </td>
                                <th>
				                	<sbux-label id="th_text8-1" name="th_text8-1" uitype="normal" text="알림 사용 여부"></sbux-label>
                                </th>
                                <td>
                                	<sbux-checkbox id="emailYn" name="emailYn" uitype="normal" true-value="Y" false-value="N" style="margin-left : 20px" <c:if test="${userManageVO.emailYn == 'Y'}"> checked </c:if>></sbux-checkbox>
                                </td>
				            </tr>
				            <tr> 				                
				                <th>
				                	<sbux-label id="th_text11" name="th_text11" uitype="normal" text="고객사"  class = "imp-label"></sbux-label>
				                </th>
				                <td>
				                	<sbux-select name="pstinstCode" id="pstinstCode" uitype="single" title="고객사">
						 				<option value='' label="<spring:message code='sr.choose' />"/>
									    <c:forEach var="result" items="${pstinstList}" varStatus="status">
											<option value='<c:out value="${result.pstinstCode}"/>'  ><c:out value="${result.pstinstNm}"/></option>
										</c:forEach>
									 </sbux-select>	
				                </td>
				                <th>
				                	<sbux-label id="th_text12" name="th_text12" uitype="normal" text="권한코드"  class = "imp-label"></sbux-label>
				                </th>
				                <td>
				                	<sbux-select name="authorCode" id="authorCode" title="권한코드" onchange="changeAuthorCode()">
							            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
							            	<c:if test="${authorManage.authorCode != 'ROLE_ANONYMOUS'}">
							                	<option value="<c:out value="${authorManage.authorCode}"/>" ><c:out value="${authorManage.authorNm}"/></option>
							            	</c:if>
							            </c:forEach>
							        </sbux-select>
				                </td>
				            </tr>
				            <tr>
                                <th>
                                	<sbux-label id="th_text13" name="th_text13" uitype="normal" text="로그인언어"></sbux-label>
                                </th>
                                <td style="border-right : 0px;">
				                	<sbux-select id="languageCode" name="languageCode" title="로그인 언어 코드" style = "width : 100%">
				                		<option value="ko">KOREAN</option>
				                		<option value="en">ENGLISH</option>
				                		<option value="cn">CHINESE</option>
							        </sbux-select>
                                </td>
                                <td style="border-right : 0px; border-left : 0px;">
                                </td>
                                <td style="border-left : 0px;">
                                </td>
				            </tr>
				            <tr>
                                <th>
                                	<sbux-label id="th_text14" name="th_text14" uitype="normal" text="비고"></sbux-label>
                                </th>
                                <td colspan="3">
                                    <sbux-input path="note" id="note" name="note" title="비고" uitype="text" value="<c:out value='${userManageVO.note}'/>" style = "width : 100%"/>
                                </td>
				            </tr>

                        </table>
                    </div>
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <!-- 버튼 끝 --> 

			        <!-- 검색조건 유지 -->
			        <input type="hidden" name="sbscrbSttus" value="<c:out value='${searchVO.sbscrbSttus}'/>"/>
			        <!-- 검색조건 유지 -->
			        
                </form>
                <div class="btn_buttom">   
                    <%-- <sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.tempSave" />" onclick="fnTempInsert();" class="btn-default"></sbux-button> --%>    
                    <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnInsert();" class="btn-default"></sbux-button> 
                    <sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.reset"/>" onclick="document.userManageVO.reset(); $('#checkResult').val('');" class="btn-default"></sbux-button> 
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage();" class="btn-default"></sbux-button>                
                </div>

            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
   		<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
    </div>
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

