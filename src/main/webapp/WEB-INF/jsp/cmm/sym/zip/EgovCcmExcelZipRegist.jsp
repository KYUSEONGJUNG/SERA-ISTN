<%--
  Class Name : EgovCcmExcelZipRegist.jsp
  Description : EgovCcmExcelZipRegist 화면
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

<title>우편번호 엑셀파일 등록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    var varForm              = document.all["Form"];

    // 파일 확장명 확인
    var arrExt      = "xls";
    var objInput    = varForm.elements["fileNm"];
    var strFilePath = objInput.value;
    var arrTmp      = strFilePath.split(".");
    var strExt      = arrTmp[arrTmp.length-1].toLowerCase();

    if (arrExt != strExt) {
        alert("엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오. ");
        abort;
    } 
    
    varForm.action           = "/sym/ccm/zip/EgovCcmExcelZipRegist.do";
    varForm.submit();

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
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>코드관리</li>
                            <li>&gt;</li>
                            <li><strong>우편번호관리</strong></li>
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
                    <div id="search_field_loc"><h2><strong>우편번호 엑셀파일 등록</strong></h2></div>
                </div>
                <form name="Form" action="<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>" method="post" enctype="multipart/form-data" >
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                <input type="submit" id="invisible" class="invisible"/>
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="우편번호 엑셀파일을 첨부할 수 있는 등록 테이블이다.">
						   <tr>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap ><label for="fileNm">우편번호 엑셀파일</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td><input name="fileNm" type="file" id="fileNm"/></td>
						  </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="#LINK" onclick="fn_egov_list_Zip(); return false;">목록</a>
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="fn_egov_regist_ExcelZip(); return false;"><spring:message code="button.save" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='ExcelZipRegist'/>"/>
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

