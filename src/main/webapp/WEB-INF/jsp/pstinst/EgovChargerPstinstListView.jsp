<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"type="text/css" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
 -->

<link href="<c:url value='/'/>jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.7.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ui/jquery-ui.js'/>"></script>

<meta http-equiv="Content-Language" content="ko">
<link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css">
<title>SR 고객사 접속정보</title>
<script type="text/javaScript" language="javascript" defer="defer">
	
</script>

<style>
#mainView div {
	margin: 5px;
	margin-left: 20px;
}
</style>
<script>
	var rowData;
	function getAllList() {
		$.ajax({
			url : "/isprintSr/pstinst/EgovChargerPstinstList.do",
			method : "POST",
			dataType : "JSON",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : null,

			success : function(data, status) {
				rowData = data;
				collectData(rowData);
			},
			error : function(xhr) {
				console.log(xhr);
			}
		});
	}

	function collectData(data) {
		var dictObj = {};

		var gubun = $("#mainGubun option:selected").val();

		data.forEach(function(cur) {

			if (gubun == "MAIN" && cur.mainAt == "N") {
				return true;
			} else if (gubun == "SUB" && cur.mainAt == "Y") {
				return true;
			}

			if (!dictObj[cur.userName]) {
				dictObj[cur.userName] = [];
			}

			dictObj[cur.userName].push(cur);
		});

		var html;
		for ( var key in dictObj) {
			var cur = dictObj[key];
			html += "<h3>" + cur.userName + " ( " + cur.length + " ) "
					+ "</h3>";
			html += "<div><ul>";
			for (let i = 0; i < cur.length; i++) {
				const element = cur[i];
				html += "<li>" + element.pstinstName + "</li>";
			}
			html += "</ul></div>";
		}
		$("#mainView").html(html);

	}

	$(document).ready(function() {
		getAllList();

		$("#search").click(function() {
			collectData(rowData);
			//$("#mainView").empty();
		});

		$("#mainView h3").click(function() {
			var idx = $("#mainView h3").index(this);
			$("#mainView div").eq(idx).toggle('slow');
		});
	});
</script>
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<!-- 전체 레이어 시작 -->
	<div id="wrapper">
		<!-- header 시작 -->
		<div id="header">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
		</div>
		<c:import url="/sym/mms/EgovMainMenuHead.do" />
		<!-- //header 끝 -->

		<!-- container 시작 -->
		<!-- 현재위치 네비게이션 시작 -->
		<div id="contents">
			<div class="list2">
				<ul>
					<li><img src="<c:url value='/' />images/sr/icon_home.gif" /> &nbsp;HOME > 기반관리 > 담당자별 고객리스트</li>
				</ul>
			</div>
			<!-- 검색 필드 박스 시작 -->
			<div class="searchtb2">
				<table width="980" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="3" bgcolor="#0257a6" height="2"></td>
					</tr>
					<tr>
						<td class="tdblue">정/부</td>
						<td class="tdleft" width="270px;"><select name="mainGubun" id="mainGubun" class="select" title="고객사">
								<option value='ALL'>==선택==</option>
								<option value='MAIN'>정</option>
								<option value='SUB'>부</option>
						</select></td>

						<td align="center"><img id="search" src="<c:url value='/' />images/sr/btn_search2.gif" /></td>
					</tr>
					<tr>
						<td colspan="3" bgcolor="#dcdcdc" height="1"></td>
					</tr>
				</table>
			</div>
			<div id="mainView">
				<h3>Section 1</h3>
				<div>
					<ul>
						<li>List item one</li>
						<li>List item two</li>
						<li>List item three</li>
					</ul>
				</div>
				<h3>Section 2</h3>
				<div>
					<p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna.</p>
				</div>
				<h3>Section 3</h3>
				<div>
					<ul>
						<li>List item one</li>
						<li>List item two</li>
						<li>List item three</li>
					</ul>
				</div>
				<h3>Section 4</h3>
				<div>
					<p>Cras dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia mauris vel est.</p>
					<p>Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</p>
				</div>
			</div>
		</div>
		<!-- //content 끝 -->
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->
</body>

</html>
