<%--
  Class Name : EgovMenuDetailSelectUpdt.jsp
  Description : 메뉴정보 상세조회및 수정 화면
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
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css" > -->

<title>메뉴상세조회및 수정</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
<!--
/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateMenuManage(form) {
    
    if(!validateMenuManageVO(form)){            
        return;
    }else{
    	if(confirm("<spring:message code='common.save.msg' />")){
         form.action="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do'/>";
         form.submit();
    	}
    }
}

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteMenuManage(form) {
    if(confirm("<spring:message code='common.delete.msg' />")){
        form.action="<c:url value='/sym/mnu/mpm/EgovMenuManageDelete.do'/>";
        form.submit();
    }
}
/* ********************************************************
 * 파일목록조회  함수
 ******************************************************** */
function searchFileNm() {
    document.all.tmp_SearchElementName.value = "progrmFileNm";
    window.open("<c:url value='/sym/prm/EgovProgramListSearch.do'/>",'','width=800,height=600');
}
/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList_bak(){
    location.href = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
}
function fncSelectList() {
    var varFrom = document.getElementById("menuManageVO");
    varFrom.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    varFrom.submit();       
}
/* ********************************************************
 * 파일명 엔터key 목록조회  함수
 ******************************************************** */
function press() {
    if (event.keyCode==13) {
        searchFileNm();    // 원래 검색 function 호출
    }
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->

function searchFileNm() {
	SBUxMethod.openModal('modalMenu');
	isOpen = SBUxMethod.getModalStatus("modalMenu");
	if(isOpen == 'open'){
		init();
	}
    /* document.all.tmp_SearchElementName.value = "progrmFileNm";
    window.open("<c:url value='/sym/prm/EgovProgramListSearch.do'/>",'','width=800,height=600'); */
}

<!-- Modal 시작 -->
function init(){
	if(SBUxMethod.getModalStatus("modalMenu") == 'open'){
		fn_loading();
		createGrid();
	}
}

var datagrid; // 그리드 객체 전역으로 선언
var gridData = [];
var isOpen = "";

async function loadData(payload = {}, dataType = "json") {
    return new Promise((resolve, reject) => {
    	$("#pageIndex").val(Number(payload.pageNo) + 1);

		$.ajax({
			url : "<c:url value='/select/prm/EgovProgramListSearch.do'/>"			
			,type : "POST"
			, data :  $("#listForm").serialize()
			, success : function(data){
				resolve({ total: data.paginationInfo.totalRecordCount, selected: data.resultList })
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
	isOpen = SBUxMethod.getModalStatus("modalMenu");
	
	if(isOpen == 'open'){
	
	    let dsConfig = {
	   	schema: {
	   		id : (value) => value.progrmFileNm
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
	    	{ field: 'progrmFileNm', caption: "프로그램파일명", editable: false, type: 'text', width:55, unit:'%', colCss : "pointer"},
	    	{ field: 'progrmKoreanNm', caption: "프로그램명", editable: false, type: 'text', width:45, unit:'%', colCss : "pointer"},
	       ],
	       editable: true,
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
	 	                	if(command.column){	  	                		
	  	  	                	var progrmFileNm = SBGrid3.getValue(grid, command.key, 'progrmFileNm');
	  	  	                	
	  	  	                	$('#progrmFileNm').val(progrmFileNm);

	  	  	    				SBUxMethod.closeModal('modalMenu');
	  	  	                }
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
}


function fnSearch(){
    SBGrid3.reload(datagrid);
}

function fnInsertAddr() {
	const id = SBGrid3.getCheckedKeys(datagrid);

	
	if(id.length > 1) {
		alert('한 개만 선택해주세요.');
		
	} else if (id.length < 1) {
		alert('선택한 항목이 없습니다.')
		
	} else {
		var tempId = id[0]
		$('#progrmFileNm').val(tempId);

		SBUxMethod.closeModal('modalMenu');
	}
	
}


<!-- 모달창 끝 -->

/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList_bak(){
    location.href = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
}
function fncSelectList() {
    var varFrom = document.getElementById("menuManageVO");
    varFrom.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    varFrom.submit();       
}

/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateMenuManage(form) {
	var form = document.getElementById('menuManageVO');
    if(!validateMenuManageVO(form)){            
        return;
    }else{
    	if(confirm("<spring:message code='common.save.msg' />")){
    		
    		//document.menuManageVO.action="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do'/>";
    		//document.menuManageVO.submit();
    		
    		var form = $("#menuManageVO")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.replace("<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>");
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

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteMenuManage(form) {
    if(confirm("<spring:message code='common.delete.msg' />")){
    	//document.menuManageVO.action="<c:url value='/sym/mnu/mpm/EgovMenuManageDelete.do'/>";
    	//document.menuManageVO.submit();
    	
    	var form = $("#menuManageVO")[0];
		var formData = new FormData(form);
                
        $.ajax({        	
			url : "<c:url value='/sym/mnu/mpm/EgovMenuManageDelete.do'/>"			
			,type : "POST"
			,data : formData
	     	,contentType : false
	     	,processData : false
			,beforeSend : fn_loading()
			,success : function(data){

				alert(data.msg);
				if(data.msgType == 'S') {
					location.replace("<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>");
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

/* ********************************************************
 * 저장처리 함수
 ******************************************************** */
function insertMenuManage(form) {
    var form = document.getElementById('menuManageVO');
    if(!validateMenuManageVO(form)){  
    	return;    	
    } else {
		if(confirm("<spring:message code='common.save.msg' />")){
			
    		//document.menuManageVO.action="<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
    		//document.menuManageVO.submit();
    		
    		var form = $("#menuManageVO")[0];
			var formData = new FormData(form);
	                
	        $.ajax({        	
				url : "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
	
					alert(data.msg);
					if(data.msgType == 'S') {
						location.replace("<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>");
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

function validateMenuManageVO(form){	
	var checkOption = {
		menuNo : 
			{ valid : "required, maxlength" 
			, label : "메뉴번호" 
			, max : 40 }
		, menuOrdr : 
			{ valid : "required, maxlength" 
			, label : "메뉴순서"
			, max : 10}
		, menuNm : 
			{ valid : "required, maxlength" 
			, label : "메뉴명"
			, max : 30}
		, upperMenuId : 
			{ valid : "required, maxlength" 
			, label : "상위메뉴번호"
			, max : 10}
		, progrmFileNm : 
			{ valid : "required, maxlength" 
			, label : "프로그램파일명"
			, max : 60}
		, relateImageNm : 
			{ valid : "maxlength" 
			, label : "관련이미지명"
			, max : 30}
		, relateImagePath : 
			{ valid : "maxlength" 
			, label : "관련이미지경로"
			, max : 30}
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

                <form modelAttribute="menuManageVO" id="menuManageVO" name="menuManageVO" action ="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do' />" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                    <div class="sr-table-wrap">
                		<table class="sr-table">
		                    <colgroup>
		                        <col width="12%">
		                        <col width="29%">
		                        <col width="12%">
		                        <col width="49%">
		                    </colgroup>

                          <tr> 
                            <th>
                            	<sbux-label id="th_text1" name="th_text1" uitype="normal" class = "imp-label" text="메뉴번호"></sbux-label>
                           	</th>
                            <td>
                            <c:if test="${empty menuManageVO.menuNo}">
	                            <sbux-input uitype="text" name="menuNo" id="menuNo" style="width:100%;" value="<c:out value="${menuManageVO.menuNo}"/>"></sbux-input> 
	                            <hidden id="menuNo" name="menuNo" />
                            </c:if>
                             <c:if test="${not empty menuManageVO.menuNo}">
	                            <sbux-input uitype="text" name="menuNo" id="menuNo" style="width:100%;" value="<c:out value="${menuManageVO.menuNo}"/>" readonly></sbux-input> 
	                             <hidden id="menuNo" name="menuNo" />
                             </c:if>
                            </td>
                            <th>
                            	<sbux-label id="th_text2" name="th_text2" uitype="normal" class = "imp-label" text="메뉴순서"></sbux-label>
                            </th>
                            <td>
                              <sbux-input uitype="text" name="menuOrdr" id="menuOrdr" style="width:100%;" value="<c:out value="${menuManageVO.menuOrdr}"/>"></sbux-input> 
                              <!-- <input name="menuOrdr" size="10" maxlength="10" title="메뉴순서"/> -->
                            </td>
                          </tr> 
                          <tr> 
                            <th>
                            	<sbux-label id="th_text3" name="th_text3" uitype="normal" class = "imp-label" text="메뉴명"></sbux-label>
                            </th>
                            <td>
                            	<sbux-input uitype="text" name="menuNm" id="menuNm" style="width:100%;" value="<c:out value="${menuManageVO.menuNm}"/>"></sbux-input> 
                              <!-- <input path="menuNm" size="30" maxlength="30" title="메뉴명"/> -->                              
                            </td>
                            <th>
                            	<sbux-label id="th_text4" name="th_text4" uitype="normal" class = "imp-label" text="상위메뉴번호"></sbux-label>
                            </th>
                            <td>
                              <!-- <input path="upperMenuId" size="10" maxlength="10" title="상위메뉴No"/> -->
                            	<sbux-input uitype="text" name="upperMenuId" id="upperMenuId" style="width:100%;" value="<c:out value="${menuManageVO.upperMenuId}"/>"></sbux-input>
                            </td>
                          </tr>
                          <tr> 
                            <th>
                            	<sbux-label id="th_text5" name="th_text5" uitype="normal" class = "imp-label" text="프로그램파일명"></sbux-label>
                            </th>
                            <td style="border-right : 0px;">
                                <%-- <input type="text" name="progrmFileNm_view" size="60" disabled="disabled" value="${menuManageVO.progrmFileNm}">
                                <input path="progrmFileNm" size="60" maxlength="60" title="프로그램파일명" cssStyle="display:none" /> --%>
                                <sbux-input uitype="text" name="progrmFileNm" id="progrmFileNm" style="width:100%;" value="<c:out value="${menuManageVO.progrmFileNm}"/>" readonly></sbux-input>    
                            </td>
                            <td colspan="2" style="border-left : 0px;">
                            	<%-- <a href="<c:url value='/sym/prm/EgovProgramListSearch.do'/>?tmp_SearchElementName=progrmFileNm" target="_blank" title="새창으로 이동" onclick="searchFileNm();return false;"  style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />"
                                 alt='' width="15" height="15" />(프로그램파일명 검색)</a> --%>
                                 <sbux-button id="button4" name="button4" uitype="normal" text="프로그램파일명 검색" onclick="searchFileNm()" class="btn-default"></sbux-button>
                            </td>
                          </tr>
                          <tr> 
                            <th>
                            	<sbux-label id="th_text6" name="th_text6" uitype="normal" text="관련이미지명"></sbux-label>
                            </th>
                            <td>
                              <!-- <input path="relateImageNm" size="30" maxlength="30" title="관련이미지명"/> -->
                              <sbux-input uitype="text" name="relateImageNm" id="relateImageNm" style="width:100%;" value="<c:out value="${menuManageVO.relateImageNm}"/>"></sbux-input>
                              
                            </td>
                            <th>
                            	<sbux-label id="th_text7" name="th_text7" uitype="normal" text="관련이미지경로"></sbux-label>
                            </th>
                            <td>
                            	<sbux-input uitype="text" name="relateImagePath" id="relateImagePath" style="width:100%;" value="<c:out value="${menuManageVO.relateImageNm}"/>"></sbux-input>
                             <!--  <input path="relateImagePath" size="30" maxlength="30" title="관련이미지경로"/> -->
                            </td>
                          </tr>
				          
                          <tr> 
                            <th>
                            	<sbux-label id="th_text8" name="th_text8" uitype="normal" text="메뉴설명"></sbux-label>
                            </th>
                            <td colspan="3">
                              <sbux-textarea id="menuDc" name="menuDc" uitype="normal" style="width:100% ; height:150px;" init="${menuManageVO.menuDc}"></sbux-textarea>

                            </td>
                          </tr>
                        </table>
                    </div>
                    
                    <input type="hidden" name="tmp_SearchElementName" value=""/>
                    <input type="hidden" name="tmp_SearchElementVal" value=""/>
                    <input name="cmd"    type="hidden"   value="update"/>
                    
                    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                    
                    <input name="searchMenuNo" type="hidden" value="<c:out value='${searchVO.searchMenuNo}'/>"/>
                    <input name="searchMenuNm" type="hidden" value="<c:out value='${searchVO.searchMenuNm}'/>"/>
                    <input name="searchProgrmFileNm" type="hidden" value="<c:out value='${searchVO.searchProgrmFileNm}'/>"/>
                    
                    <!-- 검색조건 유지 -->
                </form>
                
                <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                <div class="btn_buttom">            	
	            	<c:if test="${not empty menuManageVO.menuNo}">
	            		<sbux-button id="button2" name="button2" uitype="normal" text="<spring:message code="button.save" />" onclick="updateMenuManage(document.getElementById('menuManageVO'))" class="btn-default"></sbux-button>
	            		<sbux-button id="button3" name="button3" uitype="normal" text="<spring:message code="button.delete" />" onclick="deleteMenuManage(document.getElementById('menuManageVO'))" class="btn-default"></sbux-button>
	            		<sbux-button id="button1" name="button1" uitype="normal" text="<spring:message code="button.list" />" onclick="fncSelectList()" class="btn-default"></sbux-button>	            	
	            	</c:if>
	            	<c:if test="${empty menuManageVO.menuNo}">
	            		<sbux-button id="button5" name="button5" uitype="normal" text="신규 등록" onclick="insertMenuManage(document.getElementById('menuManageVO'))" class="btn-default"></sbux-button>	            		
	            		<sbux-button id="button6" name="button6" uitype="normal" text="<spring:message code="button.list" />" onclick="selectList_bak()" class="btn-default"></sbux-button>
	            	</c:if>
	            	
	            </div>
	            <!-- 버튼 끝 -->  

            </div>
            <!-- //content 끝 -->    
    <!-- footer 시작 -->
    	<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
    <!-- //footer 끝 -->
    </div>
</div>
<!-- //전체 레이어 끝 -->
<!-- 주소검색 Modal -->
<sbux-modal id="modalMenu" name="modalMenu" 
			uitype="middle" 
			header-title="프로그램파일명 검색" 
			body-html-id="modalBody"
			footer-html='<sbux-button uitype="normal" text="저장" class="btn-default" image-style="width:15px;height:13px;" style ="margin-right : 5px;" onclick = "fnInsertAddr();"></sbux-button>'>

</sbux-modal>
<div id="modalBody" style="height : 600px;">
	<c:import url="/sym/prm/EgovProgramListSearch.do" />
</div>

</body>
</html>

