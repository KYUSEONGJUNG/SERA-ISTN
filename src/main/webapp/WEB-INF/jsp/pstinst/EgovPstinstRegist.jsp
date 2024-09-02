<%--
  Class Name : EgovUserInsert.jsp
  Description : 고객사등록View JSP
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<!--  <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >-->

<title>고객사 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="pstinstVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fnListPage(){
    document.pstinstVO.action = "<c:url value='/pstinst/EgovPstinstList.do'/>";
    document.pstinstVO.submit();
}
function fnInsert(){
	if(validatePstinstVO(document.pstinstVO)){
		
		//중복확인
    	var rows = document.getElementById("rowAddTable").rows.length;
    	var cnt = 0;	
    	
    	for(var i=rows-2;i>=0;i--){
    		for(var j=rows-2;j>=0;j--){
    			if(document.pstinstVO.elements["moduleCodes"][i].value == document.pstinstVO.elements["moduleCodes"][j].value){
    				cnt++;    				
    			}
    			
    		}
    		if(cnt > 1){
    			alert("중복된 모듈이 있습니다.");
          	 	return;
    		}
    		cnt = 0;
    	}
        document.pstinstVO.submit();
    }
}
//모듈담당자 추가
var enableRowCnt = 0;
function fncAdd(index)	{
	
	var orderNum = enableRowCnt+2;
	var sTable = document.getElementById("rowAddTable");

	enableRowCnt++;
	
	var lastRow = sTable.rows.length;
	

	var row = sTable.insertRow(lastRow);
	row.id = "rowTr"+enableRowCnt;
	
	row.className = "tdcenter";
	
	var cell01 = row.insertCell(0);
	cell01.innerHTML ="&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selectBox' id='selectBox"+enableRowCnt+"' />"; 
	
	var cell02 = row.insertCell(1);
	cell02.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='moduleCodes' id='moduleCode"+enableRowCnt+"' title='모듈코드'><option value='' >==선택==</option><c:forEach var='result' items='${moduleCode_result}' varStatus='status'><option value='<c:out value="${result.code}"/>'><c:out value='${result.codeNm}'/></option></c:forEach></select>";
	
	var cell03 = row.insertCell(2);
	cell03.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='userIdAs' id='userIdA"+enableRowCnt+"' title='담당자'><option value='' >==선택==</option><c:forEach var='result' items='${chargerList}' varStatus='status'><option value='<c:out value="${result.userId}"/>'><c:out value='${result.userNm}'/></option></c:forEach></select>";
	
	var cell04 = row.insertCell(3);
	cell04.innerHTML ="&nbsp;&nbsp;&nbsp;<select name='userIdBs' id='userIdB"+enableRowCnt+"' title='담당자'><option value='' >==선택==</option><c:forEach var='result' items='${chargerList}' varStatus='status'><option value='<c:out value="${result.userId}"/>'><c:out value='${result.userNm}'/></option></c:forEach></select>";
	
}

//모듈담당자 삭제
function fncAddDelete()	{
	
	var rows = document.getElementById("rowAddTable").rows.length;
	
	var j=rows-2;
	var cnt = 0;	
	
	if(j == 0) {
		if(document.pstinstVO.elements["selectBox"].checked==false){
			alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
			return;
		}else{	
			alert("첫행은 삭제할수 없습니다.");
      	 	return;
		}
	} 
	
	for(var i=rows-2;i>=0;i--){
		if(document.pstinstVO.elements["selectBox"][i].checked){
			cnt++;
		}
	}
	
    if(cnt == 0){
		alert("삭제 할 항목을 선택하여 주시기 바랍니다.");
		return;
    }
//     if(confirm("삭제 하시겠습니까?")){
	    for(var i=rows-2;i>=0;i--){
			if(document.pstinstVO.elements["selectBox"][i].checked){
				document.getElementById("rowAddTable").deleteRow(i+1);
				cnt++;
			}
		}
		enableRowCnt--;
// 	}
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>

</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div class="sr-contents-wrap">
    <!-- header 시작 -->
    <c:import url="/sym/mms/EgovMainMenuLeft.do" />
    <!-- //header 끝 --> 
    <!-- container 시작 -->
    	<div class="sr-contents-area">
            <!-- 현재위치 네비게이션 시작 -->
            <div class="sr-contents">
               <div class="sr-breadcrumb-area">                
	                <sbux-breadcrumb id="breadcrumb" name="breadcrumb" uitype="text" jsondata-ref="menuJson" disabled></sbux-breadcrumb>
	            </div>
			   
                <!-- 검색 필드 박스 시작 -->
		        <form modelAttribute="pstinstVO" action="${pageContext.request.contextPath}/pstinst/EgovPstinstRegist.do" name="pstinstVO" method="post" >
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
			                	<sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="고객사명"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input id="name" name="name" size="30"  maxlength="30" style="width : 100%"/>
						    </td>
						    <th>
			                	<sbux-label id="th_text2" name="th_text2" uitype="normal" class = "imp-label" text="고객사 영문명"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="ename" id="ename" size="30"  maxlength="30" style="width:100%;"/>
						    </td>    
						  </tr>
					
						  <tr> 
						    <th>
			                	<sbux-label id="th_text3" name="th_text3" uitype="normal" text="전화번호"></sbux-label>
						    </th>
						    <td>
						    	<sbux-input name="tel" id="tel" size="30"  maxlength="30" style="width:100%"/>
				            </td>
						    <th>
								<sbux-label id="th_text4" name="th_text4" uitype="normal" text="팩스번호"></sbux-label>
						    </th>          
						    <td>
						    	<sbux-input name="fax" id="fax" size="30"  maxlength="30" style="width:100%"/>
						    </td>    
						  </tr>
						  
						  
						  <tr>
						    <th>
								<sbux-label id="th_text5" name="th_text5" uitype="normal" text="주소"></sbux-label>						    
						    </th>
						    <td width="30%" colspan="3" class="tdleft">
						        <hidden path="zipCode" />
		                        <a href="#LINK" onclick="javascript:fn_egov_ZipSearch(document.pstinstVO, document.pstinstVO.zipCode, document.pstinstVO.zip_view, document.pstinstVO.address1, document.pstinstVO.address2);">
		                            <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(주소 검색)
		                        </a>
						        <input path="address1" id="address1" title="주소" cssClass="txaIpt" size="60" maxlength="255" readonly="true" />
			                    <input name="zip_view" id="zip_view" type="hidden" title="우편번호" size="20" value="<c:out value='${pstinstVO.zipCode}'/>"  maxlength="8" readonly="readonly" />
						    </td>
						  </tr>
						  
						  <tr>  
						    <th width="20%" height="23" class="tdblue"  >상세주소</th>
						    <td width="30%" colspan="3" class="tdleft">
						        <input path="address2" id="address2" title="상세주소" cssClass="txaIpt" size="74" maxlength="255" />
						    </td>
						  </tr>	
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >결재기능</th>
						    <td width="30%" class="tdleft">
						    	<spring:message code="pstinst.settleY" /> : <input type="radio" name="settleAt" class="radio2" value="Y" >&nbsp;
					            <spring:message code="pstinst.settleN" /> : <input type="radio" name="settleAt" class="radio2" value="N"  checked="checked">                                
						    </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >계약공수</th>          
						    <td width="30%" class="tdleft">
						    	<input path="contractTime" id="contractTime" onclick="checkNum(this);" onKeyUp="checkNum(this);commaDot(this,8,2);" cssStyle="ime-mode:disabled; text-align:right;" cssClass="txaIpt" size="10"  maxlength="10" />
				                &nbsp;<spring:message code='sr.predictionLabourHoursEx'/>
						    </td>    
						  </tr>
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >계약방식</th>
						    <td width="30%" class="tdleft">
						    	<input path="contractKind" id="contractKind" cssClass="txaIpt" size="20"  maxlength="20" />
						    </td>
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >업종코드</th>          
						    <td width="30%" class="tdleft"><label for="jobCode"></label>
				                  <select name="jobCode" class="select" title="업종코드">
								    <c:forEach var="result" items="${jobCode_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == pstinstVO.jobCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								  </select>
						    </td>    
						  </tr>
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >고객사 약어
						    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
						    </th>          
						    <td width="30%" class="tdleft">
						    	<input path="pstinstAbrv" id="pstinstAbrv" cssClass="txaIpt" size="2"  maxlength="2" />
						    </td> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >삭제여부</th>
						    <td width="30%"  class="tdleft"><label for="jobCode"></label>
						    	<select name="delAt" class="select" title="삭제여부">
								    <c:forEach var="result" items="${delAt_result}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == pstinstVO.delAt}">selected</c:if>><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								  </select>
						    </td>
						  </tr>
						  
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row" nowrap >비고</th>
						    <td width="80%" colspan="3" class="tdleft"><label for="note"></label>
				                    <input path="note" id="note" cssClass="txaIpt" size="105" maxlength="300" />
							</td>
						  </tr>
						  
                        </table>
                    </div>
                    
                    <br/>
                    <div class="inputtb" >
                    	<table width="980" border="0" cellpadding="0" cellspacing="0" summary="모듈담당자 지정 테이블이다.">
                    	  <tr>
			                <td bgcolor="#0257a6" height="2"></td>
			              </tr>
                    	  <tr>
                    	    <td></td>
                    	  </tr>
                    	</table>
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="모듈담당자 지정 테이블이다." id="rowAddTable">
						  <tr>
						    <th width="5%" height="23" class="tdblue3" scope="row" nowrap >선택</th>
						    <th width="15%" height="23" class="tdblue3" scope="row" nowrap >모듈<img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>          
						    <th width="40%" height="23" class="tdblue3" scope="row" nowrap >정</th>
						    <th width="40%" height="23" class="tdblue3" scope="row" nowrap >부</th>
						  </tr>
						  <c:choose>
						  	<c:when test="${!empty srchargerList}">
						  		<c:set var="trIdValue" value="0"/>
						  		<c:forEach var="list" items="${srchargerList}" varStatus="status">
						  		<tr id="rowTr${trIdValue}">
						  			<td class="tdcenter"><input type="checkbox" name="selectBox" id="selectBox${status.index}" value="" /></td>	
						  			<td class="tdcenter">
										<select name="moduleCodes" id="moduleCode${trIdValue}" class="select" title="모듈코드">
											<option value='' >==선택==</option>
										    <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == list.moduleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>
						  			<td class="tdcenter">
						  				<select name="userIdAs" id="userIdA${trIdValue}" class="select" title="담당자">
						  					<option value='' >==선택==</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdA}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>
						  			<td class="tdcenter">
						  				<select name="userIdBs" id="userIdB${trIdValue}" class="select" title="담당자">
						  					<option value='' >==선택==</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>		
						  		</tr>	
						  		<c:set var="trIdValue" value="${trIdValue+1}"/>
						  		</c:forEach>
						  		
						  	</c:when>
						  	<c:otherwise>
						  		<c:set var="trIdValue" value="0"/>
						  		<tr>
						  			<td class="tdcenter"><input type="checkbox" name="selectBox" id="selectBox${trIdValue}" value=""  /></td>		
						  			<td class="tdcenter">
										<select name="moduleCodes" id="moduleCode${trIdValue}" class="select" title="모듈코드">
											<option value='' >==선택==</option>
										    <c:forEach var="result" items="${moduleCode_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>'  <c:if test="${result.code == list.moduleCode}">selected</c:if>><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>
						  			<td class="tdcenter">
						  				<select name="userIdAs" id="userIdA${trIdValue}" class="select" title="담당자">
						  					<option value='' >==선택==</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdA}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>
						  			<td class="tdcenter">
						  				<select name="userIdBs" id="userIdB${trIdValue}" class="select" title="담당자">
						  					<option value='' >==선택==</option>
										    <c:forEach var="result" items="${chargerList}" varStatus="status">
												<option value='<c:out value="${result.userId}"/>'  <c:if test="${result.userId == list.userIdB}">selected</c:if>><c:out value="${result.userNm}"/></option>
											</c:forEach>
										 </select>
						  			</td>	
						  		</tr>
						  	</c:otherwise>	
						  				
						  </c:choose> 
						  
                        </table>
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="모듈담당자 지정 테이블이다.">
                    	  <tr>
			                <td bgcolor="dcdcdc" height="1"></td>
			              </tr>
                    	  <tr>
                    	    <td></td>
                    	  </tr>
                    	</table>
                        
                    </div>
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncAdd(); return false;">담당자추가 ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncAddDelete(); return false;">담당자삭제 ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="JavaScript:fnInsert(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="<c:url value='/pstinst/EgovPstinstList.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:document.pstinstVO.reset();"><spring:message code="button.reset" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 -->   

			        <!-- 검색조건 유지 -->

			        <!-- 우편번호검색 -->
			        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/EgovCcmZipSearchPopup.do'/>" />
			        
			        <!-- 검색조건 유지 -->
			        
                </form>

            </div>  
            <!-- //content 끝 -->    
    <!-- //container 끝 -->
    </div>
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function dchk2(num) {
	   num = num.toString();
	   var dot = 0;
	   var dottmp = new Array();
	   dot = ( num.indexOf(".") != -1 )? num.length - num.indexOf("."): 0;
	   var vlen = num.length - dot ;
	   var c = 1;
	   var tmp = new Array();
	   for ( i = vlen ; i > -1; i-- ) {
	      c++;
	      tmp[i] = ( ( c%3 == 0 ) && ( i != vlen - 1) )? num.charAt(i) + "," : num.charAt(i);
	   }
	   if ( dot > 1 ) {
	      num = num.split(".");
	      if ( num != null ) {
	         for ( i = 0; i < tmp.length; i++ ) {
	            dottmp[i] = tmp[i];
	         }
	         dottmp[tmp.length-1] = dottmp[tmp.length-1] + num[1];
	         return dottmp ;
	      }
	   }
	   return tmp;
	}
function CommaIns(val, intLen, dotLen) {
	   var vals = "";
	   vals = val.toString();
	   
	   if ( vals.indexOf(".") != -1 ) {
	      var dotpos = vals.split(".");
	      if ( dotpos[1].length > dotLen ) {
	         vals = vals.substring( 0, vals.length - 1);
	         return vals;
	      }
	   }else{
		   if ( vals.replace(/,/gi,'').length > intLen ) {
			   vals = vals.substring( 0, vals.length - 1);
		       return vals;
		   }
	   }
	   
	   
	   var pas = "";
	   comma=/,/gi;
	   var sol = dchk2(vals.replace(comma,''));
	   for ( i=0; i<sol.length; i++ ) {
	      pas += sol[i];
	   }
	   return pas;
	}
	

function commaDot(obj) {
		key = event.keyCode;
	    if( ( key == 13 )||( key == 9 ))
	    {
	       return;
	    }
	    if ( ( obj.value.length == 2 ) && ( obj.value.charAt(0) == '0' ) ) {
	        if ( (obj.value.substring(0, 2) == "00") || ( obj.value.substring(0, 2) != "0." ) ) {
	           obj.value = "";
	           return;
	        }
	    }
	    obj.value = CommaIns(obj.value);
	}

function checkNum(obj) {
	 var word = obj.value;
	 var str = "1234567890.";
	 for (i=0;i< word.length;i++){
		 if(str.indexOf(word.charAt(i)) < 0){
			 alert("숫자만 입력 가능합니다.");
			 obj.value="";
			 obj.focus();
			 return false;
		 }
	 }
} 

</script>
