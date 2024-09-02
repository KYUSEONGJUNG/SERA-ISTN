<%--
  Class Name : EgovCcmCmmnClCodeList.jsp
  Description : EgovCcmCmmnClCodeList 화면
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

<title>공통분류코드 목록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(){
    location.href = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(clCode){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'/>";
    varForm.clCode.value     = clCode;
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    // 
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
            <form name="listForm" action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
            
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>내부시스템관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>분류코드관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="5" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">분류코드</td>
			              <td class="tdleft">
			              	<input name="searchClCode" type="text" size="60" value="<c:out value='${searchVO.searchClCode}'/>"  maxlength="60" id="F1" title="검색조건"> 
			              </td>
			              <td class="tdblue">권한명</td>
			              <td class="tdleft">
			              	<input name="searchClCodeNm" type="text" size="60" value="<c:out value='${searchVO.searchClCodeNm}'/>"  maxlength="60" id="F1" title="검색조건"> 
			              </td>
			              <td align="center"><a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
                                
                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>공통분류코드 목록</strong></h2></div> -->
                        
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                 	<label for="searchClCode">분류코드 : </label> -->
<%--                                     <input name="searchClCode" type="text" size="60" value="<c:out value='${searchVO.searchClCode}'/>"  maxlength="60" id="F1" title="검색조건"> --%>
<!-- 						  			<br> -->
<!--                                     <label for="searchClCodeNm">분류코드명 : </label> -->
<%--                                     <input name="searchClCodeNm" type="text" size="60" value="<c:out value='${searchVO.searchClCodeNm}'/>"  maxlength="60" id="F1" title="검색조건">  --%>
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="position:absolute;left:870px;top:170px;"> -->
<%--                                         <a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a> --%>
<!--                                         <a href="#LINK" onclick="fnRegist(); return false;">등록</a>  -->
<!--                                     </div>                               -->
<!--                                 </li> -->
<!--                             </ul>            -->
<!--                         </div>           -->
<!--                         </fieldset> -->
<!--                 </div> -->
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
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="분류코드, 분류코드명, 사용여부를 조회하는 공통분류코드 목록 테이블이다." cellpadding="0" cellspacing="0">
<%--                     <caption></caption> --%>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="50%" >
                    <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
		        	  <td colspan="4" bgcolor="#0257a6" height="2"></td>
		       	  </tr>
		        	<tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">분류코드</th>
                        <th scope="col" nowrap="nowrap">분류코드명</th>
                        <th scope="col" nowrap="nowrap">사용여부</th>
                    </tr>
                    <tr>
                        <td colspan="4" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.clCode}');">
						    <td nowrap="nowrap" class="tdwc"><strong><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></strong></td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.clCode}</td>
						    <td nowrap="nowrap" class="tdwc">${resultInfo.clCodeNm}</td>
						    <td nowrap="nowrap" class="tdwc"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
						</tr>   
						<tr>
						    <td colspan="4" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                    </c:forEach>     
					<c:if test="${fn:length(resultList) == 0}">
					    <tr> 
					        <td colspan=4>
					            <spring:message code="common.nodata.msg" />
					        </td>
					    </tr>                                              
					</c:if>
                    </tbody>
                    </table>
                    
                    <table width="980" border="0" cellpadding="0" cellspacing="0">
			        	<tr>
			        	  <td height="30"></td>
			      	  </tr>
			        	<tr>
			        	  <td align="center";>
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
			        	  </td>
			      	  </tr>
			        	<tr>
			            	<td align="right" valign="bottom" height="60">
			                <span class="btnblue"><a href="#LINK" onclick="fnRegist(); return false;"><spring:message code="button.create" /> ▶</a></span>&nbsp;
			                </td>
			            </tr>
			        </table>
			                            
                </div>

                <!-- 페이지 네비게이션 시작 -->
<!--                 <div id="paging_div"> -->
<!--                     <ul class="paging_align"> -->
<%-- 				        <ui:pagination paginationInfo = "${paginationInfo}" --%>
<%-- 				                type="image" --%>
<%-- 				                jsFunction="linkPage" --%>
<%-- 				                /> --%>
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>

			<form name="Form" method="post" action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'/>">
			    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			    <input type=hidden name="clCode">
			    <input type="submit" id="invisible" class="invisible"/>
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