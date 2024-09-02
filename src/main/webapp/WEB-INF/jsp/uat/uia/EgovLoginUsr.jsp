<%--
  Class Name : EgovLoginUsr.jsp
  Description : 로그인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 	 2024.02.26		최대묵	로그인 화면(softbowl 적용)
    author   : 공통서비스 개발팀  박지욱
    since    : 2009.03.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<script type="text/javascript">
<!--
function actionLogin() {

    if (document.loginForm.id.value =="") {
        alert("<spring:message code='error.required.id'/>");
        return false;
    } else if (document.loginForm.password.value =="") {
        alert("<spring:message code='errors.required.pwInput.msg'/>");
        return false;
    } else {
    	
    	saveid(document.loginForm);
    	savepassword(document.loginForm);
//     	saveLanguage(document.loginForm);
    	
        document.loginForm.action="<c:url value='/uat/uia/actionSecurityLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}

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

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked){
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    }else{
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    }
    setCookie("saveid", loginForm.id.value, expdate);    
}
function savepassword(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkPw.checked){
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    }else{
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    }
    setCookie("savepassword", loginForm.password.value, expdate);
}
function saveLanguage(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    setCookie("saveLanguage", loginForm.language.value, expdate);    
//     alert(getCookie("saveLanguage"));
}
function getid(form) {
    form.checkId.checked = ((loginForm.id.value = getCookie("saveid")) != "");
}
function getpw(form) {
    form.checkPw.checked = ((loginForm.password.value = getCookie("savepassword")) != "");
}
function getLanguage(form) {
	//임시 한국어로 고정함 wbpark  2016.06.30
//     form.language.checked = ((loginForm.language.value = getCookie("saveLanguage")) != "");
// 	form.language.value = ((loginForm.language.value = getCookie("saveLanguage")) != "");
	form.language.value = getCookie("saveLanguage");
// 	alert("form.language.value : " + form.language.value);
//     form.language.checked = 'ko';
}
function fnInit() {
    var message = document.loginForm.message.value;
    if (message != "") {
        alert(message);
    }
    getid(document.loginForm);
    getpw(document.loginForm);
    getLanguage(document.loginForm);
}
/* ********************************************************
 * id/pw찾기 함수
 ******************************************************** */
function fCallUrl(url) {
	url = url + '?language='+loginForm.language.value;
	window.open(url,'dokdo','width=850,height=400,menubar=no,toolbar=no,location=no,resizable=no,status=no,scrollbars=no,top=200,left=250');
}
//-->
</script>
<!-- <link rel="shortcut icon" href="http://localhost:8080/images/sr/istn.ico" />  -->
<link rel="icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="<c:url value='/' />css/style.css">
</head>
<%-- <body  onload="fnInit();" background="<c:url value='/' />images/sr/img_pattern.jpg"> --%>
<body  onload="fnInit();">
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>  
	<%--  <div class="sr-login-wrap">
          <div class="logo">
	          <img src="<c:url value='/' />images/login_logo.png">
	          <span class="proName">SeRa System</span>            
          </div>            
          <form name="loginForm" method="post" id="loginForm">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<input type="hidden" name="message" value="${message}" />
            <input type="hidden" name="userSe"  value="USR"/>
            <input name="j_username" type="hidden"/>
            <input type="hidden" name="language" value="" />
            <div class="sr-contents">
                <div class="box-login">
                    <div class="bannerImg" style="background-image:url(<c:url value='/' />images/login_img.jpg"></div>
                    <div class="member-inner">
                        <p><sbux-input id='id' name='id' uitype='text' class='idicon text-int' style="width: 100%; height: 50px;"  placeholder="아이디를 입력해주세요" onkeyenter="actionLogin(); }" ></sbux-input></p> 
                        <p class="mgt7"><sbux-input id='password' name='password' uitype='password' class='pwicon text-int'  style="width: 100%; height: 50px;"  placeholder="패스워드를 입력해주세요" onkeyenter="actionLogin(); }"></sbux-input></p> 
                        <div class="idpw-box">
                            <div>
                            <sbux-checkbox id="checkId" name="checkId" uitype="normal" text="아이디 저장"  style="font-size: 13px; font-weight: bold; margin-right: 15px; margin-left: 0;" required ></sbux-checkbox>
                            <sbux-checkbox id="checkPw" name="checkPw" uitype="normal" text="비밀번호 저장" style="font-size: 13px; font-weight: bold; margin-left: 0;"></sbux-checkbox>
                            </div>
                            <span class="idpw-find"><a href="javascript:SBUxMethod.openModal('modalMenu');">아이디/비밀번호 찾기</a></span>
                        </div>
                        <sbux-button id="login_button" name="login_button" uitype="normal" text="로그인" class="btn-login" onclick="javascript:actionLogin()"></sbux-button>
                    </div>
                </div>               

                <p class="login_copyright">
                    Copyrightⓒ ISTN Consulting Co.,Ltd. ALL RIGHTS RESERVED.<br>
                    서울특별시 송파구 법원로 9길 26 (문정동 645-2 번지) 에이치비지니스파크 C동 901호
                </p>
        	</div><!--sr-contents-->
        </form>
    </div> --%>
    <div class="wrap">
        <div class="login-box" style="">
            <h1 style="display: block; margin-inline-start: 0px; margin-inline-end: 0px; font-weight: bold; unicode-bidi: isolate; font-family:  Apple SD Gothic Neo;">
                Welcome<br>
                SeRa System
            </h1>
            <h2 style="color : white; display: block; margin-block-start: 0.83em; margin-block-end: 0.83em; margin-inline-start: 0px; margin-inline-end: 0px; font-weight: bold; unicode-bidi: isolate; font-family:  Apple SD Gothic Neo;">
            	Login
           	</h2>
            <form name="loginForm" method="post" id="loginForm" >
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<input type="hidden" name="message" value="${message}" />
	            <input type="hidden" name="userSe"  value="USR"/>
	            <input name="j_username" type="hidden"/>
	            <input type="hidden" name="language" value="" />
                <ul>
                    <li>
                        <input type="text" id='id' name='id' placeholder="User Name" onkeyenter="actionLogin(); }" style="font-family:  Apple SD Gothic Neo;">
                    </li>
                    <li>
                        <input type="password" id='password' name='password' placeholder="Password" onkeyenter="actionLogin(); }" style="font-family:  Apple SD Gothic Neo;">
                    </li>
                    <li class="save_id_pw">
                        <div>
                            <input type="checkbox" id="checkId" name="checkId">
                            <label for="id_save" style="font-family:  Apple SD Gothic Neo;">아이디 저장</label>
                        </div>
                        <div>
                            <input type="checkbox" name="checkPw" id="pw_save">
                            <label for="pw_save" style="font-family:  Apple SD Gothic Neo;">비밀번호 저장</label>
                        </div>                        
                    </li>
                    <li>
                        <button class="confirm" id="login_button" name="login_button" onclick="javascript:actionLogin()" style="font-family: Apple SD Gothic Neo;">로그인</button>
                    </li>
                    <li class="find-id-pw">
                        <a href="javascript:SBUxMethod.openModal('modalMenu');" style="font-family: Apple SD Gothic Neo;">아이디/비밀번호 찾기</a>
                    </li>
                </ul>
            </form>            
        </div>
        <div class="footer" style="font-family: Apple SD Gothic Neo;">
            Copyrightⓒ ISTN Consulting Co.,Ltd. ALL RIGHTS RESERVED.<br>
            서울특별시 송파구 법원로 9길 26 (문정동 645-2 번지) 에이치비지니스파크 C동 901호
        </div>
    </div>
    
    
    
    <sbux-modal id="modalMenu" name="modalMenu" 
			uitype="middle" 
			header-title="<spring:message code='uss.umt.findId'/> / <spring:message code='uss.umt.findPw'/>" 
			body-html-id="modalBody"
			is-fade="false"
			footer-html=''>

	</sbux-modal>
	<div id="modalBody" style= "height : 500px;">
		<c:import url="/uat/uia/egovIdPasswordSearch.do" />
	</div>
</body>
</html>