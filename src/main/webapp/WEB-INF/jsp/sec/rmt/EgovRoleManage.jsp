<%--
  Class Name : EgovRoleManage.jsp
  Description : EgovRoleManage 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
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

<title>롤관리</title>

<script type="text/javaScript" language="javascript" defer="defer">
SBGrid3.$(document).ready(function () {
    init(); 
})
var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];
var moduleData = [];
var statusData = []; 
var srLanguage = "<c:out value = '${srLanguage}'/>";

function init(){
	
	fn_loading();
	createGrid();
	
}


async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);
   		$.ajax({
	    	url : "<c:url value='/select/sec/rmt/EgovRoleList.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#listForm").serialize(),
	   	    success : function(data){
	   	    	
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.roleList })
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
    	schema: {
    		id : (value) => value.roleCode + ':' + value.regYn
    	}	 
		,ajax: {
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
			{ field: 'roleCode', caption: "롤 ID", editable: false, type: 'text', width:15, unit:'%', colCss : "pointer"},
			{ field: 'roleNm', caption: "롤 이름", editable: false, type: 'text', width:15, unit:'%', colCss : "pointer"},
			{ field: 'roleTyp', caption: "롤 타입", editable: false, type: 'text', width:15, unit:'%'},
			{ field: 'roleSort', caption: "롤 Sort", editable: false, type: 'text', width:10, unit:'%'},
			{ field: 'roleDc', caption: "롤 설명", editable: false, type: 'text', width:20, unit:'%'},
			{ field: 'roleCreatDt', caption: "등록일자", editable: false, type: 'text', width:15, unit:'%'},		
        ],
		showRowNo:true,
		virtualRow:false,
		resizable: {
			mode: "column",
			minWidth: 10, 
			maxWidth: 300, 
			autoFit: ["caption", "data"]
		},
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
  	                	if(command.column && (command.column.field == "roleCode" || command.column.field == "roleNm") ){
  	                		var roleCode = SBGrid3.getValue(grid, command.key, 'roleCode');
  	                		if(roleCode) {
  	                			fncSelectRole(roleCode);
  	                		}
  	  	                	
  	                	}
  	                	
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

	
    /* var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;
    
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue; */
    
    var checkField = SBGrid3.getCheckedRows(datagrid);
    var returnValue = "";
    var returnBoolean = true;
    if(checkField.length > 0) {
        for(var i=0; i<checkField.length; i++) {      
             
             if(returnValue == "")
                 returnValue = checkField[i].data.roleCode;
             else 
                 returnValue += ";" + checkField[i].data.roleCode;
            
        }
    } else { 
        alert("선택된 롤이 없습니다.");
        returnBoolean = false;
    }
    
    document.listForm.roleCodes.value = returnValue;
    return returnBoolean;
}

function fncSelectRoleList(pageNo){
    /* document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit(); */
	SBGrid3.reload(datagrid);
}

function fncSelectRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddRoleInsert() {
    location.replace("<c:url value='/sec/rmt/EgovRoleInsertView.do'/>"); 
}

function fncRoleListDelete() {
    if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/rmt/EgovRoleListDelete.do'/>";
            document.listForm.submit();
        }
    }
}

function fncAddRoleView() {
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleUpdate.do'/>";
    document.listForm.submit();     
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
        fncSelectRoleList('1');
    }
}
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
	            <div class="btn_right">
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="fncSelectRoleList('1')" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>

                <form id="listForm" name="listForm" action="<c:url value='/sec/rmt/EgovRoleList.do'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />                 
				<input type="hidden" name="roleCode"/>
				<input type="hidden" name="roleCodes"/>
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
				<input type="hidden" name="searchCondition" value = "1"/>

                <!-- 검색 필드 박스 시작 -->
                <div class="sr-table-wrap">
					<table class="sr-table">
						<colgroup>
							<col width="12%">
							<col width="29%">
							<col width="12%">
							<col width="49%">
						</colgroup>
						<tbody>
						<tr>
							<th>
								<sbux-label id="table_label1" name="table_label1" uitype="normal" text="롤 이름 "></sbux-label>	              			
							</th>
							<td style="border-right : 0px;">
								<sbux-input id="searchKeyword" name="searchKeyword" uitype="text" value="<c:out value='${roleManageVO.searchKeyword}'/>" style="width : 100%" title="검색" onkeypress="press();" />
							</td>
							<td style="border-left : 0px; border-right : 0px;">
							</td>
							<td style="border-left : 0px;">
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
                    	<sbux-button uitype="normal" text="등록" class="btn-default" onclick = "fncAddRoleInsert()"></sbux-button>                    
                    	<sbux-button uitype="normal" text="삭제" class="btn-default" onclick = "fncRoleListDelete()"></sbux-button>                    
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
<%-- <div id="wrapper">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <c:import url="/sym/mms/EgovMainMenuHead.do" />        
    <!-- //header 끝 --> 
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
            <form:form name="listForm" action="<c:url value='/sec/rmt/EgovRoleList.do'/>" method="post">
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>내부시스템관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>사용자권한관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>롤관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
                <!-- 검색 필드 박스 시작 -->
                
                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="3" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">롤명</td>
			              <td class="tdleft">
			              	<input name="searchKeyword" type="text" value="<c:out value='${roleManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" />
			              </td>
			              <td align="center"><a href="#LINK" onclick="javascript:fncSelectRoleList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="3" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->
                                
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>롤 관리</strong></h2></div> -->
                        
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                                 <li> -->
<!--                                     <label for="search_select">롤 명 : </label> -->
                                    <input name="searchKeyword" type="text" value="<c:out value='${roleManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" /> 
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
                                        <a href="#LINK" onclick="javascript:fncSelectRoleList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
<!--                                         <a href="#LINK" onclick="javascript:fncAddRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> -->
<!--                                         <a href="#LINK" onclick="javascript:fncRoleListDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> -->
<!--                                     </div>                               -->
<!--                                 </li> -->
<!--                             </ul>            -->
<!--                         </div>           -->
<!--                         </fieldset> -->
<!--                 </div> -->
                
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 사용자관리 > 롤관리</li>
			        </ul>
			      </div>  
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="롤 관리 테이블입니다.롤  ID,롤 명,롤 타입,롤 Sort,롤 설명,등록일자의 정보를 담고 있습니다." cellpadding="0" cellspacing="0">
                    <caption></caption>
                    <colgroup>
                    <col width="3%" >
                    <col width="10%" >  
                    <col width="20%" >
                    <col width="10%" >
                    <col width="10%" >
                    <col width="30%" >
                    <col width="12%" >
                    <col width="5%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="8" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체선택"></th>
                        <th scope="col" nowrap="nowrap">롤 ID</th>
                        <th scope="col" nowrap="nowrap">롤 명</th>
                        <th scope="col" nowrap="nowrap">롤 타입</th>
                        <th scope="col" nowrap="nowrap">롤 Sort</th>
                        <th scope="col" nowrap="nowrap">롤 설명</th>
                        <th scope="col" nowrap="nowrap">등록일자</th>
                        <th scope="col" nowrap="nowrap"></th>
                    </tr>
                    <tr>
                        <td colspan="8" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="8" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="role" items="${roleList}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
                        <td nowrap="nowrap" class="tdwc"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${role.roleCode}"/>" /></td>
                        <td nowrap="nowrap" class="tdwc"><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><c:out value="${role.roleCode}"/></a></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${role.roleNm}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${role.roleTyp}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${role.roleSort}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${role.roleDc}"/></td>
                        <td nowrap="nowrap" class="tdwc"><c:out value="${role.roleCreatDe}"/></td>
                        <td nowrap="nowrap" class="tdwc"><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><img src="<c:url value='/images/img_search.gif'/>" width="15" height="15" align="middle"  alt="상세조회"></a></td>
                      </tr>
                      <tr>
						    <td colspan="8" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                     </c:forEach>     
                     <c:if test="${fn:length(roleList) == 0}">
                      <tr>
                        <td nowrap colspan="6"><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>
                    </tbody>
                    </table>
                    
                    <table width="980" border="0" cellpadding="0" cellspacing="0">
			        	<tr>
			        	  <td height="30"></td>
			      	  </tr>
			        	<tr>
			        	  <td align="center";>
							<!-- 페이지 네비게이션 시작 -->
			                <div id="paging_div">
			                    <ul class="paging_align">
							        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
			                    </ul>
			                </div>                          
			                <!-- //페이지 네비게이션 끝 -->  			                
			        	  </td>
			      	  </tr>
			        	<tr>
			            	<td align="right" valign="bottom" height="60">
			                <span class="btnblue"><a href="#LINK" onclick="javascript:fncAddRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.create" /> ▶</a></span>&nbsp;
			                <span class="btnblue"><a href="#LINK" onclick="javascript:fncRoleListDelete()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
			                </td>
			            </tr>
			        </table>             
			                            
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <c:if test="${!empty roleManageVO.pageIndex }">
<!--                     <div id="paging_div"> -->
<!--                         <ul class="paging_align"> -->
					        <ui:pagination paginationInfo = "${paginationInfo}"
					            type="image"
					            jsFunction="linkPage"
					            />
<!--                         </ul> -->
<!--                     </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
<!-- 				    <div align="right"> -->
				        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
<!-- 				    </div>      -->
                </c:if>
				<input type="hidden" name="roleCode"/>
				<input type="hidden" name="roleCodes"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
				<input type="hidden" name="searchCondition"/>
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