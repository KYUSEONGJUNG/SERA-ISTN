<%--
  Class Name : EgovMenuCreat.jsp
  Description : 권한설정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>

<title>권한설정</title>
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
	padding-top:5px;
}
.depth01 {
	padding-left:20px;
	color:#06F;
	font-weight:bold;
	height:23px;
}
.depth02 {
	padding-left:40px;
	color:#06F;
	font-weight:bold;
	height:23px;
}
/*기본버튼*/
span.btnblue {display:inline-block; padding-left:5px; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:left top;}
span.btnblue button,
span.btnblue input {display:inline-block; height:27px; padding:0 5px 0 6px; border:none; cursor:pointer; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
span.btnblue a {display:inline-block; height:27px; padding:6px 6px 0 10px; padding-right:15px; border:none; font-size:11px; color:#fff; font-weight:bold; background:url(../../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
-->

</style>
<script type="text/javaScript">
<!--
var imgpath = "<c:url value='/'/>images/tree/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuCreatTmp() {
    document.menuCreatManageForm.action = "<c:url value='/sym/mpm/EgovMenuCreatSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
    var checkField = document.menuCreatManageForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }   
    document.menuCreatManageForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
    document.menuCreatManageForm.submit();
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
    id = document.menuCreatManageForm.authorCode.value;
    window.open("<c:url value='/sym/mpm/EgovMenuCreatSiteMapSelect.do'/>?authorCode="+id,'Pop_SiteMap','scrollbars=yes, width=550, height=700');
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");
window.close();
</c:if>
-->
</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->

<form name="menuCreatManageForm" action ="/sym/mpm/EgovMenuCreatSiteMapSelect.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<!-- <input type="submit" id="invisible" class="invisible"/> -->
		<input name="checkedMenuNoForInsert" type="hidden" >
		<input name="checkedAuthorForInsert"  type="hidden" >

		<c:forEach var="result1" items="${list_menulist}" varStatus="status" > 
			<input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
		</c:forEach>
	                
        <table width="600" cellpadding="0" cellspacing="0" class="tbox">
        	<tr>
        	  <td valign="top" align="center">
              	<table width="560" border="0" cellpadding="0" cellspacing="0">
                	<tr>
                	  <td height="15">&nbsp;</td>
               	  </tr>
                	<tr>
                	  <td height="40" valign="top" class="title"><img src="<c:url value='/'/>images/sr/bullet_arrow.gif" width="13" height="13" align="absmiddle" /> 권한설정</td>
               	  </tr>
                	<tr>
                	  <td><table width="560" border="0" cellpadding="0" cellspacing="0">
                	    <tr>
                	      <td colspan="2" bgcolor="#0257a6" height="2"></td>
              	      </tr>
                	    <tr>
                	      <td class="tdblue">권한코드</td>
                	      <td class="tdleft">
                	      	<input name="authorCode" type="text" size="50"  maxlength="30" title="권한코드" value="${resultVO.authorCode}" readonly>
                	      	<span class="btnblue"><a href="#LINK" onclick="fInsertMenuCreat(); return false;">저장 ▶</a></span>
                	      	<span class="btnblue"><a href="#LINK" onclick="javascript:window.close(); return false;">닫기 ▶</a></span> 
                	      </td>
              	      </tr>
                	    <tr>
                	      <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
              	      </tr>
              	    </table>
                      </td>
               	  </tr>
                	<tr>
                	  <td height="20"><br>
                	  
	                	  <div class="tree" >
					        <script language="javascript" type="text/javaScript">
					            var chk_Object = true;
					            var chk_browse = "";
					            if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
					            if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
					            if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";
					
					            var Tree = new Array;
					            if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
					               alert("메뉴 목록 데이타가 존재하지 않습니다.");
					               chk_Object = false;
					            }
					            if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
					               alert("메뉴 목록 데이타가 존재하지 않습니다.");
					               chk_Object = false;
					            }
					            if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
					                   alert("메뉴 목록 데이타가 존재하지 않습니다.");
					                   chk_Object = false;
					            }
					            if( chk_Object ){
					                for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
					                    Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
					                }
					                createTree(Tree);
					            }else{
					                alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
					                window.close();
					            }
					        </script>
					    </div>
<!--                       <table width="560" border="0" cellpadding="0" cellspacing="0"> -->
<!--                       	<tr> -->
<!--                       	  <td><input type="checkbox" name="checkbox" id="checkbox" class="input_chk"/> -->
<!--                       	    메뉴목록</td> -->
<!--                    	    </tr> -->
<!--                       	<tr> -->
<!--                        	  <td class="depth01"><input type="checkbox" name="checkbox2" id="checkbox2" class="input_chk1"/> -->
<!--                    	        <img src="img/icon_sfolder.gif" width="15" height="14" align="absmiddle" /> SR 리스트</td> -->
<!--                         </tr> -->
<!--                         <tr> -->
<!--                        	  <td class="depth02"><input type="checkbox" name="checkbox2" id="checkbox2" class="input_chk1"/> -->
<!--                    	        <img src="img/icon_sfile.gif" width="10" height="11" align="absmiddle" /> SR 리스트</td> -->
<!--                         </tr> -->
<!--                         <tr> -->
<!--                        	  <td class="depth01"><input type="checkbox" name="checkbox2" id="checkbox2" class="input_chk1"/> -->
<!--                    	        <img src="img/icon_ofolder.gif" width="15" height="14" align="absmiddle" /> 통계</td> -->
<!--                         </tr> -->
<!--                         <tr> -->
<!--                        	  <td class="depth02"><input type="checkbox" name="checkbox2" id="checkbox2" class="input_chk1"/> -->
<!--                        	    <img src="img/icon_sfile.gif" width="10" height="11" align="absmiddle" /> SR 처리율</td> -->
<!--                         </tr> -->
<!--                         <tr> -->
<!--                        	  <td class="depth02"><input type="checkbox" name="checkbox2" id="checkbox2" class="input_chk1"/> -->
<!--                        	    <img src="img/icon_sfile.gif" width="10" height="11" align="absmiddle" /> SR Activity Report</td> -->
<!--                         </tr> -->
<!--                       </table> -->
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

<input type="hidden" name="req_menuNo">
</form>



    <!-- //전체 레이어 끝 -->
 </body>
</html>