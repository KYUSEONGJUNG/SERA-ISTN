<%--
  Class Name : EgovMenuBndeRegist.jsp
  Description : 메뉴프로그램목록 일괄 등록 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<title>메뉴일괄등록</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script  language="javascript1.2" type="text/javaScript">
/* ********************************************************
 * 메뉴일괄생성처리 함수
 ******************************************************** */
function insertMenuManage() {
    if(confirm("메뉴일괄등록을 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 존재시 삭제 하실 수 없습니다.")){
       if(checkFile()){
           document.menuManageRegistForm.action ="<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
          document.menuManageRegistForm.submit();
       }
    }
}
/* ********************************************************
 * 메뉴일괄삭제처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(confirm("메뉴일괄삭제를 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 데이타 모두  삭제 삭제처리 됩니다.")){
        document.menuManageRegistForm.action ="<c:url value='/sym/mpm/EgovMenuBndeAllDelete.do'/>";
        document.menuManageRegistForm.submit();
    }
}
/* ********************************************************
 * 메뉴일괄등록시 등록파일 체크 함수
 ******************************************************** */
function checkFile(){ 
    if(document.menuManageRegistForm.file.value==""){
       alert("업로드 할 파일을 지정해 주세요");
       return false;
    }

    var  str_dotlocation,str_ext,str_low;
    str_value  = document.menuManageRegistForm.file.value;
    str_low   = str_value.toLowerCase(str_value);
    str_dotlocation = str_low.lastIndexOf(".");
    str_ext   = str_low.substring(str_dotlocation+1);
    
    switch (str_ext) {
      case "xls" :
      case "xlsx" :
         return true;
         break;
      default:
         alert("파일 형식이 맞지 않습니다.\n xls,XLS,xlsx,XLSX 만\n 업로드가 가능합니다!");
         return false;
    }
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>메뉴관리</li>
                            <li>&gt;</li>
                            <li><strong>메뉴목록관리</strong></li>
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
                    <div id="search_field_loc"><h2><strong>메뉴일괄등록</strong></h2></div>
                </div>
                <form name="menuManageRegistForm" action ="<c:url value='/sym/mpm/EgovMenuBndeRegist.do'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                <input type="submit" id="invisible" class="invisible"/>

                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="메뉴일괄등록">
				         <tr> 
				           <!-- td width="5%"></td>
				           <td><img src="<%=imagePath_button %>bu2_left.gif" width="8" height="20"></td>
				           <td background="<%=imagePath_button %>bu2_bg.gif" nowrap="nowrap"><a href="javascript:deleteMenuList()">일괄삭제</a></td>
				           <td><img src="<%=imagePath_button %>bu2_right.gif" width="8" height="20"></td--> 
				           <td width="10"></td> 
				         </tr>
                          <tr> 
                            <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmFileNm">일괄파일</label>
                            <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
                            <td width="80%" nowrap="nowrap">
                              <input type = "file" name="file" size="40" title="일괄파일"/>
                            </td>
                          </tr> 
                          <tr>
                            <td width="10"></td> 
                          </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="selectList(); return false;">목록</a> 
                          </td>
                          <td>
                            <a href="#LINK" onclick="javascript:insertMenuManage(); return false;">일괄등록</a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='bndeInsert'/>"/>
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

