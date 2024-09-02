<%--
  Class Name : EgovProgramListManage.jsp
  Description : 프로그램목록 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >

<title>프로그램목록관리</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2" type="text/javaScript">
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
	    	url : "<c:url value='/select/sym/prm/EgovProgramListManageSelect.do'/>",
	   	    type : 'POST',
	   	    //dataType : "json",
	   	    //contentType:"application/json",
	   	    data : $("#progrmManageForm").serialize(),
	   	    success : function(data){
	   	    	resolve({ total: data.paginationInfo.totalRecordCount, selected: data.list_progrmmanage })
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
			{ field: 'progrmFileNm', caption: "프로그램 파일명", editable: false, type: 'text', width:20, unit:'%', colCss : 'pointer'},
			{ field: 'progrmKoreanNm', caption: "프로그램 한글명", editable: false, type: 'text', width:20, unit:'%'},
			{ field: 'url', caption: "URL", editable: false, type: 'text', width:40, unit:'%'},
			{ field: 'progrmDc', caption: "프로그램설명", editable: false, type: 'text', items : authorCodeList, width:20, unit:'%'}
        ],
		showRowNo:true,
		editable: false,
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
  	                	if(command.column && (command.column.field == "progrmFileNm") ){
  	                		var progrmFileNm = SBGrid3.getValue(grid, command.key, 'progrmFileNm');
  	                		if(progrmFileNm) {
  	                			selectUpdtProgramListDetail(progrmFileNm);
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


/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.progrmManageForm.checkField;
    if(document.progrmManageForm.checkAll.checked) {
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

/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteProgrmManageList() {
    //var checkField = document.progrmManageForm.checkField;
    var checkField = SBGrid3.getCheckedRows(datagrid);
    //var ProgrmFileNm = document.progrmManageForm.checkProgrmFileNm;
    var checkProgrmFileNms = "";
    //var checkedCount = 0;
    /* if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkProgrmFileNms += ((checkedCount==0? "" : ",") + ProgrmFileNm[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkProgrmFileNms = ProgrmFileNm.value;
            }
        }
    }    */
    if(checkField.length > 0) {
        for(var i=0; i<checkField.length; i++) {      
             
             if(checkProgrmFileNms == ""){
            	 checkProgrmFileNms = checkField[i].data.progrmFileNm;
             }            	 
             else{
            	 checkProgrmFileNms += ";" +  checkField[i].data.progrmFileNm;
	             
             } 
            
        }
    } else { 
        alert("선택된 항목이 없습니다.");
        resultCheck = false;
    }
    
    document.progrmManageForm.checkedProgrmFileNmForDel.value=checkProgrmFileNms;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgrmManageListDelete.do'/>";
    document.progrmManageForm.submit(); 
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//  document.menuManageForm.searchKeyword.value = 
    document.progrmManageForm.pageIndex.value = pageNo;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>";
    document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectProgramListManage() { 
   /*  document.progrmManageForm.pageIndex.value = 1;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>";
    document.progrmManageForm.submit();  */
	SBGrid3.reload(datagrid);
}
/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertProgramListManage() {
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListRegist.do'/>";
    document.progrmManageForm.submit(); 
}
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtProgramListDetail(progrmFileNm) {
    document.progrmManageForm.tmp_progrmNm.value = progrmFileNm;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListDetailSelectUpdt.do'/>";
    document.progrmManageForm.submit(); 
}
/* ********************************************************
 * focus 시작점 지정함수
 ******************************************************** */
 function fn_FocusStart(){
        var objFocus = document.getElementById('F1');
        objFocus.focus();
    }

<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>

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
	                <sbux-button id="search_button" name="search_button" uitype="normal" onclick="selectProgramListManage()" text="<spring:message code='button.search'/>" class="btn-search" image-src="<c:url value = "/"/>images/search_btn.png" image-style="width:15px;height:14px;"></sbux-button>
	            </div>

                <form id = "progrmManageForm" name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />                 
				<input name="checkedProgrmFileNmForDel" type="hidden" />
				<input type="hidden" name="cmd">
				<input type="hidden" name="tmp_progrmNm">
				<input type="hidden" id = "pageIndex" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>

                <!-- 검색 필드 박스 시작 -->
                <div class="sr-table-wrap">
					<table class="sr-table">
						<colgroup>
							<col width="12%">
							<col width="38%">
							<col width="12%">
							<col width="38%">
						</colgroup>
						<tbody>
						<tr>
							<th>
								<sbux-label id="table_label1" name="table_label1" uitype="normal" text="프로그램 파일명"></sbux-label>
							</th>
							<td>
								<sbux-input id="searchProgrmFileNm" name="searchProgrmFileNm" uitype="text" value="<c:out value='${searchVO.searchProgrmFileNm}'/>" style="width : 100%;" />
							</td>
							<th>
								<sbux-label id="table_label2" name="table_label2" uitype="normal" text="프로그램 한글명"></sbux-label>
							</th>
							<td>
								<sbux-input id="searchProgrmKoreanNm" name="searchProgrmKoreanNm" uitype="text" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>" style="width : 100%;" />
							</td>
						</tr>
						<tr>
							<th>
								<sbux-label id="table_label3" name="table_label3" uitype="normal" text="URL"></sbux-label>
							</th>
							<td style="border-right : 0px;">
								<sbux-input id="searchUrl" name="searchUrl" uitype="text" value="<c:out value='${searchVO.searchUrl}'/>" style="width : 100%; " />
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
                    	<sbux-button uitype="normal" text="등록" class="btn-default" onclick = "insertProgramListManage()"></sbux-button>                    
                    	<sbux-button uitype="normal" text="삭제" class="btn-default" onclick = "fDeleteProgrmManageList()"></sbux-button>                    
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
            <!-- 현재위치 네비게이션 시작 -->
            <div id="contents">
            <form name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
            <input type="submit" id="invisible" class="invisible"/>
<!--                 <div id="cur_loc"> -->
<!--                     <div id="cur_loc_align"> -->
<!--                         <ul> -->
<!--                             <li>HOME</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li>메뉴관리</li> -->
<!--                             <li>&gt;</li> -->
<!--                             <li><strong>프로그램목록관리</strong></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->

                <!-- 검색 필드 박스 시작 -->
                <div class="searchtb2">
                
                	<table width="980" border="0" cellpadding="0" cellspacing="0">
			            <tr>
			              <td colspan="5" bgcolor="#0257a6" height="2"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">프로그램 파일명</td>
			              <td class="tdleft">
			              	<input name="searchProgrmFileNm" type="text" size="40" value="<c:out value='${searchVO.searchProgrmFileNm}'/>"  maxlength="60" id="F1" title="검색조건">
			              </td>
			              <td class="tdblue">프로그램 한글명</td>
			              <td class="tdleft">
			              	<input name="searchProgrmKoreanNm" type="text" size="40" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>"  maxlength="60" id="F1" title="검색조건">
			              </td>
			              <td rowspan="3" align="center"><a href="#LINK" onclick="javascript:selectProgramListManage(); return false;" ><img src="<c:url value='/' />images/sr/btn_search2.gif"/></a></td>
			            </tr>
			            <tr>
			              <td colspan="4" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			            <tr>
			              <td class="tdblue">URL</td>
			              <td width="270" class="tdleft" colspan="3">
			              	<input name="searchUrl" type="text" size="60" value="<c:out value='${searchVO.searchUrl}'/>"  maxlength="60" id="F1" title="검색조건">
			              </td>
			            </tr>
			            <tr>
			              <td colspan="5" bgcolor="#dcdcdc" height="1"></td>
			            </tr>
			          </table>
                </div>
                <!-- //검색 필드 박스 끝 -->     
                
                <!-- 검색 필드 박스 시작 -->
<!--                 <div id="search_field"> -->
<!--                     <div id="search_field_loc"><h2><strong>프로그램목록관리</strong></h2></div> -->
                        
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<!-- 							<input name="checkedProgrmFileNmForDel" type="hidden" /> -->
<!--                         <fieldset><legend>조건정보 영역</legend>     -->
<!--                         <div class="sf_start"> -->
<!--                             <ul id="search_first_ul"> -->
<!--                             	<li> -->
<!--                             		<label for="searchProgrmFileNm">프로그램 파일명 : </label> -->
                                    <input name="searchProgrmFileNm" type="text" size="40" value="<c:out value='${searchVO.searchProgrmFileNm}'/>"  maxlength="60" id="F1" title="검색조건">
<!-- 						  			<br> -->
<!--                                     <label for="searchProgrmKoreanNm">프로그램 한글명 : </label> -->
                                    <input name="searchProgrmKoreanNm" type="text" size="40" value="<c:out value='${searchVO.searchProgrmKoreanNm}'/>"  maxlength="60" id="F1" title="검색조건"> 
<!-- 	                                <br> -->
<!-- 	                                <label for="searchUrl">URL &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label> -->
                                    <input name="searchUrl" type="text" size="60" value="<c:out value='${searchVO.searchUrl}'/>"  maxlength="60" id="F1" title="검색조건">
<!-- 						  		</li> -->
<!--                             </ul> -->
<!--                             <ul id="search_second_ul"> -->
<!--                                 <li> -->
<!--                                     <div class="buttons" style="float:right;"> -->
                                        <a href="#LINK" onclick="javascript:selectProgramListManage(); return false;" ><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                                        <a href="<c:url value='/sym/mpm/EgovProgramListRegist.do'/>" onclick="insertProgramListManage(); return false;"><spring:message code="button.create" /></a>                              
                                        <a href="#LINK" onclick="fDeleteProgrmManageList(); return false;"><spring:message code="button.delete" /></a>
<!--                                     </div> -->
<!--                                 </li> -->
<!--                             </ul>            -->
<!--                         </div>           -->
<!--                         </fieldset> -->
<!--                 </div> -->
                <!-- //검색 필드 박스 끝 -->
                
                <div class="list">
			        	<ul>
			            	<li><img src="<c:url value='/' />images/sr/bullet_arrow.gif" style="vertical-align:middle"/> 총건수 : <span style="color:#F00"><c:out value="${paginationInfo.totalRecordCount}"/>건</span></li>
			            </ul>
			      </div>     
			    <div class="list2">
			      	<ul>
			        	<li><img src="<c:url value='/' />images/sr/icon_home.gif"/> &nbsp;HOME > 메뉴관리 > 프로그램목록관리</li>
			        </ul>
			      </div>                      
                <!-- table add start -->
                <div class="list3">
                    <table width="980" border="0" cellpadding="0" cellspacing="0" summary="프로그램목록관리 목록으로 프로그램파일명, 프로그램명, url,프로그램설명 으로 구성" cellpadding="0" cellspacing="0">
                    <caption></caption>
                    <colgroup>
                    <col width="3%" >
                    <col width="20%" >  
                    <col width="20%" >
                    <col width="40%" >
                    <col width="17%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <td colspan="5" bgcolor="#0257a6" height="2"></td>
                    </tr>
                    <tr class="tdgrey">
                        <th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택"></th>
                        <th scope="col" nowrap="nowrap">프로그램파일명</th>
                        <th scope="col" nowrap="nowrap">프로그램 한글명</th>
                        <th scope="col" nowrap="nowrap">URL</th>
                        <th scope="col" nowrap="nowrap">프로그램설명</th>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#717171" height="1"></td>
                    </tr>
                    <tr>
                        <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
					    <td nowrap="nowrap" class="tdwc">
					       <input type="checkbox" name="checkField" class="check2" title="선택">
					       <input name="checkProgrmFileNm" type="hidden" value="<c:out value='${result.progrmFileNm}'/>"/>
					    </td>
					    <td style="cursor:hand;" nowrap="nowrap" class="tdwc">                                 
					            <span class="link"><a href="<c:url value='/sym/prm/EgovProgramListDetailSelectUpdt.do'/>?tmp_progrmNm=<c:out value="${result.progrmFileNm}"/>"  onclick="selectUpdtProgramListDetail('<c:out value="${result.progrmFileNm}"/>'); return false;"><c:out value="${result.progrmFileNm}"/></a></span>
					    </td>
					    <td nowrap="nowrap" class="tdwc"><c:out value="${result.progrmKoreanNm}"/></td>
					    <td nowrap="nowrap" class="tdwc"><c:out value="${result.URL}"/></td>
					    <td nowrap="nowrap" class="tdwc"><c:out value="${result.progrmDc}"/></td>  
                      </tr>
                      <tr>
						    <td colspan="5" bgcolor="#cdcdcd" height="1"></td>
						</tr>
                     </c:forEach>   
                     <c:if test="${fn:length(list_progrmmanage) == 0}">
                      <tr>
                        <td nowrap colspan="5"><spring:message code="common.nodata.msg" /></td>  
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
			                <span class="btnblue"><a href="<c:url value='/sym/mpm/EgovProgramListRegist.do'/>" onclick="insertProgramListManage(); return false;"><spring:message code="button.create" /> ▶</a></span>&nbsp;
			                <span class="btnblue"><a href="#LINK" onclick="fDeleteProgrmManageList(); return false;"><spring:message code="button.delete" /> ▶</a></span>&nbsp;
			                </td>
			            </tr>
			        </table>   
			                            
                </div>

                <!-- 페이지 네비게이션 시작 -->
<!--                 <div id="paging_div"> -->
<!--                     <ul class="paging_align"> -->
                        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>                        
<!--                     </ul> -->
<!--                 </div>                           -->
                <!-- //페이지 네비게이션 끝 -->  
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input name="checkedProgrmFileNmForDel" type="hidden" />
				<input type="hidden" name="cmd">
				<input type="hidden" name="tmp_progrmNm">
            </form>

            </div>
            <!-- //content 끝 -->    
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div> --%>
    <!-- //전체 레이어 끝 -->
 </body>
</html>