<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% 
response.setHeader("Cache-Control","no-store");    
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);    
if (request.getProtocol().equals("HTTP/1.1"))  
        response.setHeader("Cache-Control", "no-cache"); 
%>

<script type="text/javascript">
var SBUxConfig = {
	Path : "<c:url value='/' />resources/sbux",
	SBGrid : {  
        Version3_0 : true,//SBGrid3 사용 시.
    },
	SBChart : {	
		Version2_5 : true	
	},
};
</script>
<!-- SBUx.js 호출,필수 -->
<script src="<c:url value='/' />resources/sbux/SBUx.js" type="text/javascript"></script>
<!-- 개발 시 사용할 jquery 버전은 SBUx.js 호출 이후 구문에 삽입하시기 바랍니다.
(제품에서 사용하는 jquery 버전은 1.11.3 입니다.) -->
<!-- SBGrid3 별도 호출 -->
<%-- <script src="<c:url value='/' />resources/SBGrid3/sbgrid3.js" type="text/javascript"></script>
<link href="<c:url value='/' />resources/SBGrid3/css/sbgrid3.css" rel="stylesheet" /> --%>
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/custom.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/reset.css" rel="stylesheet" type="text/css" >
