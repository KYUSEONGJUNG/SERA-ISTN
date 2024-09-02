<%--
  Class Name : EgovAuthorUpdate.jsp
  Description : EgovAuthorUpdate 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<c:set var="registerFlag" value="${empty authorManage.authorCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty authorManage.authorCode ? '권한 등록' : '권한 수정'}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->

<title>권한 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="authorManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectAuthorList() {
    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    varFrom.submit();       
}

function fncAuthorInsert() {

    var varFrom = document.getElementById("authorManage");
    //varFrom.action = "<c:url value='/sec/ram/EgovAuthorInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            //varFrom.submit();
            var form = $("#authorManage")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sec/ram/EgovAuthorInsert.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.reload(true);
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

function fncAuthorUpdate() {
    var varFrom = document.getElementById("authorManage");
    //varFrom.action = "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            //varFrom.submit();
            var form = $("#authorManage")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.reload(true);
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

function fncAuthorDelete() {
    var varFrom = document.getElementById("authorManage");
    //varFrom.action = "<c:url value='/sec/ram/EgovAuthorDelete.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        //varFrom.submit();
        var form = $("#authorManage")[0];
		var formData = new FormData(form);
                
        $.ajax({        	
			url : "<c:url value='/sec/ram/EgovAuthorDelete.do'/>"			
			,type : "POST"
			,data : formData
	     	,contentType : false
	     	,processData : false
			,beforeSend : fn_loading()
			,success : function(data){

				alert(data.msg);
				if(data.msgType == 'S') {
					location.replace("<c:url value='/sec/ram/EgovAuthorList.do'/>");
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

function validateAuthorManage(form){
	var checkOption = {
		authorCode : 
			{ valid : "required, maxlength" 
			, label : "권한코드" 
			, max : 40 }
		, authorNm : 
			{ valid : "required, maxlength" 
			, label : "권한명"
			, max : 40}
		, authorDc : 
			{ valid : "maxlength" 
			, label : "설명"
			, max : 50}
	}	
	if(validateCheck(form, checkOption)){
		return true;
	}
	return false;
}

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
					<sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
				</div>
                <!-- 검색 필드 박스 시작 -->
                <form modelAttribute="authorManage" id="authorManage" name="authorManage" method="post" >
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="sr-table-wrap">
				         <table class="sr-table">
	                        <colgroup>
	                            <col width="12%">
	                            <col width="38%">
	                            <col width="12%">
	                            <col width="38%">
	                        </colgroup>
						  <tr>
						    <th>
								<sbux-label id="th_text1" name="th_text1" uitype="normal" text="권한 코드" class = "imp-label"></sbux-label>						    
							</th>
						    <td style="border-right : 0px;">
						    	<sbux-input name="authorCode" id="authorCode" uitype="text" value="<c:out value='${authorManage.authorCode}'/>" style="width : 100%" title="권한코드"/>
					    	</td>
					    	<td style="border-right : 0px; border-left : 0px;">
					    	</td>
					    	<td style="border-left : 0px;">
				    		</td>						     
						  </tr>
       	  
						  <tr>  
						    <th>
                                <sbux-label id="th_text2" name="th_text2" uitype="normal" text="권한 명" class = "imp-label"></sbux-label>
                            </th>
						    <td style="border-right : 0px;">
						    	<sbux-input name="authorNm" id="authorNm" uitype="text" value="<c:out value='${authorManage.authorNm}'/>" style="width : 100%" title="권한명"/>
					    	</td>
					    	<td style="border-right : 0px; border-left : 0px;">
					    	</td>
					    	<td style="border-left : 0px;">
				    		</td>	
						    
						  </tr>
						  
						  <tr>  
						    <th>
						    	<sbux-label id="th_text3" name="th_text3" uitype="normal" text="설명"></sbux-label>
					    	</th>
						    <td style="border-right : 0px;">
						    	<sbux-input name="authorDc" id="authorDc" uitype="text" value="<c:out value='${authorManage.authorDc}'/>" style="width : 100%" title="설명"/>
					    	</td>
					    	<td style="border-right : 0px; border-left : 0px;">
					    	</td>
					    	<td style="border-left : 0px;">
				    		</td>	
						  </tr>
						  
						  <tr>  
						    <th>
						    	<sbux-label id="th_text4" name="th_text4" uitype="normal" text="등록일자"></sbux-label>
					    	</th>
						    <td style="border-right : 0px;">
						    	<sbux-input name="authorCreatDe" id="authorCreatDe" uitype="text" value="<c:out value='${authorManage.authorCreatDe}'/>" style="width : 100%" readonly title="등록일자"/>
					    	</td>
					    	<td style="border-right : 0px; border-left : 0px;" > 
					    	</td>
					    	<td style="border-left : 0px;">
				    		</td>
						  </tr>
						  
                        </table>
                    </div>
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) 
                    <div class="list4">
                    	<c:if test="${registerFlag == 'INSERT'}">
	                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    	</c:if>
                    	<c:if test="${registerFlag == 'UPDATE'}">
	                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncAuthorUpdate()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.save" /> ▶</a></span>&nbsp;
	                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncAuthorDelete()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
                    	</c:if>
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncSelectAuthorList()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    </div>-->
                    <!-- 버튼 끝 -->                            

					<!-- 검색조건 유지 -->
					<c:if test="${registerFlag == 'UPDATE'}">
					<input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
					<input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
					<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
					</c:if>
                    <!-- 검색조건 유지 -->
                </form>
                
                <div class="btn_buttom">
					<c:if test="${empty authorManage.authorCode}">   
                    	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save" />" onclick="fncAuthorInsert(); return false;" class="btn-default"></sbux-button>
                	</c:if>
                	<c:if test="${not empty authorManage.authorCode}">
                    	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.save"/>" onclick="fncAuthorUpdate(); return false;" class="btn-default"></sbux-button>
                    	<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.delete"/>" onclick="fncAuthorDelete();" class="btn-default"></sbux-button> 
                    </c:if>
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fncSelectAuthorList();" class="btn-default"></sbux-button> 
                    
                                    
                </div>


            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    	<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
    </div>
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

					    						    	