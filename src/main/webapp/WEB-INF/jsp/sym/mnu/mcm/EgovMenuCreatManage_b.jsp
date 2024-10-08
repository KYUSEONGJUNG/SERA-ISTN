<%--
  Class Name : EgovMenuCreatManage.jsp
  Description : 메뉴생성관리 조회 화면
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
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>메뉴권한관리</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javaScript">
<!--
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){ 
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.menuCreatManageForm.pageIndex.value = pageNo;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() { 
    document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat_bak(vAuthorCode) {
    document.menuCreatManageForm.authorCode.value = vAuthorCode;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
    window.open("#", "_menuCreat", "scrollbars = yes, top=100px, left=100px, height=700px, width=850px");    
    document.menuCreatManageForm.target = "_menuCreat";
    document.menuCreatManageForm.submit();  
}

function selectMenuCreat(vAuthorCode){
	var url = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode="+vAuthorCode;
	var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=850,height=700,left=0,top=0";
	window.open(url,"_menuCreat", openParam);
}       

<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
//-->
</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>        
    <!-- //header 끝 --> 
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
            <form name="menuCreatManageForm" action ="<c:url value='/sym/mpm/EgovMenuCreatManageSelect.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>메뉴관리</li>
                            <li>&gt;</li>
                            <li><strong>메뉴권한관리</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 메뉴목록관리 > 메뉴 등록</li>
			        </ul>
			    </div>	
			    
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>메뉴권한관리</strong></h2></div>
					
						<input name="checkedMenuNoForDel" type="hidden" />
						<input name="authorCode"          type="hidden" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="searchAuthorCode">권한코드 : </label>
                                    <input name="searchAuthorCode" type="text" size="40" value="<c:out value='${searchVO.searchAuthorCode}'/>"  maxlength="60" title="검색조건"/>                                    
                                    <br>
                                    <label for="searchAuthorNm">권한명 &nbsp;&nbsp;&nbsp;: </label>
                                    <input name="searchAuthorNm" type="text" size="40" value="<c:out value='${searchVO.searchAuthorNm}'/>"  maxlength="60" title="검색조건"/> 
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="javascript:selectMenuCreatManageList(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="list3">
                    <table summary="메뉴생성관리  목록화면으로 권한코드, 권한명, 권한설명, 메뉴생성여부, 메뉴생성으로 구성됨" cellpadding="0" cellspacing="0">
<%--                     <caption>메뉴생성관리 목록</caption> --%>
                    <colgroup>
                    <col width="20%" >
                    <col width="20%" >  
                    <col width="20%" >
                    <col width="20%" >
                    <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="5" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">권한코드</th>
                        <th scope="col" nowrap="nowrap">권한명</th>
                        <th scope="col" nowrap="nowrap">권한설명</th>
                        <th scope="col" nowrap="nowrap">권한설정여부</th>
                        <th scope="col" nowrap="nowrap">권한설정</th>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${list_menumanage}" varStatus="status">
                    <!-- loop 시작 -->   
                      <c:if test="${result.authorCode != 'ROLE_ANONYMOUS'}">    
	                      <tr>
						    <td nowrap="nowrap"  class="tdwc"><c:out value="${result.authorCode}"/></td>
						    <td nowrap="nowrap"  class="tdwc"><c:out value="${result.authorNm}"/></td>
						    <td nowrap="nowrap"  class="tdwc"><c:out value="${result.authorDc}"/></td>
						    <td nowrap="nowrap"  class="tdwc">
						          <c:if test="${result.chkYeoBu > 0}">Y</c:if>
						          <c:if test="${result.chkYeoBu == 0}">N</c:if>
						    </td>
						    <td nowrap="nowrap" class="tdwc">
	                            <a href="<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode='<c:out value="${result.authorCode}"/>'"  onclick="selectMenuCreat('<c:out value="${result.authorCode}"/>'); return false;">설정</a>
						    </td>
	                      </tr>
	                      <tr>
						    <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                      </c:if>                         
                     </c:forEach>     
                     <c:if test="${fn:length(list_menumanage) == 0}">
                      <tr>
                        <td nowrap colspan="5"><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  

                <input type="hidden" name="req_menuNo">
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