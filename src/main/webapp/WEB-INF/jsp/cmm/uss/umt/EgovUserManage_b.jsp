<%--
  Class Name : EgovUserManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<title>사용자 목록</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
        //alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
            document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];    
    }
    document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();
      
}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnViewCheck(){ 
    if(insert_msg.style.visibility == 'hidden'){
        insert_msg.style.visibility = 'visible';
    }else{
        insert_msg.style.visibility = 'hidden';
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>

</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
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
              <form name="listForm" action="<c:url value='/uss/umt/user/EgovUserManage.do'/>" method="post">
              <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
              <input type="submit" id="invisible" class="invisible"/>
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>기반관리</li>
                            <li>&gt;</li>
                            <li><strong>사용자관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>사용자관리</strong></h2></div>
				        <input name="selectedId" type="hidden" />
				        <input name="checkedIdForDel" type="hidden" />
				        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                	<label for="searchEmplyrId">아이디 : </label>
                                    <input name="searchEmplyrId" type="text" size="20" value="<c:out value='${searchVO.searchEmplyrId}'/>"  maxlength="60" id="F1" title="검색조건">
						  			<br>
						  			<label for="searchUserNm">이름 &nbsp;&nbsp;&nbsp;: </label>
                                    <input name="searchUserNm" type="text" size="30" value="<c:out value='${searchVO.searchUserNm}'/>"  maxlength="60" id="F1" title="검색조건">
						  			<br>
						  			<label for="searchPstinstNm">고객사 : </label>
                                    <input name="searchPstinstNm" type="text" size="30" value="<c:out value='${searchVO.searchPstinstNm}'/>"  maxlength="60" id="F1" title="검색조건">
                                    <br>
                                    <label for="searchDelAt">삭제여부</label>
									<select name="searchDelAt" id="searchDelAt">
									    <option value="N" selected="selected">미삭제</option>
									    <option value="Y">삭제</option>
									</select>	
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" onclick="javascript:fnSearch(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
				                        <a href="#LINK" onclick="javascript:fnDeleteUser(); return false;"><spring:message code="button.delete" /></a>
				                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>"><spring:message code="button.list" /></a>
				                        <a href="<c:url value='/uss/umt/user/EgovUserInsertView.do'/>" onclick="fnAddUserView(); return false;"><spring:message code="button.create" /></a>
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->

                <div id="page_info"><div id="page_info_align">사용자수  : <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong></div></div>                    
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="사용자 목록을 제공한다." cellpadding="0" cellspacing="0">
<%--                     <caption>사용자목록</caption> --%>
                    <colgroup>
                    <col width="5%" >
                    <col width="5%" >
                    <col width="11%" >
                    <col width="11%" >
                    <col width="13%" >
                    <col width="11%" >
                    <col width="15%" >
                    <col width="11%" >
                    <col width="11%" >
                    <col width="7%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap"><strong>No.</strong></th>
                        <th scope="col" nowrap="nowrap"><input name="checkAll" type="checkbox" title="Check All" onclick="javascript:fnCheckAll();"/></th>
                        <th scope="col" nowrap="nowrap">아이디</th>
                        <th scope="col" nowrap="nowrap">이름</th>
                        <th scope="col" nowrap="nowrap">고객사</th>
                        <th scope="col" nowrap="nowrap">권한</th>
                        <th scope="col" nowrap="nowrap">이메일</th>
                        <th scope="col" nowrap="nowrap">전화번호</th>
                        <th scope="col" nowrap="nowrap">등록일</th>
                        <th scope="col" nowrap="nowrap">삭제여부</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
                      <tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;">
                        <td class="lt_text3" nowrap="nowrap"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
<%-- 	                    <td nowrap="nowrap"><strong><c:out value="${status.count}"/></strong></td> --%>
	                    <td nowrap="nowrap">
	                        <input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
	                        <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
	                    </td>
	                    <td nowrap="nowrap">
	                        <c:out value="${result.userId}"/>
	                    </td>
	                    <td nowrap="nowrap">
	                        <c:out value="${result.userNm}"/>
	                    </td>
	                    <td nowrap="nowrap"><c:out value="${result.pstinstNm}"/></td>
	                    <td nowrap="nowrap">
				            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
				            	<c:if test="${authorManage.authorCode == result.authorCode}"><c:out value="${authorManage.authorNm}"/></c:if>
				            </c:forEach>				        
	                    </td>
	                    <td nowrap="nowrap"><c:out value="${result.emailAdres}"/></td>
	                    <td nowrap="nowrap">
	                    	<c:if test="${result.moblphonNo != '' && result.offmTelno != ''}">
	                    		<c:out value="${result.moblphonNo}"/>
	                    	</c:if>
	                    	<c:if test="${result.moblphonNo != '' && result.offmTelno == ''}">
	                    		<c:out value="${result.moblphonNo}"/>
	                    	</c:if>
	                    	<c:if test="${result.moblphonNo == '' && result.offmTelno != ''}">
	                    		<c:out value="${result.offmTelno}"/>
	                    	</c:if>
	                    </td>
	                    <td nowrap="nowrap">
	                    <fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
	                    </td>
	                    <td nowrap="nowrap">
	                        <c:forEach var="delAt_result" items="${delAt_result}" varStatus="status">
	                            <c:if test="${result.delAt == delAt_result.code}"><c:out value="${delAt_result.codeNm}"/></c:if>
	                        </c:forEach>
	                    </td>
                      </tr>
                     </c:forEach>     
                    </tbody>
                    </table>
                </div>
                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                        <ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fnLinkPage" />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  
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