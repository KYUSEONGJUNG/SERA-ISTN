<%--
  Class Name : EgovProgramListDetailSelectUpdt.jsp
  Description : 프로그램목록 상세조회및 수정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >

<title>프로그램목록리스트</title>

<script language="javascript1.2" type="text/javaScript">

function insertProgramListManage() {
    var form = document.progrmManageVO;    
    if(validateProgrmManageVO(form)){
    	if(confirm("<spring:message code="common.save.msg" />")){    	       
        	form.cmd.value = "insert";
            form.action="<c:url value='/sym/prm/EgovProgramListRegist.do'/>";
            form.submit();        
    	}	
    }	
}
/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateProgramListManage() {
	var form = document.progrmManageVO;
	if(validateProgrmManageVO(form)){
    	if(confirm("<spring:message code="common.save.msg" />")){    	       
    		form.cmd.value = "update";
            form.action="<c:url value='/'/>sym/prm/EgovProgramListDetailSelectUpdt.do";
            form.submit();      
    	}	
    }	
}

function validateProgrmManageVO(form){
	var checkOption = {
			progrmFileNm : { valid : "required" , label : "프로그램파일명"}
			, progrmStrePath : { valid : "required" , label : "저장경로"}
			, progrmKoreanNm : { valid : "required" , label : "프로그램 한글명"}
			, URL : { valid : "required" , label : "URL"}
		}	
		if(validateCheck(form, checkOption)){
			return true;
		}
		return false;
}

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteProgramListManage() {
	var form = document.progrmManageVO;
    if(confirm("<spring:message code="common.delete.msg" />")){
        form.action="<c:url value='/'/>sym/prm/EgovProgramListManageDelete.do";
        form.submit();
    }
}

/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList_bak(){
    location.href = "<c:url value='/'/>sym/prm/EgovProgramListManageSelect.do";
}
function fncSelectList() {
    var varForm = document.getElementById("progrmManageVO");
    varForm.action = "<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>";
    varForm.submit();       
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>

</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
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
                <form modelAttribute="progrmManageVO" id="progrmManageVO" name="progrmManageVO" method="post" >
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input name="cmd" type="hidden" value=""/>
                    <div class="sr-table-wrap">
				         <table class="sr-table">
	                        <colgroup>
	                            <col width="12%">
	                            <col width="*">
	                        </colgroup>	                      
						  <tr>  
						    <th>
                                <sbux-label id="th_text2" name="th_text2" uitype="normal" text="프로그램파일명" class = "imp-label"></sbux-label>
                            </th>
						    <td >
						    	<sbux-input name="progrmFileNm" id="progrmFileNm" uitype="text" value="<c:out value='${progrmManageVO.progrmFileNm}'/>" />
					    	</td>	
						    
						  </tr>
						  
						  <tr>  
						    <th>
						    	<sbux-label id="th_text3" name="th_text3" uitype="normal" text="저장경로" class = "imp-label"></sbux-label>
					    	</th>
						    <td >
						    	<sbux-input name="progrmStrePath" id="progrmStrePath" uitype="text" value="<c:out value='${progrmManageVO.progrmStrePath}'/>" />
					    	</td>	
						  </tr>
						  
						  <tr>  
						    <th>
						    	<sbux-label id="th_text4" name="th_text4" uitype="normal" text="프로그램 한글명"  class = "imp-label"></sbux-label>
					    	</th>
						    <td >
						    	<sbux-input name="progrmKoreanNm" id="progrmKoreanNm" uitype="text" value="<c:out value='${progrmManageVO.progrmKoreanNm}'/>" />
					    	</td>
						  </tr>
						  <tr>  
						    <th>
						    	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="URL" class = "imp-label"></sbux-label>
					    	</th>
						    <td >
						    	<sbux-input name="URL" id="URL" uitype="text" value="<c:out value='${progrmManageVO.URL}'/>" />
					    	</td>
						  </tr>
						  <tr>  
						    <th>
						    	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="프로그램설명"></sbux-label>
					    	</th>
						    <td >
						    	<sbux-textarea name="progrmDc" id="progrmDc" cols="100" rows="5"><c:out value = "${progrmManageVO.progrmDc}"/></sbux-textarea> 
					    	</td>
						  </tr>
                        </table>
                    </div>             
                </form>
                
                <div class="btn_buttom">
					<c:if test="${empty progrmManageVO.progrmFileNm}">   
                    	<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.save" />" onclick="insertProgramListManage(); return false;" class="btn-default"></sbux-button>
                	</c:if>
                	<c:if test="${not empty progrmManageVO.progrmFileNm}">
                    	<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.save"/>" onclick="updateProgramListManage(); return false;" class="btn-default"></sbux-button>
                    	<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.delete"/>" onclick="fncRoleDelete();" class="btn-default"></sbux-button> 
                    </c:if>
                    <sbux-button id="button4" name="button4" uitype="normal" text="<spring:message code="button.list"/>" onclick="fncSelectList();" class="btn-default"></sbux-button> 

                                    
                </div>

            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    	<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
    </div>
</div>
<%-- <div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>내부시스템관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>메뉴관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>프로그램목록관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 프로그램목록관리 > 프로그램목록 상세조회(수정)</li>
			        </ul>
			   </div>	
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>프로그램목록 상세조회 /수정</strong></h2></div> -->
<!--                 </div> -->
                <form:form modelAttribute="progrmManageVO" action="${pageContext.request.contextPath}/sym/prm/EgovProgramListDetailSelectUpdt.do">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="inputtb" >
                        <table width="980" border="0" cellpadding="0" cellspacing="0" summary="프로그램목록 상세조회 /수정">
						  <tr>
				              <td colspan="4" bgcolor="#0257a6" height="2"></td>
				          </tr>
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmFileNm">프로그램파일명</label>
						    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      <input type="text" disabled="disabled" value="<c:out value="${progrmManageVO.progrmFileNm  }"/>" >
						      <form:input  path="progrmFileNm" size="50"  maxlength="50" title="프로그램파일명" cssStyle="display:none" />
						      <form:errors path="progrmFileNm"/>
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmStrePath">저장경로</label>
						    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      <form:input  path="progrmStrePath" size="50"  maxlength="50" title="저장경로"/>
						      <form:errors path="progrmStrePath"/> 
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="progrmKoreanNm">프로그램 한글명</label>
						    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      <form:input path="progrmKoreanNm" size="60"  maxlength="50"  title="프로그램 한글명"/>
						      <form:errors path="progrmKoreanNm" /> 
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th width="20%" height="23" class="tdblue" scope="row"><label for="URL">URL</label>
						    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" /></th>
						    <td width="80%" nowrap="nowrap">
						      <form:input path="URL" size="60"  maxlength="60" title="URL" />
						      <form:errors path="URL" /> 
						    </td>
						  </tr>
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
						  <tr> 
						    <th height="23" class="tdblue" scope="row"><label for="progrmDc">프로그램설명</label></th>
						    <td>
						      <form:textarea path="progrmDc" rows="14" cols="75" title="프로그램설명"/>
						      <form:errors path="progrmDc"/>
						    </td>
						  </tr> 
						  
						  <tr>
				              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				          </tr>
				          
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="list4">
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:fncSelectList()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.list" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="#LINK" onclick="javascript:updateProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
                    	<span class="btnblue"><a href="<c:url value='/sym/prm/EgovProgramListManageDelete.do'/>?progrmFileNm=<c:out value="${progrmManageVO.progrmFileNm  }"/>" onclick="deleteProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
                    </div>
                    <!-- 버튼 끝 -->  
                    
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
<!--                     <div class="buttons" style="padding-top:10px;padding-bottom:10px;"> -->
<!--                         목록/저장버튼  -->
<!--                         <table border="0" cellspacing="0" cellpadding="0" align="center"> -->
<!--                         <tr>  -->
<!--                           <td>                             -->
<!--                             <a href="#LINK" onclick="javascript:fncSelectList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a>  -->
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
                            <a href="#LINK" onclick="javascript:updateProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.save" /></a> 
<!--                           </td> -->
<!--                           <td width="10"></td> -->
<!--                           <td> -->
                            <a href="<c:url value='/sym/prm/EgovProgramListManageDelete.do'/>?progrmFileNm=<c:out value="${progrmManageVO.progrmFileNm  }"/>" onclick="deleteProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.delete" /></a> 
<!--                           </td> -->
<!--                         </tr> -->
<!--                         </table> -->
<!--                     </div> -->
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <input name="cmd" type="hidden" value="<c:out value='update'/>"/>

                    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                    
                    <input name="searchProgrmFileNm" type="hidden" value="<c:out value='${searchVO.searchProgrmFileNm}'/>"/>
                    <input name="searchProgrmKoreanNm" type="hidden" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>"/>
                    <input name="searchUrl" type="hidden" value="<c:out value='${searchVO.searchUrl}'/>"/>
                    
                    <!-- 검색조건 유지 -->
                </form:form>

            </div>  
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div> --%>
<!-- //전체 레이어 끝 -->
</body>
</html>

