<%--
  Class Name : incLeftmenu.jsp
  Description : 좌메뉴화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2024.02.26		최대묵	최초 생성
 
    author   : ISTN 최대묵
    since    : 2024.02.26 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="egovframework.let.main.service.com.cmm.LoginVO" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
if(loginVO == null){ 
%>
<%
}else{
%>
<c:set var="loginName" value="<%= loginVO.getName()%>"/>
<%
}
String strservicelvl = (String)session.getAttribute("strservicelvl");
if(!"".equals(strservicelvl) && strservicelvl != null){
%>
<c:set var="strservicelvl" value="<%= strservicelvl%>"/>
<%
} 
%>
<style>
.ck-content .table table {
    border: none;
    border-collapse: collapse;
    border-spacing: 0;
    height: 100%;
    width: 100%;
}
</style>
<div class="sr-left-gnb">         
    <div class="sr-gnb-area">
        <h3><a href="<c:url value='/'/>sr/EgovSrList.do"><img src="<c:url value='/' />images/main_logo.png"></a></h3>
        <div class="sr-info">
            <div class="info-top">
                <div class="name">
                    <sbux-label id="header_label" name="header_label" uitype="normal" text="<c:out value="${loginName}"/>"></sbux-label>
                    <!-- <span style="font-size: 14px; color: #fff;">님</span> -->                       
                </div>
                <sbux-button id="login_button" name="login_button" uitype="normal" text="<spring:message code='sr.charge'/>" class="btn-admin" image-src="<c:url value='/' />images/uesr_icon.png" image-style="width:15px;height:18px;" onclick="fn_charger_popup();"></sbux-button>
            </div>
            <div class="info-bottom">
                <sbux-button id='info1' name='info1' uitype='normal' class='btn-info' text='<spring:message code='button.modifyInformation'/>' onclick="fn_href('<c:url value='/uss/umt/user/EgovCstmrSelectUpdtView.do'/>')"></sbux-button>
                <sbux-button id='info2' name='info2' uitype='normal' class='btn-info' text='<spring:message code='button.logOut'/>' onclick="fn_href('<c:url value='/uat/uia/actionLogout.do'/>')"></sbux-button>
            </div>
        </div><!--로그인정보 sr-info-->
        <div class="sr-gnb">
        	<form name="menuListForm" action ="<c:url value='/EgovPageLink.do'/>" method="post">
	        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	        	<input type="hidden" id="selMenuNo" name="selMenuNo" value="<%=session.getAttribute("selMenuNo")%>" />
	        	<input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
				<input type="hidden" id="link" name="link" value="" />
			</form>        	
            <sbux-sidemenu id="idxSide_norm" name="side_norm" uitype="normal" onclick="fn_MovePage(side_norm)" is-expand-only-select="true">    
				<c:forEach var="result" items="${menulist}" varStatus="status">
					<%-- <li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>
					<li><img src="<c:url value='/' />images/sr/img_navbar.gif" /></li> --%>
					<menu-item id="<c:out value="${result.menuNo}"/>" name = "<c:out value="${result.menuNo}"/>" text="<c:choose>
	  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.menuNm}"/></c:when>
	  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.menuNmEn}"/></c:when>
	  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.menuNmCn}"/></c:when>
	  				</c:choose>  "/>">
						<c:forEach var="childResult" items="${childMenulist}" varStatus="status">
							<c:if test ="${result.menuNo == childResult.upperMenuId}">
								<c:choose>
				  					<c:when test="${srLanguage == 'ko'}">
				  						<menu-item id="<c:out value="${result.menuNo}"/>_<c:out value="${childResult.menuNo}"/>" text="<c:out value="${childResult.menuNm}"/>" value="<c:out value="${childResult.chkURL}"/>"></menu-item>
				  					</c:when>
				  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.menuNmEn}"/>
				  						<menu-item id="<c:out value="${result.menuNo}"/>_<c:out value="${childResult.menuNo}"/>" text="<c:out value="${childResult.menuNmEn}"/>" value="<c:out value="${childResult.chkURL}"/>"></menu-item>
				  					</c:when>
				  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.menuNmCn}"/>
				  						<menu-item id="<c:out value="${result.menuNo}"/>_<c:out value="${childResult.menuNo}"/>" text="<c:out value="${childResult.menuNmCn}"/>" value="<c:out value="${childResult.chkURL}"/>"></menu-item>
				  					</c:when>
				  				</c:choose>
							</c:if>
						</c:forEach>
					</menu-item>
				</c:forEach>
            </sbux-sidemenu>
        </div><!--메뉴-->
    </div> 
</div>
<sbux-modal id="modalChager" name="modalChager" 
			uitype="large" 
			header-title="<spring:message code='cop.searchCharge'/>" 
			body-html-id="modalBody_charger">

</sbux-modal>

<div id="modalBody_charger">
	<div class="popup-wrap">
        <div class="popup-area">
            <table class="sr-table">             
                <tbody>                       
                    <tr>
                         <th class="th_center"><spring:message code='sr.module'/></th>
                         <th class="th_center"><spring:message code='cop.mainCharge'/></th>
                         <th class="th_center"><spring:message code='cop.mbtlNum'/></th>
                         <th class="th_center"><spring:message code='cop.emailAdres'/></th>
                         <th class="th_center"><spring:message code='cop.subCharge'/></th>
                         <th class="th_center"><spring:message code='cop.mbtlNum'/></th>
                         <th class="th_center"><spring:message code='cop.emailAdres'/></th>
                    </tr>     
                    <tr>                        
                        <c:forEach var="list" items="${srchargerList}" varStatus="status">
						<tr>
							<td class="td_center">
								<c:forEach var="result" items="${moduleCode_result}" varStatus="status">
									<c:if test="${result.code == list.moduleCode}">
							  				<c:choose>
							  					<c:when test="${srLanguage == 'ko'}"><c:out value="${result.codeNm}"/></c:when>
							  					<c:when test="${srLanguage == 'en'}"><c:out value="${result.codeNmEn}"/></c:when>
							  					<c:when test="${srLanguage == 'cn'}"><c:out value="${result.codeNmCn}"/></c:when>
							  					<c:otherwise><c:out value="${result.codeNm}"/></c:otherwise>
							  				</c:choose>										
									</c:if>
								</c:forEach>
							</td>
							<td class="td_center">
								<c:forEach var="result" items="${chargerList}" varStatus="status">
									<c:if test="${result.userId == list.userIdA}">
						  				<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value='${result.userNm}'/></c:when>
						  					<c:otherwise><c:out value='${result.userNmEn}'/></c:otherwise>
						  				</c:choose> 										
									</c:if>
								</c:forEach>
							</td>
							<td class="td_center"><c:out value="${list.mbtlnumA}" /></td>
							<td class="td_center"><c:out value="${list.emailAdresA}" /></td>							
							<td class="td_center">
								<c:forEach var="result" items="${chargerList}" varStatus="status">
									<c:if test="${result.userId == list.userIdB}">
						  				<c:choose>
						  					<c:when test="${srLanguage == 'ko'}"><c:out value='${result.userNm}'/></c:when>
						  					<c:otherwise><c:out value='${result.userNmEn}'/></c:otherwise>
						  				</c:choose> 
									</c:if>
								</c:forEach>
							</td>
							<td class="td_center"><c:out value="${list.mbtlnumB}" /></td>
							<td class="td_center"><c:out value="${list.emailAdresB}" /></td>
						</tr>
					</c:forEach>
                   </tr>           
                </tbody>
            </table>
            <p class="contactslist">※ 비상연락 순서: 모듈 주담당자 -> 부담당자 -> 팀장 (김은수이사: 010-5447-5136) -> 부문장 (정용길전무: 010-2261-2824)</p>
        </div>
    </div>
</div>	   


<script type="text/javascript">
	var menuJson = [
	    { "order" : "1", "id" : "id_1",   "pid" : "0", "text" : "Home", "value" : "value2", "imagesrc":"<c:url value = '/'/>images/breadcrumb-home.png", "imagealt" : "imageAlt", "imagetitle" : "imageTitle", "imagestyle" : "height:15px; width:16px;"}
	    ,{ "order" : "2", "id" : "id_2",   "pid" : "0","text" : "test"}
		,{ "order" : "3", "id" : "id_3",   "pid" : "0","text" : "test2"}
	    ];
	window.onload = function(){		
		SBUxMethod.setSideMenu('side_norm',document.menuListForm.baseMenuNo.value+"_"+document.menuListForm.selMenuNo.value,'id');
		
		
		var parentMenuText = document.getElementsByClassName("sbux-sidemeu-li sbux-sidemeu-chl-wrap active")[0].getElementsByClassName("sbux-sidemeu-item-txt")[0].innerText;
		var childMenuText = document.title;
	
		if(document.getElementById("breadcrumb").getElementsByClassName("sbux-bre-item-txt").length > 1){
			document.getElementById("breadcrumb").getElementsByClassName("sbux-bre-item-txt")[1].innerText = parentMenuText;
			document.getElementById("breadcrumb").getElementsByClassName("sbux-bre-item-txt")[2].innerText  = childMenuText;	
		}else{
			SBUxMethod.refresh('side_norm');
		}	
		
		
		$('input[type="text"]').keydown(function() {
		   	  if (event.keyCode === 13) {
		   	    event.preventDefault();
		   	  };
	   	});
	}
	
    function fn_ServiceLevel(){
        document.menuListForm.action = "<c:url value='/sts/stsfdg/selectStsfdgSttus.do'/>";
        document.menuListForm.submit();      
    }
    function fn_old_sr_popup() {
    	window.open('http://isprint.co.kr/support/supportInquiry2.asp','srSystem','width=1024,height=768,menubar=yes,toolbar=yes,location=yes,resizable=yes,status=yes,scrollbars=yes,top=100,left=100');
    }
    function fn_charger_popup(){
    	/*var url = "<c:url value='/pstinst/EgovPstinstChargerList.do'/>";
    	var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=1,status=0,menubar=0,width=680,height=390,left=20,top=20";
    	window.open(url,"_chargerPopup", openParam); */
    	SBUxMethod.openModal('modalChager');
    }  
    
    function fn_href(url){
    	window.location.href = url;
    }
    
    function fn_MovePage(obj) {
    	
    	var sideMenuInfo = SBUxMethod.getSideMenu('side_norm').attrObj;
    	var menuInfo = sideMenuInfo["id"].split("_");
    	
    	if(menuInfo.length > 1){
    		
    		if(sideMenuInfo["value"] && sideMenuInfo["value"] == obj){    			
    			return false;
    		}
    		document.menuListForm.baseMenuNo.value = menuInfo[0];
    		document.menuListForm.selMenuNo.value = menuInfo[1];
    		//document.menuListForm.link.value = sideMenuInfo["value"];
    		document.menuListForm.action = "${pageContext.request.contextPath}" + sideMenuInfo["value"];
    		//location.href = "${pageContext.request.contextPath}" + sideMenuInfo["value"];
    		document.menuListForm.submit();
    	}
    }
    
	
    /*공통 소스 (추후 분리 예정)*/
    function fn_loading(){
    	var mask = "<div id='mask' style='position:absolute; background-color:#000000; display:none; top:0;'></div>";      
    	$('.sr-contents-area').append(mask);     //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.    
    	$('#mask').css({            
    		'width' : $(".sr-contents-area").width(),            
    		'height': $(".sr-left-gnb").height() > $(".sr-contents-area")[0].scrollHeight ? $(".sr-left-gnb").height() - 56 : $(".sr-contents-area")[0].scrollHeight,            
    		'opacity' : '0.3',
    		'z-index' : '10000'   
    	});
  	    //마스크 표시    
    	$('#mask').show();      
    	//로딩중 이미지 표시   
    	var loadingBar = "<div id = 'loadingBar' class='lds-spinner' style = 'display : none;'><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>";
    	$('#mask').append(loadingBar); 
    	
    	$('#loadingBar').css({            
    		'left' : ($(".sr-contents-area").width() / 2) - 80,            
    		'top': ($("#mask").height() / 2) -80
    	});
    	
    	$('#loadingBar').show(); 
    	
    }
    
    function fn_closeLoading(){
    	$('#mask, #loadingImg').hide();    
    	$('#mask, #loadingImg').empty();  
    }
    
    /**
    * 현재 required, minlength, maxlength 만 작동하도록 임시 작업
    * email, range 등등은 필요할 경우 추가 예정
    */
    function validateCheck(form, checkOption){
    	
    	var requiredMsg = '<spring:message code="errors.required" arguments='###1' />';
    	var minlengthMsg = '<spring:message code="errors.minlength" arguments='###1,###2' />';
    	var maxlengthMsg = '<spring:message code="errors.maxlength" arguments='###1,###2' />';
    	
    	var alertMsg = "";
    	 for(var i in checkOption){
    		
    		if(!form[i]) continue;
    		
    		var validArr = checkOption[i].valid.split(",");
    		
    		for(var j in validArr){
    			switch (validArr[j]){
    				case "required" :
    					if(form[i].value){
    						if(!form[i].value.trim() || form[i].value == '<p>&nbsp;</p>') {
    							alertMsg = requiredMsg.replace('###1', checkOption[i].label);						
    						} 
    					}else{
    						alertMsg = requiredMsg.replace('###1', checkOption[i].label);
    					}			
    					break;
    				case "minlength" :					
    					if(form[i].value){
    						if(form[i].value.length < checkOption[i].min){
    							alertMsg = minlengthMsg.replace('###1', checkOption[i].label);
    							alertMsg = alertMsg.replace('###2', checkOption[i].min);	
    						}
    					}else{
    						alertMsg = minlengthMsg.replace('###1', checkOption[i].label);
    						alertMsg = alertMsg.replace('###2', checkOption[i].min);	
    					}
    					
    					break;
    				case "maxlength" :
    					if(form[i].value){
    						if(form[i].value.length > checkOption[i].max){
    							alertMsg = maxlengthMsg.replace('###1', checkOption[i].label);
    							alertMsg = alertMsg.replace('###2', checkOption[i].max);	
    						}
    					}
    				
    					break;
    			}
    			if(alertMsg) break;
    		}		
    		if(alertMsg) break;
    	} 
    	 
    	if(alertMsg){
    		alert(alertMsg);
    		return false;
    	}  
    	return true;	
    }
    
    function fnFileDownload(item){
    	
    	//window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+item.atchFileId+"&fileSn="+item.fileSn+"'/>");
    	var form = null;
    	if(!$("#downloadForm")){
    		form = $("#downloadForm");
    	}else{
    		form = document.createElement("form");
    		form.id = "downloadForm";
    		form.name = "downloadForm";
    		form.method = "post";
    		document.body.appendChild(form);
    		
    		var input = document.createElement("input");
    		input.setAttribute("type", "hidden");
    		input.setAttribute("name", "${_csrf.parameterName }");
    		input.setAttribute("value", "${_csrf.token }");
    		form.appendChild(input);
    	}	
    	form.action = "<c:url value='/cmm/fms/FileDown.do?atchFileId="+item.atchFileId+"&fileSn="+item.fileSn+"'/>";
    	form.submit();
    };
    function fnFileDownLoad(item){
    	
    	if(!item.atchFileId) return true;
    	//window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+item.atchFileId+"&fileSn="+item.fileSn+"'/>");
    	var form = null;
    	if(!$("#fileForm")){
    		form = $("#fileForm");
    	}else{
    		form = document.createElement("form");
    		form.id = "fileForm";
    		form.name = "fileForm";
    		form.method = "post";
    		document.body.appendChild(form);
    		
    		var input = document.createElement("input");
    		input.setAttribute("type", "hidden");
    		input.setAttribute("name", "${_csrf.parameterName }");
    		input.setAttribute("value", "${_csrf.token }");
    		form.appendChild(input);
    	}	
    	form.action = "<c:url value='/cmm/fms/FileDown.do?atchFileId="+item.atchFileId+"&fileSn="+item.fileSn+"'/>";
    	form.submit();
    };

    function fnFileDelete(item){
    	if(!item.atchFileId) return true;
    	
    	if(confirm("<spring:message code='sr.msg.attachmentFileDelete'/>")){
    		
    		fn_callDelAjax(item.atchFileId,item.fileSn);
    		
       	}else{
       		return false;
       	}
    }

    function fnFileDeleteList(item){
    	var deleteFileList;
    	if($("#ansFileUpload")[0]){
    		deleteFileList = SBUxMethod.getFileCheckedInList('ansFileUpload');
    	}else{
    		deleteFileList = SBUxMethod.getFileCheckedInList('fileUpload');
    	}
    	
    	var atchFileId = "";
    	for(var i in deleteFileList){
    		atchFileId = deleteFileList[i].atchFileId;	
    	}
    	
    	if(!atchFileId) return true;
    	
    	if(confirm("<spring:message code='sr.msg.attachmentFileDelete'/>")){   		
    		
    		for(var i in deleteFileList){
    			var item = deleteFileList[i];
    			if(item.atchFileId){
    				fn_callDelAjax(item.atchFileId,item.fileSn);	
    			}			
    		}        
       	}else{
       		return false;
       	}
    }

    function fn_callDelAjax(atchFileId,fileSn){
    	$.ajax({
    		url : "<c:url value='/cmm/fms/deleteFileInfs.do'/>",
       	    type : 'POST',
       	    //dataType : "json",
       	    //contentType:"application/json",
       	    data : {
       	    	'${_csrf.parameterName }' : '${_csrf.token }'
       	    	,'atchFileId' : atchFileId
       	    	,'fileSn' : fileSn
       	    },
       	    success : function(data){
       	    	alert("<spring:message code='success.common.delete'/>");
       	    },
       	    error : function(request, status, error){
    			alert("error");   	            
       	    },
       	    complete:function(){
       	    	//fn_closeLoading();
       	    }
    	});
    }
    
    function openAlert(msg){
    	var alertOption ={
 			 text : msg
			 , mode : "light"
 			 , placement : "middle-center"
 			 , show_close_on_footer : true
 			 , is_fixed : true
 			 , is_modal : true
 			 , close_keyenter : true
 		};
 		SBUxMethod.openAlert(alertOption);
    }    

    const emailValidation = (target) => {
		regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,10}$/i;	
		if(!regex.test(target)){
			return false;
		} else {
			return true;
		}
	}
    
    
    const resource = { emptyMessage : "<spring:message code='info.nodata.msg'/>"  }
    SBGrid3.setResourceDefault(resource);
    
    
    function setEditText(editor){
    	var editorText = editor.getData();
    	var currentPos = 0;
    	var findStr = '<table';
    	//table
    	while(1){
    		var tablePos = editorText.indexOf(findStr,currentPos);	
    		if(!editorText || tablePos == -1)		break;
    		else{
    			var tableEndPos = editorText.indexOf(">", tablePos + findStr.length);
    			var tableStylePos = editorText.indexOf("style=", tablePos + findStr.length);
    			
    			if(tableStylePos != -1 && tableStylePos < tableEndPos){//적용된 스타일 존재
    				editorText = editorText.substr(0,tableStylePos + 7) +" border-collapse:collapse; border-spacing:0px; "+editorText.substr(tableStylePos + 7);
    			}else{//적용된 스타일 없음.
    				editorText = editorText.substr(0,tablePos + findStr.length) + ' style="border-collapse:collapse; border-spacing:0px;" '+editorText.substr(tablePos + findStr.length);	
    			}
    			currentPos = tablePos+1;
    		}
    	}
    	 //image size
    /* 	findStr = 'image_resized';
    	currentPos = 0;
    	while(1){
    		var imgResizePos = editorText.indexOf(findStr,currentPos);	
    		if(!editorText || imgResizePos == -1)		break;
    		else{
    			var imgWidthPos = editorText.indexOf("width", imgResizePos + findStr.length);
    			var imgWidthEndPos = editorText.indexOf("%;", imgWidthPos);
    			var imgWidth = editorText.substr(imgWidthPos + 6,imgWidthEndPos - imgWidthPos - 4);
    			
    			
    		
    			var insertPos = editorText.indexOf("aspect-ratio", imgResizePos + findStr.length);
    			var originWidthEndPos = editorText.indexOf("/", insertPos);
    			var originWidth =  editorText.substr(insertPos + 13,  originWidthEndPos - insertPos - 13);
    			if(imgWidthPos != -1){
    				//기존 width 제거
    				//editorText = editorText.substr(0,imgWidthPos) +"width:100%;"+ editorText.substr(imgWidthEndPos+2);
    				editorText = editorText.substr(0,insertPos) + "width:100%; height:auto;" + editorText.substr(insertPos);
    			}    			
    			currentPos = insertPos+1;
    		}
    	}  */
    	
    	return editorText;
    }
    
    
    function editorSetting(editor){
    	editor.keystrokes.set( 'Tab', ( data, cancel ) => {
			const command = editor.commands.get( 'input' );

			if ( command.isEnabled ) {
				command.execute({ text: '     ' });
				cancel();
			}
		} );
		
		editor.model.document.on("change:data",(data) => {
			var changes = data.source.differ._cachedChanges;
			for(var i in changes){
				if(changes[i].type == "insert" && changes[i].name =="table"){
					var path = changes[i].position.path[0];
					var firstCell = editor.model.document.getRoot().getNodeByPath([path,0,0]);
					if(!firstCell._attrs.get("tableCellBorderStyle")){
						var row = editor.model.document.getRoot().getNodeByPath([path])._children._nodes;
						var rowCnt = -1;
						for(var i in row){
							if(row[i].name == "tableRow"){
								rowCnt++;
							}
						}					
						var col = editor.model.document.getRoot().getNodeByPath([path,0]).childCount - 1;
						var lastCell = editor.model.document.getRoot().getNodeByPath([path,rowCnt,col]);
						editor.plugins.get("TableSelection").setCellSelection(firstCell,lastCell);
						
						setTimeout(()=>{
							editor.execute( 'tableBorderStyle', {
								value: 'solid'
							} );
							editor.execute( 'tableBorderColor', {
							  	value: '#bfbfbf'
							} );
							editor.execute( 'tableBorderWidth', {
							  	value: '1px'
							} );
							editor.execute( 'tableCellBorderStyle', {
							  	value: 'solid'
							} );
							editor.execute( 'tableCellBorderColor', {
							  	value: '#bfbfbf'
							} );
							editor.execute( 'tableCellBorderWidth', {
							  	value: '1px'
							} ); 
						},0);
					}
											
				}
			}
			
		});
    }
    
   	/*공통 소스 (추후 분리 예정)*/
 </script>
