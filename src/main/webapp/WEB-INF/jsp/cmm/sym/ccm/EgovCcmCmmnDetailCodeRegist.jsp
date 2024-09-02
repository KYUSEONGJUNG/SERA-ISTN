<%--
  Class Name : EgovCcmCmmnDetailCodeRegist.jsp
  Description : EgovCcmCmmnDetailCodeRegist 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >

<title>공통상세코드 등록</title>
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnListPage(){
    location.href = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fnInsert(){
	
	if(validateCmmnDetailCode(document.searchVO)){
		if(confirm("<spring:message code='common.save.msg'/>")){
	        
			var code = "${result.code}";
			
			if(code){
				document.searchVO.action = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do'/>";
				document.searchVO.cmd.value = "Modify";
			}else{
				document.searchVO.action =  "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do'/>";
				document.searchVO.cmd.value = "Regist";
			}
	        
			document.searchVO.submit();
	        
	    }	
	}
    
}

function validateCmmnDetailCode(form){
	var checkOption = {
		codeId : { valid : "required,maxlength" , label : "코드ID", max : 6} 
		, code : { valid : "required,maxlength" , label : "코드", max : 6}
		, codeNm : { valid : "required" , label : "코드명"}
		, codeDc : { valid : "required" , label : "코드 설명"}
		, useAt : { valid : "required" , label : "사용여부"}
	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}

function fnDelete(){
	if (confirm("<spring:message code="common.delete.msg"/>")) {
    	document.searchVO.action           = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeRemove.do'/>";
        document.searchVO.submit();
    }
}
</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
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
            		<input type="hidden" name="cmd" value=""/>
            		
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
	                                	<c:if test = "${empty result.code}">
	                                	<sbux-select name="codeId" id="codeId" style = "width : auto;">
								            <c:forEach var="list" items="${cmmnCodeList}" varStatus="status">
								                <option value='<c:out value="${list.codeId}"/>' <c:if test = "${list.codeId}">selected</c:if>><c:out value="${list.codeIdNm}"/></option>
								            </c:forEach>                       
								        </sbux-select>
								        </c:if>
								        <c:if test = "${not empty result.code}">
								        	<input type="hidden" name="codeId" value="<c:out value = "${result.codeId}"/>"/>
								        	<sbux-input id="codeIdNm" name="codeIdNm" uitype="text" value="<c:out value = "${result.codeIdNm}"/>" readonly></sbux-input>                           	
	                                	</c:if>
	                                </td>                            
	                            </tr>
	                             <tr>
	                                <th>
	                                    <sbux-label id="th_text2" name="th_text2" uitype="normal" class = "imp-label" text="코드"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-input id="code" name="code" uitype="text" value="<c:out value = "${result.code}"/>" maxlength="15" <c:if test = "${not empty result.code}">readonly</c:if>></sbux-input>
	                                </td>                            
	                            </tr>         
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text3" name="th_text3" uitype="normal" text="코드명"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<sbux-input name="codeNm" id="codeNm" value = "<c:out value = "${result.codeNm}" />" maxlength="60"></sbux-input> 
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text4" name="th_text4" uitype="normal" text="코드명 영어"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-input name="codeNmEn" id="codeNmEn" value = "<c:out value = "${result.codeNmEn}" />" maxlength="60"></sbux-input> 
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text5" name="th_text5" uitype="normal" text="코드명 중국어"></sbux-label>
	                                </th>
	                                <td colspan="3">
	                                	<sbux-input name="codeNmCn" id="codeNmCn" value = "<c:out value = "${result.codeNmCn}" />" maxlength="60"></sbux-input> 
	                                </td>                            
	                            </tr>
	                            <tr>
	                                <th>
	                                    <sbux-label id="th_text6" name="th_text6" uitype="normal" text="코드 설명"  class="imp-label"></sbux-label>
	                                </th>
	                                <td colspan="3" class="tdText">
	                                	<sbux-textarea name="codeDc" id="codeDc" cols="100" rows="5"><c:out value = "${result.codeDc}"/></sbux-textarea> 
	                                </td>                            
	                            </tr>
								<tr>
	                                <th>
	                                    <sbux-label id="th_text8" name="th_text8" uitype="normal" class = "imp-label" text="사용여부"></sbux-label>
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
<!-- 전체 레이어 시작 -->
<%-- <div id="wrapper">
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
<!--                             <li><strong>상세공통코드관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 상세코드관리 > 공통상세코드 등록</li>
			        </ul>
			    </div>	
			    
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>공통상세코드 등록</strong></h2></div> -->
<!--                 </div> -->

				<form:form modelAttribute="cmmnDetailCode" name="cmmnDetailCode" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input name="cmd" type="hidden" value=""/>

                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="코드ID, 코드, 코드명, 코드설명, 사용여부를 입력하는 공통상세코드 등록 테이블이다.">
						  <tr>
				              <td colspan="2" bgcolor="#0257a6" height="2"></td>
				            </tr>
                          <tr> 
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeId">코드ID</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap colspan="3">
						    	<input name="clCode" type="hidden" value='<c:out value="${result.clCode}"/>' />
<!-- 						        <select name="clCode" class="select" onChange="javascript:fn_egov_get_CodeId(document.cmmnDetailCode);" title="clCode"> -->
						            <c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
						                <option value='<c:out value="${result.clCode}"/>' <c:if test="${result.clCode == cmmnCode.clCode}">selected="selected"</c:if>><c:out value="${result.clCodeNm}"/></option>
						            </c:forEach>                       
<!-- 						        </select> -->
						        <select name="codeId" class="select" id="codeId">
						            <c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
						                <option value='<c:out value="${result.codeId}"/>' ><c:out value="${result.codeIdNm}"/></option>
						            </c:forEach>                       
						        </select>
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="code">코드</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="code" size="15" maxlength="15" id="code"/>
						      <form:errors path="code"/>
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeNm">코드명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="codeNm" size="60" maxlength="60" id="codeNm"/>
						      <form:errors path="codeNm"/>
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
				          <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeNm">코드명 영어</label></th>          
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="codeNmEn" size="60" maxlength="60" id="codeNmEn"/>
						      <form:errors path="codeNmEn"/>
						    </td>   
						  </tr>
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="codeNm">코드명 중국어</label></th>          
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="codeNmCn" size="60" maxlength="60" id="codeNmCn"/>
						      <form:errors path="codeNmCn"/>
						    </td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th height="23" class="tdblue" scope="row" ><label for="codeDc">코드설명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>
						      <form:textarea path="codeDc" rows="3" cols="60" id="codeDc"/>
						      <form:errors   path="codeDc"/>
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
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_list_CmmnDetailCode(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_CmmnDetailCode(document.cmmnDetailCode); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 -->  

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         목록/저장버튼  -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_list_CmmnDetailCode(); return false;">목록</a> -->
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_regist_CmmnDetailCode(document.cmmnDetailCode); return false;">저장</a>  -->
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
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

