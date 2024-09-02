<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<title>Untitled Document</title>
<style type="text/css">
<!--
img, fieldset {border:0 none}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,button,form,fieldset,p,blockquote{margin:0;padding:0;}
#container {
	position:absolute;
	width:98%;
	height:98%;
}
#container_con {
	text-align:center;
	position:absolute;
	top:30%;
	width:100%
}
#error {
	margin:0 auto;
	width:734px;
	height:277px;
}
-->
</style>
<script type="text/javascript">
function fncGoAfterErrorPage(){
    location.href = "/";
}
</script>
</head>

<body>
<div id="container">
    <div id="container_con">
        <div id="error">
<%--         <img src="<c:url value='/' />images/sr/img_error02.gif" border="0" usemap="#Map2" /> --%>
<!--           <map name="Map2" id="Map"> -->
<!--             <area shape="rect" coords="498,156,561,185" href="javascript:fncGoAfterErrorPage();" /> -->
<!--           </map> -->
        <c:choose>
          <c:when test="${language == 'ko'}">
	      	  <img src="<c:url value='/' />images/sr/img_error02.gif" border="0" usemap="#Map3" />
          </c:when>
          <c:when test="${language == 'en'}">
	      	  <img src="<c:url value='/' />images/sr/img_error02En.gif" border="0" usemap="#Map3" />
          </c:when>
          <c:when test="${language == 'cn'}">
	      	  <img src="<c:url value='/' />images/sr/img_error02Cn.gif" border="0" usemap="#Map3" />
          </c:when>
          <c:otherwise>
	      	  <img src="<c:url value='/' />images/sr/img_error02.gif" border="0" usemap="#Map3" />
          </c:otherwise>
        </c:choose>  
        <div class="list3">
        	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fncGoAfterErrorPage(); return false;">BACK ▶</a></span>
        </div>
   	  </div>
    </div>
</div>	
</body>
</html>
