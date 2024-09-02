<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.let.main.service.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<c:url value="/js/EgovMainMenu.js"/>"/></script>
<script type="text/javascript">
<!--
/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function fn_MovePage(nodeNum) {
    var nodeValues = treeNodes[nodeNum].split("|");
    //parent.main_right.location.href = nodeValues[5];
    document.menuListForm.action = "${pageContext.request.contextPath}"+nodeValues[5];
    //alert(document.menuListForm.action);
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
<!-- 메뉴 시작 -->
<input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
<input type="hidden" id="link" name="link" value="" />

<ul>
<c:out value='${baseMenuNo}'/>

<c:forEach var="result" items="${list_menulist}" varStatus="status" >
<c:out value='${result.upperMenuId}'/>
	<c:if test="${result.upperMenuId == baseMenuNo}">
     <input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
     <li><a href="" class="bold"><c:out value='${result.menuNm}'/></li>
	
	</c:if>
</c:forEach>
</ul>
        
<!-- <ul> -->
<!-- 	<li><a href="" class="bold">SR 처리율</a></li> -->
<!--     <li>/</li> -->
<!--     <li><a href="" class="bold"><span style="letter-spacing:0.3px;">SR Activity Report</span></a></li> -->
<!--     <li>/</li> -->
<!--     <li><a href="" class="bold">SR 처리 상세내역</a></li> -->
<!--     <li>/</li> -->
<!--     <li><a href="" class="bold">SR 월별 처리현황</a></li> -->
<!--     <li>/</li> -->
<!--     <li><a href="" class="bold">만족도 현황</a></li> -->
<!-- </ul>    -->

<!-- <div id="nav">	 -->
<!-- 	<div class="top"></div> -->
<!--     <div class="nav_style"> -->
<!--      <script type="text/javascript"> -->
<!--
//          var Tree = new Array;
//          if(document.menuListForm.tmp_menuNm != null){
//              for (var j = 0; j < document.menuListForm.tmp_menuNm.length; j++) {
//                  Tree[j] = document.menuListForm.tmp_menuNm[j].value;
//              }
//          }
//          createTree(Tree, true, document.getElementById("baseMenuNo").value);
//      //-->
<!--      </script> -->
<!--     </div> -->
<!-- 	<div class="bottom"></div> -->
<!-- </div> -->
	
<!-- //메뉴 끝 -->	