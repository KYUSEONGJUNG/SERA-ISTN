<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
    history.back(-2);
}
</script>
</head>

<body>
<div id="container">
    <div id="container_con">
    	<div id="error"><img src="<c:url value='/' />images/sr/img_error01.gif" border="0" usemap="#Map1" />
          <map name="Map1" id="Map">
            <area shape="rect" coords="496,181,559,210" href="javascript:fncGoAfterErrorPage();" />
          </map>
    	</div>
    </div>
</div>	
</body>
</html>
