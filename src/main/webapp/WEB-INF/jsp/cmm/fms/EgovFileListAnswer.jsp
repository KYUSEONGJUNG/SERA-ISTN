<%--
  Class Name : EgovFileList.jsp
  Description : 파일 목록화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.26   이삼섭          최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.26 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


        <c:forEach var="fileVO" items="${fileListAns}" varStatus="status">
           <c:choose>
               <c:when test="${updateFlagAns=='Y'}">
                   <a href="#LINK" onclick="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">
	                   <c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
                   </a>
                   &nbsp;<img  alt="파일 삭제" src="<c:url value='/images/btn/bu5_close.gif'/>" 
                        width="19" height="18" onClick="fn_egov_deleteFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>');" /><br>
               </c:when>
               <c:otherwise>
                   <a href="#LINK" onclick="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">
                   <c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
                   </a><br>        
               </c:otherwise>
           </c:choose>
        </c:forEach>
        <c:if test="${fn:length(fileListAns) == 0}">
        </c:if>
      