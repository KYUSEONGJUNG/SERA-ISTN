/****************************************************************
 * 
 * 파일명 : EgovPstinstPopup.js
 * 설  명 : 전자정부 공통서비스 고객사 팝업 JavaScript
 * 
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2014.02.27     박원배       1.0             최초생성
 * 
 * 
 */

/**********************************************
 * 함수명 : fn_egov_PstinstSearch
 * 설  명 : 고객사찾기 팝업 호출 - form별로 이름이 다른 경우 사용
 * 인  자 : 사용할 Form 객체, 고객사코드(123456), 고객사명 
 * 사용법 : fn_egov_PstinstSearch(frm, sPstinstCode, sPstinstNm)
 * 
 * 수정일        수정자      수정내용
 * ------        ------     -------------------
 * 2009.03.30    이중호      신규작업
 * 
 */
function fn_egov_PstinstSearch(frm, sPstinstCode, sPstinstNm) {
	var retVal;

	var url = frm.pstinst_url.value;
	//var url = "/ebt/sym/ccm/EgovCcmZipSearchPopup.do"; 
	var varParam = new Object();
	varParam.sPstinstCode = sPstinstCode.value;		
	varParam.sPstinstNm = sPstinstNm.value;		

	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:680px;dialogHeight:530px;scroll:no;status:no;center:yes;resizable:yes;";

	retVal = window.showModalDialog(url, varParam, openParam);

	if(retVal) {
		sPstinstCode.value  = retVal.sPstinstCode;
		sPstinstNm.value = retVal.sPstinstNm;
	}
}
