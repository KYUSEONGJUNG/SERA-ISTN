<%--
  Class Name : EgovCcmZipDetail.jsp
  Description : EgovCcmZipDetail 화면
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

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>우편번호 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<!-- <link type="text/css" rel="stylesheet" href="/css/com.css"> -->
<link href="<c:url value='/css/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Zip(){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipModify.do'/>";
    varForm.zip.value        = "${result.zip}";
    varForm.sn.value         = "${result.sn}";
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Zip(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipRemove.do'/>";
        varForm.zip.value        = "${result.zip}";
        varForm.sn.value         = "${result.sn}";
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
<!--                             <li><strong>우편번호관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 코드관리 > 우편번호관리 > 상세조회</li>
			        </ul>
			    </div>	
			    
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>우편번호 상세조회</strong></h2></div> -->
<!--                 </div> -->
				<form name="Form" method="post" action="<c:url value='/sym/ccm/zip/EgovCcmZipModify.do'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible"/>
				    <input type="hidden" name="zip">
				    <input type="hidden" name="sn">
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="우편번호, 시도명, 시군구명, 읍면동명, 리건물명, 번지동호를 가지고 있는 우편번호 상세조회 테이블이다.">
						  <tr>
						    <td colspan="2" bgcolor="#0257a6" height="2"></td>
						  </tr>
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >우편번호<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td><c:out value='${fn:substring(result.zip, 0,3)}'/>-<c:out value='${fn:substring(result.zip, 3,6)}'/></td>
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >시도명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td>${result.ctprvnNm}</td>    
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						   
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >시군구명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td>${result.signguNm}</td>    
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >읍면동명</th>          
						    <td>${result.emdNm}</td>    
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >리건물명</th>          
						    <td>${result.liBuldNm}</td>    
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >도로명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <td>${result.loadNm}</td>    
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >번지동호</th>          
						    <td>${result.lnbrDongHo}</td>    
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >리건물명(구)</th>          
						    <td>${result.liBuldNmOld}</td>    
						  </tr> 
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >번지동호(구)</th>          
						    <td>${result.lnbrDongHoOld}</td>    
						  </tr>
						  
						  <tr>
						    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
						  </tr>
						  
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_modify_Zip(); return false;"><spring:message code="button.update" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_delete_Zip(); return false;"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="fn_egov_list_Zip(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 --> 
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td> -->
<%--                             <a href="#LINK" onclick="fn_egov_modify_Zip(); return false;"><spring:message code="button.update" /></a>  --%>
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<%--                             <a href="#LINK" onclick="fn_egov_delete_Zip(); return false;"><spring:message code="button.delete" /></a>  --%>
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="fn_egov_list_Zip(); return false;">목록</a> -->
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="codeId" type="hidden">
                    
                    <input name="searchZip" type="hidden" value="<c:out value='${searchVO.searchZip}'/>"/>  
                    <input name="searchCtprvnNm" type="hidden" value="<c:out value='${searchVO.searchCtprvnNm}'/>"/>  
                    <input name="searchSignguNm" type="hidden" value="<c:out value='${searchVO.searchSignguNm}'/>"/>  
                    <input name="searchEmdNm" type="hidden" value="<c:out value='${searchVO.searchEmdNm}'/>"/>  
                    <input name="searchLiBuldNm" type="hidden" value="<c:out value='${searchVO.searchLiBuldNm}'/>"/>  
                    <input name="searchLoadNm" type="hidden" value="<c:out value='${searchVO.searchLoadNm}'/>"/>  
                    <input name="searchLnbrDongHo" type="hidden" value="<c:out value='${searchVO.searchLnbrDongHo}'/>"/>  
                    <input name="searchLiBuldNmOld" type="hidden" value="<c:out value='${searchVO.searchLiBuldNmOld}'/>"/>  
                    <input name="searchLnbrDongHoOld" type="hidden" value="<c:out value='${searchVO.searchLnbrDongHoOld}'/>"/>                     
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

