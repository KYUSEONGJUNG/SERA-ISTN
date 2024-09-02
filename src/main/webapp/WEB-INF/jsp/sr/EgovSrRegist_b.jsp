<%--
  Class Name : EgovUserInsert.jsp
  Description : SR등록View JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var = "date" value = "<%= new Date()%>"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >
<!-- Smart Editor CSS -->
<link href="<c:url value='/'/>css/editor.css" rel="stylesheet" type="text/css" charset="utf-8"/>
<!-- //Smart Editor CSS -->
<title>SR 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="srVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<!-- Smart Editor Script -->
<script type="text/javascript" src="<c:url value='/js/HuskyEZCreator.js'/>" charset="utf-8"></script>
<!-- //Smart Editor Script -->
<script type="text/javaScript" language="javascript" defer="defer">
<!--

/**
 * 목록
 */
function fnListPage(){
    document.srVO.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.srVO.submit();
}
/**
 * 저장
 */
function fnInsert(){
	if(validateSrVO(document.srVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        	document.srVO.submit();
		}
    }
}
/**
 * 임시저장
 */
function fnTempInsert(){
	if(validateSrVO(document.srVO)){
		if(confirm("<spring:message code="common.save.msg" />")){
			oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			document.srVO.tempSaveAt.value="Y";
			document.srVO.submit();			
		}
    }
}
function fnSendMail(){
	if(confirm("<spring:message code="common.sendMail.msg" />")){
		oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
    	document.srVO.action           = "<c:url value='/sr/sendMail.do'/>";
	    document.srVO.submit();
    }
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
                            <li>SR리스트</li>
                            <li>&gt;</li>
                            <li><strong>SR리스트</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>SR 등록</strong></h2></div>
                </div>
		        <form:form commandName="srVO" action="${pageContext.request.contextPath}/sr/EgovSrRegist.do" name="srVO" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		        	<input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
		        	<input type="hidden" name="tempSaveAt" />
		        	
		            
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="SR, 업종코드, 업무명, 업체명 등을 가지고 있는 SR 상세조회(수정) 테이블이다.">
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >제목
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3">
						    	<form:input path="subject" id="subject" cssClass="txaIpt" size="100"  maxlength="30" />
				                <form:errors path="subject" cssClass="error" />
						    </td>    
						  </tr>

						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >고객사
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%">
						        <c:out value='${srVO.pstinstNm}'/>
						        <form:hidden path="pstinstCode" />
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >요청자
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%">
<%-- 						    	<form:input path="customerNm" id="customerNm" cssClass="txaIpt" size="30"  maxlength="30" /> --%>
<%-- 				                <form:hidden path="customerId" /> --%>
<%-- 				                <form:errors path="customerId" cssClass="error" /> --%>
				                <select name="customerId" id="customerId" class="select" title="요청자">
								    <c:forEach var="result" items="${cstmrCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == srVO.customerId}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								 </select>
						    </td>    
						  </tr>
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >연락처(내선)</th>
						    <td width="30%">
						    	<form:input path="tel1" id="tel1" cssClass="txaIpt" size="30"  maxlength="30" />
				                <form:errors path="tel1" cssClass="error" />
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >연락처(이동전화)</th>          
						    <td width="30%">
						    	<form:input path="tel2" id="tel2" cssClass="txaIpt" size="30"  maxlength="30" />
				                <form:errors path="tel2" cssClass="error" />
						    </td>    
						  </tr>
						  
						  <tr>
						    <th width="20%" height="23" class="tdblue">이메일
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="30%">
						    	<form:input path="email" id="email" title="이메일주소" cssClass="txaIpt" size="50" maxlength="50" />
						    	<div><form:errors path="email" cssClass="error" /></div>
						    </td>  <th width="20%" height="23" class="tdblue" scope="row" nowrap >모듈
						    	<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%">
						    	<select name="moduleCode" id="moduleCode" class="select" title="모듈코드">
									<option value='' >==선택==</option>
								    <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								 </select>
						    </td>    
						  </tr>  
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >처리구분</th>
						    <td width="30%">
<%-- 						    	<form:input path="category" id="category" cssClass="txaIpt" size="30"  maxlength="30" /> --%>
<%-- 				                <form:errors path="category" cssClass="error" /> --%>
				                <select name="category" id="category" class="select" title="처리구분">
									<option value='' >==선택==</option>
								    <c:forEach var="result" items="${classCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								 </select>
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >우선순위</th>          
						    <td width="30%">
<%-- 						    	<form:input path="priority" id="priority" cssClass="txaIpt" size="30"  maxlength="30" /> --%>
<%-- 				                <form:errors path="priority" cssClass="error" /> --%>
				                <input type="radio" name="priority" class="radio2" value="1000" >&nbsp;상
					            <input type="radio" name="priority" class="radio2" value="1001" checked="checked" >&nbsp;&nbsp;중
					            <input type="radio" name="priority" class="radio2" value="1002" >&nbsp;&nbsp;하
						    </td>    
						  </tr>  
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >요청일</th>
						    <td width="30%">
						    	<c:out value='${srVO.signDate}'/>
<%-- 						    	<fmt:formatDate value="${date}" type="date" pattern="yyyy-MM-dd"/> --%>
						    	<input type="hidden" name="signDate" value="<c:out value='${srVO.signDate}'/>">
				            </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >완료희망일</th>          
						    <td width="30%">
<%-- 						    	<form:input path="hopeDate" id="hopeDate" cssClass="txaIpt" size="30"  maxlength="30" /> --%>
<%-- 				                <form:errors path="hopeDate" cssClass="error" /> --%>
				                <input name="hopeDate" type="hidden" value="<c:out value='${srVO.hopeDate}'/>" >
				                <input name="hopeDateView" title="완료희망일" type="text" size="10" value="<c:out value='${srVO.hopeDateView}'/>"  readonly="readonly"
                                  onClick="javascript:fn_egov_NormalCalendar(document.srVO, document.srVO.hopeDate, document.srVO.hopeDateView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
                                <img src="<c:url value='/images/sr/icon_calendar.gif' />"
                                  onClick="javascript:fn_egov_NormalCalendar(document.srVO, document.srVO.hopeDate, document.srVO.hopeDateView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                                  alt="calendar">
						    </td>    
						  </tr> 
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >검색키워드</th>
						    <td width="80%" colspan="3">
						    	<form:input path="tcode" id="tcode" cssClass="txaIpt" size="100"  maxlength="30" />
				                <form:errors path="tcode" cssClass="error" />
						    </td>    
						  </tr>	
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >요청내용
								<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>
						    <td width="80%" colspan="3">
						    	<textarea name="comment" id="comment" rows="10" cols="100"></textarea>
<%-- 						    	<form:input path="comment" id="comment" cssClass="txaIpt" size="100"  maxlength="30" /> --%>
<%-- 				                <form:errors path="comment" cssClass="error" /> --%>
						    </td>    
						  </tr>	
						  
						  <tr>
                             <th height="23"><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
                             <td colspan="3">
                             	<input name="file_1" id="egovComFileUploader" type="file" />
                                        	<div id="egovComFileList"></div>
                             </td>
                           </tr>		
                           
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">

                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="#LINK" onclick="JavaScript:fnTempInsert(); return false;"><spring:message code="button.tempSave" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="JavaScript:fnInsert(); return false;"><spring:message code="button.save" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="<c:url value='/sr/EgovSrList.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="javascript:document.srVO.reset();"><spring:message code="button.reset" /></a>
                          </td>  
<!--                           <td width="10"></td> -->
<!--                           <td> -->
<!--                             <a href="#LINK" onclick="JavaScript:fnSendMail(); return false;">메일발송</a> -->
<!--                           </td>      -->
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

			        <!-- 검색조건 유지 -->
			        
			        <!-- 우편번호검색 -->
			        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />
			        
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

<!-- Smart Editor Script -->
<script type="text/javascript">
	var oEditors = [];
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "comment",
		sSkinURI: "<c:url value='/SmartEditor2Skin.html' />",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["comment"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});

	function pasteHTML(filepath){ 
	
	    var sHTML = '<img src="<%=request.getContextPath()%>/' + filepath + '">'; 
	//    alert(sHTML); 
	    oEditors.getById["comment"].exec("PASTE_HTML", [sHTML]); 
	
	}

	function showHTML() {
		var sHTML = oEditors.getById["comment"].getIR();
		alert(sHTML);
	}
	
	function submitContents(elClickedObj) {
		oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("comment").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}

	function setDefaultFont() {
		var sDefaultFont = '맑은고딕';
		var nFontSize = 24;
		oEditors.getById["comment"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<!-- //Smart Editor Script -->

<!-- 멀티파일 업로드를 위한 스크립트처리 -->
<script type="text/javascript">
// 해당 필의에 정의된 수만큼 파일 업로드가 가능하다. 값이 없을시에는 스크립트에 정의된 값으로 적용.
   var maxFileNum = 10;
   var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
   multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );         
</script>
<!-- //멀티파일 업로드를 위한 스크립트처리 -->
