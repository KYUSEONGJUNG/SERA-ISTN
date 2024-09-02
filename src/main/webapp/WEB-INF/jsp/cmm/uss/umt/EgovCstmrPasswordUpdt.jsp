<%--
  Class Name : EgovPasswordUpdt.jsp
  Description : 암호수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="egovframework.let.utl.sim.service.EgovFileScrty"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<%
//패스워드 암호화
String userPassword = request.getParameter("userPassword");
String encryptPass = EgovFileScrty.encryptPassword(userPassword);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><html>
<head>
<meta http-equiv="Content-Language" content="ko">
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<title><spring:message code='button.passwordUpdate'/></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">

function validatePasswordChgVO(form){
	var checkOption = {
		emplyrId : { 
			valid : "maxlength" 
			, label : "<spring:message code='sr.client'/>" 
			, max : 20 
			}
		, oldPassword : { 
			valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.oldPw'/>"
			, max : 20
			}
		, newPassword : { 
			valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.password'/>"
			, max : 20
			}
		, newPassword2 : { 
			valid : "required, maxlength" 
			, label : "<spring:message code='uss.umt.confirmPw'/>"
			, max : 20
			}
	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}


function fnUpdate(){
    if(validatePasswordChgVO(document.passwordChgVO)){
        if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        /* document.passwordChgVO.submit();
        document.passwordChgVO.action = ""; */
        
        var form = $("#passwordChgVO")[0];
		var formData = new FormData(form);
                
        $.ajax({        	
			url : "<c:url value='/uss/umt/user/EgovUserPasswordUpdt.do'/>"			
			,type : "POST"
			,data : formData
	     	,contentType : false
	     	,processData : false
			,beforeSend : fn_loading()
			,success : function(data){
				alert(data.msg);
				if(data.msgType == 'S') {
  		       		//location.replace('<c:url value='/uss/umt/user/EgovCstmrSelectUpdtView.do'/>');
  		       		document.passwordChgVO.action = "<c:url value='/uss/umt/user/EgovCstmrSelectUpdtView.do'/>";
  		       		document.passwordChgVO.submit();
  		        
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
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>

function fnListPage() {
	document.passwordChgVO.action = "<c:url value='/sr/EgovSrList.do'/>";
	document.passwordChgVO.submit();
}

var headText = [
	{"order" : "1", "id" : "id_1", "pid" : "0","text" : "<spring:message code='button.passwordUpdate'/>", "value" : "value2", "imagesrc":"<c:url value = '/'/>images/breadcrumb-home.png", "imagealt" : "imageAlt", "imagetitle" : "imageTitle", "imagestyle" : "height:15px; width:16px;"}
]
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
					<sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="headText" disabled></sbux-breadcrumb>
				</div>

				<form id="passwordChgVO" name="passwordChgVO" method="post" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserPasswordUpdt.do">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="submit" id="invisible" class="invisible" />
					<!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
					<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
					<input name="checkedIdForDel" type="hidden" />
					<!-- 검색조건 유지 -->
					<input type="hidden" name="sbscrbSttus" value="<c:out value='${searchVO.sbscrbSttus}'/>" /> 
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
					<!-- 우편번호검색 -->
					<input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
					<input type="password" style="width:0px; height:0px; position : absolute; left : -500px; top : -500px;" />
					<div class="sr-table-wrap">
				         <table class="sr-table">
	                        <colgroup>
	                            <col width="12%">
	                            <col width="29%">
	                            <col width="12%">
	                            <col width="49%">
	                        </colgroup>
							<tr>
								<th>
									<sbux-label id="th_text1" name="th_text1" uitype="normal" text="<spring:message code='uss.umt.id'/>"></sbux-label>
								</th>
								<td style="border-right : 0px;">
									<sbux-input name="emplyrId" id="emplyrId" title="사용자아이디" uitype="text" size="20" value="<c:out value='${userManageVO.emplyrId}'/>" maxlength="20" readonly style="width : 100%"></sbux-input> 
									<input name="uniqId" id="uniqId" title="uniqId" type="hidden" size="20" value="<c:out value='${userManageVO.uniqId}'/>" /> 
									<input name="userTy" id="userTy" title="userTy" type="hidden" size="20" value="<c:out value='${userManageVO.userTy}'/>" />
								</td>
								<td style="border-right : 0px; border-left:0px;"></td>
								<td style="border-left:0px;"></td>
							</tr>
						
							<tr>
								<th>
									<sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='uss.umt.oldPw'/>" class = "imp-label"></sbux-label>
								</th>
								<td style="border-right : 0px;">
									<sbux-input name="oldPassword" id="oldPassword" title="기존 비밀번호" uitype="password" size="20" value="" maxlength="100" style="width : 100%"/>
								</td>
								<td style="border-right : 0px; border-left:0px;"></td>
								<td style="border-left:0px;"></td>
							</tr>
							
							<tr>
								<th>
									<sbux-label id="th_text3" name="th_text3" uitype="normal" text="<spring:message code='uss.umt.password'/>" class = "imp-label"></sbux-label>
								</th>
								<td style="border-right : 0px;">
									<sbux-input name="newPassword" id="newPassword" title="비밀번호" uitype="password" size="20" value="" maxlength="100" style="width : 100%"/>
								</td>
								<td style="border-right : 0px; border-left:0px;"></td>
								<td style="border-left:0px;"></td>
							</tr>
							
							<tr>
								<th>
									<sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='uss.umt.confirmPw'/>" class = "imp-label"></sbux-label>								
								</th>
								<td style="border-right : 0px;">
									<sbux-input name="newPassword2" id="newPassword2" title="비밀번호확인" uitype="password" size="20" value="" maxlength="100" style="width : 100%"/>
								</td>
								<td style="border-right : 0px; border-left:0px;"></td>
								<td style="border-left:0px;"></td>
							</tr>
							
						</table>
					</form>
					</div>
					
					<!-- 버튼 시작(상세지정 style로 div에 지정) -->
     				<div class="btn_buttom">   
                    	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save" />" onclick="fnUpdate();" class="btn-default"></sbux-button>
                    	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.reset" />" onclick="document.passwordChgVO.reset();" class="btn-default"></sbux-button>
                    	<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.list" />" onclick="fnListPage();" class="btn-default"></sbux-button> 
                	</div> 
                    <!-- 버튼 끝 -->
                    

				
			</div>
			<!-- //content 끝 -->
		<!-- footer 시작 -->
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->
</body>
</html>

