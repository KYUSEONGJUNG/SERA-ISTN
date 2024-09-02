<%--
  Class Name : EgovSrList.jsp
  Description : EgovSrList 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>


<meta http-equiv="Content-Language" content="ko">
	<%-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > --%>
	<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/EgovPstinstPopup.js' />"></script>




		<title>SR <spring:message code='button.list' /></title> <script type="text/javaScript" language="javascript">
<!--

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveLanguage() {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    setCookie("saveLanguage", document.Form.language.value, expdate);
//     alert("document.Form.language.value : " + document.Form.language.value);
//     alert(getCookie("saveLanguage"));
}

// function getLanguage(form) {
// 	//임시 한국어로 고정함 wbpark  2016.06.30
//     form.language.checked = ((loginForm.language.value = getCookie("saveLanguage")) != "");
// //     form.language.checked = 'ko';
// }

// getLanguage(document.loginForm);
// saveLanguage();

/* ********************************************************
 * 새로고침 방지
 ******************************************************** */
function noEvent() {
    if (event.keyCode == 116) {		// function F5
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))		//ctrl+N , ctrl+R
    {
        return false;
    }
}
document.onkeydown = noEvent;

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sr/EgovSrList.do'/>";
    document.listForm.submit();
    document.listForm.action = "";
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
// function fn_egov_search_Sr(){
//     sC = document.listForm.searchCondition.value;
//     sK = document.listForm.searchKeyword.value; 
//     if (sC == "1") {
//         document.listForm.searchKeyword.value = sK.replace(/\-/, "");
//     }
//     document.listForm.pageIndex.value = 1;
//     document.listForm.submit();
// }
/**
 * 검색
 */
function fn_egov_search_Sr(){
	fnDateChk();
    document.listForm.pageIndex.value = 1;
    document.listForm.selectStatus.value = "";
    document.listForm.searchAt.value = "Y";
    
    //등록과 반려 체크 여부 확인
    var checkFieldStatus = document.listForm.searchStatus;
    var checkSearchStatusRetnrn = document.listForm.searchStatusRetnrn;
    
//     if(checkFieldStatus) {
//         if(checkFieldStatus.length > 1) {
//         	if(checkFieldStatus[1].checked){		//등록"
//         		document.listForm.searchStatus1001At.value = "Y";
//         	}else{
//         		document.listForm.searchStatus1001At.value = "N";
//         	}
//         } 
//     }    
//     if(checkSearchStatusRetnrn) {
// 	    if(checkSearchStatusRetnrn.checked == true) {
// 	    	checkFieldStatus[1].checked = true;		//반려시 등록 체크함    	
// 	    } 
//     }
    document.listForm.submit();
}
/**
 * 상태별 선택
 */
function fn_egov_search_SrSelect(selStatus){
    document.listForm.pageIndex.value = 1;
    document.listForm.selectStatus.value = selStatus;
    document.listForm.searchAt.value = "Y";
    document.listForm.submit();
    document.listForm.action = "";
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Sr(){
//     location.href = "<c:url value='/sr/EgovSrInsertView.do'/>";
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sr/EgovSrInsertView.do'/>";
    varForm.submit();
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Sr(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Sr(srNo){
    var varForm              = document.all["Form"];
    //var varForm = document.listForm;
    varForm.action           = "<c:url value='/sr/EgovSrSelectUpdtView.do'/>";
    varForm.srNo.value        = srNo;
    varForm.submit();
    varForm.action = "";
}
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.listForm.checkField;
//     var checkStatus = document.listForm.statusArr;
//     var checkSanctnerAt = document.listForm.sanctnerAtArr;
    
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
//                 	if(checkStatus[i].value == '1001' && (checkSanctnerAt[i].value == null || checkSanctnerAt[i].value == '')){
                    	checkField[i].checked = true;                		
//                 	}
                }
            } else {
//             	if(checkStatus.value == '1001' && (checkSanctnerAt.value == null || checkSanctnerAt.value == '')){
	                checkField.checked = true;            		
//             	}            	
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
/* ********************************************************
 * 일괄결재 처리 함수
 ******************************************************** */
function fn_egov_regist_SrSanctn(){
	if(fnChecked()) {
	    if (confirm("<spring:message code='common.sanctnAll.msg'/>")) {
	    	document.listForm.action = "<c:url value='/sr/EgovSrSanctnAll.do'/>";
	    	document.listForm.submit();
	    	document.listForm.action = "";
	    }		
	}
}
/* 
/**
 * 일괄SR결재처리
 */
function fnChecked() {
	
// 	alert("fnChecked : ");

    var checkField = document.listForm.checkField;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    
//     alert("checkField : " + checkField);
//     alert("checkId : " + checkId);
//     alert("checkField : " + document.listForm.checkField.length);

    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
//     	alert("checkField in : ");
//     	alert("checkField length : " + checkField.length);
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
            	alert('<spring:message code='common.noChecked.msg'/>');
                returnBoolean = false;
            }
        } else {
//         	alert("checkField.length > 1 else : ");
            if(document.listForm.checkField.checked == false) {
                returnBoolean = false;
                alert('<spring:message code='common.noChecked.msg'/>');
            } else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
//     	alert("checkField.length : " + checkField.length);
//     	alert("document.listForm.checkField.checked : " + document.listForm.checkField.checked);
    	alert('<spring:message code='common.noChecked.msg'/>');
    }
//     alert("returnValue : " + returnValue);
    document.listForm.srNoSanctnAllArr.value = returnValue;
    return returnBoolean;
}
/**
 * 엑셀다운로드(월간보고서)
 */
 function fncExcelReport(){
     //var varForm              = document.all["Form"];
     var varForm = document.listForm;
     varForm.selectStatus.value = "";
     varForm.action           = "<c:url value='/sr/EgovSrListExcelReport.do'/>";
     varForm.submit();
     varForm.action = "";
 } 
 
 /**
  * 엑셀다운로드(상세내역)
  */
  function fncExcelDetail(){
      //var varForm              = document.all["Form"];
      var varForm = document.listForm;
      varForm.action           = "<c:url value='/sr/EgovSrListExcelDetail.do'/>";
      varForm.submit();
      varForm.action = "";
  } 
  /**
   * 데이터 삭제
   */
  function fnClear(obj) {
	 obj.value="";
	 obj.focus();
	 return false;
  }

  /* ********************************************************
   * 모두선택 처리 함수 - 상태
   ******************************************************** */
  function fnStatusAllCheck(obj) {
      var checkFieldStatus = document.listForm.searchStatus;
      if(obj.checked) {
          if(checkFieldStatus) {
              if(checkFieldStatus.length > 1) {
                  for(var i=0; i < checkFieldStatus.length; i++) {
                	  checkFieldStatus[i].checked = true;
                  }
              } else {
            	  checkFieldStatus.checked = true;
              }
          }
      } else {
          if(checkFieldStatus) {
              if(checkFieldStatus.length > 1) {
                  for(var j=0; j < checkFieldStatus.length; j++) {
                	  checkFieldStatus[j].checked = false;
                  }
              } else {
            	  checkFieldStatus.checked = false;
              }
          }
      }
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check Start	////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
var fReqDate = "<c:out value='${searchVO.searchConfirmDateF}'/>";
var tReqDate = "<c:out value='${searchVO.searchConfirmDateT}'/>";
var fComDate = "<c:out value='${searchVO.searchCompleteDateF}'/>";
var tComDate = "<c:out value='${searchVO.searchCompleteDateT}'/>";
// 요청일 체크..
function fnReqDateChk(fdate, tdate){
	//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
	if(fdate.value != "" && tdate.value != ""){
		if(fdate.value > tdate.value){
			alert("<spring:message code='sr.error.msg.dateNotValid'/>");
			if(fReqDate != fdate.value){
				document.getElementById('searchConfirmDateF').value = fReqDate;
				if(fReqDate == ""){
					document.getElementById('searchConfirmDateFView').value = "";
				}else{
					document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
				}
			}
			if(tReqDate != tdate.value){
				document.getElementById('searchConfirmDateT').value = tReqDate;
				if(tReqDate == ""){
					document.getElementById('searchConfirmDateTView').value = "";
				}else{
					document.getElementById('searchConfirmDateTView').value = tReqDate.substring(0,4) + '-' + tReqDate.substring(4,6) + '-' + tReqDate.substring(6,8);	
				}
			}
			
		}else{
			//요청일과 완료일 비교.
			if(fdate.value != "" && fComDate != ""){
				if(fdate.value > fComDate){
					alert("<spring:message code='sr.error.msg.requestDate'/>");
					document.getElementById('searchConfirmDateF').value = fReqDate;
					if(fReqDate == ""){
						document.getElementById('searchConfirmDateFView').value = "";
					}else{
						document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
					}
					return;
				}
			}
			//From, To 일자 셋팅.
			fReqDate = fdate.value;
			tReqDate = tdate.value;
		}
	}else{
		//요청일과 완료일 비교.
		if(fdate.value != "" && fComDate != ""){
			if(fdate.value > fComDate){
				alert("<spring:message code='sr.error.msg.requestDate'/>");
				document.getElementById('searchConfirmDateF').value = fReqDate;
				if(fReqDate == ""){
					document.getElementById('searchConfirmDateFView').value = "";
				}else{
					document.getElementById('searchConfirmDateFView').value = fReqDate.substring(0,4) + '-' + fReqDate.substring(4,6) + '-' + fReqDate.substring(6,8);	
				}
				
			}
			return;
		}
		//From, To 일자 셋팅.
		fReqDate = fdate.value;
		tReqDate = tdate.value;
	}
}

//완료일 체크..
function fnComDateChk(fdate, tdate){
	//From 날짜는 To 날짜보다 미래일 수는 없다. (To 날짜는 From 날짜보다 과거일 수는 없다.)
	if(fdate.value != "" && tdate.value != ""){
		if(fdate.value > tdate.value){
			alert("<spring:message code='sr.error.msg.completionDateNotValid'/>");
			if(fComDate != fdate.value){
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
			}
			
			if(tComDate != tdate.value){
				document.getElementById('searchCompleteDateT').value = tComDate;
				if(tComDate == ""){
					document.getElementById('searchCompleteDateTView').value = "";
				}else{
					document.getElementById('searchCompleteDateTView').value = tComDate.substring(0,4) + '-' + tComDate.substring(4,6) + '-' + tComDate.substring(6,8);
				}
				
			}
			
		}else{
			//요청일과 완료일 비교.
			if(fdate.value != "" && fReqDate != ""){
				if(fdate.value < fReqDate){
					alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
					document.getElementById('searchCompleteDateF').value = fComDate;
					if(fComDate == ""){
						document.getElementById('searchCompleteDateFView').value = "";
					}else{
						document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);
					}
					return;
				}
			}
			//From, To 일자 셋팅.
			fComDate = fdate.value;
			tComDate = tdate.value;
		}
	}else{
		//요청일과 완료일 비교.
		if(fdate.value != "" && fReqDate != ""){
			if(fdate.value < fReqDate){
				alert("<spring:message code='sr.error.msg.completionDateRequestDate'/>");
				document.getElementById('searchCompleteDateF').value = fComDate;
				if(fComDate == ""){
					document.getElementById('searchCompleteDateFView').value = "";
				}else{
					document.getElementById('searchCompleteDateFView').value = fComDate.substring(0,4) + '-' + fComDate.substring(4,6) + '-' + fComDate.substring(6,8);	
				}
				return;
			}
		}
		//From, To 일자 셋팅.
		fComDate = fdate.value;
		tComDate = tdate.value;
	}
	
}


//조회시 널값인 날짜 처리.
function fnDateChk(){
	if(document.getElementById('searchConfirmDateFView').value == ""){
		document.getElementById('searchConfirmDateF').value = "";
	}
	
	if(document.getElementById('searchConfirmDateTView').value == ""){
		document.getElementById('searchConfirmDateT').value = "";
	}
	
	if(document.getElementById('searchCompleteDateFView').value == ""){
		document.getElementById('searchCompleteDateF').value = "";
	}
	
	if(document.getElementById('searchCompleteDateTView').value == ""){
		document.getElementById('searchCompleteDateT').value = "";
	}
}
////////////////////////////////////////////////////////////////////////////////////////
///////////			날짜 Valication Check End		////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>

		<script>
			//자바스크립트 Start
			$(document).ready(function(){
				$('#searchConfirmDateFView').datepicker({
					dateFormat:"yy-mm-dd",
					altFormat: "yymmdd",
					altField: "#searchConfirmDateF",
					onSelect: function(dateText){
						fnReqDateChk(document.listForm.searchConfirmDateF, document.listForm.searchConfirmDateT);
					}
				});
				$('#searchConfirmDateTView').datepicker({
					dateFormat:"yy-mm-dd",
					altFormat: "yymmdd",
					altField: "#searchConfirmDateT",
					onSelect: function(dateText){
						fnReqDateChk(document.listForm.searchConfirmDateF, document.listForm.searchConfirmDateT);
					}
				});
				$('#searchCompleteDateFView').datepicker({
					dateFormat:"yy-mm-dd",
					altFormat: "yymmdd",
					altField: "#searchCompleteDateF",
					onSelect: function(dateText){
						fnComDateChk(document.listForm.searchCompleteDateF, document.listForm.searchCompleteDateT);
					}
				});
				$('#searchCompleteDateTView').datepicker({
					dateFormat:"yy-mm-dd",
					altFormat: "yymmdd",
					altField: "#searchCompleteDateT",
					onSelect: function(dateText){
						fnComDateChk(document.listForm.searchCompleteDateF, document.listForm.searchCompleteDateT);
					}
				});
			});
</script>
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<!-- 전체 레이어 시작 -->

	<div id="wrapper">
		<div id="header">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
		</div>
		<c:import url="/sym/mms/EgovMainMenuHead.do" />
		<div id="contents">
			<form name="listForm" id="listForm" action="<c:url value='/sr/EgovSrList.do'/>" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="submit" id="invisible" class="invisible" /> <input type="hidden" name="cal_url" value="<c:url value='/sym/ccm/EgovNormalCalPopup.do'/>" />

				<c:forEach var="srCntList" items="${srCntList}" varStatus="status">
					<c:if test="${srCntList.status == '1001'}">
						<c:set var="status1001">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1002'}">
						<c:set var="status1002">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1003'}">
						<c:set var="status1003">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1004'}">
						<c:set var="status1004">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1005'}">
						<c:set var="status1005">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
					<c:if test="${srCntList.status == '1006'}">
						<c:set var="status1006">
							<c:out value='${srCntList.cnt}' />
						</c:set>
					</c:if>
				</c:forEach>
				<c:if test="${status1001 == NULL}">
					<c:set var="status1001">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1002 == NULL}">
					<c:set var="status1002">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1003 == NULL}">
					<c:set var="status1003">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1004 == NULL}">
					<c:set var="status1004">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1005 == NULL}">
					<c:set var="status1005">
						<c:out value='0' />
					</c:set>
				</c:if>
				<c:if test="${status1006 == NULL}">
					<c:set var="status1006">
						<c:out value='0' />
					</c:set>
				</c:if>

				<div class="tabstate">
					<ul>
						<li class="tab01"><a href="#LINK" onclick="fn_egov_search_SrSelect('1001'); return false;"><br /> <br /> <spring:message code='button.create' /><br />(<c:out value='${status1001}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab02"><a href="#LINK" onclick="fn_egov_search_SrSelect('1002'); return false;"><br /> <br /> <spring:message code='sr.receptionWaiting' /><br />(<c:out value='${status1002}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab03"><a href="#LINK" onclick="fn_egov_search_SrSelect('1003'); return false;"><br /> <br /> <spring:message code='sr.receptionCompletion' /><br />(<c:out value='${status1003}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab04"><a href="#LINK" onclick="fn_egov_search_SrSelect('1004'); return false;"><br /> <br /> <spring:message code='sr.beingResolved' /><br />(<c:out value='${status1004}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab05"><a href="#LINK" onclick="fn_egov_search_SrSelect('1005'); return false;"><br /> <br /> <spring:message code='sr.customerConfirm' /><br />(<c:out value='${status1005}' /> <spring:message code='sr.msg.cnt' />)</a></li>
						<li class="tab06"><a href="#LINK" onclick="fn_egov_search_SrSelect('1006'); return false;"><br /> <br /> <spring:message code='sr.completion' /><br />(<c:out value='${status1006}' /> <spring:message code='sr.msg.cnt' />)</a></li>
					</ul>
				</div>
				<div class="searchtb">
					<table width="980" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="5" bgcolor="#0257a6" height="2"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.requestDate' /></td>
							<td class="tdleft"><input name="searchConfirmDateF" id="searchConfirmDateF" type="hidden" value="<c:out value='${searchVO.searchConfirmDateF}'/>"> <input name="searchConfirmDateFView" id="searchConfirmDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchConfirmDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> ~ <input name="searchConfirmDateT" id="searchConfirmDateT" type="hidden" value="<c:out value='${searchVO.searchConfirmDateT}'/>" /> <input name="searchConfirmDateTView" id="searchConfirmDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchConfirmDateTView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> <form:errors path="searchConfirmDateF" /> <form:errors path="searchConfirmDateT" /></td>
							<td class="tdblue4"><spring:message code='sr.completionDate' /></td>
							<td class="tdleft"><input name="searchCompleteDateF" id="searchCompleteDateF" type="hidden" value="<c:out value='${searchVO.searchCompleteDateF}'/>"> <input name="searchCompleteDateFView" id="searchCompleteDateFView" title="게시시작일" type="text" size="10" value="<c:out value='${searchVO.searchCompleteDateFView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> ~ <input name="searchCompleteDateT" id="searchCompleteDateT" type="hidden" value="<c:out value='${searchVO.searchCompleteDateT}'/>" /> <input name="searchCompleteDateTView" id="searchCompleteDateTView" title="게시종료일" type="text" size="10" value="<c:out value='${searchVO.searchCompleteDateTView}'/>" readonly="readonly" onClick="javascript:fnClear(this);"> <form:errors path="searchCompleteDateF" /> <form:errors path="searchCompleteDateT" /></td>
							<td rowspan="9" align="center"><a href="#LINK" onclick="fn_egov_search_Sr(); return false;"> <c:choose>
										<c:when test="${srLanguage == 'ko'}">
											<img src="<c:url value='/' />images/sr/btn_search.gif" width="86" height="65" />
										</c:when>
										<c:when test="${srLanguage == 'en'}">
											<img src="<c:url value='/' />images/sr/btn_searchEn.gif" width="86" height="65" />
										</c:when>
										<c:when test="${srLanguage == 'cn'}">
											<img src="<c:url value='/' />images/sr/btn_searchCn.gif" width="86" height="65" />
										</c:when>
										<c:otherwise>
											<img src="<c:url value='/' />images/sr/btn_search.gif" width="86" height="65" />
										</c:otherwise>
									</c:choose>
							</a></td>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.requester' /></td>
							<td class="tdleft"><input name="searchCustomerNm" type="text" size="20" value="<c:out value='${searchVO.searchCustomerNm}'/>" maxlength="30" id="F1" title="검색조건"></td>
							<td class="tdblue4"><spring:message code='sr.charge' /></td>
							<td class="tdleft"><select name="searchRid" id="searchRid" class="select" title="담당자">
									<option value=''>==
										<spring:message code='sr.choose' />==
									</option>
									<c:forEach var="result" items="${chargerList}" varStatus="status">
										<option value='<c:out value="${result.userId}"/>' <c:if test="${result.userId == searchVO.searchRid}">selected</c:if>>
											<%-- 						<c:out value="${result.userNm}"/> --%>
											<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value="${result.userNm}" />
												</c:when>
												<c:when test="${srLanguage == 'en'}">
													<c:out value="${result.userNmEn}" />
												</c:when>
												<c:when test="${srLanguage == 'cn'}">
													<c:out value="${result.userNmEn}" />
												</c:when>
												<c:otherwise>
													<c:out value="${result.userNm}" />
												</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
							</select> <%--               	<input name="searchRname" type="text" size="20" value="<c:out value='${searchVO.searchRname}'/>"  maxlength="30" id="F1" title="검색조건"> --%></td>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
						</tr>
						<tr>
							<td class="tdblue4"><spring:message code='sr.module' /></td>
							<td class="tdleft"><select name="searchModuleCode" class="select" title="모듈코드">
									<option value=''>==
										<spring:message code='sr.choose' />==
									</option>
									<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' <c:if test="${result.code == searchVO.searchModuleCode}">selected</c:if>>
											<%-- 						<c:out value="${result.codeNm}"/> --%>
											<c:choose>
												<c:when test="${srLanguage == 'ko'}">
													<c:out value="${result.codeNm}" />
												</c:when>
												<c:when test="${srLanguage == 'en'}">
													<c:out value="${result.codeNmEn}" />
												</c:when>
												<c:when test="${srLanguage == 'cn'}">
													<c:out value="${result.codeNmCn}" />
												</c:when>
												<c:otherwise>
													<c:out value="${result.codeNm}" />
												</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
							</select></td>
							<td class="tdblue4"><spring:message code='sr.keyword' /></td>
							<td class="tdleft"><input name="searchTcode" type="hidden" value="<c:out value='${searchVO.searchTcode}'/>" maxlength="30" id="F1" title="검색조건"> <input name="searchSubject" type="text" size="30" value="<c:out value='${searchVO.searchSubject}'/>" maxlength="200" id="F1" title="검색조건"></td>
						</tr>

						<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
							<tr>
								<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							</tr>
							<tr>
								<td class="tdblue4"><label for="searchPstinstNm"><spring:message code='sr.client' /></label></td>
								<td class="tdleft"><select name="searchPstinstCode" id="searchPstinstCode" class="select" title="고객사">
										<option value=''>==
											<spring:message code='sr.choose' />==
										</option>
										<c:forEach var="result" items="${pstinstList}" varStatus="status">
											<option value='<c:out value="${result.pstinstCode}"/>' <c:if test="${result.pstinstCode == searchVO.searchPstinstCode}">selected</c:if>><c:out value="${result.pstinstNm}" /></option>
										</c:forEach>
								</select> <%-- 	           			<input name="searchPstinstNm" type="text" size="20" value="<c:out value='${searchVO.searchPstinstNm}'/>"  maxlength="30" id="F1" title="검색조건"> --%> <%-- 	           			<input type="hidden" name="pstinst_url" value="<c:url value='/pstinst/EgovPstinstSearchPopup.do'/>" /> --%> <%-- 	           			<input type="text" name="searchPstinstNm" id="searchPstinstNm" title="고객사명" size="30" maxlength="100" value="<c:out value='${searchVO.searchPstinstNm}'/>"  /> --%> <%--                         <input name="searchPstinstCode" id="searchPstinstCode" type="hidden" size="20" value="<c:out value='${searchVO.searchPstinstCode}'/>"  maxlength="30" id="F1" title="검색조건"> --%> <!--                         <a href="#LINK" onclick="javascript:fn_egov_PstinstSearch(document.listForm, document.listForm.searchPstinstCode, document.listForm.searchPstinstNm);"> --> <%--                             <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(고객사 검색) --%> <!--                         </a> --></td>
								<td class="tdblue4"><spring:message code='sr.status' /> <input type="checkbox" name="searchStatusAllCheck" value="true" <c:if test="${searchVO.searchStatusAllCheck == 'true'}">checked</c:if> onClick="javascript:fnStatusAllCheck(this);"></td>
								<td class="tdleft"><input name="searchStatus" type="hidden" value="1000" /> <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
										<c:set var="vChecked">
											<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
												<c:choose>
													<c:when test="${vList == statusCode_result.code}">checked</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</c:set>
										<%-- 	                   		<c:if test="${statusCode_result.code != '1000'}"> --%>
										<%-- 	                   			<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>><c:out value="${statusCode_result.codeDc}"/> --%>
										<%-- 	              			</c:if>	      --%>
										<c:if test="${statusCode_result.code != '1000'}">
											<!-- 반려 -->
											<c:if test="${statusCode_result.code != '1007'}">
												<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> <c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:when>
														<c:otherwise>
															<c:out value="${statusCode_result.codeNm}" />
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_COOPERATION'}">
													<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> <%-- 	                   					<c:out value="${statusCode_result.codeDc}"/> --%> <c:choose>
															<c:when test="${srLanguage == 'ko'}">
																<c:out value="${statusCode_result.codeNm}" />
															</c:when>
															<c:when test="${srLanguage == 'en'}">
																<c:out value="${statusCode_result.codeNmEn}" />
															</c:when>
															<c:when test="${srLanguage == 'cn'}">
																<c:out value="${statusCode_result.codeNmCn}" />
															</c:when>
															<c:otherwise>
																<c:out value="${statusCode_result.codeNm}" />
															</c:otherwise>
														</c:choose>
												</c:if>
											</c:if>
										</c:if>
									</c:forEach></td>
							</tr>
						</c:if>

						<!-- 현업 및 결제자 -->
						<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
							<tr>
								<td colspan="4" bgcolor="#dcdcdc" height="1"></td>
							</tr>
							<tr>
								<td class="tdblue4" valign="middle"><spring:message code='sr.status' /> <input type="checkbox" name="searchStatusAllCheck" value="true" <c:if test="${searchVO.searchStatusAllCheck == 'true'}">checked</c:if> onClick="javascript:fnStatusAllCheck(this);"></td>
								<td colspan="3" class="tdleft"><input name="searchStatus" type="hidden" value="1000" /> <c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
										<c:set var="vChecked">
											<c:forEach var="vList" items="${searchVO.searchStatus}" varStatus="vStatus2">
												<c:choose>
													<c:when test="${vList == statusCode_result.code}">checked</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</c:set>
										<c:if test="${statusCode_result.code != '1000'}">
											<!-- 반려 -->
											<c:if test="${statusCode_result.code != '1007'}">
												<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> <%-- 	                   				<c:out value="${statusCode_result.codeDc}"/> --%> <c:choose>
														<c:when test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:when>
														<c:when test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:when>
														<c:when test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:when>
														<c:otherwise>
															<c:out value="${statusCode_result.codeNm}" />
														</c:otherwise>
													</c:choose>
											</c:if>
											<c:if test="${statusCode_result.code == '1007'}">
												<!-- 현업, 결제자, admin -->
												<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER' || authorCode == 'ROLE_ADMIN'}">
													<input type="checkbox" name="searchStatus" value="<c:out value='${statusCode_result.code}'/>" <c:out value='${vChecked}'/>> <%-- 	                   					<c:out value="${statusCode_result.codeDc}"/> --%> <c:choose>
															<c:when test="${srLanguage == 'ko'}">
																<c:out value="${statusCode_result.codeNm}" />
															</c:when>
															<c:when test="${srLanguage == 'en'}">
																<c:out value="${statusCode_result.codeNmEn}" />
															</c:when>
															<c:when test="${srLanguage == 'cn'}">
																<c:out value="${statusCode_result.codeNmCn}" />
															</c:when>
															<c:otherwise>
																<c:out value="${statusCode_result.codeNm}" />
															</c:otherwise>
														</c:choose>
												</c:if>
											</c:if>
										</c:if>
									</c:forEach> <!-- 반려 checkbox --> <%-- 	               		&nbsp;&nbsp;(<input type="checkbox" name="searchStatusRetnrn" value="true" <c:if test="${searchVO.searchStatusRetnrn == 'true'}">checked</c:if> >반려) --%></td>
							</tr>
						</c:if>
						</tr>
						<tr>
							<td colspan="5" bgcolor="#dcdcdc" height="1"></td>
						</tr>
					</table>
				</div>


				<div class="list">
					<ul>
						<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align: middle" /> <spring:message code='sr.msg.totalCnt' /> <span style="color: #F00"><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="##,###,##0" /></span> <spring:message code='sr.msg.cnt' /></li>
					</ul>
				</div>
				<div class="list2">
					<ul>
						<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" /> &nbsp;<spring:message code='sr.realLabourHoursSum' /> : <span style="color: #F00"><fmt:formatNumber value="${realExpectTimeSum}" pattern="##,###,###.00" /></span></li>&nbsp;&nbsp;
						<li><img src="<c:url value='/' />images/sr/icon_home.gif" style="vertical-align: middle" /> &nbsp;<spring:message code='sr.navigation.srList' /></li>
					</ul>
				</div>
				<div class="list3">
					<table width="980" border="0" cellpadding="0" cellspacing="0">

						<colgroup>
							<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
								<col width="4%">
							</c:if>
							<col width="7%">

								<%--                     <col width="200px;" > --%>
								<col width="*">
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<col width="7%">
									</c:if>

									<col width="7%">
										<col width="7%">
											<col width="7%">
												<col width="7%">
													<col width="8%">
														<!-- 현업 및 결제자 -->
														<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
															<col width="10%">
														</c:if>
														<col width="10%">
															<col width="10%">
																<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
																	<col width="5%">
																</c:if>
																<col width="10%">
																	<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#0257a6" height="2"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#0257a6" height="2"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#0257a6" height="2"></td>
								</c:if>
							</tr>
							<tr class="tdgrey">
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택" /></th>
								</c:if>
								<th scope="col" class="f_field" nowrap="nowrap"><spring:message code='sr.srNumber' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code="cop.nttSj" /></th>

								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<th scope="col" nowrap="nowrap"><spring:message code='sr.client' /></th>
								</c:if>

								<th scope="col" nowrap="nowrap"><spring:message code='sr.module' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.status' /></th>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.requester' /></th>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.charge'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.charge' /></th>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.requestDate'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.requestDate' /></th>
								<!-- 현업 및 결제자 -->
								<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
									<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.completeHopeDate'/></th> --%>
									<th scope="col" nowrap="nowrap"><spring:message code='sr.list.completeHopeDate' /></th>
								</c:if>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.expectedCompletionDate'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.expectedCompletionDate' /></th>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.completionDate'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.completionDate' /></th>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<%--                         	<th scope="col" nowrap="nowrap"><spring:message code='sr.customerConfirm'/></th> --%>
									<th scope="col" nowrap="nowrap"><spring:message code='sr.list.customerConfirm' /></th>
								</c:if>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='sr.realLabourHours2'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.realLabourHours' /></th>
								<%--                         <th scope="col" nowrap="nowrap"><spring:message code='cop.satisfaction.stsfdg'/></th> --%>
								<th scope="col" nowrap="nowrap"><spring:message code='sr.list.stsfdg' /></th>
							</tr>
							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#717171" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#717171" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#717171" height="1"></td>
								</c:if>
							</tr>
						</thead>

						<tbody>

							<tr>
								<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
									<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
									<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
								<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
									<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
								</c:if>
							</tr>

							<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td nowrap="nowrap" align="center"><c:if test="${resultInfo.status == '1001' && resultInfo.sanctnerAt == null}">
												<input type="checkbox" name="checkField" class="check2" title="선택" />
											</c:if> <c:if test="${resultInfo.status == '1001' && resultInfo.sanctnerAt != null}">
												<input type="checkbox" name="checkField" class="check2" title="선택" disabled="disabled" />
											</c:if> <c:if test="${resultInfo.status != '1001'}">
												<input type="checkbox" name="checkField" class="check2" title="선택" disabled="disabled" />
											</c:if> <input name="checkId" type="hidden" value="<c:out value='${resultInfo.srNo}'/>" /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><a href="#LINK" onclick="javascript:fn_egov_detail_Sr('${resultInfo.srNo}')"><c:out value='${resultInfo.srNo}' /></a></td>
									<td class="ellipsis" nowrap="nowrap"><a href="#LINK" onclick="javascript:fn_egov_detail_Sr('${resultInfo.srNo}')"><c:out value='${resultInfo.subject}' /></a></td>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.pstinstNm}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:forEach var="moduleCode_result" items="${moduleCode_result}" varStatus="status">
											<c:if test="${resultInfo.moduleCode == moduleCode_result.code}">
												<c:out value="${moduleCode_result.codeNm}" />
											</c:if>
										</c:forEach></td>
									<td nowrap="nowrap" <c:choose><c:when test="${resultInfo.status == '1000'}"> class="state00"</c:when><c:when test="${resultInfo.status == '1001'}"> class="state01"</c:when><c:when test="${resultInfo.status == '1002'}"> class="state02"</c:when><c:when test="${resultInfo.status == '1003'}"> class="state03"</c:when><c:when test="${resultInfo.status == '1004'}"> class="state04"</c:when><c:when test="${resultInfo.status == '1005'}"> class="state05"</c:when><c:when test="${resultInfo.status == '1006'}"> class="state06"</c:when><c:when test="${resultInfo.status == '1007'}"> class="state07"</c:when></c:choose>><c:forEach var="statusCode_result" items="${statusCode_result}" varStatus="status">
											<c:if test="${resultInfo.status == statusCode_result.code}">
												<%-- 		                            	<c:if test="${resultInfo.status == '1001'}">	 --%>
												<%-- 		                            		<c:if test="${resultInfo.returnResn != '' && resultInfo.returnResn != null}">반려</c:if> --%>
												<%-- 		                            		<c:if test="${resultInfo.returnResn == '' || resultInfo.returnResn == null}"> --%>
												<%-- 		                            			<c:out value="${statusCode_result.codeNm}"/> --%>
												<%-- 		                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" /> --%>
												<%-- 		                            		</c:if> --%>

												<%-- 		                            		<c:if test="${resultInfo.sanctnerAt == 'N'}">반려 --%>
												<%-- 		                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" /> --%>
												<%-- 		                            			<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" /> --%>
												<%-- 		                            		</c:if> --%>
												<%-- 		                            		<c:if test="${resultInfo.sanctnerAt != 'N'}"> --%>
												<%-- 		                            			<c:out value="${statusCode_result.codeNm}"/> --%>
												<%-- 		                            			<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>" /> --%>
												<%-- 		                            			<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" /> --%>
												<%-- 		                            		</c:if> --%>
												<%-- 		                            	</c:if> --%>
												<%-- 		                            	<c:if test="${resultInfo.status != '1001'}"> --%>
												<c:choose>
													<c:when test="${resultInfo.status == '1006'}">
														<spring:message code='sr.complete' />
													</c:when>
													<c:otherwise>
														<%-- 		                            				<c:out value="${statusCode_result.codeNm}"/> --%>
														<c:if test="${srLanguage == 'ko'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:if>
														<c:if test="${srLanguage == 'en'}">
															<c:out value="${statusCode_result.codeNmEn}" />
														</c:if>
														<c:if test="${srLanguage == 'cn'}">
															<c:out value="${statusCode_result.codeNmCn}" />
														</c:if>
														<c:if test="${srLanguage != 'ko' && srLanguage != 'en' && srLanguage != 'cn'}">
															<c:out value="${statusCode_result.codeNm}" />
														</c:if>
													</c:otherwise>
												</c:choose>
												<%-- 			                            	<input type="hidden" name="statusArr" value="<c:out value='${statusCode_result.code}'/>"  /> --%>
												<%-- 			                            	<input type="hidden" name="sanctnerAtArr" value="<c:out value='${resultInfo.sanctnerAt}'/>" /> --%>
												<%-- 		                            	</c:if> --%>
											</c:if>
										</c:forEach></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.customerNm}' /></td>
									<td class="tdwc" nowrap="nowrap">
										<%-- 						    	<c:out value='${resultInfo.rname}'/> --%> <c:choose>
											<c:when test="${srLanguage == 'ko'}">
												<c:out value="${resultInfo.rname}" />
											</c:when>
											<c:when test="${srLanguage == 'en'}">
												<c:out value="${resultInfo.rnameEn}" />
											</c:when>
											<c:when test="${srLanguage == 'cn'}">
												<c:out value="${resultInfo.rnameEn}" />
											</c:when>
											<c:otherwise>
												<c:out value="${resultInfo.rname}" />
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.signDate}' /></td>
									<!-- 현업 및 결제자 -->
									<c:if test="${authorCode == 'ROLE_USER_MEMBER' || authorCode == 'ROLE_USER_SANCTNER'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.hopeDate}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.scheduleDate}' /></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.testCompleteDate}' /></td>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
										<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.tat}' /></td>
									</c:if>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.realExpectTime}' /></td>
									<td class="tdwc" nowrap="nowrap"><c:out value='${resultInfo.point}' /></td>
								</tr>
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" align="center" height="30"><spring:message code="common.nodata.msg" /></td>
									</c:if>
								</tr>
								<tr>
									<c:if test="${authorCode == 'ROLE_USER_MEMBER'}">
										<td colspan="12" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
									<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR' || authorCode == 'ROLE_COOPERATION'}">
										<td colspan="13" bgcolor="#cdcdcd" height="1"></td>
									</c:if>
								</tr>
							</c:if>
						</tbody>

					</table>
					<table width="980" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="30"></td>
						</tr>
						<tr>
							<td align="center">
								<%--         	  <a href="#"><img src="<c:url value='/' />images/sr/btn_prev.gif" width="59" height="21" align="absmiddle" />&nbsp;&nbsp; 1</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a href="#">2 &nbsp;&nbsp;<img src="<c:url value='/' />images/sr/btn_next.gif" width="59" height="21" border="0" align="absmiddle" /></a> --%> <!-- 페이지 네비게이션 시작 -->
								<div id="paging_div">
									<ul class="paging_align">
										<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
									</ul>
								</div> <!-- //페이지 네비게이션 끝 --> <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" /> <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> <input type="hidden" name="searchStatus1001At" value="<c:out value='${searchVO.searchStatus1001At}'/>" /> <input type="hidden" name="srNoSanctnAllArr" />

							</td>
						</tr>
						<tr>
							<c:if test="${authorCode != 'ROLE_COOPERATION'}">
								<td align="right" valign="bottom" height="60"><span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_Sr(); return false;"><spring:message code='button.requestRegistration' /> ▶</a></span>&nbsp;
							</c:if>
							<c:if test="${authorCode == 'ROLE_USER_SANCTNER'}">
								<span class="btnblue"><a href="#LINK" onclick="fn_egov_regist_SrSanctn(); return false;"><spring:message code='button.srAllApproval' /> ▶</a></span>&nbsp;            	
            	</c:if>
							<c:if test="${authorCode != 'ROLE_COOPERATION'}">
								<span class="btnblue"><a href="#LINK" onclick="javascript:fncExcelReport(); return false;"><spring:message code='button.excelMonthly' /> ▶</a></span>&nbsp; 
	            </c:if>
							<c:if test="${authorCode == 'ROLE_ADMIN' || authorCode == 'ROLE_CHARGER' || authorCode == 'ROLE_MNGR'}">
								<span class="btnblue"><a href="#LINK" onclick="javascript:fncExcelDetail(); return false;"><spring:message code='button.excelDetails' /> ▶</a></span>&nbsp;
                </c:if>
							</td>
						</tr>
					</table>
				</div>




			</form>


			<form name="Form" method="post" action="<c:url value='/sr/EgovSrSelectUpdtCstmr.do'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" name="srNo"> <input type="submit" id="invisible" class="invisible" /> <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" /> <input type="hidden" name="searchAt" value="<c:out value='${searchVO.searchAt}'/>" /> <input type="hidden" name="selectStatus" value="<c:out value='${searchVO.selectStatus}'/>" /> <c:forEach var="vList3" items="${searchVO.searchStatus}" varStatus="vStatus3">
						<input type="hidden" name="searchStatus" value="<c:out value='${vList3}'/>">
					</c:forEach> <input type="hidden" name="searchStatusAllCheck" value="<c:out value='${searchVO.searchStatusAllCheck}'/>"> <%--        			<input type="hidden" name="searchStatusRetnrn" value="<c:out value='${searchVO.searchStatusRetnrn}'/>" > --%> <%--        			<input type="hidden" name="searchStatus1001At" value="<c:out value='${searchVO.searchStatus1001At}'/>" > --%> <input type="hidden" name="searchConfirmDateF" value="<c:out value='${searchVO.searchConfirmDateF}'/>" /> <input type="hidden" name="searchConfirmDateT" value="<c:out value='${searchVO.searchConfirmDateT}'/>" /> <input type="hidden" name="searchConfirmDateFView" value="<c:out value='${searchVO.searchConfirmDateFView}'/>" /> <input type="hidden" name="searchConfirmDateTView" value="<c:out value='${searchVO.searchConfirmDateTView}'/>" /> <input type="hidden" name="searchCustomerNm" value="<c:out value='${searchVO.searchCustomerNm}'/>" /> <input type="hidden" name="searchRname"
						value="<c:out value='${searchVO.searchRname}'/>"
					/> <input type="hidden" name="searchRid" value="<c:out value='${searchVO.searchRid}'/>" /> <input type="hidden" name="searchCompleteDateF" value="<c:out value='${searchVO.searchCompleteDateF}'/>" /> <input type="hidden" name="searchCompleteDateT" value="<c:out value='${searchVO.searchCompleteDateT}'/>" /> <input type="hidden" name="searchCompleteDateFView" value="<c:out value='${searchVO.searchCompleteDateFView}'/>" /> <input type="hidden" name="searchCompleteDateTView" value="<c:out value='${searchVO.searchCompleteDateTView}'/>" /> <input type="hidden" name="searchTcode" value="<c:out value='${searchVO.searchTcode}'/>" /> <input type="hidden" name="searchPstinstNm" value="<c:out value='${searchVO.searchPstinstNm}'/>" /> <input type="hidden" name="searchPstinstCode" value="<c:out value='${searchVO.searchPstinstCode}'/>" /> <input type="hidden" name="searchModuleCode" value="<c:out value='${searchVO.searchModuleCode}'/>" /> <input type="hidden" name="searchSubject"
						value="<c:out value='${searchVO.searchSubject}'/>"
					/> <input type="hidden" name="language" value="<c:out value='${srLanguage}'/>" />
			</form>

		</div>
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div>
	</div>

	<!-- //전체 레이어 끝 -->
</body>
</html>

<script type="text/javascript">
//다국어 적용
saveLanguage();
// alert("cookie saveLanguage : " + getCookie("saveLanguage")) ; 
</script>