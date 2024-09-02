<%--
  Class Name : EgovProgramListRegist.jsp
  Description : 프로그램목록 등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>프로그램목록등록</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<validator:javascript formName="progrmManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 입력 처리 함수
 ******************************************************** */
function insertProgramListManage(form) {
    if(confirm("<spring:message code="common.save.msg" />")){
        if(!validateProgrmManageVO(form)){          
            return;
        }else{
            form.action="<c:url value='/sym/prm/EgovProgramListRegist.do'/>";
            form.submit();
        }
    }
}
/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList(){
    location.href = "<c:url value='/sym/prm/EgovProgramListManageSelect.do' />";
}

/* ********************************************************
 * focus 시작점 지정함수
 ******************************************************** */
 function fn_FocusStart(){
        var objFocus = document.getElementById('F1');
        objFocus.focus();
    }

 
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
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
<!--                             <li>내부시스템관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>메뉴관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>프로그램목록관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 프로그램목록관리 > 프로그램목록 등록</li>
			        </ul>
			   </div>	
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>프로그램목록 등록</strong></h2></div> -->
<!--                 </div> -->
                <form:form commandName="progrmManageVO"  action="${pageContext.request.contextPath}/sym/prm/EgovProgramListRegist.do" method="post" >
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="프로그램목록 등록">
                          <tr>
				              <td colspan="4" bgcolor="#0257a6" height="2"></td>
				            </tr>
                          <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmFileNm">프로그램파일명</label>
                            <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      &nbsp; 
						      <form:input path="progrmFileNm" size="50"  maxlength="50" id="F1" title="프로그램파일명"/>
						      <form:errors path="progrmFileNm" />
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				            
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmStrePath">저장경로</label>
                            <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      &nbsp; <form:input path="progrmStrePath"  size="60"   maxlength="60" title="저장경로"/> 
						      <form:errors path="progrmStrePath" />
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmKoreanNm">프로그램 한글명</label>
                            <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      &nbsp; <form:input path="progrmKoreanNm" size="60"  maxlength="50" title="프로그램 한글명"/> 
						      <form:errors path="progrmKoreanNm"/>
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="URL">URL</label>
                            <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      &nbsp; <form:input path="URL" size="60"    maxlength="60" title="URL"/> 
						      <form:errors path="URL"/>
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th height="23" class="tdblue" scope="row"><label for="progrmDc">프로그램설명</label></th>
						    <td>&nbsp;
						      <form:textarea path="progrmDc" rows="14" cols="75" cssClass="txaClass" title="프로그램설명"/>
						      <form:errors path="progrmDc"/>
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>" onclick="selectList(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:insertProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 -->  
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         목록/저장버튼  -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<%--                             <a href="<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>" onclick="selectList(); return false;"><spring:message code="button.list" /></a>  --%>
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<%--                             <a href="#LINK" onclick="javascript:insertProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.save" /></a>  --%>
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='insert'/>"/>
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

