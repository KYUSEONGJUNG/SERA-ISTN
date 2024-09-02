<%--
  Class Name : EgovAuthorGroupManage.jsp
  Description : EgovAuthorGroupManage List 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.03.23
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >

<title>사용자별권한관리</title>

<script type="text/javaScript" language="javascript">
SBGrid3.$(document).ready(function () {
    init(); 
})
var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];
var authorCodeList = [];
var srLanguage = "<c:out value = '${srLanguage}'/>";

function init(){
	<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
		authorCodeList.push({ value: '${authorManage.authorCode}', label: '${authorManage.authorNm}' });
	</c:forEach>
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/sec/rgm/EgovAuthorGroupList.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){
	   	    	
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.authorGroupList })
	 	   		$("#totalCnt").text(data.paginationInfo.totalRecordCount);
	   	    },
	   	    error : function(request, status, error){
				alert("error");   	            
	   	    },
	   	    complete:function(){
	   	    	fn_closeLoading();
	   	    }
		});
	});
}

 function createGrid() {
     let dsConfig = {
    	ajax: {
	       // 해당 소스를 추가해주시면 됩니다.
	       select: async(request) => {
	         return await loadData(request);
	       },
             // 해당 부분이 받아온 response data의 protorype name 입니다. 데이터 형식은 최하단에 첨부하겠습니다.
             // 기존 같은 경우 data: 데이터 객체를 넣었겠지만 ajax.selected가 설정되어 있으면 그 적용 값으로 됩니다.
		},
      
       serverPaging: true, 
       cachePaging: true,
       serverSorting: true,
       pageSize: 10,
     };

	let gridConfig = {
	    dataSource: dsConfig,
	    container: "#SBGridArea",
	    width: "100%",
	    height: "480px",
	    captionHeight: 40,
	    rowHeight:40,
	    showCheck:true,
	    columns: [
			{ field: 'userId', caption: "사용자 ID", editable: false, type: 'text', width:20, unit:'%'},
			{ field: 'userNm', caption: "사용자명", editable: false, type: 'text', width:20, unit:'%'},
			{ field: 'pstinstNm', caption: "고객사", editable: false, type: 'text', width:30, unit:'%'},
			{ field: 'authorCode', caption: "권한", editable: true, type: 'combo', items : authorCodeList, width:20, unit:'%'},
			{ field: 'regYn', caption: "등록여부", editable: false, type: 'text', width:5, unit:'%'},		
			{ field: 'mberTyCode', caption: "사용자타입", editable: false, type: 'text', width:20, unit:'%', visible : false},		
			{ field: 'uniqId', caption: "고유ID", editable: false, type: 'text', width:5, unit:'%', visible : false},		
        ],
		showRowNo:true,
		editable: true,
		virtualRow:false,
		pagerBar: {center:["pager"]},
		pageable: {
			buttonCount: 5,
			numeric: true,
			previousNext: true,
		},
		doCommand: (grid, name, command) => {
  	        switch(name) {
  	            case 'event' : {
  	                if (command.event.type == 'dblclick') {
  	                   // cell을 dblclick하면 더블클릭 메시지 띄우기
  	                    
  	                }
  	                else if(command.event.type == 'click'){
  	                	
  	                }
  	                else if (command.event.type == 'keydown') {
  	                   // cell에 입력했을 때 키 다운 메세지 띄우기
  	                  
  	                }
  	                
  	            }
  	            case 'updated' : {
  	                // updated인 경우 TODO
  	            }
  	            case 'edit' : {
  	                // edit인 경우 TODO
  	            }
  	            case 'focus' : {//click
  	                // focus인 경우 TODO 
  	                
  	            }   
  	            case 'menu' : {
  	                // menu인 경우 TODO
  	            }
  	            case 'captionCheck' : {
  	                // captionCheck인 경우 TODO

  	            }
  	        }
		},
     };
     
     datagrid = SBGrid3.createGrid(gridConfig);
     datagrid.refresh();
 }

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
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

function fncManageChecked() {

    var resultCheck = true;

//    var checkField = document.listForm.delYn;
    var checkField = SBGrid3.getCheckedRows(datagrid);
   /*  var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;
    var listMberTyCode = document.listForm.mberTyCode; */
    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";
    var returnmberTyCode = "";

    //var checkedCount = 0;

/*     if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        returnRegYn = booleanRegYn[i].value;
                        returnmberTyCode = listMberTyCode[i].value;
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                        returnmberTyCode = returnmberTyCode + ";" + listMberTyCode[i].value;
                        
                    }
                }
            }

            if(checkedCount > 0) 
                resultCheck = true;
            else {
                alert("선택된  항목이 없습니다.");
                resultCheck = false;
            }
            
        } else {
             if(document.listForm.delYn.checked == false) {
                alert("선택 항목이 없습니다.");
                resultCheck = false;
            }
            else {
                returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                returnmberTyCode = listMberTyCode.value;

                resultCheck = true;
            }
        } 
    } else {
        alert("조회된 결과가 없습니다.");
    } */
    
    if(checkField.length > 0) {
        for(var i=0; i<checkField.length; i++) {      
             
             if(returnId == ""){
            	 returnId = checkField[i].data.uniqId;
	             returnAuthor = checkField[i].data.authorCode;
	             returnRegYn = checkField[i].data.regYn;
	             returnmberTyCode = checkField[i].data.mberTyCode;
             }            	 
             else{
            	 returnId += ";" +  checkField[i].data.uniqId;
	             returnAuthor += ";" +  checkField[i].data.authorCode;
	             returnRegYn += ";" +  checkField[i].data.regYn;
	             returnmberTyCode += ";" +  checkField[i].data.mberTyCode;
             } 
            
        }
    } else { 
        alert("선택된 항목이 없습니다.");
        resultCheck = false;
    }
    
    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;
    document.listForm.mberTyCodes.value = returnmberTyCode;

    return resultCheck;
}

function fncSelectAuthorGroupList(pageNo){
    //document.listForm.searchCondition.value = "1";
    /* document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit(); */
	SBGrid3.reload(datagrid);
}

function fncAddAuthorGroupInsert() {

    if(!fncManageChecked()) return;
    
    if(confirm("등록하시겠습니까?")) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupInsert.do'/>";
        document.listForm.submit();
    }
}

function fncAuthorGroupDeleteList() {
 
    if(!fncManageChecked()) return;

    if(confirm("삭제하시겠습니까?")) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupDelete.do'/>";
        document.listForm.submit(); 
    }
}

function linkPage(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorGroupPop() {

    if(document.listForm.searchCondition.value == '3') {
        window.open("<c:url value='/sec/gmt/EgovGroupSearchView.do'/>","notice","height=500, width=800, top=50, left=20, scrollbars=no, resizable=no");
    } else {
        alert("그룹을 선택하세요.");
        return;
    }
}

function onSearchCondition() {
    document.listForm.searchKeyword.value = "";
    if(document.listForm.searchCondition.value == '3') {
        document.listForm.searchKeyword.readOnly = true;
    } else {
        document.listForm.searchKeyword.readOnly = false;
    }
}

function press() {

    if (event.keyCode==13) {
        fncSelectAuthorGroupList('1');
    }
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
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fncSelectAuthorGroupList('1')" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>

                <form id="listForm" name="listForm" action="<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />                 
				<input type="hidden" name="userId"/>
				<input type="hidden" name="userIds"/>
				<input type="hidden" name="authorCodes"/>
				<input type="hidden" name="regYns"/>
				<input type="hidden" name="mberTyCodes"/>
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
				<input type="hidden" name="searchCondition" value = "1"/>

                <!-- 검색 필드 박스 시작 -->
                <div class="sr-table-wrap">
					<table class="sr-table">
						<colgroup>
							<col width="12%">
							<col width="*">
						</colgroup>
						<tbody>
						<tr>
							<th>
								<sbux-label id="table_label2" name="table_label2" uitype="normal" text="검색키워드"></sbux-label>
							</th>
							<td>
								<sbux-input id="searchKeyword" name="searchKeyword" uitype="text" value="<c:out value='${authorGroupVO.searchKeyword}'/>" style="width : 200px;" />
							</td>
						</tr>
						</tbody>
					</table>
                </div>
                
            </form> 
                <!-- //검색 필드 박스 끝 -->
                
                <div class="grid_area">
		        	<div class="grid_txt">
	                    <p class="txt_pre"><spring:message code='sr.msg.totalCnt'/> <span id='totalCnt'></span> <spring:message code='sr.msg.cnt' /></p>        
	                </div>
	                <div class="btn_grid">
                    	<sbux-button uitype="normal" text="권한등록" class="btn-default" onclick = "fncAddAuthorGroupInsert()"></sbux-button>                    
                    	<sbux-button uitype="normal" text="등록취소" class="btn-default" onclick = "fncAuthorGroupDeleteList()"></sbux-button>                    
	                </div>
			      </div>    
                <!-- table add start -->
                	<div id="SBGridArea" class="sr-grid" style="margin-top: 6px;"></div>
                </div> 
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        	<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
        </div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->    
<!-- 전체 레이어 시작 -->
<%-- <div id="wrapper">
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
            <form:form name="listForm" action="<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>기반관리</li>
                            <li>&gt;</li>
                            <li><strong>사용자권한관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 메뉴목록관리 > 메뉴 등록</li>
			        </ul>
			    </div>	
			    
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>사용자권한관리</strong></h2></div>
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="search_select">조회조건 : </label>
					                <select name="searchCondition" onchange="onSearchCondition()" title="조회조건">
					                    <option value="1" <c:if test="${authorGroupVO.searchCondition == '1'}">selected</c:if> >사용자 ID</option>
					                    <option value="2" <c:if test="${authorGroupVO.searchCondition == '2'}">selected</c:if> >사용자 명</option>
					                    <option value="3" <c:if test="${authorGroupVO.searchCondition == '3'}">selected</c:if> >그룹</option>
					                </select>
                                </li>
                                <li>
    								<input name="searchKeyword" type="text" value="<c:out value='${authorGroupVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();"/>
                                    <a href="#LINK" onclick="javascript:fncSelectAuthorGroupPop()"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />팝업 </a>
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="javascript:fncSelectAuthorGroupList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                                        <a href="#LINK" onclick="javascript:fncAddAuthorGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">권한등록</a>
                                        <a href="#LINK" onclick="javascript:fncAuthorGroupDeleteList()" style="selector-dummy:expression(this.hideFocus=false);">등록취소</a>
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 기반관리 > 고객사관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="권한 그룹을 관리하는 테이블입니다.사용자 ID,사용자 명,사용자 유형,권한,등록 여부의 정보를 담고 있습니다." cellpadding="0" cellspacing="0">
                    <caption></caption>
                    <colgroup>
                    <col width="5%" >
                    <col width="15%" >  
                    <col width="15%" >
                    <col width="35%" >
                    <col width="20%" >
                    <col width="10%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="6" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" title="선택여부" class="check2" onclick="javascript:fncCheckAll()"></th>
                        <th scope="col" nowrap="nowrap">사용자 ID</th>
                        <th scope="col" nowrap="nowrap">사용자 명</th>
                        <th scope="col" nowrap="nowrap">고객사</th>
                        <th scope="col" nowrap="nowrap">권한</th>
                        <th scope="col" nowrap="nowrap">등록 여부</th>
                    </tr>
                    <tr>
                        <td colspan="6" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="6" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="authorGroup" items="${authorGroupList}" varStatus="status">
                    <input type="hidden" name="mberTyCode" value="${authorGroup.mberTyCode}"/>                              
                    <!-- loop 시작 -->  
                      <tr>
                        <td nowrap="nowrap" class="tdwc"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${authorGroup.uniqId}"/>"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${authorGroup.userId}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${authorGroup.userNm}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${authorGroup.pstinstNm}"/></td>
                        <td nowrap="nowrap" class="tdwc"><select name="authorManageCombo" title="권한">
									            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
									            	<c:if test="${authorManage.authorCode != 'ROLE_ANONYMOUS'}">
									                	<option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == authorGroup.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
									            	</c:if>
									            </c:forEach>
									        </select>
                        </td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${authorGroup.regYn}"/><input type="hidden" name="regYn" value="<c:out value="${authorGroup.regYn}"/>"></td>
                      </tr>
                      <tr>
						    <td colspan="6" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                     </c:forEach>  
                     <c:if test="${fn:length(authorGroupList) == 0}">
                      <tr>
                        <td nowrap colspan="6"><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>   
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <c:if test="${!empty authorGroupVO.pageIndex }">
                    <div id="paging_div">
                        <ul class="paging_align">
					        <ui:pagination paginationInfo = "${paginationInfo}"
					            type="image"
					            jsFunction="linkPage"
					            />
                        </ul>
                    </div>                          
                <!-- //페이지 네비게이션 끝 -->  
<!--                     <div align="right"> -->
                        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지"/>
<!--                     </div>      -->
                </c:if>
				<input type="hidden" name="userId"/>
				<input type="hidden" name="userIds"/>
				<input type="hidden" name="authorCodes"/>
				<input type="hidden" name="regYns"/>
				<input type="hidden" name="mberTyCodes"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
            </form:form>

            </div>
            <!-- //content 끝 -->    
        </div>  
        <!-- //container 끝 -->
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div> --%>
    <!-- //전체 레이어 끝 -->
 </body>
</html>