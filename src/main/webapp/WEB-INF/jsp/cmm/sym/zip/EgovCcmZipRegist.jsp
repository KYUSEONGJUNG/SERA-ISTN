<%--
  Class Name : EgovCcmZipRegist.jsp
  Description : EgovCcmZipRegist 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>우편번호 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="zip" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
/* ********************************************************
 * 등록처리
 ******************************************************** */
function fn_egov_regist_Zip(form){
    if(confirm("<spring:message code='common.save.msg'/>")){
        if(!validateZip(form)){             
            return;
        }else{
            form.submit();
        }
    }
}
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
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>우편번호관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 코드관리 > 우편번호관리 > 우편번호 등록</li>
			        </ul>
			    </div>	
			    
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>우편번호 등록</strong></h2></div> -->
<!--                 </div> -->
                <form:form commandName="zip" name="zip" method="post">
                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="우편번호, 시도명, 시군구명, 읍면동명, 리건물명, 번지동호를 입력하는 우편번호 등록 테이블입니다.">
						  <tr>
						    <td colspan="2" bgcolor="#0257a6" height="2"></td>
						  </tr>
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="zip">우편번호</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <input type="text" id="zip" name="zip" size="6" maxlength="6" />
						      <form:errors path="zip"/> &nbsp;* 우편번호의 '-'를 제외하고 입력하시오.
						    </td>
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="ctprvnNm">시도명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="ctprvnNm" size="20" maxlength="20" id="ctprvnNm"/>
						      <form:errors path="ctprvnNm"/>
						    </td>
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="signguNm">시군구명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="signguNm" size="20" maxlength="20" id="signguNm"/>
						      <form:errors path="signguNm"/>
						    </td>
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="emdNm">읍면동명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="emdNm" size="30" maxlength="30" id="emdNm"/>
						      <form:errors path="emdNm"/>
						    </td>
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="liBuldNm">리건물명</label></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="liBuldNm" size="60" maxlength="60" id="liBuldNm"/>
						      <form:errors path="liBuldNm"/>
						    </td>
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="loadNm">도로명</label></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="loadNm" size="60" maxlength="60" id="loadNm"/>
						      <form:errors path="loadNm"/>
						    </td>
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="lnbrDongHo">번지동호</label></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="lnbrDongHo" size="20" maxlength="20" id="lnbrDongHo"/>
						      <form:errors path="lnbrDongHo"/>
						    </td>    
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						   
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="liBuldNmOld">리건물명(구)</label></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="liBuldNmOld" size="60" maxlength="60" id="liBuldNmOld"/>
						      <form:errors path="liBuldNmOld"/>
						    </td>
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="lnbrDongHoOld">번지동호(구)</label></th>          
						    <td width="80%" nowrap="nowrap" class="tdleft">
						      <form:input  path="lnbrDongHoOld" size="20" maxlength="20" id="lnbrDongHoOld"/>
						      <form:errors path="lnbrDongHoOld"/>
						    </td>    
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_Zip(document.zip); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_list_Zip(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 --> 
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_list_Zip(); return false;">목록</a> -->
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<%--                             <a href="#LINK" onclick="fn_egov_regist_Zip(document.zip); return false;"><spring:message code="button.save" /></a>  --%>
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='save'/>"/>
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

