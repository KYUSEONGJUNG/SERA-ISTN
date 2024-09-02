<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovIdPasswordSearch.jsp
  * @Description : 아이디/비밀번호 찾기 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.09    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.09
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%-- <link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css"> --%>
<title><spring:message code='uss.umt.findIdPw'/></title>
<script>

function fnSearchId() {
	if (document.idForm.name.value =="") {
		alert("<spring:message code='error.required.name'/>");
	} else if (document.idForm.email.value =="") {
		alert("<spring:message code='error.required.email'/>");
	} else {
		//window.open("<c:url value='/cmm/uat/uia/searchId.do' />?id=");
		document.idForm.target = "_blank";
		/* document.idForm.submit(); */
		$.ajax({				 
			url : "<c:url value='/select/uat/uia/searchId.do'/>",
			type : "POST",
			data : $("#idForm").serialize(),
			
			success :function(data) {
				//Rename Setting
				//SBUxMethod.set('th_text_sub', data.resultInfo);
				//$("#th_text_sub").val(data.resultInfo);
				//SBUxMethod.openModal('modalMenu_sub');
				//$("#modalBody_sub").show();
				alert(data.resultInfo);
			},
			
			error : function(request, status, error){
				alert("error");   	            
			}
		});
	}
}

function fnSearchPassword() {
	if (document.passwordForm.id.value =="") {
		alert("<spring:message code='error.required.id'/>");
	} else if (document.passwordForm.name.value =="") {
		alert("<spring:message code='error.required.name'/>");
	} else if (document.passwordForm.email.value =="") {
		alert("<spring:message code='error.required.email'/>");
	} else if (document.passwordForm.passwordHint.value =="") {
		alert("<spring:message code='error.required.pwHint'/>");
	} else if (document.passwordForm.passwordCnsr.value =="") {
		alert("<spring:message code='error.required.pwAnswer'/>");
	} else {
		document.passwordForm.target = "_blank";
		//document.passwordForm.submit();
		$.ajax({				 
			url : "<c:url value='/select/uia/searchPassword.do'/>",
			type : "POST",
			data : $("#passwordForm").serialize(),
			
			success :function(data) {
				//Rename Setting
				//SBUxMethod.set('th_text_sub', data.resultInfo);
				//$("#th_text_sub").val(data.resultInfo);
				//SBUxMethod.openModal('modalMenu_sub');
				alert(data.resultInfo);
			},
			
			error : function(request, status, error){
				alert("error");   	            
			}
		});
	}
}

</script>
</head>

<body>
	<div class="sr-contents-wrap" style = "min-width : 0px;">
		<div class="sr-contents-area" style = "left:0px; width: 100%; position: relative; max-width : 100%; max-height:100%; overflow-x : hidden; overflow-y : hidden;">
            <div class="sr-contents" style="margin-bottom:0px; height:200px;" >
            	<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text"><spring:message code='uss.umt.findId'/></sbux-breadcrumb>
	            </div>
            
            	<form id="idForm" name="idForm" method="post">
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            	<input name="userSe" type="hidden" value="USR">
            	<!-- <input type="submit" id="invisible" class="invisible"/> -->
                
                	<div class="sr-table-wrap">
                		<table class="sr-table">
		                    <colgroup>
		                        <col width="17%">
		                        <col width="33%">
		                        <col width="12%">
		                        <col width="38%">
		                    </colgroup>
	                    
	                    <tr>
	                    	<th>
	                    		<sbux-label id="th_text1" name="th_text1" uitype="normal" text="<spring:message code='cop.ncrdNm'/>"></sbux-label>
	                    	</th>
	                    	<td colspan = "3">
	                    		<sbux-input uitype="text" name="name" id="name" style="width:100%;" value=""></sbux-input>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>
	                    		<sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='cop.emailAdres'/>"></sbux-label>
	                    	</th>
	                    	<td colspan = "3">
	                    		<sbux-input uitype="text" name="email" id="email" style="width:100%;" value=""></sbux-input>
	                    	</td>
	                    </tr>
	                    </table>
                    </div>
                </form>
                <div class="btn_buttom">  
                   	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code='uss.umt.findId'/>" onclick="fnSearchId()" class="btn-default"></sbux-button>              
                </div>
            </div>
            
            <!-- 현재위치 네비게이션 시작 -->
		      <div class="sr-contents" style="margin-top:0px;">
		      	<div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text"><spring:message code='uss.umt.findPw'/></sbux-breadcrumb>
	            </div>
		      
	      		<form id="passwordForm" name="passwordForm" action ="<c:url value='/uat/uia/searchPassword.do'/>" method="post">
		      	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		      	<input type="submit" id="invisible" class="invisible"/>
		        <input name="userSe" type="hidden" value="USR">  
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
			               		<sbux-label id="th_text3" name="th_text3" uitype="normal" text="<spring:message code='uss.umt.id'/>"></sbux-label>
			               	</th>
			               	<td colspan = "3">
			               		<sbux-input uitype="text" name="id" id="id1" style="width:100%;" value=""></sbux-input>
			               	</td>
		               </tr>
		               <tr>
			               	<th>
			               		<sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='cop.ncrdNm'/>"></sbux-label>
			               	</th>
			               	<td colspan = "3">
			               		<sbux-input uitype="text" name="name" id="name" style="width:100%;" value=""></sbux-input>
			               	</td>
		               </tr>
		               <tr>
			               	<th>
			               		<sbux-label id="th_text5" name="th_text5" uitype="normal" text="<spring:message code='cop.emailAdres'/>"></sbux-label>
			               	</th>
			               	<td colspan = "3">
			               		<sbux-input uitype="text" name="email" id="email" style="width:100%;" value=""></sbux-input>
			               	</td>
		               </tr>
		               <tr>
			               	<th>
			               		<sbux-label id="th_text6" name="th_text6" uitype="normal" text="<spring:message code='uss.umt.pwHint'/>"></sbux-label>
			               	</th>
			               	<td colspan = "3">
			               		 <sbux-select name="passwordHint" id="passwordHint" style="width: 100%;">
								    <option selected value=''><spring:message code='sr.choose'/></option>
								    <c:forEach var="result" items="${pwhtCdList}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'>
							  				<c:choose>
							  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.codeNm}"/></c:when>
							  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.codeNmEn}"/></c:when>
							  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.codeNmCn}"/></c:when>
							  					<c:otherwise><c:out value="${result.codeNm}"/></c:otherwise>
							  				</c:choose>   											
										</option>
									</c:forEach>
								  </sbux-select>
			               	</td>
		               </tr>
		               <tr>
			               	<th>
			               		<sbux-label id="th_text7" name="th_text7" uitype="normal" text="<spring:message code='uss.umt.pwAnswer'/>"></sbux-label>
			               	</th>
			               	<td colspan = "3">
			               		<sbux-input uitype="text" name="passwordCnsr" id="passwordCnsr" style="width:100%;" value=""></sbux-input>
			               	</td>
		               </tr>
		               </table>
		              </div>
		          </form>
		          
		          <div class="btn_buttom">
		             	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code='uss.umt.findPw'/>" onclick="fnSearchPassword()" class="btn-default"></sbux-button>               
		          </div>
		      
		      </div>
      	</div>

</body>
</html>

