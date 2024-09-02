<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Language" content="ko" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->
<!-- CK Editor Script -->
<script type="text/javascript" src="<c:url value='/js/ckEditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckEditor/en.js'/>"></script>
<style>
.ck-editor__editable_inline {
    min-height: 200px;
}
</style>
<!-- CK Editor Script -->

<title><spring:message code='button.modifyInformation'/></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
    if(confirm("<spring:message code="common.secsn.msg" />")){
        document.userManageVO.checkedIdForDel.value=checkedIds;
        /* document.userManageVO.action = "<c:url value='/uss/umt/user/EgovCstmrDelete.do'/>";
        document.userManageVO.submit(); 
        document.userManageVO.action = ""; */
        
        var form = $("#userManageVO")[0];
		var formData = new FormData(form);
                
        $.ajax({        	
			url : "<c:url value='/uss/umt/user/EgovCstmrDelete.do'/>"			
			,type : "POST"
			,data : formData
	     	,contentType : false
	     	,processData : false
			,beforeSend : fn_loading()
			,success : function(data){
				
				alert(data.msg);
				if(data.msgType == 'S') {
					location.replace("<c:url value='/uat/uia/egovLoginUsr.do'/>");  		       		
				} else {
					location.reload(true);				
				}
				 	
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	fn_closeLoading();
	   	    }
		}); 
    }
}
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovCstmrPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
   		if(confirm("<spring:message code="common.save.msg" />")){
       		/* document.userManageVO.submit();    
       		document.userManageVO.action = ""; */
       		$("#emailSignature").text(editor.getData());
       		var form = $("#userManageVO")[0];
    		var formData = new FormData(form);
                    
            $.ajax({        	
    			url : "<c:url value='/uss/umt/user/EgovCstmrSelectUpdt.do'/>"			
    			,type : "POST"
    			,data : formData
    	     	,contentType : false
    	     	,processData : false
    			,beforeSend : fn_loading()
    			,success : function(data){
    				
    				alert(data.msg);
    				if(data.msgType == 'S') {
    					location.replace("<c:url value='/sr/EgovSrList.do'/>");  		       		
    				} else {
    					location.reload(true);				
    				}
    				 	
    	   	    },
    	   	    error : function(request, status, error){
    				alert("error");   	            
    	   	    },
    	   	    complete:function(){
    	   	    	fn_closeLoading();
    	   	    }
    		}); 
   		}
    }
}
/* function fn_egov_inqire_cert() {
    var url = '/uat/uia/EgovGpkiRegist.do';
    var popupwidth = '500';
    var popupheight = '400';
    var title = '인증서';

    Top = (window.screen.height - popupheight) / 3;
    Left = (window.screen.width - popupwidth) / 2;
    if (Top < 0) Top = 0;
    if (Left < 0) Left = 0;
    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
    PopUpWindow = window.open(url, title, Future)
    PopUpWindow.focus();
} */

function validateUserManageVO(form) {
	var checkOption = {
			emplyrId : 
				{ valid : "required, maxlength" 
				, label : "<spring:message code='uss.umt.id'/>" 
				, max : 20 }
			, emplyrNm : 
				{ valid : "required, maxlength" 
				, label : "<spring:message code='cop.ncrdNm'/>"
				, max : 60}
			, emplyrNmEn : 
				{ valid : "required, maxlength" 
				, label : "<spring:message code='cop.ncrdNmEn'/>"
				, max : 20}
			, passwordCnsr : 
				{ valid : "maxlength" 
				, label : "<spring:message code='uss.umt.pwAnswer'/>"
				, max : 100}
			, moblphonNo : 
				{ valid : "maxlength" 
				, label : "<spring:message code='cop.mbtlNum'/>"
				, max : 15}
			, offmTelno : 
				{ valid : "maxlength" 
				, label : "<spring:message code='cop.offTelNo'/>"
				, max : 15}
			, emailAdres : 
				{ valid : "required, maxlength" 
				, label : "<spring:message code='cop.emailAdres'/>"
				, max : 50}
		}	
		if(validateCheck(form, checkOption)){
			return true;
		}
		return false;
}

</script>
<script>
	var editor;
	//자바스크립트 Start
	$(document).ready(function(){
		
		var editorLanguage = "${srLanguage}";
		
		if(editorLanguage != "ko"){
			editorLanguage = "en";
		}
		
		ClassicEditor
		.create( document.querySelector( '#editor' ), {
		    language: editorLanguage
		}).then(newEditor => {
			editor = newEditor;
			editorSetting(editor);
			
			
		})
		.catch( error => {
		    console.error( error );
		} );
		
		
		
	});
	
function fnreset() {
	if(confirm("<spring:message code="uss.umt.msg.reset"/>")){
		document.userManageVO.reset();
	}
}
	
var headText = [
	{"order" : "1", "id" : "id_1", "pid" : "0","text" : "<spring:message code='button.modifyInformation'/>", "value" : "value2", "imagesrc":"<c:url value = '/'/>images/breadcrumb-home.png", "imagealt" : "imageAlt", "imagetitle" : "imageTitle", "imagestyle" : "height:15px; width:16px;"}
]
</script>

</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div class="sr-contents-wrap">
    <!-- header 시작 -->
    <c:import url="/sym/mms/EgovMainMenuLeft.do" />
    <!-- //header 끝 -->
    	<div class="sr-contents-area"> 
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
				<div class="sr-breadcrumb-area">                
					<sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="headText" disabled></sbux-breadcrumb>
				</div>
			   
                <!-- 검색 필드 박스 시작 -->
		        <form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovCstmrSelectUpdt.do" id="userManageVO" name="userManageVO" method="post" >
		        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
			        <input name="checkedIdForDel" type="hidden" />
			        <!-- 검색조건 유지 -->
			        <input type="hidden" name="sbscrbSttus" value="<c:out value='${searchVO.sbscrbSttus}'/>"/>
			        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
			        <input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />
			        <!-- 권한코드 등록여부 -->
			        <input type="hidden" name="regYn" value="<c:out value='${userManageVO.regYn}'/>" />
			        <!-- 권한코드 -->
			        <input type="hidden" name="authorCode" value="<c:out value='${userManageVO.authorCode}'/>" />
			        <!-- 삭제여부 -->
			        <input type="hidden" name="delAt" value="<c:out value='${userManageVO.delAt}'/>"/>

                    <div class="sr-table-wrap">
				         <table class="sr-table">
	                        <colgroup>
	                            <col width="12%">
	                            <col width="29%">
	                            <col width="12%">
	                            <col width="49%">
	                        </colgroup>

                            <tr> 
                                <th width="20%" height="23" class="tdblue"  >
                                	<sbux-label id="th_text1" name="th_text1" uitype="normal" text="<spring:message code='uss.umt.id'/>" class = "imp-label"></sbux-label>
                                </th>
				                <td width="30%" class="tdleft"><label for="emplyrId"></label>
				                	<sbux-input name="emplyrId" id="emplyrId" size="20"  maxlength="20" uitype="text" value="<c:out value="${userManageVO.emplyrId}"/>" style="width : 100%" readonly></sbux-input>				                	
				                    <hidden name="emplyrId" id="emplyrId" size="20" maxlength="20" readonly="true" />				                   
				                    <input type="hidden" name="uniqId" id="uniqId" value="<c:out value="${userManageVO.uniqId}"/>"/>
				                    <hidden name="languageCode" id="languageCode" value="${userManageVO.uniqId}"/>				                    
				                </td>
				                <th width="20%" height="23" class="tdblue">
				                	<sbux-label id="th_text2" name="th_text2" uitype="normal" text="<spring:message code='cop.ncrdNm'/>" class = "imp-label"></sbux-label> 
                                </th>
				                <td width="30%" class="tdleft"><label for="emplyrNm"></label>
				                    <sbux-input name="emplyrNm" id="emplyrNm" size="20"  maxlength="60" uitype="text" value="<c:out value="${userManageVO.emplyrNm}"/>" style="width : 100%"/>
				                </td>
                            </tr>
                            <tr><!-- 영문명 -->
                                <th>
                                	<sbux-label id="th_text3" name="th_text3" uitype="normal" text="<spring:message code='cop.ncrdNmEn'/>" class = "imp-label"></sbux-label>
                                </th>
				                <td style="border-right : 0px;">
				                    <sbux-input name="emplyrNmEn" id="emplyrNmEn" size="20" maxlength="20" uitype="text" value="<c:out value="${userManageVO.emplyrNmEn}"/>" style="width : 100%"></sbux-input>
				                </td>
				                <td style="border-right : 0px; border-left : 0px;"></td>
				                <td style="border-left : 0px;"></td>
                            </tr>
                            <tr> 
                                <th>
                                	<sbux-label id="th_text4" name="th_text4" uitype="normal" text="<spring:message code='uss.umt.pwHint'/>"></sbux-label>
                               	</th>
				                <td>				                    
				                    <sbux-select name="passwordHint" id="passwordHint">
				                    	<c:choose>
					                        <c:when test="${srLanguage == 'ko'}"><option value="" label="선택"/></c:when>
					                        <c:when test="${srLanguage == 'en'}"><option value="" label="choose"/></c:when>
						  					<c:when test="${srLanguage == 'cn'}"><option value="" label="选择"/></c:when>
						  					<c:otherwise>선택</c:otherwise>
				                        </c:choose>
				                        
			                        	<c:forEach var="result" items="${passwordHint_result}" varStatus="status">
			                        		<c:if test="${srLanguage == 'ko'}"><option value='<c:out value="${result.code}"/>' <c:if test="${result.code == userManageVO.passwordHint}">selected</c:if>><c:out value="${result.codeNm}"/></option></c:if>
			                        		<c:if test="${srLanguage == 'en'}"><option value='<c:out value="${result.code}"/>' <c:if test="${result.code == userManageVO.passwordHint}">selected</c:if>><c:out value="${result.codeNm}"/></option></c:if>
				  							<c:if test="${srLanguage == 'cn'}"><option value='<c:out value="${result.code}"/>' <c:if test="${result.code == userManageVO.passwordHint}">selected</c:if>><c:out value="${result.codeNm}"/></option></c:if>
			                        	</c:forEach>			                        	
				                        
				                    </sbux-select>
				                </td>
                                <th>
                                	<sbux-label id="th_text5" name="th_text5" uitype="normal" text="<spring:message code='uss.umt.pwAnswer'/>"></sbux-label>
                               	</th>
				                <td>
				                    <sbux-input name="passwordCnsr" id="passwordCnsr" size="40" maxlength="100" uitype="text" value="<c:out value="${userManageVO.passwordCnsr}"/>" style="width : 100%"/>
				                </td>
                            </tr>
                            <tr> 
                                <th>
                                	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="<spring:message code='cop.mbtlNum'/>"></sbux-label>
                               	</th>
				                <td>
				                    <sbux-input name="moblphonNo" id="moblphonNo" size="20" maxlength="15" uitype="text" value="<c:out value="${userManageVO.moblphonNo}"/>" style="width : 100%"/>     
				                </td>
				                <th>
				                	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="<spring:message code='cop.offTelNo'/>"></sbux-label> 
			                	</th>
				                <td>
				                    <sbux-input name="offmTelno" id="offmTelno" size="20" maxlength="15" uitype="text" value="<c:out value="${userManageVO.offmTelno}"/>" style="width : 100%"/>
				                </td>
                            </tr>
                            <tr>
                                <th>
                                	<sbux-label id="th_text8" name="th_text8" uitype="normal" text="<spring:message code='cop.emailAdres'/>" class = "imp-label"></sbux-label>
                                </th>
				                <td colspan="3">
				                    <sbux-input name="emailAdres" id="emailAdres" size="50" maxlength="50" uitype="text" value="<c:out value="${userManageVO.emailAdres}"/>" style="width : 100%"/>
				                </td>
                            </tr>
                            
                            <tr> 
                                <th>
                                	<sbux-label id="th_text9" name="th_text9" uitype="normal" text="<spring:message code='sr.client'/>" class = "imp-label"></sbux-label>
								</th>
				                <td style="border-right : 0px;">
					  				<c:choose>
					  					<c:when test="${srLanguage == 'ko'}">
					  						<sbux-label id="th_text10" name="th_text10" uitype="normal" text="<c:out value='${userManageVO.pstinstNm}'/>" style="padding-left : 12px"></sbux-label>
				  						</c:when>
					  					<c:otherwise>
					  						<sbux-label id="th_text11" name="th_text11" uitype="normal" text="<c:out value='${userManageVO.pstinstNmEn}'/>" style="padding-left : 12px"></sbux-label>
				  						</c:otherwise>
					  				</c:choose>  				                	
				                	<input type="hidden" name="pstinstCode" value="<c:out value='${userManageVO.pstinstCode}'/>" />
				                </td>
				                <td style="border-right : 0px; border-left : 0px;"></td>
				                <td style="border-right : 0px; border-left : 0px;"></td>
                            </tr>
                            <tr>
                            	<th>
                            		<sbux-label id="th_text12" name="th_text12" uitype="normal" text="<spring:message code='sr.signature'/>"></sbux-label>
                            	</th>
                            	<td colspan="3" class="tdText">
									<textarea name="emailSignature" id="emailSignature" style=" display:none;"></textarea> 			                                	
									<div id="editor" >${userManageVO.emailSignature}</div>
								</td>
                            </tr>

                        </table>
                       </form>
                      </div>
                       <!-- 버튼 시작(상세지정 style로 div에 지정) -->
						<div class="btn_buttom">
		                   	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save" />" onclick="fnUpdate()" class="btn-default"></sbux-button>
		                   	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.secsn" />" onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>')" class="btn-default"></sbux-button>
		                   	<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.passwordUpdate" />" onclick="fnPasswordMove()" class="btn-default"></sbux-button>
		                   	<sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.reset" />" onclick="fnreset();" class="btn-default"></sbux-button> 
		               	</div>
	                    <!-- 버튼 끝 --> 
                       
                </div>
                     
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    	<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

