<%--
  Class Name : EgovCcmZipSearchList.jsp
  Description : EgovCcmZipSearchList 화면(include)
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/zip.css'/>" >
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<title>우편번호 찾기</title>
<script type="text/javaScript" language="JavaScript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/ccm/EgovCcmZipSearchList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 결과 우편번호,주소 반환 
 ******************************************************** */
function fn_egov_return_Zip(zip,addr){
	var retVal   = new Object();
	var sZip     = zip;
	var vZip     = zip.substring(0,3)+"-"+zip.substring(3,6);
	var sAddr    = addr.replace("/^\s+|\s+$/g","");
	retVal.sZip  = sZip;
	retVal.vZip  = vZip;
	retVal.sAddr = sAddr;
	parent.window.returnValue = retVal;
	parent.window.close();
}	
function fCallUrl(url) {

	window.open(url,'dokdo','width=1024,height=768,menubar=yes,toolbar=yes,location=yes,resizable=yes,status=yes,scrollbars=yes,top=100,left=100');
}
//-->
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

/*기본버튼*/
span.btnblue {display:inline-block; padding-left:5px; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:left top;}
span.btnblue button,
span.btnblue input {display:inline-block; height:27px; padding:0 5px 0 6px; border:none; cursor:pointer; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}
span.btnblue a {display:inline-block; height:27px; padding:6px 6px 0 10px; padding-right:15px; border:none; font-size:11px; color:#fff; font-weight:bold; background:url(../../images/sr/img_btnbg.gif) no-repeat; background-position:right top;}

#paging_div{clear:both;position:relative;width:650px;}
#paging_div .paging_align{
	clear: both;
    margin: 0 auto;
    padding-top: 16px;
    text-align: center;
    width: 650px;}
.paging_align .first{border:medium none;padding:0px;}
.paging_align li{display:inline;border-right:1px solid #dddddd;padding-left:3px;padding-right:10px; vertical-align:middle;}
.paging_align li a{color:#666666;}
.paging_align li a:hover{color:#0958A5;font-weight:bold;}
.paging_align a:active{color:#0958A5;} 
.paging_align a:visited{color:#0958A5;}

.list3 {
	padding-top:10px;
}
.tdgrey {
	color:#000;
	background:#f0f0f0;
	text-align:center;
	font-weight:bold;
	height:30px;
	line-height:14px;
}
.tdwc {
	text-align:center;
	height:23px;
}

-->

</style>

<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<form name="listForm" action="<c:url value='/sym/ccm/EgovCcmZipSearchList.do'/>" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
    <input name="searchCondition" type="hidden" size="35" value="4" /> 

<table width="510" height="300" cellpadding="0" cellspacing="0" class="tbox">
	<tr>
		<td valign="top" align="center">
			<table width="500" border="0" cellpadding="0" cellspacing="0">
            	<tr>
             	  <td height="15">&nbsp;</td>
            	</tr>
             	<tr>
             	  <td height="40" valign="top" class="title"><img src="<c:url value='/' />images/sr/bullet_arrow.gif" width="13" height="13" align="absmiddle" /> 우편번호찾기</td>
            	  </tr>
            	    <tr>
            	      <td colspan="2" bgcolor="#0257a6" height="2"></td>
            	    </tr>
            	    <tr>
            	      <td class="tdblue" width="35%">
            	      도로명주소 또는 지번주소<br>
            	      <a href="javascript:fCallUrl('http://www.juso.go.kr/');">http://www.juso.go.kr/</a>
            	      </td>
            	      <td class="tdleft" width="65%">
            	      	<input name="searchKeyword" type="text" size="30" value="${searchVO.searchKeyword}"  maxlength="30" title="동명"/> 
            	      	<span class="btnblue"><a href="javascript:fn_egov_search_Zip();"><spring:message code='button.search'/> ▶</a></span>
            	      </td>
            	    </tr>
            	    <tr>
            	      <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
            	    </tr>
          	    </table>
		</td>
	</tr>
	<tr>
		<td align="center">
		
			<div class="list3">
			
				<table width="500" border="0" cellpadding="0" cellspacing="0">
				<thead>
				<tr>
		        	  <td colspan="2" bgcolor="#0257a6" height="2"></td>
		       	  </tr>
				<tr class="tdgrey">
					<th width="25%" scope="col" nowrap="nowrap">우편번호</th>
					<th width="75%" scope="col" nowrap="nowrap">주소</th>
				</tr>
				<tr>
	        	  <td colspan="2" bgcolor="#717171" height="1"></td>
	       	  </tr>
				</thead>    
				<tbody>
				<tr>
	        	  <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
	       	    </tr>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_return_Zip( '${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}  ${resultInfo.loadNm} ${resultInfo.lnbrDongHo}');">
					<td class="tdwc" nowrap="nowrap" ><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
					<td class="tdwc" nowrap="nowrap" >
					<%-- 	<c:out value='${resultInfo.address}'/> --%>
					   	${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}  ${resultInfo.loadNm} ${resultInfo.lnbrDongHo}
					  	<c:if test="${resultInfo.lnbrDongHoOld != NULL && resultInfo.liBuldNmOld != NULL}">
					  		(${resultInfo.lnbrDongHoOld}, ${resultInfo.liBuldNmOld})
					  	</c:if>
					  	<c:if test="${resultInfo.lnbrDongHoOld != NULL && resultInfo.liBuldNmOld == NULL}">
					  		(${resultInfo.lnbrDongHoOld})
					  	</c:if>
					  	<c:if test="${resultInfo.lnbrDongHoOld == NULL && resultInfo.liBuldNmOld != NULL}">
					  		(${resultInfo.liBuldNmOld})
					  	</c:if>
					</td>
				</tr>   
				<tr>
	        	  <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
	       	    </tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
                     <tr> 
                         <td class="tdwc" nowrap="nowrap" colspan=3>
                             <spring:message code="common.nodata.msg" />
                         </td>
                     </tr>  
                     <tr>
		        	  <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
		       	    </tr>                                            
                 </c:if>
				    	
				</tbody>  
				</table>
				
				<table width="400" border="0" cellpadding="0" cellspacing="0">
			        	<tr>
			        	  <td height="30"></td>
			      	  </tr>
			        	<tr>
			        	  <td align="center";>
							<!-- 페이지 네비게이션 시작 -->
			                <div id="paging_div">
			                    <ul class="paging_align">
							        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 -->  			                
			        	  </td>
			      	  </tr>
			      	  <tr>
					 	  <td height="50" valign="bottom" align="center"><span class="btnblue"><a href="#LINK" onclick="javascript:window.close(); return false;">닫기 ▶</a></span></td>
					  </tr>
			        </table>
				
			</div>
		
		</td>
	</tr>
</table>
 

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
</body>
</html>


