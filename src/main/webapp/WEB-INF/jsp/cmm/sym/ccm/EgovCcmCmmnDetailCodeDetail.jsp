<%--
  Class Name : EgovCcmCmmnDetailCodeDetail.jsp
  Description : EgovCcmCmmnDetailCodeDetail 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>공통상세코드 상세조회</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnList_bak(){
    location.href = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>";
}
function fncSelectList() {
	var varForm              = document.all["Form"];
	varForm.action = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>";
	varForm.submit();       
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do'/>";
    varForm.codeId.value     = "${result.codeId}";
    varForm.code.value       = "${result.code}";
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeRemove.do'/>";
        varForm.codeId.value     = "${result.codeId}";
        varForm.code.value       = "${result.code}";
        varForm.submit();
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
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>상세코드관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 상세코드관리 > 상세코드관리 상세조회</li>
			        </ul>
			    </div>	
                
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>상세코드관리 상세조회</strong></h2></div> -->
<!--                 </div> -->

                <form name="Form" method="post" action="<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>">
                    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <input type="submit" id="invisible" class="invisible"/>
				    <input type="hidden" name="codeId">
				    <input type="hidden" name="code">

                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="코드명, 코드, 코드명, 코드설명, 사용여부가 나타나 있는 공통상세코드 상세조회 테이블이다.">
						  <tr>
				              <td colspan="2" bgcolor="#0257a6" height="2"></td>
				            </tr>
                          <tr> 
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드ID<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>${result.codeId}</td>
						  </tr>
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드ID명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>${result.codeIdNm}</td>
						  </tr>
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td>${result.code}</td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td>${result.codeNm}</td>    
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
				          <c:if test="${result.codeId == 'SR0003' || result.codeId == 'SR0005'}">				          
				          
					          <tr>
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드명 영어</th>          
							    <td>${result.codeNmEn}</td>    
							  </tr> 
							  
							  <tr>
					              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
					          </tr> 
					          
					          <tr>
							    <th width="20%" height="23" class="tdblue" scope="row" nowrap >코드명 중국어</th>          
							    <td>${result.codeNmCn}</td>    
							  </tr> 
							  
							  <tr>
					              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
					          </tr> 
				          
				          </c:if>
				          
						  <tr> 
						    <th height="23" class="tdblue" scope="row" ><label for="codeDc">코드설명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td><textarea class="textarea"  cols="100" rows="5" disabled="disabled" id="codeIdDc">${result.codeDc}</textarea></td>
						  </tr> 
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="useAt">사용여부</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td>
						        <select name="useAt" id="useAt" disabled id="useAt">
						            <option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
						            <option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>               
						        </select>
						    </td>    
						  </tr>  
						  
						  <tr>
				              <td colspan="2" bgcolor="#dcdcdc" height="1"></td>
				          </tr> 
				             
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="fnModify(); return false;"><spring:message code="button.update" /> ▶</a></span>&nbsp;
                    	<c:if test="${result.useAt == 'Y'}"> 
	                    	<span class="btnblue"><a href="#LINK" onclick="fnDelete(); return false;"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
                    	</c:if>
                    	<span class="btnblue"><a href="#LINK" onclick="fncSelectList(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 --> 
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fnModify(); return false;">수정</a> -->
<!--                           </td> -->
<%--                           <c:if test="${result.useAt == 'Y'}">  --%>
<!-- 	                          <td width="10"></td> -->
<!-- 	                          <td> -->
<!-- 	                            <a href="#LINK" onclick="fnDelete(); return false;">삭제</a>  -->
<!-- 	                          </td> -->
<%--                           </c:if> --%>
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fncSelectList(); return false;">목록</a> -->
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value=""/>
                    
                    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				    <input name="searchCodeId" type="hidden" value="<c:out value='${searchVO.searchCodeId}'/>"/>
				    <input name="searchCode" type="hidden" value="<c:out value='${searchVO.searchCode}'/>"/>
					<input name="searchCodeIdNm" type="hidden" value="<c:out value='${searchVO.searchCodeIdNm}'/>"/>
                    <!-- 검색조건 유지 -->
                </form>

            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

