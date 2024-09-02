<%--
  Class Name : EgovFileNmSearch.jsp
  Description : 프로그램파일명 검색 화면
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
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/popup.css" rel="stylesheet" type="text/css" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->
<title>프로그램파일명 검색</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2"  type="text/javaScript"> 
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListSearch.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */ 
function selectProgramListSearch() { 
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListSearch.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */ 
function choisProgramListSearch(vFileNm) { 
	eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
	if(opener.document.all.progrmFileNm_view){
		opener.document.all.progrmFileNm_view.value = vFileNm;
	}
    window.close();
}
//-->
</script>
</head>
<body>
<div class="sr-contents-wrap" style = "min-width : 0px;">
	<div class="sr-contents-area" style = "left:0px; width: 100%; position: relative; max-width : 100%; max-height:100%; overflow-x : hidden; overflow-y : hidden;">
        <div class="sr-contents">
        
        	<div class="btn_right" style="margin-top: -20px">
                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fnSearch(); return false;" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
            </div> 
			<form id="listForm" name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListSearch.do'/>" method="post">
			
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible"/>
				<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				
			    <div class="sr-table-wrap">
                	<table class="sr-table">
	                    <colgroup>
	                        <col width="20%">
	                        <col width="30%">
	                        <col width="20%">
	                        <col width="30%">
	                    </colgroup>
	                    <tr>
	                    	<th>
	                    		<sbux-label id="table_label1" name="table_label1" uitype="normal" text="프로그램 파일명"></sbux-label>
	                    	</th>
	                    	<td colspan="3">
	                    		<sbux-input id="searchProgrmFileNm" name="searchProgrmFileNm" uitype="text" size="30" value="<c:out value='${searchVO.searchProgrmFileNm}'/>" style="width:100%" maxlength="60" title="검색조건"/>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>
	                    		<sbux-label id="table_label2" name="table_label2" uitype="normal" text="프로그램 한글명"></sbux-label>
	                    	</th>
	                    	<td colspan="3">
	                    		<sbux-input id="searchProgrmKoreanNm" name="searchProgrmKoreanNm" uitype="text" size="30" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>" style="width:100%" maxlength="60" title="검색조건"/>
	                    	</td>
	                    </tr>
	                    
			        <%-- <div id="search_field_loc" class="h_title">프로그램파일명 검색</div>
			            <fieldset><legend>조건정보 영역</legend>    
			            <div class="sf_start">
			                <ul id="search_first_ul">
			                    <li>
			                        <label for="searchProgrmFileNm">프로그램 파일명 : </label>
			                        <input name="searchProgrmFileNm" type="text" size="30" value="<c:out value='${searchVO.searchProgrmFileNm}'/>"  maxlength="60" title="검색조건">
			                        <br>
			                        <label for="searchProgrmKoreanNm">프로그램 한글명 : </label>
			                        <input name="searchProgrmKoreanNm" type="text" size="40" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>"  maxlength="60" id="F1" title="검색조건">
			                    </li>     
			                </ul>
			                <ul id="search_second_ul">
			                    <li>
			                        <div class="buttons" style="float:right;">
			                            <a href="#LINK" onclick="javascript:selectProgramListSearch(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
			                        </div>                              
			                    </li>
			                </ul>           
			            </div>          
			            </fieldset> --%>
		            </table>
			    </div>
			    <!-- //검색 필드 박스 끝 -->
			</form>
			
			    <div class="grid_area">
					<div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>               
                </div>
                
                <div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
                      
			    <!-- table add start -->
			    <!-- <div class="list3">
			        <table width="100%" summary="프로그램파일명 검색목록으로 프로그램파일명 프로그램명으로 구성됨"> -->
			<%--             <caption>프로그램파일명 검색</caption> --%>
			            <%-- <colgroup>
			            <col width="50%" >
			            <col width="50%" >  
			            </colgroup>
			            <thead>
			            <tr>
			                <td colspan="2" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr class="tdgrey">
			                <th scope="col" class="tdwc" nowrap="nowrap">프로그램파일명</th>
			                <th scope="col" nowrap="nowrap" class="tdwc">프로그램명</th>
			            </tr>
			            <tr>
			                <td colspan="2" bgcolor="#717171" height="1"></td>
			            </tr>
			            <tr>
			                <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
			            </tr>
			            </thead>
			            <tbody>                 
			            
			            <c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
			            <!-- loop 시작 -->                                
			              <tr>
						    <td nowrap="nowrap">
						        <span class="link"><a href="#LINK" onclick="choisProgramListSearch('<c:out value="${result.progrmFileNm}"/>'); return false;">
						      <c:out value="${result.progrmFileNm}"/></a></span></td>
						    <td nowrap="nowrap"><c:out value="${result.progrmKoreanNm}"/></td>
			              </tr>
			              <tr>
							    <td colspan="2" bgcolor="#cdcdcd" height="1"></td>
							</tr>
			            </c:forEach>
			            <c:if test="${fn:length(list_progrmmanage) == 0}">
			              <tr>
			                <td nowrap colspan="2"><spring:message code="common.nodata.msg" /></td>  
			              </tr>      
			             </c:if>
			            </tbody> 
			        </table>
			    </div> --%>
			
			    <!-- 페이지 네비게이션 시작 -->
			    <%-- <div id="paging_div">
			        <ul class="paging_align">
			            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
			        </ul>
			    </div> --%>                          
			    <!-- //페이지 네비게이션 끝 -->
		</div>
	</div>
</div>  


</body>
</html>

