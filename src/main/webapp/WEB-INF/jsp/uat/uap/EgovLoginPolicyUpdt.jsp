<%--
  Class Name : EgovLoginPolicyUpdt.jsp
  Description : EgovLoginPolicyUpdt 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
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

<title>로그인정책 수정</title>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="loginPolicy" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncSelectLoginPolicyList() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    varFrom.submit();       
}

function fncLoginPolicyUpdate() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/updtLoginPolicy.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateLoginPolicy(varFrom)){           
            return;
        }else{
            if(ipValidate())
                varFrom.submit();
            else 
                return;
        } 
    }
}

function fncLoginPolicyDelete() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/removeLoginPolicy.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

function ipValidate() {
    
    var varFrom = document.getElementById("loginPolicy");
    var IPvalue = varFrom.ipInfo.value;

    var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
    var ipArray = IPvalue.match(ipPattern);

    var result = "";
    var thisSegment;

    if(IPvalue == "0.0.0.0") {
        alert(IPvalue + "는 예외 아이피 입니다..");
        result = false;
    } else if (IPvalue == "255.255.255.255") {
        alert(result =IPvalue + "는 예외 아이피 입니다.");
        result = false;
    } else {
        result = true;
    }

    if(ipArray == null) {
        alert("형식이 일치 하지않습니다. ");
        result = false;
    } else {
        for (var i=1; i<5; i++) {
            
            thisSegment = ipArray[i];

            if (thisSegment > 255) {
                alert("형식이 일치 하지않습니다. ");
                result = false;
            }
            
            if ((i == 0) && (thisSegment > 255)) {
                alert("형식이 일치 하지않습니다. ");
                result = false;
            }
        }
    }

    return result;
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
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>로그인정책 수정</strong></li>
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
                    <div id="search_field_loc"><h2><strong>로그인정책 수정</strong></h2></div>
                </div>
                <form:form commandName="loginPolicy" method="post" action="${pageContext.request.contextPath}/uat/uap/updtLoginPolicy.do">  
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="로그인정책을 수정한다.">
						  <tr>
						    <th class="tdblue" width="20%" scope="row" nowrap="nowrap">사용자ID
                            </th>
						    <td nowrap="nowrap"><input name="emplyrId_view" value="<c:out value='${loginPolicy.emplyrId}'/>" disabled="disabled" title="사용자ID(화면출력용)">
						                        <input name="emplyrId" id="emplyrId" title="사용자ID" type="hidden" size="30" readonly="readonly" value="<c:out value='${loginPolicy.emplyrId}'/>" ></td>
						  </tr>
						  <tr>
						    <th class="tdblue" width="20%" scope="row" nowrap="nowrap">사용자명
                            </th>
						    <td nowrap="nowrap"><input name="emplyrNm_view" value="<c:out value='${loginPolicy.emplyrNm}'/>" disabled="disabled" title="사용자명(화면출력용)">
						                        <input name="emplyrNm" id="emplyrNm" title="사용자명" type="hidden" value="<c:out value='${loginPolicy.emplyrNm}'/>" maxLength="50" size="30" readonly="readonly"></td>
						  </tr>
						  <tr>
						    <th class="tdblue" width="20%" scope="row" nowrap="nowrap">IP정보
                            </th>
						    <td nowrap="nowrap"><input name="ipInfo" id="ipInfo" title="IP정보" type="text" value="<c:out value='${loginPolicy.ipInfo}'/>" maxLength="23" size="30" >&nbsp;<form:errors path="ipInfo" /></td>
						  </tr>
						  <tr>
						    <th class="tdblue" width="20%" scope="row" nowrap="nowrap">IP제한여부
                            </th>
						    <td nowrap="nowrap">
						      <select name="lmttAt" id="lmttAt" title="IP제한여부">
						          <option value="Y" <c:if test="${loginPolicy.lmttAt == 'Y'}">selected</c:if> >Y</option>
						          <option value="N" <c:if test="${loginPolicy.lmttAt == 'N'}">selected</c:if> >N</option>
						      </select>
						      (Y로 설정되면 등록된 IP에서의 접속만을 허용하도록 제한됨)
						    </td>
						  </tr>
						  <tr>
						    <th class="tdblue" width="20%" scope="row" nowrap="nowrap">등록일시
                            <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                             -->
                            </th>
						    <td nowrap="nowrap"><input name="regDate" id="regDate" title="등록일시" type="text" value="<c:out value='${loginPolicy.regDate}'/>" maxLength="50" size="20" class="readOnlyClass" readOnly ></td>
						  </tr>    
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
	                        <tr> 
	                          <td>
	                            <a href="#LINK" onclick="javascript:fncLoginPolicyUpdate(); return false;" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.save" /></a>  
	                          </td>
	                          <td width="10"></td>
	                          <td>
	                            <a href="<c:url value='/uat/uap/removeLoginPolicy.do'/>?emplyrId=<c:out value='${loginPolicyVO.emplyrId}'/>" onclick="fncLoginPolicyDelete(); return false;"><spring:message code="button.delete" /></a>  
	                          </td>
	                          <td width="10"></td>
	                          <td>
	                            <a href="<c:url value='/uat/uap/selectLoginPolicyList.do'/>?pageIndex=<c:out value='${loginPolicyVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${loginPolicyVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncSelectLoginPolicyList(); return false;"><spring:message code="button.list" /></a>  
	                          </td>
	                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
					<input type="hidden" name="dplctPermAt" value="Y" >
					<input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>" >
					<input type="hidden" name="searchKeyword" value="<c:out value='${loginPolicyVO.searchKeyword}'/>" >
					<input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>" >
                    <!-- 검색조건 유지 -->
                </form:form>

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

