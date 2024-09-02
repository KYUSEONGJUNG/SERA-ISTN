<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/main/inc/incUiSet.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
    .connTable {
		width: 100%;
		border: 1px solid #dcdcdc;
		border-collapse: collapse;
	}
	.connTable th{
		border: 1px solid #dcdcdc;
		padding: 2px;
	}

	.connTable td{
		border: 1px solid #dcdcdc;
		padding: 2px;
	}

</style>
<head>
	<meta http-equiv="Content-Language" content="ko">
	<!-- <link href="<c:url value='/'/>css/basic.css" rel="stylesheet" type="text/css"> -->
	<title>SR 고객사 접속정보</title>
	<script type="text/javascript" src="<c:url value='/validator.do'/>"> </script> <validator:javascript formName="pstinstVO" staticJavascript="false" xhtml="true" cdata="false" />
	<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
	<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
	<script type="text/javaScript" language="javascript" defer="defer">

		function fn_egov_search_Pstinst(){
			//document.listForm.submit();
			var form = $("#listForm")[0];
			var formData = new FormData(form);      
	        $.ajax({        	
				url : "<c:url value='/select/EgovPstinstSelectDisplay.do'/>"			
				,type : "POST"
				,data : formData
		     	,contentType : false
		     	,processData : false
				,beforeSend : fn_loading()
				,success : function(data){
					pstinstVO = data.pstinstVO;
					if(data.msgType == 'S') {
						debugger;
						$.each(data, funtion(index, value){
							
						})
						$("#displayTable").append( pstinstVO );					
						
					} else {
						alert(data.msg);				
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
		function fn_egov_detail_Pstinst(pstinstCode){
    		var varForm              = document.forms["Form"];
    		varForm.pstinstCode.value        = pstinstCode;
    		varForm.submit();
		}
	</script>
	<script>
	$(document).ready(function(){	
		
		<c:forEach var="pstinst" items="${pstinstVO}" varStatus="status">
		<c:if test="${not empty pstinst.fileId}">
			$.ajax({
		    	url : "<c:url value='/cmm/fms/selectFileInfById.do'/>",
		   	    type : 'POST',
		   	    data : {
		   	    	"${_csrf.parameterName }" : "${_csrf.token }"
		   	    	,atchFileId : "${pstinst.fileId}"
		   	    },
		   	    success : function(data){
		 	   		for(var i in data.fileList){
		 	   			data.fileList[i].name = data.fileList[i].orignlFileNm;
		 	   			data.fileList[i].ext = data.fileList[i].fileExtsn;
		 	   			data.fileList[i].size = data.fileList[i].fileMg;
		 	   		}
		 	   		SBUxMethod.refresh('fileUpload_'+ '<c:out value="${pstinst.pstinstCode}"/>',{'jsondataRef':data.fileList});
		   	    },
		   	    error : function(request, status, error){
					alert("error");   	            
		   	    },
		   	    complete:function(){
		   	    	//fn_closeLoading();
		   	    }
			});
		</c:if>
	</c:forEach>
	
	});
	</script>
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<!-- 전체 레이어 시작 -->
	<div class="sr-table-wrap" id="displayTableSub">
	<c:forEach var="pstinst" items="${pstinstVO}" varStatus="status">
      <table class="sr-table" id="${status.index}">
        <colgroup>
            <col width="12%">
            <col width="29%">
            <col width="12%">
            <col width="49%">
        </colgroup>
		<tr> 
			<th>
				<sbux-label id="table_label1_${pstinst.pstinstCode}" name="table_label1_${pstinst.pstinstCode}" uitype="normal" text="고객사"></sbux-label>
			</th>
			<td style="border-right:0px;">
			    <a href="#LINK" onclick="javascript:fn_egov_detail_Pstinst('${pstinst.pstinstCode}');">
			    	<sbux-label uitype="normal" text="<c:out value="${pstinst.name}"/>" readonly class="pointer"></sbux-label>
		    	</a>
			</td>
			<td style="border-right:0px; border-left:0px;"></td>
			<td style="border-left:0px;"></td>
		</tr>
		<tr> 
			<th>
				<sbux-label id="table_label2_${pstinst.pstinstCode}" name="table_label2_${pstinst.pstinstCode}" uitype="normal" text="접속방법"></sbux-label>
			</th>
			<td style="border-right:0px;">
				<c:forEach var="result" items="${connMethodCode_result}" varStatus="status">
					<c:if test="${result.code == pstinst.connMethodCode}">
						<sbux-label uitype="normal" text="<c:out value="${result.codeNm}"/>" readonly></sbux-label>
					</c:if>	
				</c:forEach>
			</td>
			<td style="border-right:0px; border-left:0px;"></td>
			<td style="border-left:0px;"></td>
		</tr>
		<tr> 
		    <th>
		    	<sbux-label id="table_label3_${pstinst.pstinstCode}" name="table_label3_${pstinst.pstinstCode}" uitype="normal" text="VPN URL 정보"></sbux-label>
		    </th>
		    <td colspan="3">
		    	<sbux-label id="" name="" uitype="normal" text="<c:out value="${pstinst.vpnUrl}"/>" readonly></sbux-label>							
            </td>
		</tr>
		<tr> 
		    <th>
		    	<sbux-label id="table_label4_${pstinst.pstinstCode}" name="table_label4_${pstinst.pstinstCode}" uitype="normal" text="VPN IP Address"></sbux-label>
		    </th>
		    <td>
		    	<sbux-label uitype="normal" text="<c:out value="${pstinst.vpnAddr}"/>" readonly></sbux-label>							
            </td>
		    <th>
		    	<sbux-label id="table_label5_${pstinst.pstinstCode}" name="table_label5_${pstinst.pstinstCode}" uitype="normal" text="VPN Port"></sbux-label>
		    </th>          
		    <td>
		    	<sbux-label uitype="normal" text="<c:out value="${pstinst.vpnPort}"/>" readonly></sbux-label>							
		    </td>
		</tr>
		<tr> 
		    <th>
		    	<sbux-label id="table_label6_${pstinst.pstinstCode}" name="table_label6_${pstinst.pstinstCode}" uitype="normal" text="VPN ID"></sbux-label>
		    </th>
		    <td>
				<sbux-label uitype="normal" text="<c:out value="${pstinst.vpnId}"/>" readonly></sbux-label>
            </td>
		    <th>
		    	<sbux-label id="table_label7_${pstinst.pstinstCode}" name="table_label7_${pstinst.pstinstCode}" uitype="normal" text="VPN Password"></sbux-label>
		    </th>          
		    <td>
				<sbux-label uitype="normal" text="<c:out value="${pstinst.vpnPasswd}"/>" readonly></sbux-label>
		    </td>
		</tr>				  
 			    <tr> 
		    <th>
		    	<sbux-label id="table_label8_${pstinst.pstinstCode}" name="table_label8_${pstinst.pstinstCode}" uitype="normal" text="OTP 사용여부"></sbux-label>
		    </th>
		    <td>
		    	사용 : <input type="radio"  class="radio2" value="Y" <c:if test="${pstinst.otp == 'Y'}"> checked="checked"</c:if> onclick="return(false);" >&nbsp;
	            미사용 : <input type="radio"  class="radio2" value="N" <c:if test="${pstinst.otp == 'N'}"> checked="checked"</c:if> onclick="return(false);" >                                
			</td>
		    <th>
		    	<sbux-label id="table_label9_${pstinst.pstinstCode}" name="table_label9_${pstinst.pstinstCode}" uitype="normal" text="Solman 사용여부"></sbux-label>
		    </th>
		    <td>
		    	사용 : <input type="radio"  class="radio2" value="Y" <c:if test="${pstinst.solman == 'Y'}"> checked="checked"</c:if> onclick="return(false);" >&nbsp;
	            미사용 : <input type="radio"  class="radio2" value="N" <c:if test="${pstinst.solman == 'N'}"> checked="checked"</c:if> onclick="return(false);" >                                
		    </td>
		    
		</tr>
                    <c:if test="${not empty pstinst.fileId}">
                        <tr> 
                     	    <th>
                     	    	<sbux-label id="table_label10_${pstinst.pstinstCode}" name="table_label10_${pstinst.pstinstCode}" uitype="normal" text="<spring:message code="cop.atchFileList" />"></sbux-label>
                     	    </th>
                            <td colspan="3">
                            		<input type="hidden" id="atchFileId_${pstinst.pstinstCode}" name="atchFileId" value="<c:out value="${pstinst.fileId}"/>"/>
						<sbux-fileupload id="fileUpload_${pstinst.pstinstCode}" name="fileUpload_${pstinst.pstinstCode}" uitype="multipleExt" style = "width: 100% "  
                                 	vertical-scroll-height="150px"
                                 	accept-file-types="txt|doc|docx|xls|xlsx|pdf|gif|jpg|jpeg|png|zip|csv|ppt|pptx|html"
                                 	header-title="<spring:message code="cop.atchFile" />"
                                 	drop-zone="false"
                                 	button-add-status="none"
                                 	button-delete-status="none"
                                 	list-checkbox-status="hidden"
                                 	list-delete-status="hidden"
                                 	button-add-title="<spring:message code="sr.ctsAdd" />"
                                 	button-delete-title="<spring:message code="sr.ctsDel" />"
                                 	callback-click-list= "fnFileDownload">
						</sbux-fileupload>
                            </td>
                        </tr>
                    </c:if>
		<tr> 
			<th>
				<sbux-label id="table_label11_${pstinst.pstinstCode}" name="table_label11_${pstinst.pstinstCode}" uitype="normal" text="특이사항"></sbux-label>
			</th>
			<td colspan="3" height="115">
				<sbux-textarea name="remark" uitype="normal" class="textarea" style="width:100%; height:inherit;" readonly><c:out value="${pstinst.remark}" escapeXml="false" /></sbux-textarea>                       
		    </td>
		</tr>
		</table>
		</div>
		<div class="sr-table-wrap">
			<c:set var="name">${pstinst.pstinstCode}</c:set> 
			<c:if test="${!empty srconnectList[name]}">
			<table summary="고객사 접속정보 관련 테이블" id="connTable" class="sr-table">
				<colgroup>
                        <col width="20%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                        <col width="5%">
                   </colgroup>
				<tr>
					<th>
						<sbux-label id="table_label12_${pstinst.pstinstCode}" name="table_label12_${pstinst.pstinstCode}" uitype="normal" text="고객사명(세부)"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label13_${pstinst.pstinstCode}" name="table_label13_${pstinst.pstinstCode}" uitype="normal" text="TYPE"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label14_${pstinst.pstinstCode}" name="table_label14_${pstinst.pstinstCode}" uitype="normal" text="시스템ID"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label15_${pstinst.pstinstCode}" name="table_label15_${pstinst.pstinstCode}" uitype="normal" text="인스턴스번호"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label16_${pstinst.pstinstCode}" name="table_label16_${pstinst.pstinstCode}" uitype="normal" text="IP Address"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label17_${pstinst.pstinstCode}" name="table_label17_${pstinst.pstinstCode}" uitype="normal" text="SAP ID"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label18_${pstinst.pstinstCode}" name="table_label18_${pstinst.pstinstCode}" uitype="normal" text="SAP Password"></sbux-label>
					</th>
					<th>
						<sbux-label id="table_label19_${pstinst.pstinstCode}" name="table_label19_${pstinst.pstinstCode}" uitype="normal" text="Client"></sbux-label>
					</th>
				</th>
			  	<c:forEach var="list" items="${srconnectList[name]}" varStatus="status1">
			  	<tr>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.nameDetail}"/>" ></sbux-input>
					</td>
					<td>
				    <c:forEach var="result" items="${type_result}" varStatus="status2">
						<c:if test="${result.code == list.typeCode}">
							<sbux-label uitype="normal" text="<c:out value="${result.codeNm}"/>" ></sbux-input>									 
						</c:if>
					</c:forEach>
				  	</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.sid}"/>" ></sbux-input>
					</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.ins}"/>" ></sbux-input>
					</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.ipAddr}"/>" ></sbux-input>
					</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.sapId}"/>" ></sbux-input>
					</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.sapPasswd}"/>" ></sbux-input>
					</td>
					<td>
						<sbux-label uitype="normal" text="<c:out value="${list.client}"/>" ></sbux-input>
					</td>
			  	</tr>
			  	</c:forEach>
                 	</table>
			</c:if>
			<br>
		</c:forEach>
		</div>			
	<!-- //전체 레이어 끝 -->
</body>

</html>
