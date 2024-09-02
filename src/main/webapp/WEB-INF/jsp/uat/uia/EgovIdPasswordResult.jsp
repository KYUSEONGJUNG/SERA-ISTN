<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovIdPasswordResult.jsp
  * @Description : 아이디/비밀번호 찾기 결과화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.17    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.17
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
/* ********************************************************
 * 뒤로 처리 함수
 ******************************************************** */
function fnBack(){
	document.backForm.action = "<c:url value='/cmm/uat/uia/egovIdPasswordSearch.do'/>";
	document.backForm.submit();
}
</script>
</head>
<style type="text/css">
<!--
body { 
font-family:'맑은고딕', Malgun Gothic,Helvetica, sans-serif !important; 	
font-size:12px; 
color:#666; 
letter-spacing:-1px; 
line-height:1.2;
}

body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,button,form,fieldset,p,blockquote{margin:0;padding:0;}
input:checked[type="checkbox"]{background-color:#fff;-webkit-appearance:checkbox;}
input[type=text]{ border:1px solid #b3b3b3; height:19px; padding-left:5px; font-family:'맑은고딕', Malgun Gothic,Helvetica, sans-serif !important; 	
font-size:12px; color:#666; }
input[type=password]{ border:1px solid #b3b3b3; height:19px; padding-left:5px; font-family:'맑은고딕', Malgun Gothic,Helvetica, sans-serif !important; 	
font-size:12px; color:#666; }
label{vertical-align:-1px}
.input_chk{width:13px;height:13px;vertical-align:text-top}
a{text-decoration:none;color:#666;}
a:focus,a:active {text-decoration:none;color:#666;}
a:hover {text-decoration:none;color:#2069b3; font-weight:bold;}
select {font-family:'맑은고딕', Malgun Gothic,Helvetica, sans-serif !important; 	
font-size:12px; color:#666;}
.tbox {
	border: 5px solid #246593;
    border-collapse: collapse;
}
.title {
	font-family:'맑은고딕', Malgun Gothic;
	font-size:16px;
	font-weight:bold;
	color:#000;
}
.tdblue {
	width:110px;
	height:30px;
	color:#000;
	background:#edf5f8;
	text-align:center;
	font-weight:bold;
}
.tdleft {
	text-align:left;
	padding-left:10px;
}
/*기본버튼*/
span.btnblue {display:inline-block; padding-left:5px; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:left top;}
span.btnblue button,
span.btnblue input {display:inline-block; height:27px; padding:0 5px 0 6px; border:none; cursor:pointer; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
span.btnblue a {display:inline-block; height:27px; padding:6px 6px 0 10px; padding-right:15px; border:none; font-size:11px; color:#fff; font-weight:bold; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
-->

</style>
<body>
  <form name="backForm"/>
  		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
  
        <table width="399" cellpadding="0" cellspacing="0" class="tbox">
        	<tr>
        	  <td width="389" align="center" valign="top">
              	<table width="360" border="0" cellpadding="0" cellspacing="0">
                	<tr>
                	  <td height="15">&nbsp;</td>
               	  </tr>
                	<tr>
                	  <td height="40" valign="top" class="title"><img src="<c:url value='/' />images/sr/bullet_arrow.gif" width="13" height="13" align="absmiddle" /> <spring:message code='uss.umt.findIdPw'/></td>
               	  </tr>
                	<tr>
                	  <td><table width="360" border="0" cellpadding="0" cellspacing="0">
                	    <tr>
                	      <td colspan="2" bgcolor="#0257a6" height="2"></td>
              	      </tr>
                	    <tr>
                	      <td class="tdblue">${resultInfo}</td>
              	      </tr>
                	    <tr>
                	      <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
              	      </tr>
              	    </table>
                      </td>
               	  </tr>
                	<tr>
                	  <td height="50" valign="bottom" align="center"><span class="btnblue"><a href="#LINK" onclick="javascript:window.close(); return false;"><spring:message code='button.close'/> ▶</a></span></td>
              	  </tr>
                	<tr>
                	  <td height="20">&nbsp;</td>
                   	</tr>
                </table>
              </td>
      	  </tr>
        </table>
<p>&nbsp;</p>
  
</body>
</html>

