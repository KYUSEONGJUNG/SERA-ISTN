<%--
  Class Name : EgovIdDplctCnfirm.jsp
  Description : 아이디중복확인
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ID중복확인</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
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
select {font-family:'맑은고딕', Malgun Gothic,Helvetica, sans-serif !important; 	
font-size:12px; color:#666;}
a{text-decoration:none;color:#666;}
a:focus,a:active {text-decoration:none;color:#666;}
a:hover {text-decoration:none;color:#2069b3; font-weight:bold;}
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
.invisible {
width:0px;
height:0px;
visibility: hidden;
}    
/*기본버튼*/
span.btnblue {display:inline-block; padding-left:5px; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:left top;}
span.btnblue button,
span.btnblue input {display:inline-block; height:27px; padding:0 5px 0 6px; border:none; cursor:pointer; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
span.btnblue a {display:inline-block; height:27px; padding:6px 6px 0 10px; padding-right:15px; border:none; font-size:11px; color:#fff; font-weight:bold; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
-->

</style>
<base target="_self">
<script type="text/javaScript">
<!--
function fnCheckId(){
	if(document.checkForm.checkId.value==""){
		alert("중복조회할 아이디를 입력하십시오.");
		document.checkForm.focus();
        return;
	}
	if(fnCheckNotKorean(document.checkForm.checkId.value)){
		document.checkForm.submit();
    }else{
    	alert("한글은 사용할 수 없습니다.");
        return;
    }
}
function fnReturnId(){
	var retVal="";
    if (document.checkForm.usedCnt.value == 0){
	    retVal = document.checkForm.resultId.value;
	    window.returnValue = retVal; 
        window.close();
    }else if (document.checkForm.usedCnt.value == 1){
        alert("이미사용중인 아이디입니다.");
        return;
    }else{
    	alert("먼저 중복확인을 실행하십시오");
        return;
    }
}
function fnClose(){
    var retVal="";
    window.returnValue = retVal; 
    window.close();
}
function fnCheckNotKorean(koreanStr){                  
    for(var i=0;i<koreanStr.length;i++){
        var koreanChar = koreanStr.charCodeAt(i);
        if( !( 0xAC00 <= koreanChar && koreanChar <= 0xD7A3 ) && !( 0x3131 <= koreanChar && koreanChar <= 0x318E ) ) { 
        }else{
            //hangul finding....
            return false;
        }
    }
    return true;
}
//-->
</script>

</head>
<body>
    <form name="checkForm" action ="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do'/>">
    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
    <input type="submit" id="invisible" class="invisible"/>
    
    
    
    <table width="400" cellpadding="0" cellspacing="0" class="tbox">
        	<tr>
        	  <td valign="top" align="center">
              	<table width="360" border="0" cellpadding="0" cellspacing="0">
                	<tr>
                	  <td height="15">&nbsp;</td>
               	  </tr>
                  <tr>
                	  <td height="40" valign="top" class="title"><img src="<c:url value='/' />images/sr/bullet_arrow.gif" width="13" height="13" align="absmiddle" /> 아이디 중복확인</td>
               	  </tr>
                	<tr>
                	  <td><table width="360" border="0" cellpadding="0" cellspacing="0">
                	    <tr>
                	      <td colspan="2" bgcolor="#0257a6" height="2"></td>
              	      </tr>
                	    <tr>
                	      <td class="tdblue">사용할아이디</td>
                	      <td class="tdleft">
			                <input type="hidden" name="resultId" value="<c:out value="${checkId}"/>" />
				            <input type="hidden" name="usedCnt" value="<c:out value="${usedCnt}"/>" />
				            <input type="text" name="checkId" title="선택여부" value="<c:out value="${checkId}"/>" maxlength="20"  />                	      
                	      </td>
              	      </tr>
                	    <tr>
                	      <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
              	      </tr>
                	    <tr>
                	      <td class="tdblue">결과</td>
                	      <td class="tdleft">
			                <c:choose>
				                <c:when test="${usedCnt eq -1}">
				                    &nbsp; 중복확인을 실행하십시오
				                </c:when>
				                <c:when test="${usedCnt eq 0}">
				                    ${checkId} 는 사용가능한 아이디입니다.
				                </c:when>
				                <c:otherwise>
				                    ${checkId} 는 사용할수 없는 아이디입니다.
				                </c:otherwise>
			                </c:choose>                	      
                	      </td>
              	      </tr>
                	    <tr>
                	      <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
              	      </tr>
              	    </table>
                      </td>
               	  </tr>
                	<tr>
                	  <td height="50" valign="bottom" align="center">
                	  	<span class="btnblue"><a href="#LINK" onclick="javascript:fnCheckId(); return false;"><spring:message code="button.inquire" /> ▶</a></span>&nbsp;
                	  	<span class="btnblue"><a href="#LINK" onclick="javascript:fnReturnId(); return false;"><spring:message code="button.use" /> ▶</a></span>&nbsp;
                	  	<span class="btnblue"><a href="#LINK" onclick="javascript:fnClose(); return false;"><spring:message code="button.close" /> ▶</a></span>&nbsp;
                	  </td>
              	  </tr>
                	<tr>
                	  <td height="20">&nbsp;</td>
                   	</tr>
                </table>
              </td>
      	  </tr>
        </table>
<p>&nbsp;</p>

    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<%-- 	    <a href="#LINK" onclick="javascript:fnCheckId(); return false;"><spring:message code="button.inquire" /></a> --%>
<%-- 	    <a href="#LINK" onclick="javascript:fnReturnId(); return false;"><spring:message code="button.use" /></a> --%>
<%-- 	    <a href="#LINK" onclick="javascript:fnClose(); return false;"><spring:message code="button.close" /></a> --%>
<!--     </div> -->
    </form>
    
</body>
</html>