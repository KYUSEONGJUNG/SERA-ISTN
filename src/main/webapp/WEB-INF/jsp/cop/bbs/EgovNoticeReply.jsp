<%--
  Class Name : EgovNoticeReply.jsp
  Description : 게시물 답글 생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.24   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.24
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" >

<!-- Smart Editor CSS -->
<link href="<c:url value='/'/>css/editor.css" rel="stylesheet" type="text/css" charset="utf-8"/>
<!-- //Smart Editor CSS -->

<!-- Smart Editor Script -->
<script type="text/javascript" src="<c:url value='/js/HuskyEZCreator.js'/>" charset="utf-8"></script>
<!-- //Smart Editor Script -->

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<!-- script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea/EgovWebEditor.js'/>" ></script-->
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">

    function fn_egov_validateForm(obj) {
        return true;
    }

    function fn_egov_regist_notice() {
        //document.board.onsubmit();
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
        if (!validateBoard(document.board)){
            return;
        }
        
        if (confirm('<spring:message code="common.regist.msg" />')) {
            document.board.action = "<c:url value='/cop/bbs${prefix}/replyBoardArticle.do'/>";
            document.board.submit();                    
        }
    }
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.board.submit();    
    }
</script>
<style type="text/css">
.noStyle {background:ButtonFace; BORDER-TOP:0px; BORDER-bottom:0px; BORDER-left:0px; BORDER-right:0px;}
  .noStyle th{background:ButtonFace; padding-left:0px;padding-right:0px}
  .noStyle td{background:ButtonFace; padding-left:0px;padding-right:0px}
</style>
<title><c:out value='${bdMstr.bbsNm}'/> - <spring:message code='button.comment'/><spring:message code='button.create'/></title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>

<!-- body onload="javascript:editor_generate('nttCn');"-->
<!-- <body onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.board.nttSj.focus();"> -->
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
			<div class="list2">
		     	<ul>
		       	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > <spring:message code='cop.cmmnty'/> > 
<%-- 		       	${brdMstrVO.bbsNm} --%>
	  				<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${brdMstrVO.bbsNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${brdMstrVO.bbsNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${brdMstrVO.bbsNmCn}"/></c:when>
	  				</c:choose> 		       	
		       	 > <strong><spring:message code='button.comment'/><spring:message code='button.create'/></strong></li>
		       </ul>
		  	</div>
		  	
            <!-- 검색 필드 박스 시작 -->
            <form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="hidden" name="replyAt" value="Y" />
            <input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
            <input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
            <input type="hidden" name="parnts" value="<c:out value='${searchVO.parnts}'/>" />
            <input type="hidden" name="sortOrdr" value="<c:out value='${searchVO.sortOrdr}'/>" />
            <input type="hidden" name="replyLc" value="<c:out value='${searchVO.replyLc}'/>" />
            
            <input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
            <input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
            <input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
            <input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
            <input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
            <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
            <input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
            <input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
            
            <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />
            
            <c:if test="${anonymous != 'true'}">
                <input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
                <input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
            </c:if>
                
            <c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
               <input name="ntceBgnde" type="hidden" value="10000101">
               <input name="ntceEndde" type="hidden" value="99991231">
            </c:if>

            <div class="inputtb" >
          		<table width="980" border="0" cellpadding="0" cellspacing="0" summary="글제목, 글내용 등을 가지고 있는 게시글 상세조회(수정) 테이블이다.">
                	<tr>
	              		<td colspan="4" bgcolor="#0257a6" height="2"></td>
	            	</tr>
	            	<c:if test="${bdMstr.bbsId == 'BBSMSTR_000000000011'}">
	            		<input type="hidden" name="pstinstCode" value="<c:out value='${result.pstinstCode}'/>" >
	            	</c:if>
                  	<tr> 
                        <th width="20%" height="23" class="tdblue" nowrap ><LABEL for="nttSj"><spring:message code="cop.nttSj" /></LABEL>
                            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
                        </th>
                        <td width="80%" nowrap class="tdleft" colspan="3">
                          	<input id="nttSj" name="nttSj" type="text" size="60" value="RE: <c:out value='${result.nttSj}'/>"  maxlength="60" > 
                          	<br/><form:errors path="nttSj" />
                        </td>
                   	</tr>
                   	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                   	<tr> 
                        <th height="23" class="tdblue"><LABEL for="nttCn"><spring:message code="cop.nttCn" /></LABEL>
                            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
                        </th>
                        <td colspan="3" class="tdleft">
                          	<textarea id="nttCn" name="nttCn" class="textarea"  cols="75" rows="20"  style="width:99%;"></textarea> 
                          	<form:errors path="nttCn" />
                        </td>
                  	</tr>
                  	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                 	<c:if test="${bdMstr.bbsAttrbCode == 'BBSA01'}"> 
                   	<tr> 
                           <th height="23" class="tdblue"><spring:message code="cop.noticeTerm" />
                           	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required" />
                           </th>
                           <td colspan="3" class="tdleft">
                             	<input name="ntceBgnde" type="hidden" value="">
                             	<input name="ntceBgndeView" title="게시시작일" type="text" size="10" value=""  readonly="readonly"
                                onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');" >
                             		<img src="<c:url value='/images/sr/icon_calendar.gif' />"
                               	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                               	width="15" height="15" alt="calendar">
                             	~
                             	<input name="ntceEndde" type="hidden"  value="">
                             	<input name="ntceEnddeView" title="게시종료일" type="text" size="10" value=""  readonly="readonly"
                               	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"  >
                             	<img src="<c:url value='/images/sr/icon_calendar.gif' />"
                               	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/ccm/EgovselectNormalCalendar.do'/>');"
                               	width="15" height="15" alt="calendar">
                              	<br/><form:errors path="ntceBgndeView" />
                              	<br/><form:errors path="ntceEnddeView" />             
                           </td>
                   	</tr>
                   	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                   	</c:if>   
                   	<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">  
                  	<tr>
                        <th height="23" class="tdblue"><LABEL for="egovComFileUploader"><spring:message code='cop.atchFile'/></LABEL></th>
                        <td colspan="3" class="tdleft">
                        	<input name="file_1" id="egovComFileUploader" type="file" />
                            	<div id="egovComFileList"></div>
                     	</td>
                   	</tr>
                   	<tr>
				    	<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
				   	</tr>
                    </c:if>
                </table>  
                <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">  
                    <script type="text/javascript">
	                     var maxFileNum = document.board.posblAtchFileNumber.value;
	                     if (maxFileNum==null || maxFileNum=="") {
	                         maxFileNum = 3;
	                     }
	                     var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	                     multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );         
                     </script>
                </c:if>
            </div>

			<!-- 버튼 시작(상세지정 style로 div에 지정) -->
         	<div class="list4">
         		<c:if test="${bdMstr.authFlag == 'Y'}">
         			<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_regist_notice(); return false;"><spring:message code="button.save" /> ▶</a></span>&nbsp;
         		</c:if>
         		<span class="btnblue"><a href="#LINK" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /> ▶</a></span>&nbsp;
	       	</div>
         	<!-- 버튼 끝 -->  
            </form:form>

        </div>  
        <!-- //content 끝 -->    
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->

<!-- Smart Editor Script -->
<script type="text/javascript">
	var oEditors = [];
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "nttCn",
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
			//oEditors.getById["nttCn"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});

	function pasteHTML(filepath){ 
	
	    var sHTML = '<img src="<%=request.getContextPath()%>/' + filepath + '">'; 
	//    alert(sHTML); 
	    oEditors.getById["nttCn"].exec("PASTE_HTML", [sHTML]); 
	
	}

	function showHTML() {
		var sHTML = oEditors.getById["nttCn"].getIR();
		alert(sHTML);
	}
	
	function submitContents(elClickedObj) {
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("nttCn").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}

	function setDefaultFont() {
		var sDefaultFont = '맑은고딕';
		var nFontSize = 24;
		oEditors.getById["nttCn"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<!-- //Smart Editor Script -->

</body>
</html>

