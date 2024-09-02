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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >-->

<title>사용자 상세 및 수정</title>
<script type="javascript/x-javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();    
}
function fnDeleteUser(checkedIds) {
    if(confirm("<spring:message code="common.delete.msg" />")){
        document.userManageVO.checkedIdForDel.value=checkedIds;
        document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
        document.userManageVO.submit(); 
        document.userManageVO.action = "";
    }
}
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
        document.userManageVO.submit();
        document.userManageVO.action = "";
    }
}
function fn_egov_inqire_cert() {
    var url = '/uat/uia/EgovGpkiRegist.do';
    var popupwidth = '500';
    var popupheight = '400';
    var title = '인증서';

    Top = (window.screen.height - popupheight) / 3;
    Left = (window.screen.width - popupwidth) / 2;
    if (Top < 0) Top = 0;
    if (Left < 0) Left = 0;
    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
    PopUpWindow = window.open(url, title, Future)
    PopUpWindow.focus();
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

function fnUpdate(){
    if(validateuserManageVO(document.userManageVO)){
    	//console.log($('#emplyrNmEn').val());
        //document.userManageVO.submit();
        //document.userManageVO.action = "";
    	if(!emailValidation(document.userManageVO.emailAdres.value)){
	    	alert('유효한 이메일이 아닙니다.');
	    	return;
	    }
    	
        var form = $("#userManageVO")[0];
		var formData = new FormData(form);       
        $.ajax({        	
			url : "<c:url value='/uss/umt/user/EgovUserSelectUpdt.do'/>"			
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

function fnDeleteUser() {
    
	if(confirm("<spring:message code="common.delete.msg" />")){
        document.userManageVO.checkedIdForDel.value=$('#userTy').val()+":"+$('#uniqId').val();
        //document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
        //document.userManageVO.submit(); 
        //document.userManageVO.action = "";
        
        var form = $("#userManageVO")[0];
		var formData = new FormData(form);       
        $.ajax({        	
			url : "<c:url value='/uss/umt/user/EgovUserDelete.do'/>"			
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

function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}

const autoHyphen = (target) => {
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

</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div class="sr-contents-wrap">
    <!-- header 시작 -->
    <c:import url="/sym/mms/EgovMainMenuLeft.do" />
    <!-- //header 끝 -->
    <div class="sr-contents-area">
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
				<div class="sr-breadcrumb-area">                
					<sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
				</div>
			   
                <!-- 검색 필드 박스 시작 -->
		        <form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserSelectUpdt.do" id="userManageVO" name="userManageVO" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
			        <input name="checkedIdForDel" type="hidden" />
			        <!-- 검색조건 유지 -->
			        
			        <input type="hidden" name="searchEmplyrId" value="<c:out value='${searchVO.searchEmplyrId}'/>"/>
			        <input type="hidden" name="searchUserNm" value="<c:out value='${searchVO.searchUserNm}'/>"/>
			        <input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>"/>
			        <input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>"/>
			        <input type="hidden" name="searchDelAt" value="<c:out value='${searchVO.searchDelAt}'/>"/>
			        
			        <input type="hidden" name="sbscrbSttus" value="<c:out value='${searchVO.sbscrbSttus}'/>"/>
			        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        <!-- 우편번호검색 -->
			        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />
			        <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
			        <input type="hidden" id="userTy" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />
			        <!-- 권한코드 등록여부 -->
			        <input type="hidden" name="regYn" value="<c:out value='${userManageVO.regYn}'/>" />
			        <input type="hidden" id=uniqId name="uniqId" value="<c:out value='${userManageVO.uniqId}'/>" />

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
                                    <sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="사용자 아이디"></sbux-label>
                                </th>
				                <td><label for="emplyrId"></label>				                	
				                    <hidden name="emplyrId" id="emplyrId" cssClass="txaIpt" readonly="true"/>
				                    <sbux-input uitype="text" name="emplyrId" id="emplyrId" value="<c:out value="${userManageVO.emplyrId}"/>" readonly style = "width : 100%"></sbux-input>
				                    <hidden name="uniqId" />
				                </td>
				                <th>
				                	<sbux-label id="th_text2" name="th_text2" uitype="normal" text="이름"  class = "imp-label"></sbux-label>
                                </th>
				                <td>
				                    <sbux-input id="emplyrNm" name="emplyrNm" uitype="text"  style = "width : 100%" value="<c:out value='${userManageVO.emplyrNm}' />"/>
			                    </td>
		                    </tr>
		                     <tr> 
				                <th>
                                    <sbux-label id="th_text3" name="th_text3" uitype="normal" text="영문명 이름" class = "imp-label"></sbux-label>
                                </th>
				                <td style="border-right : 0px;">
				                    <sbux-input name="emplyrNmEn" id="emplyrNmEn" cssClass="txaIpt" size="20"  maxlength="60" uitype="text" style = "width : 100%" value="<c:out value="${userManageVO.emplyrNmEn}" />" />
				                </td>
				                <td style="border-right : 0px; border-left : 0px;">
                                </td>
                                <td style="border-left : 0px;">
                                </td>
                            </tr>
                             <tr> 
                                <th>
                                	<sbux-label id="th_text4" name="th_text4" uitype="normal" text="비밀번호 힌트"></sbux-label>
                                </th>
				                <td>
				                    <sbux-select name="passwordHint" id="passwordHint">
				                        <option value="" label="선택하세요"/>
			                        	<c:forEach var="result" items="${passwordHint_result}" varStatus="status">
			                        		<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == userManageVO.passwordHint}">selected</c:if>><c:out value="${result.codeNm}"/></option>
			                        	</c:forEach>
				                    </sbux-select>

				                </td>
                                <th>
                                	<sbux-label id="th_text5" name="th_text5" uitype="normal" text="비밀번호 정답"></sbux-label>
                                </th>
				                <td>
				                    <sbux-input name="passwordCnsr" id="passwordCnsr" uitype="text" style = "width : 100%" value="<c:out value='${userManageVO.passwordCnsr}'/>" />
				                </td>
                            </tr>

                            <tr> 
                            	<th>
                                	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="이동전화번호" ></sbux-label>
                                </th>
				                <td>
				                    <sbux-input name="moblphonNo" id="moblphonNo" cssClass="txaIpt" size="20" maxlength="15" uitype="text" oninput="autoHyphen(this)" style = "width : 100%" value="<c:out value='${userManageVO.moblphonNo}'/>" />
				                    
				                </td>
				                <th>
				                	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="사무실전화번호"></sbux-label>
				                </th>
				                <td><label for="offmTelno"></label>
				                    <sbux-input name="offmTelno" id="offmTelno"uitype="text" style = "width : 100%" oninput="autoHyphen(this)" value="<c:out value='${userManageVO.offmTelno}'/>" />
				                    
				                </td>
                            </tr>

                            <tr>
                                <th>
                                	<sbux-label id="th_text8" name="th_text8" uitype="normal" text="이메일주소"  class = "imp-label"></sbux-label>
                                </th>
				                <td style="border-right : 0px;"><label for="emailAdres"></label>
				                    <sbux-input name="emailAdres" id="emailAdres" uitype="text" style = "width : 100%" value="<c:out value='${userManageVO.emailAdres}'/>" />				                    
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
                                	<sbux-label id="th_text9" name="th_text9" uitype="normal" text="고객사"  class = "imp-label"></sbux-label>
								</th>
				                <td><label for="pstinstCode">
				                	<sbux-input name="pstinstNm" id="pstinstNm" uitype="text" style = "width : 100%" value="<c:out value="${userManageVO.pstinstNm}"/>" readonly>
				                	</sbux-input>
				                	<input type="hidden" name="pstinstCode" value="<c:out value='${userManageVO.pstinstCode}'/>" uitype="text"/>
				                </td>
				                <th>
				                	<sbux-label id="th_text10" name="th_text10" uitype="normal" text="권한코드"  class = "imp-label"></sbux-label>
                                </th>
				                <td>
									<sbux-select id="authorCode" name="authorCode" title="권한코드" onchange="changeAuthorCode()">
							            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
							            	<c:if test="${authorManage.authorCode != 'ROLE_ANONYMOUS'}">
							                	<option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == userManageVO.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
							            	</c:if>
							            </c:forEach>
							        </sbux-select>
				                </td>
                            </tr>
					        
				            <tr>
                                <th>
                                	<sbux-label id="th_text11" name="th_text11" uitype="normal" text="로그인언어" class = "imp-label"></sbux-label>
                                </th>
                                <td style="border-right : 0px;">
				                	<sbux-select name="languageCode" title="로그인 언어 코드">
				                		<option value="ko" <c:if test="${userManageVO.languageCode == 'ko'}">selected</c:if>>KOREAN</option>
				                		<option value="en" <c:if test="${userManageVO.languageCode == 'en'}">selected</c:if>>ENGLISH</option>
				                		<option value="cn" <c:if test="${userManageVO.languageCode == 'cn'}">selected</c:if>>CHINESE</option>
							        </sbux-select>
                                </td>
                                <td style="border-right : 0px; border-left : 0px;">
                                </td>
                                <td style="border-left : 0px;">
                                </td>
				            </tr>
                            
                            <tr>
                                <th>
                                	<sbux-label id="th_text12" name="th_text12" uitype="normal" text="삭제여부"></sbux-label>
                                </th>
				                <td style="border-right : 0px;"></label>
				                  <sbux-select name="delAt" class="select" title="삭제여부">
								    <c:forEach var="result" items="${delAt_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == userManageVO.delAt}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								  </sbux-select>
				                </td>
				                <td style="border-right : 0px; border-left : 0px;">
                                </td>
                                <td style="border-left : 0px;">
                                </td>
                            </tr>
                            
						  <tr> 
						    <th>
						    	<sbux-label id="th_text13" name="th_text13" uitype="normal" text="등록일"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input unitype="text" value="<c:out value='${userManageVO.frstRegistPnttm}'/>" style="width : 100%" readonly/>
						    </td>
						    <th nowrap>
						    	<sbux-label id="th_text14" name="th_text14" uitype="normal" text="변경일"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input unitype="text" value="<c:out value='${userManageVO.lastUpdtPnttm}'/>" style="width : 100%" readonly/>
						    </td>    
						  </tr>
						  
						  <tr>
                                <th>
                                	<sbux-label id="th_text15" name="th_text15" uitype="normal" text="비고"></sbux-label>
                                </th>
				                <td colspan="3"><label for="note"></label>
				                    <sbux-input name="note" id="note" style = "width : 100%" value="<c:out value='${userManageVO.note}'/>"/>				                    
				                </td>
                            </tr>
						</table>
                         
                    </div>
                    </form>
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="btn_buttom">
                    	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save"/>" onclick="fnUpdate();" class="btn-default"></sbux-button>
        	            <sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.delete" />" onclick="fnDeleteUser(); return false;" class="btn-default"></sbux-button>
                    	<sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.passwordUpdate" />" onclick="fnPasswordMove(); return false;" class="btn-default"></sbux-button>
                    	<sbux-button id="button5" name="button5" uitype="normal" text="<spring:message code="button.reset" />" onclick="document.userManageVO.reset();" class="btn-default"></sbux-button>
                    	<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.list"/>" onclick="fnListPage(); return false;" class="btn-default"></sbux-button> 
                    
                    </div>
                    <!-- 버튼 끝 --> 
  
                    <hidden path="password" />
            </div>
        <!-- footer 시작 -->
		<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		<!-- //footer 끝 -->
	</div>  
	<!-- //content 끝 -->
</div>
<!-- //전체 레이어 끝 -->

</body>
</html>