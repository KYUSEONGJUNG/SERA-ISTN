<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.let.main.service.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
if(loginVO == null){ 
%>
<%
}else{
%>
<c:set var="loginName" value="<%= loginVO.getName()%>"/>
<%
}
String strservicelvl = (String)session.getAttribute("strservicelvl");
if(!"".equals(strservicelvl) && strservicelvl != null){
%>
<c:set var="strservicelvl" value="<%= strservicelvl%>"/>
<%
} 
%>
<script type="text/javascript">
    function fn_ServiceLevel(){
        document.menuListForm.action = "<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>";
        document.menuListForm.submit();      
    }
    function fn_old_sr_popup() {
    	window.open('http://isprint.co.kr/support/supportInquiry2.asp','srSystem','width=1024,height=768,menubar=yes,toolbar=yes,location=yes,resizable=yes,status=yes,scrollbars=yes,top=100,left=100');
    }
    function fn_charger_popup(){
    	var url = "<c:url value='/pstinst/EgovPstinstChargerList.do'/>";
    	var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=1,status=0,menubar=0,width=680,height=390,left=20,top=20";
    	window.open(url,"_chargerPopup", openParam);
    }  
    
</script>
<link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
<h1 class="logo"><a href="<c:url value='/'/>uat/uia/actionMain.do"><img src="<c:url value='/' />images/sr/img_toplogo.png" /></a></h1>
<ul id="infoMenu">
  	<li><b><c:out value="${loginName}"/></b>&nbsp;<spring:message code='uss.umt.msg.welcomeLogin'/></li>&nbsp;&nbsp;&nbsp;&nbsp;
    <li>
	    <a href="<c:url value='/uss/umt/user/EgovCstmrSelectUpdtView.do'/>">
			<c:choose>
				<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_infomodify.gif" align="absmiddle" /></c:when>
				<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_infomodifyEn.gif" align="absmiddle" /></c:when>
				<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_infomodifyCn.gif" align="absmiddle" /></c:when>
				<c:otherwise><img src="<c:url value='/' />images/sr/btn_infomodify.gif" align="absmiddle" /></c:otherwise>
			</c:choose> 	    	
	    </a>
    </li>&nbsp;
    <li>
	    <a href="<c:url value='/uat/uia/actionLogout.do'/>">	    	
			<c:choose>
				<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_logout.gif" align="absmiddle"/></c:when>
				<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_logoutEn.gif" align="absmiddle"/></c:when>
				<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_logoutCn.gif" align="absmiddle"/></c:when>
				<c:otherwise><img src="<c:url value='/' />images/sr/btn_logout.gif" align="absmiddle"/></c:otherwise>
			</c:choose> 	    	
	    </a>
    </li>&nbsp;
    <li>
	    <a href="#LINK" onclick="javascript:fn_charger_popup();">
			<c:choose>
				<c:when test="${srLanguage == 'ko'}"><img src="<c:url value='/' />images/sr/btn_moduleCharger.gif" align="absmiddle"/></c:when>
				<c:when test="${srLanguage == 'en'}"><img src="<c:url value='/' />images/sr/btn_moduleChargerEn.gif" align="absmiddle"/></c:when>
				<c:when test="${srLanguage == 'cn'}"><img src="<c:url value='/' />images/sr/btn_moduleChargerCn.gif" align="absmiddle"/></c:when>
				<c:otherwise><img src="<c:url value='/' />images/sr/btn_moduleCharger.gif" align="absmiddle"/></c:otherwise>
			</c:choose> 	    	
	    </a>
    </li>&nbsp;
    <br><br><br>
    <c:if test="${!empty strservicelvl}">
    <c:choose>
    	<c:when test="${strservicelvl == 'S'}">
    		<a href="<c:url value='/sts/stsfdg/selectStsfdgSttus.do?baseMenuNo=2000000&selMenuNo=2060000'/>" >
    			<img src="<c:url value='/' />images/sr/icon_levelS.png"/>
    		</a>
    	</c:when>
    	<c:when test="${strservicelvl == 'A'}">
    		<a href="<c:url value='/sts/stsfdg/selectStsfdgSttus.do?baseMenuNo=2000000&selMenuNo=2060000'/>" >
    			<img src="<c:url value='/' />images/sr/icon_levelA.png"/>
    		</a>
    	</c:when>
    	<c:when test="${strservicelvl == 'B'}">
    		<a href="<c:url value='/sts/stsfdg/selectStsfdgSttus.do?baseMenuNo=2000000&selMenuNo=2060000'/>" >
    			<img src="<c:url value='/' />images/sr/icon_levelB.png"/>
    		</a>
    	</c:when>
    	<c:when test="${strservicelvl == 'C'}">
    		<a href="<c:url value='/sts/stsfdg/selectStsfdgSttus.do?baseMenuNo=2000000&selMenuNo=2060000'/>" >
    			<img src="<c:url value='/' />images/sr/icon_levelC.png"/>
    		</a>
    	</c:when>
    	<c:when test="${strservicelvl == 'D'}">
    		<a href="<c:url value='/sts/stsfdg/selectStsfdgSttus.do?baseMenuNo=2000000&selMenuNo=2060000'/>" >
    			<img src="<c:url value='/' />images/sr/icon_levelD.png"/>
    		</a>
    	</c:when>
    	<c:otherwise></c:otherwise>
    </c:choose>
    
    </c:if>
</ul>     


<!-- 행정안전부 로고 및 타이틀 시작 -->
<!-- <div id="logoarea"> -->
<%-- 	<h1><a href="<c:url value='/'/>uat/uia/actionMain.do"><img src="<c:url value='/'/>images/header/logo.jpg" alt="logo" /></a></h1> --%>
<!-- </div> -->
<!-- //행정안전부 로고 및 타이틀 끝 -->
