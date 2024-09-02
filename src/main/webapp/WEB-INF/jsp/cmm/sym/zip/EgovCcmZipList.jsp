<%--
  Class Name : EgovCcmZipList.jsp
  Description : EgovCcmZipList 화면
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

<title>우편번호 목록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
// function fn_egov_search_Zip(){
//     sC = document.listForm.searchCondition.value;
//     sK = document.listForm.searchKeyword.value; 
//     if (sC == "1") {
//         document.listForm.searchKeyword.value = sK.replace(/\-/, "");
//     }
//     document.listForm.pageIndex.value = 1;
//     document.listForm.submit();
// }
function fn_egov_search_Zip(){
    if (document.listForm.searchZip.value != "") {
        document.listForm.searchZip.value = document.listForm.searchZip.value.replace(/\-/, "");
    }
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>";
}
/* ********************************************************
 * 엑셀등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmExcelZipRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Zip(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Zip(zip,sn){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>";
    varForm.zip.value        = zip;
    varForm.sn.value         = sn;
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
            <form name="listForm" action="<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>코드관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>우편번호관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
<!--                 <div class="list2"> -->
<!-- 			      	<ul> -->
<%-- 			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 코드관리 > 우편번호관리</li> --%>
<!-- 			        </ul> -->
<!-- 			    </div>	 -->
			    
<!--                     <div id="search_field_loc"><h2><strong>우편번호 목록</strong></h2></div> -->
                        
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
                        <div class="searchtb">
                            <table width="980" border="0" cellpadding="0" cellspacing="0">
					            <tr>
					              <td colspan="5" bgcolor="#0257a6" height="2"></td>
					            </tr>
					            <tr>
					              <td class="tdblue">우편번호</td>
					              <td class="tdleft" width="270px;"><input name="searchZip" type="text" size="10" value="<c:out value='${searchVO.searchZip}'/>"  maxlength="60" id="F1" title="검색조건"></td>
					              <td class="tdblue">시도명</td>
					              <td class="tdleft" width="270px;"><input name="searchCtprvnNm" type="text" size="30" value="<c:out value='${searchVO.searchCtprvnNm}'/>"  maxlength="60" id="F1" title="검색조건"></td>
					              <td rowspan="11" align="center"><a href="#LINK" onclick="fn_egov_search_Zip(); return false;"><img src="<c:url value='/' />images/sr/btn_search.gif" width="86" height="65" /></a></td>
					            </tr>
					            <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
					            <tr>
					              <td class="tdblue">시군구명</td>
					              <td class="tdleft">
					              	<input name="searchSignguNm" type="text" size="30" value="<c:out value='${searchVO.searchSignguNm}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					              <td class="tdblue">읍면동명</td>
					              <td class="tdleft">
					              	<input name="searchEmdNm" type="text" size="30" value="<c:out value='${searchVO.searchEmdNm}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					            </tr>
					            
					            <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
					            
					            <tr>
					              <td class="tdblue">리건물명</td>
					              <td class="tdleft">
					              	<input name="searchLiBuldNm" type="text" size="30" value="<c:out value='${searchVO.searchLiBuldNm}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					              <td class="tdblue">도로명</td>
					              <td class="tdleft">
					              	<input name="searchLoadNm" type="text" size="30" value="<c:out value='${searchVO.searchLoadNm}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					            </tr>
					            
					            <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
					            
					            <tr>
					              <td class="tdblue">번지동호</td>
					              <td class="tdleft">
					              	<input name="searchLnbrDongHo" type="text" size="30" value="<c:out value='${searchVO.searchLnbrDongHo}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					              <td class="tdblue">리건물명(구)</td>
					              <td class="tdleft">
					              	<input name="searchLiBuldNmOld" type="text" size="30" value="<c:out value='${searchVO.searchLiBuldNmOld}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					            </tr>
					            
					            <tr>
					              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
					            
					            <tr>
					              <td class="tdblue">번지동호(구)</td>
					              <td colspan="3" class="tdleft">
					              	<input name="searchLnbrDongHoOld" type="text" size="30" value="<c:out value='${searchVO.searchLnbrDongHoOld}'/>"  maxlength="60" id="F1" title="검색조건">
					              </td>
					            </tr>
					            <tr>
					              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
					            </tr>
					          </table>

<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
<%--                                         <a href="#LINK" onclick="fn_egov_search_Zip(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a> --%>
<!--                                         <a href="#LINK" onclick="fn_egov_regist_Zip(); return false;">등록</a> -->
<!--                                         <a href="#LINK" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록</a>  -->
<!--                                     </div>                               -->
<!--                                 </li> -->
<!--                             </ul>            -->
                        </div> 
                                 
<!--                         </fieldset> -->
                <!-- //검색 필드 박스 끝 -->
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 코드관리 > 우편번호관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="우편번호와 주소를 출력하는 우편번호 목록 테이블이다." cellpadding="0" cellspacing="0">
<%--                     <caption>공통코드 목록</caption> --%>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="70%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="3" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">우편번호</th>
                        <th scope="col" nowrap="nowrap">주소</th>
                    </tr>
                    <tr>
                        <td colspan="3" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="3" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_detail_Zip('${resultInfo.zip}','${resultInfo.sn}');">
						    <td class="tdwc" nowrap="nowrap" class="tdwc"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
						    <td class="tdwc" nowrap="nowrap" class="tdwc"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
						    <td class="tdwc"  nowrap="nowrap">
<%-- 						    	<c:out value='${resultInfo.address}'/> --%>
						    	${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}  ${resultInfo.loadNm} ${resultInfo.lnbrDongHo}
						    	<c:if test="${resultInfo.lnbrDongHoOld != NULL && resultInfo.liBuldNmOld != NULL}">
						    		(${resultInfo.lnbrDongHoOld}, ${resultInfo.liBuldNmOld})
						    	</c:if>
						    	<c:if test="${resultInfo.lnbrDongHoOld != NULL && resultInfo.liBuldNmOld == NULL}">
						    		(${resultInfo.lnbrDongHoOld})
						    	</c:if>
						    	<c:if test="${resultInfo.lnbrDongHoOld == NULL && resultInfo.liBuldNmOld != NULL}">
						    		(${resultInfo.liBuldNmOld})
						    	</c:if>
						    </td>
						</tr>   
						<tr>
						    <td colspan="3" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                            <td colspan=3>
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
			            	<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_Zip(); return false;">등록 ▶</a></span>&nbsp;
			                <span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록 ▶</a></span>&nbsp;
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

			<form name="Form" method="post" action="<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			    <input type="hidden" name="zip">
			    <input type="hidden" name="sn">
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