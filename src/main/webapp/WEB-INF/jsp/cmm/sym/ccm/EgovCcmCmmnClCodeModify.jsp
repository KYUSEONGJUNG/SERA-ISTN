<%--
  Class Name : EgovCcmCmmnClCodeModify.jsp
  Description : EgovCcmCmmnClCodeModify 화면
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
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>공통분류코드 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnClCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_CmmnClCode_bak(){
    location.href = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>";
}
function fncSelectList() {
	var varForm = document.getElementById("cmmnClCode");
	varForm.action = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>";
	varForm.submit();       
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_CmmnClCode(form){
    if(confirm("<spring:message code="common.save.msg" />")){
        if(!validateCmmnClCode(form)){          
            return;
        }else{
            form.submit();
        }
    }
}
//-->
</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>코드관리</li>
                            <li>&gt;</li>
                            <li><strong>분류코드관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 메뉴목록관리 > 메뉴 등록</li>
			        </ul>
			    </div>	
			    
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>공통분류코드 수정</strong></h2></div>
                </div>
				<form:form commandName="cmmnClCode" name="cmmnClCode" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
    				<input name="cmd" type="hidden" value="Modify">
    				<form:hidden path="clCode"/>

                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="분류코드명, 분류코드설명, 사용여부를 수정하는 공통분류코드 수정 테이블이다.">
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >분류코드<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap colspan="3">
						        ${cmmnClCode.clCode}
						    </td>
						  </tr> 
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="clCodeNm">분류코드명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="clCodeNm" size="60" maxlength="60" id="clCodeNm"/>
						      <form:errors path="clCodeNm"/>
						        
						    </td>    
						  </tr> 
						  <tr> 
						    <th height="23" class="tdblue" scope="row" ><label for="clCodeDc">분류코드설명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>
						      <form:textarea path="clCodeDc" cols="100" rows="5" id="clCodeDc"/>
						      <form:errors   path="clCodeDc"/>
						    </td>
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
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="#LINK" onclick="fncSelectList(); return false;">목록</a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="javascript:fn_egov_modify_CmmnClCode(document.cmmnClCode); return false;"><spring:message code="button.save" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <!-- 검색조건 유지 -->
                </form:form>

            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

