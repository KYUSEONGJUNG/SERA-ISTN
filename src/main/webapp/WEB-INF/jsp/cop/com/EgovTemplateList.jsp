<%--
  Class Name : EgovTemplateList.jsp
  Description : 템플릿 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.let.main.service.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_tmplatInfo('1');
        }
    }

    function fn_egov_insert_addTmplatInfo(){    
        document.frm.action = "<c:url value='/cop/com/addTemplateInf.do'/>";
        document.frm.submit();
    }
    
    function linkPage(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_inqire_tmplatInfor(tmplatId){
        document.frm.tmplatId.value = tmplatId;
        document.frm.action = "<c:url value='/cop/com/selectTemplateInf.do'/>";
        document.frm.submit();          
    }
</script>
<title>템플릿 목록</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
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
            	<form name="frm" action ="<c:url value='/cop/com/selectTemplateInfs.do'/>" method="post">
            		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>내부서비스관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>내부업무개시판관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>개시판템플릿관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="3" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">
			              	<select name="searchCnd" title="검색조건" class="select">
			              		<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option>
			              		<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>
			              	</select>
			              </td>
			              <td class="tdleft">
			              	<input name="searchWrd" title="검색어" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>'  maxlength="35" onkeypress="press(event);">
			              </td>
			              <td align="center"><a href="<c:url value='/cop/com/selectTemplateInfs.do'/>" onclick="javascript:fn_egov_select_tmplatInfo('1'); return false;" ><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="3" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
                
                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>개시판템플릿목록</strong></h2></div> -->
                        
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                     <select name="searchCnd" title="검색조건" class="select"> -->
<%--                                        <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option> --%>
<%--                                        <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>    --%>
<!--                                     </select> -->
<!--                                 </li> -->
<!--                                 <li> -->
<%--                                     <input name="searchWrd" title="검색어" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>'  maxlength="35" onkeypress="press(event);">  --%>
<!--                                 </li>        -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
<%--                                         <a href="<c:url value='/cop/com/selectTemplateInfs.do'/>" onclick="javascript:fn_egov_select_tmplatInfo('1'); return false;" ><img src="/images/img_search.gif" alt="search" />조회 </a> --%>
<%--                                         <a href="<c:url value='/cop/com/addTemplateInf.do'/>" onclick="javascript:fn_egov_insert_addTmplatInfo(); return false;" >등록</a> --%>
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
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 게시판관리 > 개시판템플릿관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="번호,게시판명,사용 커뮤니티 명,사용 동호회 명,등록일시,사용여부   목록입니다" cellpadding="0" cellspacing="0">
<%--                     <caption>게시판 템플릿 목록</caption> --%>
                    <colgroup>
                    <col width="10%" >
                    <col width="15%" >  
                    <col width="10%" >
                    <col width="32%" >
                    <col width="10%" >
                    <col width="10%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="6" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap">번호</th>
                        <th scope="col" nowrap="nowrap">템플릿명</th>
                        <th scope="col" nowrap="nowrap">템플릿구분</th>
                        <th scope="col" nowrap="nowrap">템플릿경로</th>
                        <th scope="col" nowrap="nowrap">사용여부</th>
                        <th scope="col" nowrap="nowrap">등록일자</th>
                    </tr>
                    <tr>
                        <td colspan="6" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="6" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
                        <td class="tdwc" nowrap="nowrap"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>            
                        <td class="tdwc" nowrap="nowrap">
                            <a href="<c:url value='/cop/com/selectTemplateInf.do'/>?tmplatId=<c:out value='${result.tmplatId}'/>">
                                <c:out value="${result.tmplatNm}"/>
                            </a>
                        </td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${result.tmplatSeCodeNm}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${result.tmplatCours}"/></td>
                        <td nowrap="nowrap" class="tdwc">
                            <c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
                            <c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
                        </td>  
                        <td nowrap="nowrap" class="tdwc"><c:out value="${result.frstRegisterPnttm}"/></td    >       
                      </tr>
                      <tr>
					    <td colspan="6" bgcolor="#cdcdcd" height="1"></td>
					</tr>
                     </c:forEach>     
                     <c:if test="${fn:length(resultList) == 0}">
                      <tr>
                        <td nowrap colspan="6" ><spring:message code="common.nodata.msg" /></td>  
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
							        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 -->  			                
			        	  </td>
			      	  </tr>
			        	<tr>
			            	<td align="right" valign="bottom" height="60">
			                <span class="btnblue"><a href="<c:url value='/cop/com/addTemplateInf.do'/>" onclick="javascript:fn_egov_insert_addTmplatInfo(); return false;" ><spring:message code="button.create" /> ▶</a></span>&nbsp;
			                </td>
			            </tr>
			        </table>                        
                    
                </div>
                <!-- 페이지 네비게이션 시작 -->
<!--                 <div id="paging_div"> -->
<!--                     <ul class="paging_align"> -->
<%--                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_tmplatInfo"  /> --%>
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
                
                <input type="hidden" name="tmplatId" value="" />
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
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