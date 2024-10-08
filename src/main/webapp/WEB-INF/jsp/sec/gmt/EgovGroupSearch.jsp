<%--
  Class Name : EgovGroupSearch.jsp
  Description : EgovGroupSearch Search 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.03.23
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/popup.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<title>그룹 정보</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var checkCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    returnValue = checkField[i].value;
                }
            }

            if(checkCount > 1) {
                alert("하나 이상의 그룹이 선택되었습니다.");
                return;
            } else if(checkCount < 1) {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        } else {
        	if(checkField.checked == true) {
        		returnValue = checkId.value;
        	} else {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        }

        returnBoolean = true;

    } else {
    	alert("조회 결과가 없습니다.");
    }

    document.listForm.groupId.value = returnValue;

    return returnBoolean;
    
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
    opener.listForm.searchKeyword.value = groupId;
    window.close();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
     // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}
//-->
</script>

</head>

<body>
<DIV id="main" style="display:">

<form name="listForm" action="<c:url value='/sec/gmt/EgovGroupSearchList.do'/>" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
<input type="submit" id="invisible" class="invisible"/>
    <!-- 검색 필드 박스 시작 -->
<!--     <div class="list2"> -->
<!-- 			      	<ul> -->
<%-- 			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 메뉴목록관리 > 메뉴 등록</li> --%>
<!-- 			        </ul> -->
<!-- 			    </div>	 -->
			    
    <div id="search_field">
        <div id="search_field_loc" class="h_title">그룹 조회 팝업</div>
            <fieldset><legend>조건정보 영역</legend>    
            <div class="sf_start">
                <ul id="search_first_ul">
                    <li>
                        <label for="search_select">그룹 명 : </label>
                        <input name="searchKeyword" type="text" value="<c:out value='${groupManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" />
                    </li>       
                </ul>
                <ul id="search_second_ul">
                    <li>
                        <div class="buttons" style="float:right;">
                            <a href="<c:url value='/sec/gmt/EgovGroupSearchList.do'/>" onclick="javascript:fncSelectGroupList('1'); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                            <a href="#LINK" onclick="javascript:fncSelectGroupConfirm()" style="selector-dummy:expression(this.hideFocus=false);">확인</a>
                        </div>                              
                    </li>
                </ul>           
            </div>          
            </fieldset>
    </div>
    <!-- //검색 필드 박스 끝 -->

    <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 고객사관리</li>
			        </ul>
			      </div>                      
    <!-- table add start -->
    <div class="list3">
        <table width="100%" summary="그룹 조회 결과를  보여주는 테이블입니다.그룹 ID,그룹 명의 정보를 담고 있습니다.">
<%-- 	        <caption></caption> --%>
	        <colgroup>
	        <col width="3%" >
	        <col width="15%" >  
	        <col width="25%" >
	        </colgroup>
	        <thead>
	        <tr>
                <td colspan="3" bgcolor="#0257a6" height="2"></td>
            </tr>
            <tr class="tdgrey">
	            <th scope="col" class="f_field" nowrap="nowrap"></th>
	            <th scope="col" nowrap="nowrap">그룹 ID</th>
	            <th scope="col" nowrap="nowrap">그룹 명</th>
	        </tr>
	        <tr>
                <td colspan="3" bgcolor="#717171" height="1"></td>
            </tr>
            <tr>
                <td colspan="3" bgcolor="#cdcdcd" height="1"></td>
            </tr>
	        </thead>
	        <tbody>                 
            
            <c:forEach var="group" items="${groupList}" varStatus="status">
            <!-- loop 시작 -->                                
			  <tr>
			    <td nowrap="nowrap" class="tdwc"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>
			    <td nowrap="nowrap" class="tdwc"><a href="#LINK" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
			    <td nowrap="nowrap" class="tdwc"><c:out value="${group.groupNm}"/></td>
			  </tr>
			  <tr>
				    <td colspan="3" bgcolor="#cdcdcd" height="1"></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(groupList) == 0}">
             <tr>
               <td nowrap colspan="3"><spring:message code="common.nodata.msg" /></td>  
             </tr>      
            </c:if>
			</tbody> 
        </table>
    </div>

    <!-- 페이지 네비게이션 시작 -->
    <c:if test="${!empty groupManageVO.pageIndex }">
	    <div id="paging_div">
	        <ul class="paging_align">
		        <ui:pagination paginationInfo = "${paginationInfo}"
		            type="image"
		            jsFunction="linkPage"
		            />
	        </ul>
	    </div>                          
    </c:if>
    <!-- //페이지 네비게이션 끝 -->  

	<input type="hidden" name="groupId"/>
	<input type="hidden" name="groupIds"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
	<input type="hidden" name="searchCondition"/>
</form>

</DIV>
</body>
</html>
