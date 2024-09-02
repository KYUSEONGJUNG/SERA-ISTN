<%--
  Class Name : EgovPstinstSearchList.jsp
  Description : EgovPstinstSearchList 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2014.02.27   박원배              최초 생성
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/zip.css'/>">
<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
<title><spring:message code='button.searchCharge'/></title>
<script type="text/javaScript" language="JavaScript">
<!--
	/* ********************************************************
	 * 페이징 처리 함수
	 ******************************************************** */
	function linkPage(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/pstinst/EgovPstinstSearchList.do'/>";
		document.listForm.submit();
	}
	/* ********************************************************
	 * 조회 처리 
	 ******************************************************** */
	function fn_egov_search_Pstinst() {
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	/* ********************************************************
	 * 결과 고객사코드, 고객사명 반환 
	 ******************************************************** */
	function fn_egov_return_Pstinst(pstinstCode, pstinstNm) {
		var retVal = new Object();
		var sPstinstCode = pstinstCode;
		var sPstinstNm = pstinstNm;
		retVal.sPstinstCode = sPstinstCode;
		retVal.sPstinstNm = sPstinstNm;
		// 	alert('pstinstCode : ' + retVal.sPstinstCode);
		// 	alert('sName : ' + retVal.sName);
		parent.window.returnValue = retVal;
		parent.window.close();
	}
//-->
</script>
</head>

<style type="text/css">
<!--
body {
	font-family: '맑은고딕', Malgun Gothic, Helvetica, sans-serif !important;
	font-size: 12px;
	color: #666;
	letter-spacing: -1px;
	line-height: 1.2;
}

body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,button,form,fieldset,p,blockquote
	{
	margin: 0;
	padding: 0;
}

input:checked[type="checkbox"] {
	background-color: #fff;
	-webkit-appearance: checkbox;
}

input[type=text] {
	border: 1px solid #b3b3b3;
	height: 19px;
	padding-left: 5px;
	font-family: '맑은고딕', Malgun Gothic, Helvetica, sans-serif !important;
	font-size: 12px;
	color: #666;
}

input[type=password] {
	border: 1px solid #b3b3b3;
	height: 19px;
	padding-left: 5px;
	font-family: '맑은고딕', Malgun Gothic, Helvetica, sans-serif !important;
	font-size: 12px;
	color: #666;
}

label {
	vertical-align: -1px
}

.input_chk {
	width: 13px;
	height: 13px;
	vertical-align: text-top
}

select {
	font-family: '맑은고딕', Malgun Gothic, Helvetica, sans-serif !important;
	font-size: 12px;
	color: #666;
}

a {
	text-decoration: none;
	color: #666;
}

a:focus,a:active {
	text-decoration: none;
	color: #666;
}

a:hover {
	text-decoration: none;
	color: #2069b3;
	font-weight: bold;
}

.tbox {
	border: 5px solid #246593;
	border-collapse: collapse;
}

.title {
	font-family: '맑은고딕', Malgun Gothic;
	font-size: 16px;
	font-weight: bold;
	color: #000;
}

.tdblue {
	width: 110px;
	height: 30px;
	color: #000;
	background: #edf5f8;
	text-align: center;
	font-weight: bold;
}

.tdleft {
	text-align: left;
	padding-left: 10px;
	padding-top: 5px;
}

/*기본버튼*/
span.btnblue {
	display: inline-block;
	padding-left: 5px;
	background: url(../../../isprintSr/images/sr/img_btnbg.gif) no-repeat;
	background-position: left top;
}

span.btnblue button,span.btnblue input {
	display: inline-block;
	height: 27px;
	padding: 0 5px 0 6px;
	border: none;
	cursor: pointer;
	background: url(../../../isprintSr/images/sr/img_btnbg.gif) no-repeat;
	background-position: right top;
}

span.btnblue a {
	display: inline-block;
	height: 27px;
	padding: 6px 6px 0 10px;
	padding-right: 15px;
	border: none;
	font-size: 11px;
	color: #fff;
	font-weight: bold;
	background: url(../../../isprintSr/images/sr/img_btnbg.gif) no-repeat;
	background-position: right top;
}

#paging_div {
	clear: both;
	position: relative;
	width: 650px;
}

#paging_div .paging_align {
	clear: both;
	margin: 0 auto;
	padding-top: 16px;
	text-align: center;
	width: 650px;
}

.paging_align .first {
	border: medium none;
	padding: 0px;
}

.paging_align li {
	display: inline;
	border-right: 1px solid #dddddd;
	padding-left: 3px;
	padding-right: 10px;
	vertical-align: middle;
}

.paging_align li a {
	color: #666666;
}

.paging_align li a:hover {
	color: #0958A5;
	font-weight: bold;
}

.paging_align a:active {
	color: #0958A5;
}

.paging_align a:visited {
	color: #0958A5;
}

.list3 {
	padding-top: 10px;
}

.tdgrey {
	color: #000;
	background: #f0f0f0;
	text-align: center;
	font-weight: bold;
	height: 30px;
	line-height: 14px;
}

.tdwc {
	text-align: center;
	height: 23px;
}
.tdwl {
	text-align: left;
	height: 23px;
}
-->
</style>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>


<table width="650" height="350" cellpadding="0" cellspacing="0" class="tbox" >
	<tr>
		<td valign="top" align="center">
			<table width="600" border="0" cellpadding="0" cellspacing="0">
            	<tr>
             	  <td height="15">&nbsp;</td>
            	</tr>
             	<tr>
             	  <td height="15" valign="top" class="title">
             	  	<img src="<c:url value='/' />images/sr/bullet_arrow.gif" width="13" height="13" align="absmiddle" /> <spring:message code='button.searchCharge'/>             	  	
             	  </td>
            	  </tr>
          	    </table>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top">
		
			<div class="list3">
			
				<table width="600" border="0" cellpadding="0" cellspacing="0">
				<thead>
				<tr>
		        	  <td colspan="8" bgcolor="#0257a6" height="2"></td>
		       	  </tr>
				<tr class="tdgrey">
					<th width="6%" scope="col" nowrap="nowrap"><spring:message code='sr.module'/></th>
					<th width="10%" scope="col" nowrap="nowrap"><spring:message code='cop.mainCharge'/></th>
					<th width="18%" scope="col" nowrap="nowrap"><spring:message code='cop.mbtlNum'/></th>
					<th width="18%" scope="col" nowrap="nowrap"><spring:message code='cop.emailAdres'/></th>
					<th width="2%" scope="col" nowrap="nowrap">&nbsp;</th>
					<th width="10%" scope="col" nowrap="nowrap"><spring:message code='cop.subCharge'/></th>
					<th width="18%" scope="col" nowrap="nowrap"><spring:message code='cop.mbtlNum'/></th>
					<th width="18%" scope="col" nowrap="nowrap"><spring:message code='cop.emailAdres'/></th>
				</tr>
				<tr>
	        	  <td colspan="8" bgcolor="#717171" height="1"></td>
	       	  </tr>
				</thead>    
				<tbody>
				<tr>
	        	  <td colspan="8" bgcolor="#cdcdcd" height="1"></td>
	       	    </tr>
	       	    
	       	    
	       	    
	       	    <c:choose>
				<c:when test="${!empty srchargerList}">
					<c:forEach var="list" items="${srchargerList}" varStatus="status">
						<tr id="rowTr${trIdValue}">
							<td class="tdwc">
								<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
									<c:if test="${result.code == list.moduleCode}">
<%-- 										<c:out value="${result.codeNm}" /> --%>
							  				<c:choose>
							  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.codeNm}"/></c:when>
							  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.codeNmEn}"/></c:when>
							  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.codeNmCn}"/></c:when>
							  					<c:otherwise><c:out value="${result.codeNm}"/></c:otherwise>
							  				</c:choose>										
									</c:if>
								</c:forEach>
							</td>
							<td class="tdwc">
								<c:forEach var="result" items="${chargerList}" varStatus="status">
									<c:if test="${result.userId == list.userIdA}">
<%-- 										<c:out value="${result.userNm}" /> --%>
						  				<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value='${result.userNm}'/></c:when>
						  					<c:otherwise><c:out value='${result.userNmEn}'/></c:otherwise>
						  				</c:choose> 										
									</c:if>
								</c:forEach>
							</td>
							<td class="tdwc"><c:out value="${list.mbtlnumA}" /></td>
							<td class="tdwc"><c:out value="${list.emailAdresA}" /></td>
							<td class="tdwc">&nbsp;</td>
							
							<td class="tdwc">
								<c:forEach var="result" items="${chargerList}" varStatus="status">
									<c:if test="${result.userId == list.userIdB}">
<%-- 										<c:out value="${result.userNm}" /> --%>
						  				<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value='${result.userNm}'/></c:when>
						  					<c:otherwise><c:out value='${result.userNmEn}'/></c:otherwise>
						  				</c:choose> 
									</c:if>
								</c:forEach>
							</td>
							<td class="tdwc"><c:out value="${list.mbtlnumB}" /></td>
							<td class="tdwc"><c:out value="${list.emailAdresB}" /></td>
						</tr>
						<tr>
			        	  <td colspan="8" bgcolor="#cdcdcd" height="1"></td>
			       	    </tr> 
					</c:forEach>
				</c:when>
			</c:choose>

				<c:if test="${fn:length(srchargerList) == 0}">
                     <tr> 
                         <td class="tdwc" nowrap="nowrap" colspan=8>
                             <spring:message code="common.noModuleCharger.msg" />
                         </td>
                     </tr>  
                     <tr>
		        	  <td colspan="8" bgcolor="#cdcdcd" height="1"></td>
		       	    </tr>                                            
                 </c:if>
				    	
				</tbody>  
				</table>
				
				<table width="620" border="0" cellpadding="0" cellspacing="0">
				<tr>
	             	  <td height="20">&nbsp;</td>
	            	</tr>
            	  <tr>
	             	  <td height="20">
						※ 비상연락 순서: 모듈 주담당자 -> 부담당자 -> 팀장 (김은수이사: 010-5447-5136) -> 부문장 (정용길전무: 010-2261-2824)
	             	  </td>
            	  </tr>
		        	<tr>
		        	  <td height="5"></td>
		      	  </tr>
		        	<tr>
				 	  <td height="40" valign="bottom" align="center"><span class="btnblue"><a href="#LINK" onclick="javascript:window.close(); return false;"><spring:message code='button.close'/> ▶</a></span></td>
				  </tr>
		        </table>
				
			</div>
		
			
		</td>
	</tr>
</table>


</body>
</html>


