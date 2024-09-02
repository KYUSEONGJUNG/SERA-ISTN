<%--
  Class Name : EgovPstinstList.jsp
  Description : EgovPstinstList 화면
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

<title>고객사 목록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/pstinst/EgovPstinstList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
// function fn_egov_search_Pstinst(){
//     sC = document.listForm.searchCondition.value;
//     sK = document.listForm.searchKeyword.value; 
//     if (sC == "1") {
//         document.listForm.searchKeyword.value = sK.replace(/\-/, "");
//     }
//     document.listForm.pageIndex.value = 1;
//     document.listForm.submit();
// }
function fn_egov_search_Pstinst(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Pstinst(){
    location.href = "<c:url value='/psinst/EgovPsinstInsertView.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Pstinst(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Pstinst(pstinstCode){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/pstinst/EgovPstinstSelectUpdtView.do'/>";
    varForm.pstinstCode.value        = pstinstCode;
    varForm.submit();
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
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
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
            <form name="listForm" action="<c:url value='/pstinst/EgovPstinstList.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>기반관리</li>
                            <li>&gt;</li>
                            <li><strong>고객사관리</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>고객사 목록</strong></h2></div>
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="searchPstinstNm">고객사명 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label>
                                    <input name="searchPstinstNm" type="text" size="30" value="<c:out value='${searchVO.searchPstinstNm}'/>"  maxlength="30" id="F1" title="검색조건">
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="fn_egov_search_Pstinst(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                                        <a href="#LINK" onclick="fn_egov_regist_Pstinst(); return false;">등록</a>
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >                    
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="고객사와 주소를 출력하는 고객사 목록 테이블이다." cellpadding="0" cellspacing="0">
<%--                     <caption>공통코드 목록</caption> --%>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="70%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="13" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">고객사명</th>
                        <th scope="col" nowrap="nowrap">주소</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_detail_Pstinst('${resultInfo.pstinstCode}');">
						    <td class="lt_text3" nowrap="nowrap"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
						    <td class="lt_text3" nowrap="nowrap"><c:out value='${resultInfo.name}'/></td>
						    <td class="lt_text"  nowrap="nowrap">
						    	<c:out value='${resultInfo.address1}'/> <c:out value='${resultInfo.address2}'/>
						    </td>
						</tr>   
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                            <td colspan=3>
                                <spring:message code="common.nodata.msg" />
                            </td>
                        </tr>                                              
                    </c:if>
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
				        <ui:pagination paginationInfo = "${paginationInfo}"
				                type="image"
				                jsFunction="linkPage"
				                />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>

			<form name="Form" method="post" action="<c:url value='/pstinst/EgovPstinstSelectUpdt.do'/>">
			    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			    <input type="hidden" name="pstinstCode">			    
			    <input type="submit" id="invisible" class="invisible"/>
			    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
			    <input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>"/>		    
			</form>

            </div>
            <!-- //content 끝 -->    
        </div>  
        <!-- //container 끝 -->
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>