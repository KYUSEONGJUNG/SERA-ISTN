<%--
  Class Name : EgovIncTopnav.jsp
  Description : 상단메뉴화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- topmenu start -->
<script type="text/javascript" src="<c:url value="/js/EgovMainMenu.js"/>"/></script>
<script type="text/javascript">
<!--
    function getLastLink(baseMenuNo){
    	var tNode = new Array;
        for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
            tNode[i] = document.menuListForm.tmp_menuNm[i].value;
            var nValue = tNode[i].split("|");
            //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
            if (nValue[1]==baseMenuNo) {
                if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                    //링크정보가 있으면 링크정보를 리턴한다.
                    return nValue[5];
                }else{
                    //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                    return getLastLink(nValue[0]);
                }
            }
        }
    }
	function getLastSelMenu(baseMenuNo){
		var tNode = new Array;
	    for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
	        tNode[i] = document.menuListForm.tmp_menuNm[i].value;
	        var nValue = tNode[i].split("|");
	        //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
	        if (nValue[1]==baseMenuNo) {
	        	return nValue[0];
	        }
	    }
	}
    function goMenuPage(baseMenuNo){
    	
    	document.getElementById("baseMenuNo").value=baseMenuNo;
    	document.getElementById("link").value="forward:"+getLastLink(baseMenuNo);
    	document.menuListForm.selMenuNo.value=getLastSelMenu(baseMenuNo);
        //document.menuListForm.chkURL.value=url;
//         alert(" baseMenuNo :  " + document.getElementById("baseMenuNo").value);
//         alert(" selMenuNo :  " + document.menuListForm.selMenuNo.value);
        document.menuListForm.action = "<c:url value='/EgovPageLink.do'/>";
        document.menuListForm.submit();
    }
    function actionLogout()
    {
        document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
        document.selectOne.submit();
        //document.location.href = "<c:url value='/j_spring_security_logout'/>";
    }
    
    /* ********************************************************
     * 상세내역조회 함수
     ******************************************************** */
    function fn_MovePage(nodeNum, tmp_menuNm) {
//     	alert("nodeNum : " + nodeNum);
//     	alert("tmp_menuNm : " + tmp_menuNm);
        var nodeValues = tmp_menuNm.split("|");
        //parent.main_right.location.href = nodeValues[5];
        document.menuListForm.action = "${pageContext.request.contextPath}"+nodeValues[5];
        //alert(document.menuListForm.action);
        document.menuListForm.selMenuNo.value = nodeValues[0];
        document.menuListForm.submit();
    }
    /* ********************************************************
     * 메뉴 호출 함수
     ******************************************************** */
    function fCallUrl(url) {

    	window.open(url,'dokdo','width=800,height=600,menubar=no,toolbar=no,location=no,resizable=no,status=no,scrollbars=no,top=300,left=700');
    }    
//-->
</script>
<div class="navigation">

<%-- <c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' --%>
<%--  || authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}"> --%>

<%-- </c:if> --%>
<!-- 시스템관리자 -->
<c:if test="${authorCode == 'ROLE_ADMIN'}">
	
	<ul class="navi8">
		<c:forEach var="result" items="${list_headmenu}" varStatus="status">
			<li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>
			<li><img src="<c:url value='/' />images/sr/img_navbar.gif" /></li>
		</c:forEach>
	</ul>
</c:if>

<!-- 고객-현업 및 고객-결재자 -->
<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_COOPERATION'}">
	<ul class="navi3">
		<c:forEach var="result" items="${list_headmenu}" varStatus="status">
			<li>
				<a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')">
<%-- 					<c:out value="${result.menuNm}"/> --%>
	  				<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.menuNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.menuNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.menuNmCn}"/></c:when>
	  				</c:choose>   
				</a>
			</li>
			<li><img src="<c:url value='/' />images/sr/img_navbar.gif" /></li>
		</c:forEach>
	</ul>
</c:if>

<!-- SR-관리자 및 SR-담당자 -->
<c:if test="${authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
	<ul class="navi4">
		<c:forEach var="result" items="${list_headmenu}" varStatus="status">
			<li <c:if test="${result.menuNo == baseMenuNo}">style="background:#133c67;"</c:if> ><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>
			<li><img src="<c:url value='/' />images/sr/img_navbar.gif" /></li>
		</c:forEach>
	</ul>
</c:if>

</div>
<form name="menuListForm" action ="/sym/mnu/mpm/EgovMenuListSelect.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
<%
if("1000000".equals(session.getAttribute("baseMenuNo"))){ 		//SR리스트
	
%>
	<div class="naviSub01">
<%
}else if("2000000".equals(session.getAttribute("baseMenuNo"))){ 	//통계
%>
	<div class="naviSub02">
<%
}else if("3000000".equals(session.getAttribute("baseMenuNo"))){ 	//커뮤니티
%>
	<div class="naviSub03">
<%
}else if("4000000".equals(session.getAttribute("baseMenuNo"))){ 	//기반관리
%>
<!-- SR-담당자 -->
<c:if test="${authorCode == 'ROLE_CHARGER'}">
	<div class="naviSub09">
</c:if>
<c:if test="${authorCode != 'ROLE_CHARGER'}">
	<div class="naviSub04">
</c:if>
<%
}else if("5000000".equals(session.getAttribute("baseMenuNo"))){ //사용자관리
%>
	<div class="naviSub05">
<%
}else if("7000000".equals(session.getAttribute("baseMenuNo"))){ 	//메뉴관리
%>
	<div class="naviSub06">
<%
}else if("8000000".equals(session.getAttribute("baseMenuNo"))){ 	//코드관리
%>
	<div class="naviSub07">
<%
}else if("9000000".equals(session.getAttribute("baseMenuNo"))){ 	//게시판관리
%>
	<div class="naviSub08">
<%
}%>
		<ul>
		<input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
		<input type="hidden" id="link" name="link" value="" />
		<c:forEach var="result" items="${list_menulist}" varStatus="status" >
			<input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
			<!--<c:if test="${result.upperMenuId == baseMenuNo}">-->
				<li><a href="#LINK" onclick="javascript:fn_MovePage('<c:out value="${result.menuNo}"/>','${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}')">
					<b>
					<c:if test="${result.menuNo == selMenuNo}">
						<font color="#2069b3">
<%-- 							<c:out value='${result.menuNm}'/> --%>
			  				<c:choose>
			  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.menuNm}"/></c:when>
			  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.menuNmEn}"/></c:when>
			  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.menuNmCn}"/></c:when>
			  				</c:choose>   					
						</font>
					</c:if>
					<c:if test="${result.menuNo != selMenuNo}">
<%-- 						<c:out value='${result.menuNm}'/> --%>
						<c:choose>
		  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.menuNm}"/></c:when>
		  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.menuNmEn}"/></c:when>
		  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.menuNmCn}"/></c:when>
		  				</c:choose>
					</c:if>
					</b>
				</a></li>
			<!--</c:if>-->
		</c:forEach>
	</ul>
</div>
<input type="hidden" id="selMenuNo" name="selMenuNo" value="<%=session.getAttribute("selMenuNo")%>" />
</form>
<!-- <ul> -->
<!--                     	<li><a href="" class="bold">SR 처리율</a></li> -->
<!--                         <li>/</li> -->
<!--                         <li><a href="" class="bold"><span style="letter-spacing:0.3px;">SR Activity Report</span></a></li> -->
<!--                         <li>/</li> -->
<!--                         <li><a href="" class="bold">SR 처리 상세내역</a></li> -->
<!--                         <li>/</li> -->
<!--                         <li><a href="" class="bold">SR 월별 처리현황</a></li> -->
<!--                         <li>/</li> -->
<!--                         <li><a href="" class="bold">만족도 현황</a></li> -->
<!--                     </ul>   -->
<!-- <ul> -->
<!--     <li></li> -->
<%-- 	<c:forEach var="result" items="${list_headmenu}" varStatus="status"> --%>
<%--     <li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>   --%>
<%--     </c:forEach> --%>
<!-- </ul> -->
<!-- //topmenu end -->
<!-- menu list -->

