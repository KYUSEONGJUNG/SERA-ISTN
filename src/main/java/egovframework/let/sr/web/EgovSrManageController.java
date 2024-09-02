package egovframework.let.sr.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Locale;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.sl.usermodel.ColorStyle;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.FontUnderline;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.IndexedColorMap;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellBorder.BorderSide;
import org.apache.xmlbeans.impl.repackage.Repackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ibm.icu.text.TimeZoneFormat.Style;
import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.internal.Util;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.CmmnDetailCode;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngUtil;
import egovframework.let.main.service.com.cmm.service.FileVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.main.service.com.cop.ems.service.EgovMultiPartEmail;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.sr.service.EgovSrManageService;
import egovframework.let.sr.service.Sr;
import egovframework.let.sr.service.SrVO;
import egovframework.let.sts.obsryrt.service.EgovSrObservanceRateService;
import egovframework.let.sts.obsryrt.service.SrObservanceRateVO;
import egovframework.let.sts.prcrt.service.EgovSrProcessRateService;
import egovframework.let.sts.prcrt.service.ProcessRateVO;
import egovframework.let.sts.stsfdg.service.EgovStsfdgSttusService;
import egovframework.let.sts.stsfdg.service.StsfdgSttusVO;
import egovframework.let.sr.service.SrAnswerVO;
import egovframework.let.sr.service.SrCtsVO;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.pstinst.service.SrchargerVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.JSONArray;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTColor;

/**
 * 
 * SR에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를
 * 정의한다
 * 
 * @author SR리스트 개발팀 박원배
 * @since 2013.03.18
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2013.03.19  박원배          최초 생성
 *
 *      </pre>
 */
@Controller
public class EgovSrManageController {
	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "SrManageService")
	private EgovSrManageService srManageService;

	/** userManageService */
	@Resource(name = "userManageService")
	private EgovUserManageService userManageService;

	/** PstinstManageService */
	@Resource(name = "PstinstManageService")
	private EgovPstinstManageService pstinstManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	// 첨부파일 사용시
	@Resource(name = "egovMultiPartEmail")
	private EgovMultiPartEmail egovMultiPartEmail;
	
	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** EgovStsfdgSttusService */
	@Resource(name = "stsfdgSttusService")
    private EgovStsfdgSttusService stsfdgSttusService;
    
	/** SrObservanceRateService */
    @Resource(name = "SrObservanceRateService")
    private EgovSrObservanceRateService srObservanceRateService;
    
    /** EgovSrProcessRateService */
	@Resource(name = "srProcessRateService")
    private EgovSrProcessRateService srProcessRateService;
	
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * SR 목록을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrList.do")
	public String selectSrList(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("searchVO") SrVO searchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {

		// 다국어 조회
		getLanguage(model, request);

		List<String> strStatus = new ArrayList<String>();

		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "1000000");
		request.getSession().setAttribute("selMenuNo", "1010000");

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())) {
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())) {
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		/** 검색-완료일 */
		if (!"".equals(searchVO.getSearchCompleteDateFView())) {
			searchVO.setSearchCompleteDateF(searchVO.getSearchCompleteDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchCompleteDateTView())) {
			searchVO.setSearchCompleteDateT(searchVO.getSearchCompleteDateTView().replaceAll("-", ""));
		}
//		if("".equals(searchVO.getSearchConfirmDateF())) {
//			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.MONTH, -1);
//			String strConfirmDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);
//			searchVO.setSearchConfirmDateF(strConfirmDate);
//		}
//		if("".equals(searchVO.getSearchCompleteDateT())) {
//			Calendar cal = Calendar.getInstance();
//			String strConfirmDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);
//			searchVO.setSearchConfirmDateT(strConfirmDate);
//		}
		// 권한코드
		model.addAttribute("authorCode", user.getAuthorCode());

		if ("ROLE_ADMIN".equals(user.getAuthorCode())) { // Admin
			if ("".equals(searchVO.getSearchAt())) {
				//strStatus.add("1000"); // 임시저장(검색 초기용)
				//strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				strStatus.add("1007"); // 반려
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_CHARGER".equals(user.getAuthorCode())) { // 담당자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRid(user.getId());
				//strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				// strStatus.add("1006"); //완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_COOPERATION".equals(user.getAuthorCode())) { // 협력담당자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRid(user.getId());
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				// strStatus.add("1006"); //완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_MNGR".equals(user.getAuthorCode())) { // 관리자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRid(user.getId());
				//strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				// strStatus.add("1006"); //완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) { // 고객(현업)
			searchVO.setSearchPstinstCode(user.getPstinstCode());

			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchCustomerNm(user.getName());
				strStatus.add("1000"); // 임시저장(검색 초기용)
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				strStatus.add("1007"); // 반려
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 결재자

			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				strStatus.add("1001"); // 등록(결재자 검색 초기용)
				searchVO.setSearchStatus(strStatus);
			}

		}

		// AuthorCode set
		searchVO.setAuthorCode(user.getAuthorCode());
		searchVO.setUserId(user.getId());
		
		// SR 목록
		//model.addAttribute("resultList", srManageService.selectSrList(searchVO));

		// SR Count 정보
		model.addAttribute("srCntList", srManageService.selectSrCntDetail(searchVO));

		// int totCnt = srManageService.selectSrListTotCnt(searchVO);
		// paginationInfo.setTotalRecordCount(totCnt);
		//SrVO resultCnt = srManageService.selectSrListTotCnt(searchVO);
		//paginationInfo.setTotalRecordCount(resultCnt.getTotcnt());
		//model.addAttribute("paginationInfo", paginationInfo);

		// SR실공수합계
		//model.addAttribute("realExpectTimeSum", resultCnt.getRealExpectTimeSum());

		// //고객(현업) 및 결재자조회시에만 사용
		// if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) ||
		// "ROLE_USER_SANCTNER".equals(user.getAuthorCode())){
		// if(!"".equals(searchVO.getSearchAt())){
		// //상태 checkbox 등록(1001)이 선택되었을때
		// if(searchVO.getSearchStatus1001At() != null &&
		// "Y".equals(searchVO.getSearchStatus1001At())){
		// }else{
		// strStatus.remove("1001"); //등록 : 반려로 인해 추가된 상태값 1001은 제외시킴
		// searchVO.setSearchStatus(strStatus);
		// }
		// }
		// }

		// SR Service Level(고객)
		if ("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || "ROLE_USER_SANCTNER".equals(user.getAuthorCode())) {
			if (user.getStrservicelvl() != null && !"".equals(user.getStrservicelvl())
					&& !"null".equals(user.getStrservicelvl())) {
				session.setAttribute("strservicelvl", user.getStrservicelvl());
			} else {
				session.setAttribute("strservicelvl", "");
			}
		} else {
			session.setAttribute("strservicelvl", "");
		}

		List<EgovMap> cooperCharger = new ArrayList();
		if ("ROLE_COOPERATION".equals(user.getAuthorCode())) {
			SrchargerVO srchargerVO = new SrchargerVO();
			srchargerVO.setUserId(user.getId());
			cooperCharger = pstinstManageService.selectCooperchargerList(srchargerVO);
		}

		// 모듈코드를 코드정보로부터 조회 - SR0003
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SR0003");
		vo.setPstinstCode(user.getPstinstCode());
		List<CmmnDetailCode> moduleCode = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("moduleCode_result", moduleCode);
//
//		// 협력담당자인 경우 해당되는 모듈만 리턴
//		if ("ROLE_COOPERATION".equals(user.getAuthorCode())) {
//			HashSet<CmmnDetailCode> tmpSet = new HashSet();
//			for (int i = 0; i < cooperCharger.size(); i++) {
//				CmmnDetailCode tmp = new CmmnDetailCode();
//				EgovMap m = cooperCharger.get(i);
//
//				tmp.setCode((String) m.get("moduleCode"));
//				tmpSet.add(tmp);
//			}
//			List<CmmnDetailCode> resCode = new ArrayList();
//			ArrayList<CmmnDetailCode> tmpList = new ArrayList(tmpSet);
//
//			for (int i = 0; i < tmpList.size(); i++) {
//				for (int j = 0; j < moduleCode.size(); j++) {
//					if (tmpList.get(i).getCode().equals(moduleCode.get(j).getCode())) {
//						resCode.add(moduleCode.get(j));
//					}
//				}
//			}
//			model.addAttribute("moduleCode_result", resCode);
//		} else {
//			model.addAttribute("moduleCode_result", moduleCode);
//		}

		// 상태코드를 코드정보로부터 조회 - SR0004
		vo.setCodeId("SR0004");
		model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
		
		// kpmg 2021.07.14
		// 처리구분코드를 코드정보로부터 조회 - SR0005
		vo.setCodeId("SR0005");
		model.addAttribute("classCode_result", cmmUseService.selectCmmCodeDetail(vo));
		
		// 담당자 및 관리자 목록
		model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));

		// 고객사정보

		// model.addAttribute("pstinstList",
		// pstinstManageService.selectPstinstAllList(PstinstVO));
		PstinstVO PstinstVO = new PstinstVO();
		List<EgovMap> pstinstList = pstinstManageService.selectPstinstAllList(PstinstVO);
		model.addAttribute("pstinstList", pstinstList);

		return "/sr/EgovSrList";
	}
	
	
	/**
	 * SR 목록을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/select/sr/EgovSrList.do")
	@ResponseBody
	public Map<String, Object> selectEgovSrList(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("searchVO") SrVO searchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		
		Map<String, Object> retMap = new HashMap<String, Object> ();
		// 다국어 조회
		getLanguage(model, request);

		List<String> strStatus = new ArrayList<String>();
 
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "1000000");
		request.getSession().setAttribute("selMenuNo", "1010000");

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// AuthorCode set
		searchVO.setAuthorCode(user.getAuthorCode());
		searchVO.setUserId(user.getId());
		
		if ("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || "ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 고객(현업), 결재자
			searchVO.setSearchPstinstCode(user.getPstinstCode());
		}
		// SR 목록
		retMap.put("resultList", srManageService.selectSrList(searchVO));

		// SR Count 정보
		retMap.put("srCntList", srManageService.selectSrCntDetail(searchVO));

		// int totCnt = srManageService.selectSrListTotCnt(searchVO);
		// paginationInfo.setTotalRecordCount(totCnt);
		SrVO resultCnt = srManageService.selectSrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(resultCnt.getTotcnt());
		retMap.put("paginationInfo", paginationInfo);

		// SR실공수합계
		retMap.put("realExpectTimeSum", resultCnt.getRealExpectTimeSum());

		// 모듈코드를 코드정보로부터 조회 - SR0003
//		ComDefaultCodeVO vo = new ComDefaultCodeVO();
//		vo.setCodeId("SR0003");
//		List<CmmnDetailCode> moduleCode = cmmUseService.selectCmmCodeDetail(vo);
//		retMap.put("moduleCode_result", moduleCode);
//
//		// 상태코드를 코드정보로부터 조회 - SR0004
//		vo.setCodeId("SR0004");
//		retMap.put("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
//		
//		// kpmg 2021.07.14
//		// 처리구분코드를 코드정보로부터 조회 - SR0005
//		vo.setCodeId("SR0005");
//		retMap.put("classCode_result", cmmUseService.selectCmmCodeDetail(vo));		
		
		return retMap;
	}
	

	private void getLanguage(ModelMap model, HttpServletRequest request) {
		// 다국어 wbpark 2016.05.24
		String language = (String) request.getSession().getAttribute("language");
		if ("ko".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		} else if ("en".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
			model.addAttribute("srLanguage", "en");
		} else if ("cn".equals(language)) {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
			model.addAttribute("srLanguage", "cn");
		} else {
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		}
	}

	/**
	 * SR정보 수정을 위해 상세조회한다.
	 * 
	 * @param loginVO
	 * @param sr
	 * @param model
	 * @return "/sr/EgovSrSelectUpdt"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrSelectUpdtView.do")
	public String updateSrView(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("sr") Sr sr,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("srchargerVO") SrAnswerVO srAnswerVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO,
			HttpServletRequest request, ModelMap model)
			throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		// 권한코드
		model.addAttribute("authorCode", user.getAuthorCode());

		// SR정보
		SrVO result = srManageService.selectSrDetail(srVO);

		// 답변 처리자 초기화
		result.setAnsRid(user.getId());

		// SR답변
		model.addAttribute("answerList", srManageService.selectSrAnswerList(srAnswerVO));
		// SR답변(임시저장)
		// Admin, 담당자, 관리자
		if ("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode())
				|| "ROLE_MNGR".equals(user.getAuthorCode()) || "ROLE_COOPERATION".equals(user.getAuthorCode())) {
			srAnswerVO.setAnswerSe("10"); // 답변
		} else {
			srAnswerVO.setAnswerSe("20"); // 추가요청
		}
		model.addAttribute("answerListTemp", srManageService.selectSrAnswerListTemp(srAnswerVO));

		// 모듈코드를 코드정보로부터 조회 - SR0003
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SR0003");
		vo.setPstinstCode(result.getPstinstCode());
		model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 상태코드를 코드정보로부터 조회 - SR0004
		vo.setCodeId("SR0004");
		model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 처리구분코드를 코드정보로부터 조회 - SR0005
		vo.setCodeId("SR0005");
		model.addAttribute("classCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 우선순위코드를 코드정보로부터 조회 - SR0006
		vo.setCodeId("SR0006");
		model.addAttribute("priortCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 고객사별 요청자 목록
		vo.setCodeId(result.getPstinstCode());
		model.addAttribute("cstmrCode_result", cmmUseService.selectCstmrDetail(vo));

		// 담당자 및 관리자명 목록
		model.addAttribute("chargerList", userManageService.selectChargerNmList(userManageVO));
		
		//20210325 SHS SrCTS 정보 get
		model.addAttribute("cts_result", srManageService.selectSrCtsList(srVO));
		
		model.addAttribute("sign", srManageService.selectSigature(user));
		String returnUrl = "";
		if ("1000".equals(result.getStatus())) { // 임시저장

			// 완료희망일 : todate + 5일
			Calendar cal = Calendar.getInstance();

			// 요청일
			String strSignDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);

			cal.add(Calendar.DATE, 5);
			int dat_of_week = cal.get(cal.DAY_OF_WEEK);
			if (dat_of_week == 1) { // 일요일
				cal.add(Calendar.DATE, 1);
			} else if (dat_of_week == 7) { // 월요일
				cal.add(Calendar.DATE, 2);
			}

			String strHopeDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
			Date hopeDate = sdfmt.parse(strHopeDate);
			Date signDate = sdfmt.parse(strSignDate);
			strHopeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(hopeDate);
			strSignDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(signDate);
			result.setHopeDate(strHopeDate);
			result.setHopeDateView(strHopeDate);
			result.setSignDate(strSignDate);

			returnUrl = "/sr/EgovSrSelectUpdtCstmr";
		} else if ("1001".equals(result.getStatus())) { // SR등록(조회 및 결재자 수정화면)
			if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) {
				returnUrl = "/sr/EgovSrSelectUpdtSanctner";
			} else if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) {
				returnUrl = "/sr/EgovSrSelectUpdtCstmr";
			} else {
				returnUrl = "/sr/EgovSrSelect";
			}
		} else if ("1007".equals(result.getStatus())) {
			returnUrl = "/sr/EgovSrSelectUpdtSanctner";
		}
		else {
			// Admin, 담당자, 관리자
			if ("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode())
					|| "ROLE_MNGR".equals(user.getAuthorCode()) || "ROLE_COOPERATION".equals(user.getAuthorCode())) {
				returnUrl = "/sr/EgovSrSelectUpdtMng";
			} else if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) { // 고객(현업)
				srVO.setPstinstCode(user.getPstinstCode());
				String strSettleAt = ""; // 결재여부
				// 1. SR저장시 고객사 결재여부에 따라 상태값 변경처리
				strSettleAt = srManageService.selectPstinstSettleAt(srVO);
				if ("1002".equals(result.getStatus())) { // SR접수대기
					if ("Y".equals(strSettleAt)) { // 결재
						returnUrl = "/sr/EgovSrSelectUpdt";
					} else {
						// 접수대기중 결재대상인 아닌것은 수정가능
						returnUrl = "/sr/EgovSrSelectUpdtCstmr";
					}
				} else {
					returnUrl = "/sr/EgovSrSelectUpdt";
				}
			} else if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 결재자
				// returnUrl = "/sr/EgovSrSelect";
				returnUrl = "/sr/EgovSrSelectUpdt";
			}
		}

		
		model.addAttribute("srVO", result);

		return returnUrl;

	}

	/**
	 * SR를 수정한다.(SR등록 이후부터 처리 : SR담당자/고객)
	 * 
	 * @param loginVO
	 * @param sr
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/sr/EgovSrModify"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrSelectUpdt.do")
	@ResponseBody
	public Map<String, Object> updateSr(@RequestParam("ctsChk") String ctsChk,
			@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srchargerVO") SrAnswerVO srchargerVO,
			@ModelAttribute("srchargerVO") SrAnswerVO srAnswerVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO,
			@ModelAttribute("srCtsVO") SrCtsVO srCtsVO, 
			BindingResult bindingResult, Map commandMap,
			ModelMap model, HttpServletRequest request, final MultipartHttpServletRequest multiRequest)
			throws Exception {
		
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		
		try {			
				
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

			Boolean isComplete = false;

			// 완료예정일
			if (!"".equals(srVO.getScheduleDateView())) {
				srVO.setScheduleDate(srVO.getScheduleDateView().replaceAll("-", ""));
			}
			// 완료일
			if (!"".equals(srVO.getCompleteDateView())) {
				srVO.setCompleteDate(srVO.getCompleteDateView().replaceAll("-", ""));
			}
			// 테스트완료일
			if ("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || "ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 고객,
																														// 결재자
				if ("Y".equals(srVO.getTestAt())) {
					srVO.setTat("Y"); // tat가 "Y"일때 테스트완료일 저장
					if ("".equals(srVO.getTestCompleteDate()) || srVO.getTestCompleteDate() == null) {
						srVO.setStatus("1006"); // 이미 저장된 테스트 완료일이 없을때(최초등록시) 상태 완료로 변경
						isComplete = true;
					}
				}
			}

			String atchFileId = srVO.getAnsFileId();
			//final Map<String, MultipartFile> files = multiRequest.getFileMap();
			List<MultipartFile> files = multiRequest.getFiles("files");
			if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
					//List<FileVO> result = fileUtil.parseFileInf(files, "SR_", 0, atchFileId,"Globals.fileStorePathSr");
					List<FileVO> result = fileUtil.parseFileList(files, "SR_", 0, atchFileId, "Globals.fileStorePathSr");
					atchFileId = fileMngService.insertFileInfs(result);
					srVO.setAnsFileId(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					//List<FileVO> _result = fileUtil.parseFileInf(files, "SR_", cnt, atchFileId,
							//"Globals.fileStorePathSr");
					List<FileVO> _result = fileUtil.parseFileList(files, "SR_", cnt, atchFileId, "Globals.fileStorePathSr");
					fileMngService.updateFileInfs(_result);
				}
			}

			// 답변 저장 및 임시저장
			if ("2".equals(srVO.getSaveSe()) || "3".equals(srVO.getSaveSe())) {

				// 신규답변
				if (srVO.getAnswerNo() == 0 && !"".equals(srVO.getAnsComment()) && !"<br>".equals(srVO.getAnsComment())) { // 답변
																															// 유무에
																															// 따라
																															// 답변
																															// 등록
					srVO.setAnsCreatorId(user.getId()); // 답변 생성자

					// 실제공수 데이터 타입으로 인한 초기화 처리
					if (srVO.getAnsRealExpectTime().equals("")) {
						srVO.setAnsRealExpectTime("0");
					}

					// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
					if ("2".equals(srVO.getSaveSe())) {
						srVO.setTempSaveAt("Y");
					} else if ("3".equals(srVO.getSaveSe())) {
						srVO.setTempSaveAt("N");

						if ("on".equals(srVO.getEmailSendAt())) { // 이메일 발송 체크시만 처리

							srVO.setComment(unscript(srVO.getComment())); // XSS 방지
							String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목

							if ("10".equals(srVO.getAnswerSe())) { // 답변에 대한 요청자에게 메일 발송
								// 2. 요청자에게 메일발송
								String strCstmrLanguage = srManageService.strCstmrLanguage(srVO); // 고객 사용 Language
								// subject = "[SR답변]".concat(subject);
								if ("ko".equals(strCstmrLanguage)) {
									subject = "[SR답변]".concat(subject);
								} else if ("en".equals(strCstmrLanguage)) {
									subject = "[SR Answers]".concat(subject);
								} else if ("cn".equals(strCstmrLanguage)) {
									subject = "[SR 处理内容]".concat(subject);
								} else {
									subject = "[SR답변]".concat(subject);
								}
								String emailCn = (srVO.getAnsComment() == null) ? "<p>&nbsp;</p>" : srVO.getAnsComment(); // 메일내용
								SrVO srEmailVo = srManageService.selectAnsChargerEmail(srVO); // 처리자 메일조회

								if (srEmailVo != null && !"".equals(srEmailVo.getRemail())) {
									egovMultiPartEmail.setEmailAddress(srEmailVo.getRemail()); // 보내는사람 메일
									if ("ko".equals(strCstmrLanguage)) {
										egovMultiPartEmail.setSenderName(srEmailVo.getRname()); // 보내는사람 이름
									} else {
										egovMultiPartEmail.setSenderName(srEmailVo.getRnameEn()); // 보내는사람 이름
									}
									// egovMultiPartEmail.send(srVO.getEmail(), subject, emailCn); //받는사람 메일
									egovMultiPartEmail.send(srVO.getEmail(), subject, emailCn, atchFileId, srVO.getSrNo(),
											srVO.getAnswerNo()); // 받는사람 메일
								}
							} else if ("20".equals(srVO.getAnswerSe())) { // 추가요청에 대한 담당자에게 메일 발송
								// 2. 담당자에게 메일발송
								subject = "[SR추가요청]".concat(subject);
								String emailCn = (srVO.getAnsComment() == null) ? "<p>&nbsp;</p>" : srVO.getAnsComment(); // 메일내용
								SrVO srEmailVo = srManageService.selectChargerEmail(srVO); // 담당자 메일조회

								if (srEmailVo != null && !"".equals(srEmailVo.getRemail())) {
									egovMultiPartEmail.setSenderName(srVO.getCustomerNm()); // 보내는사람 이름
									egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
									// egovMultiPartEmail.setSenderName(srVO.getCustomerNm().concat("[".concat(srVO.getEmail().concat("]"))));
									// //보내는사람 이름

									egovMultiPartEmail.send(srEmailVo.getRemail(), subject, emailCn, atchFileId,
											srVO.getSrNo(), srVO.getAnswerNo()); // 받는사람 메일
								}
							}
						}

					}

					// 신규 답변 등록
					// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
					if ("2".equals(srVO.getSaveSe())) {
						// 2: 답변임시저장의 경우 이미 저장되어진게 있는지 확인후 저장
						String strAnsTempSaveAt = ""; // 임시저장여부
						strAnsTempSaveAt = srManageService.selectAnsTempSaveAt(srVO);
						if ("".equals(strAnsTempSaveAt) || strAnsTempSaveAt == null) {
							srManageService.insertSrAnswer(srVO);
						}
					} else {
						srManageService.insertSrAnswer(srVO);
					}
				}

				// 임시 저장된 답변 수정
				if (srVO.getAnswerNo() != 0) {
					srVO.setAnsEditorId(user.getId()); // 답변 수정자

					// 실제공수 데이터 타입으로 인한 초기화 처리
					if (srVO.getAnsRealExpectTime().equals("")) {
						srVO.setAnsRealExpectTime("0");
					}

					// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
					if ("2".equals(srVO.getSaveSe())) {
						srVO.setTempSaveAt("Y");
					} else if ("3".equals(srVO.getSaveSe())) {
						srVO.setTempSaveAt("N");
						if ("on".equals(srVO.getEmailSendAt())) { // 이메일 발송 체크시만 처리

							srVO.setComment(unscript(srVO.getComment())); // XSS 방지
							String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목

							if ("10".equals(srVO.getAnswerSe())) { // 답변에 대한 요청자에게 메일 발송
								// 2. 요청자에게 메일발송
								// subject = "[SR답변]".concat(subject);
								String strCstmrLanguage = srManageService.strCstmrLanguage(srVO); // 고객 사용 Language
								// subject = "[SR답변]".concat(subject);
								if ("ko".equals(strCstmrLanguage)) {
									subject = "[SR답변]".concat(subject);
								} else if ("en".equals(strCstmrLanguage)) {
									subject = "[SR Answers]".concat(subject);
								} else if ("cn".equals(strCstmrLanguage)) {
									subject = "[SR 处理内容]".concat(subject);
								} else {
									subject = "[SR답변]".concat(subject);
								}
								String emailCn = (srVO.getAnsComment() == null) ? "<p>&nbsp;</p>" : srVO.getAnsComment(); // 메일내용
								// SrVO srEmailVo = srManageService.selectChargerEmail(srVO); //담당자 메일조회
								// /<<<<<<<<<<<<<<지금까지 이렇게 발송되고 있었나? wbpark
								SrVO srEmailVo = srManageService.selectAnsChargerEmail(srVO); // 처리자 메일조회

								if (srEmailVo != null && !"".equals(srEmailVo.getRemail())) {
									egovMultiPartEmail.setEmailAddress(srEmailVo.getRemail()); // 보내는사람 메일
									if ("ko".equals(strCstmrLanguage)) {
										egovMultiPartEmail.setSenderName(srEmailVo.getRname()); // 보내는사람 이름
									} else {
										egovMultiPartEmail.setSenderName(srEmailVo.getRnameEn()); // 보내는사람 이름
									}
									egovMultiPartEmail.send(srVO.getEmail(), subject, emailCn, atchFileId, srVO.getSrNo(),
											srVO.getAnswerNo()); // 받는사람 메일
								}
							} else if ("20".equals(srVO.getAnswerSe())) { // 추가요청에 대한 담당자에게 메일 발송
								// 2. 담당자에게 메일발송
								subject = "[SR추가요청]".concat(subject);
								String emailCn = (srVO.getAnsComment() == null) ? "<p>&nbsp;</p>" : srVO.getAnsComment(); // 메일내용
								SrVO srEmailVo = srManageService.selectChargerEmail(srVO); // 담당자 메일조회

								if (srEmailVo != null && !"".equals(srEmailVo.getRemail())) {
									egovMultiPartEmail.setSenderName(srVO.getCustomerNm()); // 보내는사람 이름
									egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일

									// //보내는사람 이름
									egovMultiPartEmail.send(srEmailVo.getRemail(), subject, emailCn, atchFileId,
											srVO.getSrNo(), srVO.getAnswerNo()); // 받는사람 메일
								}
							}

						}
					}
					srManageService.updateSrAnswer(srVO);
				}

			}
			// 20200619 SHS SR완료시 담당자에게 메일 발송
			if (isComplete) {
				SrVO fromVO = srManageService.selectSrDetail(srVO);
				String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
				subject = "[SR완료]".concat(subject);
				SrVO srEmailVo = srManageService.selectChargerEmail(srVO); // 담당자 메일조회
				String emailCn = getSendCompleteComment(srVO, fromVO);
				if (srEmailVo != null && !"".equals(srEmailVo.getRemail())) {
					egovMultiPartEmail.setSenderName(srVO.getCustomerNm()); // 보내는사람 이름
					egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
					egovMultiPartEmail.send(srEmailVo.getRemail(), subject, emailCn, null, srVO.getSrNo(), 0); // 받는사람 메일
				}
			}

			// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장, 4: 고객의견)
			// 고객의견은 2015.10.01일부로 이미 등록된것만 보여주고 신규등록은 안함
			// if ("4".equals(srVO.getSaveSe())){
			// //고객의견 등록
			// if(srVO.getAnswerNoArr() != null){
			//
			// int [] answerNo = srVO.getAnswerNoArr();
			// String [] cstmrComment = srVO.getCstmrCommentArr();
			//
			// for(int i=0; i<srVO.getAnswerNoArr().length; i++){
			//
			//// if(!"".equals(cstmrComment[i])){
			// srVO.setAnswerNoUpdate(answerNo[i]);
			// srVO.setAnsCstmrCommentUpdate(cstmrComment[i]);
			// srManageService.updateSrAnswerCstmrComment(srVO);
			//// }
			// }
			// }
			// }

			// SR를 수정한다.
			srManageService.updateSr(srVO);

			// 답변 실공수(헤더) 수정
			srManageService.updateSrRealExpectTime(srVO);
			
			//S_20210323 SHS
			//CTS가 변경되었을 경우 (행 추가 or 행 삭제) ctsChk = "Y" 
			//아닌경우 ctsChk = "N"
			if(ctsChk.equals("Y")) {
				//삭제후 저장
				int cnt = 0;
				srManageService.deleteSrCts(srVO.getSrNo());
				if(srCtsVO.getCts_numbers() != null) {
					for(int i=0;i<srCtsVO.getCts_numbers().length; i++) {
						SrCtsVO srCtsVOTmp = new SrCtsVO();
						srCtsVOTmp.setCreatorId(user.getId()); // 생성자
						
						if(!srCtsVO.getCts_numbers()[i].trim().equals("")) {
							cnt++;
							srCtsVOTmp.setSrNo(srVO.getSrNo());
							srCtsVOTmp.setCts_number(srCtsVO.getCts_numbers()[i]);
							srCtsVOTmp.setCts_desc(srCtsVO.getCts_descs()[i]);
							srCtsVOTmp.setCts_owner(srCtsVO.getCts_owners()[i]);
							srCtsVOTmp.setCts_seq(cnt);
							srManageService.insertSrCts(srCtsVOTmp);
						}					
					}
				}
			}
			
			// Exception 없이 진행시 수정성공메시지
			retMap.put("msgType", "S");			
			retMap.put("msg", egovMessageSource.getMessage("success.common.save"));
			
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
		}finally {
			
		}	
		
		return retMap;

	}

	/**
	 * SR를 수정한다.(고객-현업)
	 * 
	 * @param loginVO
	 * @param sr
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/sr/EgovSrModify"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrSelectUpdtCstmr.do")
	@ResponseBody
	public Map<String, Object> updateSrCstmr(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srchargerVO") SrAnswerVO srchargerVO,
			BindingResult bindingResult, Map commandMap, ModelMap model, HttpServletRequest request,
			final MultipartHttpServletRequest multiRequest) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			beanValidator.validate(srVO, bindingResult);
			if (bindingResult.hasErrors()) {

				retMap.put("msgType", "E");
				retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
				
			} else {
				
				LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
				String atchFileId = srVO.getFileId();
				String strSettleAt = ""; // 결재여부

				// 신청일(요청일)
				if (!"".equals(srVO.getSignDate())) {
					srVO.setSignDateDisp(srVO.getSignDate()); // 메일발송용
					srVO.setSignDate(srVO.getSignDate().replaceAll("-", ""));
				}
				// 완료희망일
				if (!"".equals(srVO.getHopeDateView())) {
					srVO.setHopeDateDisp(srVO.getHopeDateView()); // 메일발송용
					srVO.setHopeDate(srVO.getHopeDateView().replaceAll("-", ""));
				}
				
				//파일 저장
				//final Map<String, MultipartFile> files = multiRequest.getFileMap();
				List<MultipartFile> files = multiRequest.getFiles("files");
				if (!files.isEmpty()) {
					if ("".equals(atchFileId)) {
						//List<FileVO> result = fileUtil.parseFileInf(files, "SR_", 0, atchFileId,"Globals.fileStorePathSr");
						List<FileVO> result = fileUtil.parseFileList(files, "SR_", 0, atchFileId, "Globals.fileStorePathSr");
						atchFileId = fileMngService.insertFileInfs(result);
						srVO.setFileId(atchFileId);
					} else {
						FileVO fvo = new FileVO();
						fvo.setAtchFileId(atchFileId);
						int cnt = fileMngService.getMaxFileSN(fvo);
						//List<FileVO> _result = fileUtil.parseFileInf(files, "SR_", cnt, atchFileId,
								//"Globals.fileStorePathSr");
						List<FileVO> _result = fileUtil.parseFileList(files, "SR_", cnt, atchFileId, "Globals.fileStorePathSr");
						fileMngService.updateFileInfs(_result);
					}
				}

				// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
				if ("Y".equals(srVO.getTempSaveAt())) {
					srVO.setStatus("1000");
				} else {
					// 1. SR저장시 고객사 결재여부에 따라 상태값 변경처리
					strSettleAt = srManageService.selectPstinstSettleAt(srVO);
					if ("Y".equals(strSettleAt)) { // 결재
						srVO.setStatus("1001"); // SR등록

						// 결재자에게 메일발송
						srVO.setComment(unscript(srVO.getComment())); // XSS 방지
						String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
						String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용

						srMngrSendEmail(srVO, subject, emailCn, "sanctner", atchFileId);

					} else { // 미결재
						srVO.setStatus("1002"); // SR접수대기

						// 2. 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
						srVO.setComment(unscript(srVO.getComment())); // XSS 방지
						String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
						String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용

						srMngrSendEmail(srVO, subject, emailCn, "charger", atchFileId);
					}
				}

				// SR를 수정한다.
				if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) {
					if ("Y".equals(srVO.getSanctnerAt())) { // 결재완료
						srVO.setStatus("1002"); // SR접수대기
						srVO.setReturnResn(""); // 반려사유
					}
					// kpmg 2021.07.14 결재자 id
					srVO.setSanctnerId(user.getId());
					
					srManageService.updateSrSanctner(srVO);
				} else {
					srManageService.updateSrCstmr(srVO);
				}
				retMap.put("msgType", "S");			
				retMap.put("msg", egovMessageSource.getMessage("success.common.save"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
		}finally {
			
		}
		
		return retMap;
	}

	/**
	 * SR를 결재처리한다.(고객-결재자)
	 * 
	 * @param loginVO
	 * @param sr
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/sr/EgovSrModify"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrSelectUpdtSanctner.do")
	@ResponseBody
	public Map<String, Object> updateSrSanctner(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srchargerVO") SrAnswerVO srchargerVO,
			BindingResult bindingResult, Map commandMap, ModelMap model, MultipartHttpServletRequest multiRequest,
			HttpServletRequest request) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

			// SR를 수정한다.
			if ("Y".equals(srVO.getSanctnerAt())) { // 결재완료
				srVO.setStatus("1002"); // SR접수중
				srVO.setReturnResn(""); // 반려사유
			} else if ("N".equals(srVO.getSanctnerAt())) { // 반려
				// srVO.setStatus("1001"); //SR등록
				srVO.setStatus("1007"); // 반려
			}
			
			// kpmg 2021.07.14 결재자 id
			srVO.setSanctnerId(user.getId());
			
			srManageService.updateSrSanctner(srVO);

			// 2. 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
			// SR정보
			SrVO srReq = srManageService.selectSrDetail(srVO);

			srReq.setComment(unscript(srReq.getComment())); // XSS 방지
			String subject = (srReq.getSubject() == null) ? "" : srReq.getSubject(); // 메일제목
			String emailCn = (srReq.getComment() == null) ? "<p>&nbsp;</p>" : srReq.getComment(); // 메일내용

			// Exception 없이 진행시 수정성공메시지
			if ("Y".equals(srVO.getSanctnerAt())) { // 결재완료
				srMngrSendEmail(srReq, subject, emailCn, "charger", srReq.getFileId());
				retMap.put("msg", egovMessageSource.getMessage("success.common.sanctn"));
			} else { // 요청자에게 반려 메일 발송
				srMngrSendEmail(srReq, subject, emailCn, "member", srReq.getFileId());
				retMap.put("msg", egovMessageSource.getMessage("success.common.return"));
			}								
			retMap.put("msgType", "S");	
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
			
		}finally {
			
		}
		
		return retMap;

	}

	/**
	 * SR등록화면으로 이동한다.
	 * 
	 * @param searchVO
	 *            검색조건정보
	 * @param userManageVO
	 *            SR초기화정보
	 * @param model
	 *            화면모델
	 * @return cmm/uss/umt/EgovUserInsert
	 * @throws Exception
	 */
	@RequestMapping("/sr/EgovSrInsertView.do")
	public String insertUserView(@ModelAttribute("srVO") SrVO srVO, @ModelAttribute("searchVO") SrVO searchVO,
			// Model model,
			ModelMap model, HttpServletRequest request) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		srVO.setCustomerId(user.getId()); // 요청자ID
		srVO.setCustomerNm(user.getName()); // 요청자명
		srVO.setTel1(user.getOffmTelno()); // 연락처(내선)
		srVO.setTel2(user.getMbtlnum()); // 연락처(이동전화)
		srVO.setEmail(user.getEmail()); // 이메일
		srVO.setPstinstCode(user.getPstinstCode()); // 고객처
		srVO.setPstinstNm(user.getPstinstNm()); // 고객처명
		srVO.setPstinstNmEn(user.getPstinstNmEn()); // 고객처 영문명
		srVO.setAuthorCode(user.getAuthorCode()); // 권한코드

		// 완료희망일 : todate + 5일
		Calendar cal = Calendar.getInstance();

		// 요청일
		String strSignDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);

		cal.add(Calendar.DATE, 5);
		int dat_of_week = cal.get(cal.DAY_OF_WEEK);
		if (dat_of_week == 1) { // 일요일
			cal.add(Calendar.DATE, 1);
		} else if (dat_of_week == 7) { // 월요일
			cal.add(Calendar.DATE, 2);
		}
		
		String strHopeDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);

		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
		Date hopeDate = sdfmt.parse(strHopeDate);
		Date signDate = sdfmt.parse(strSignDate);
		strHopeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(hopeDate);
		strSignDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(signDate);
		srVO.setHopeDate(strHopeDate);
		srVO.setHopeDateView(strHopeDate);
		srVO.setSignDate(strSignDate);

		// 모듈코드를 코드정보로부터 조회 - SR0003
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SR0003");
		vo.setPstinstCode(user.getPstinstCode());
		model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 처리구분코드를 코드정보로부터 조회 - SR0005
		vo.setCodeId("SR0005");
		model.addAttribute("classCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 우선순위코드를 코드정보로부터 조회 - SR0006
		vo.setCodeId("SR0006");
		model.addAttribute("priortCode_result", cmmUseService.selectCmmCodeDetail(vo));

		// 고객사별 요청자 목록
		vo.setCodeId(srVO.getPstinstCode());
		model.addAttribute("cstmrCode_result", cmmUseService.selectCstmrDetail(vo));
		
		//
		
		model.addAttribute("sign", srManageService.selectSigature(user));
		return "/sr/EgovSrRegist";
	}

	/**
	 * SR를 등록한다.
	 * 
	 * @param loginVO
	 * @param sr
	 * @param bindingResult
	 * @param model
	 * @return "/sr/EgovSrRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrRegist.do")
	@ResponseBody
	public Map<String, Object> insertSr(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			final MultipartHttpServletRequest multiRequest) throws Exception {
		
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			beanValidator.validate(srVO, bindingResult);
			if(bindingResult.hasErrors()) {
				retMap.put("msgType", "E");
				retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));				
			}else {
				
				// 첨부파일 등록
				List<FileVO> result = null;
				String atchFileId = "";
				//final Map<String, MultipartFile> files = multiRequest.getFileMap();
				List<MultipartFile> files = multiRequest.getFiles("files");
				if (!files.isEmpty()) {
					//result = fileUtil.parseFileInf(files, "SR_", 0, "", "Globals.fileStorePathSr");
					/*신규 File List 변경*/
					result = fileUtil.parseFileList(files, "SR_", 0, "", "Globals.fileStorePathSr");
					atchFileId = fileMngService.insertFileInfs(result);
					srVO.setFileId(atchFileId);
				}

				// 신청일(요청일)
				if (!"".equals(srVO.getSignDate())) {
					srVO.setSignDateDisp(srVO.getSignDate()); // 메일발송용
					srVO.setSignDate(srVO.getSignDate().replaceAll("-", ""));
				}
				// 완료희망일
				if (!"".equals(srVO.getHopeDateView())) {
					srVO.setHopeDateDisp(srVO.getHopeDateView()); // 메일발송용
					srVO.setHopeDate(srVO.getHopeDateView().replaceAll("-", ""));
				}

				// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
				if ("Y".equals(srVO.getTempSaveAt())) {
					srVO.setStatus("1000");
				} else {
					// 1. SR저장시 고객사 결재여부에 따라 상태값 변경처리
					String strSettleAt = srManageService.selectPstinstSettleAt(srVO);
					if ("Y".equals(strSettleAt)) { // 결재
						srVO.setStatus("1001"); // SR등록
						// 결재자에게 메일발송
						srVO.setComment(unscript(srVO.getComment())); // XSS 방지
						String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
						String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용

						srMngrSendEmail(srVO, subject, emailCn, "sanctner", atchFileId);

					} else { // 미결재
						srVO.setStatus("1002"); // SR접수대기

						// 2. 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
						srVO.setComment(unscript(srVO.getComment())); // XSS 방지
						String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
						String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용

						srMngrSendEmail(srVO, subject, emailCn, "charger", atchFileId);

					}
				}
				srManageService.insertSr(srVO);
				retMap.put("msgType", "S");
				retMap.put("msg", egovMessageSource.getMessage("success.common.insert"));
			}
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
		}finally {
			
		}
		
		return retMap;
//		beanValidator.validate(srVO, bindingResult);
//		if (bindingResult.hasErrors()) {
//
//			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//
//			srVO.setCustomerId(user.getId()); // 요청자ID
//			srVO.setCustomerNm(user.getName()); // 요청자명
//			srVO.setTel1(user.getOffmTelno()); // 연락처(내선)
//			srVO.setTel2(user.getMbtlnum()); // 연락처(이동전화)
//			srVO.setEmail(user.getEmail()); // 이메일
//			srVO.setPstinstCode(user.getPstinstCode()); // 고객처
//			srVO.setPstinstNm(user.getPstinstNm()); // 고객처명
//			srVO.setPstinstNmEn(user.getPstinstNmEn()); // 고객처 영문명
//			srVO.setAuthorCode(user.getAuthorCode()); // 권한코드
//
//			// 완료희망일 : todate + 5일
//			Calendar cal = Calendar.getInstance();
//
//			// 요청일
//			String strSignDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);
//
//			cal.add(Calendar.DATE, 5);
//			int dat_of_week = cal.get(cal.DAY_OF_WEEK);
//			if (dat_of_week == 1) { // 일요일
//				cal.add(Calendar.DATE, 1);
//			} else if (dat_of_week == 7) { // 월요일
//				cal.add(Calendar.DATE, 2);
//			}
//
//			String strHopeDate = cal.get(cal.YEAR) + "-" + (cal.get(cal.MONTH) + 1) + "-" + cal.get(cal.DATE);
//
//			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
//			Date hopeDate = sdfmt.parse(strHopeDate);
//			Date signDate = sdfmt.parse(strSignDate);
//			strHopeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(hopeDate);
//			strSignDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(signDate);
//			srVO.setHopeDate(strHopeDate);
//			srVO.setHopeDateView(strHopeDate);
//			srVO.setSignDate(strSignDate);
//
//			// 모듈코드를 코드정보로부터 조회 - SR0003
//			ComDefaultCodeVO vo = new ComDefaultCodeVO();
//			vo.setCodeId("SR0003");
//			model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//			// 처리구분코드를 코드정보로부터 조회 - SR0005
//			vo.setCodeId("SR0005");
//			model.addAttribute("classCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//			// 우선순위코드를 코드정보로부터 조회 - SR0006
//			vo.setCodeId("SR0006");
//			model.addAttribute("priortCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//			// 고객사별 요청자 목록
//			vo.setCodeId(srVO.getPstinstCode());
//			model.addAttribute("cstmrCode_result", cmmUseService.selectCstmrDetail(vo));
//
//			return "/sr/EgovSrRegist";
//
//		} else {
//
//			// 첨부파일 등록
//			List<FileVO> result = null;
//			String atchFileId = "";
//			//final Map<String, MultipartFile> files = multiRequest.getFileMap();
//			List<MultipartFile> files = multiRequest.getFiles("files");
//			if (!files.isEmpty()) {
//				//result = fileUtil.parseFileInf(files, "SR_", 0, "", "Globals.fileStorePathSr");
//				/*신규 File List 변경*/
//				result = fileUtil.parseFileList(files, "SR_", 0, "", "Globals.fileStorePathSr");
//				atchFileId = fileMngService.insertFileInfs(result);
//				srVO.setFileId(atchFileId);
//			}
//
//			// 신청일(요청일)
//			if (!"".equals(srVO.getSignDate())) {
//				srVO.setSignDateDisp(srVO.getSignDate()); // 메일발송용
//				srVO.setSignDate(srVO.getSignDate().replaceAll("-", ""));
//			}
//			// 완료희망일
//			if (!"".equals(srVO.getHopeDateView())) {
//				srVO.setHopeDateDisp(srVO.getHopeDateView()); // 메일발송용
//				srVO.setHopeDate(srVO.getHopeDateView().replaceAll("-", ""));
//			}
//
//			// 저장구분(1:수정, 2: 답변입시저장, 3: 답변저장)
//			if ("Y".equals(srVO.getTempSaveAt())) {
//				srVO.setStatus("1000");
//			} else {
//				// 1. SR저장시 고객사 결재여부에 따라 상태값 변경처리
//				String strSettleAt = srManageService.selectPstinstSettleAt(srVO);
//				if ("Y".equals(strSettleAt)) { // 결재
//					srVO.setStatus("1001"); // SR등록
//					// 결재자에게 메일발송
//					srVO.setComment(unscript(srVO.getComment())); // XSS 방지
//					String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
//					String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용
//
//					srMngrSendEmail(srVO, subject, emailCn, "sanctner", atchFileId);
//
//				} else { // 미결재
//					srVO.setStatus("1002"); // SR접수대기
//
//					// 2. 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
//					srVO.setComment(unscript(srVO.getComment())); // XSS 방지
//					String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
//					String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용
//
//					srMngrSendEmail(srVO, subject, emailCn, "charger", atchFileId);
//
//				}
//			}
//			srManageService.insertSr(srVO);
//
//		}
//
//		// Exception 없이 진행시 성공메시지
//		model.addAttribute("resultMsg", "success.common.insert");
//
//		return "forward:/sr/EgovSrList.do";
	}

	/**
	 * SR를 삭제한다.
	 * 
	 * @param loginVO
	 * @param sr
	 * @param model
	 * @return "forward:/sr/EgovSrList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrRemove.do")
	@ResponseBody
	public Map<String, Object> deleteSr(@ModelAttribute("loginVO") LoginVO loginVO, SrVO srVO, ModelMap model,
			HttpServletRequest request) throws Exception {
		
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		
		try {
			if (!"".equals(srVO.getFileId()) || srVO.getFileId() != null) {
				// 1. 첨부파일 목록을 삭제한다.
				FileVO fileVO = new FileVO();
				fileVO.setAtchFileId(srVO.getFileId());
				fileMngService.deleteAllFileInf(fileVO);
			}

			srManageService.deleteSr(srVO);
			srManageService.deleteSrAnswerAll(srVO);
			
			retMap.put("msgType","S");
			retMap.put("msg",egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType","E");
			retMap.put("msg",egovMessageSource.getMessage("fail.common.delete"));
		}

		return retMap;
	}

	/**
	 * SR답변을 삭제한다.
	 * 
	 * @param loginVO
	 * @param sr
	 * @param model
	 * @return "forward:/sr/EgovSrList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrDeleteAnswer.do")
	@ResponseBody
	public Map<String, Object> deleteSrAnswer(@RequestParam("answerNoDelArr") String answerNoDelArr,
			@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srchargerVO") SrAnswerVO srchargerVO,
			@ModelAttribute("srchargerVO") SrAnswerVO srAnswerVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO, ModelMap model, SessionStatus status,
			HttpServletRequest request) throws Exception {
		
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			String[] strAnswerNoDelArr = answerNoDelArr.split(";");
			for (int i = 0; i < strAnswerNoDelArr.length; i++) {
				srVO.setAnswerNoDelete(strAnswerNoDelArr[i]);

				// 답변에 등록된 파일ID를 조회한다.
				String strFileId = srManageService.selectFileId(srVO);
				if (!"".equals(strFileId)) {
					// 1. 첨부파일 목록을 삭제한다.
					FileVO fileVO = new FileVO();
					fileVO.setAtchFileId(strFileId);
					fileMngService.deleteAllFileInf(fileVO);
				}

				srManageService.deleteSrAnswer(srVO);
			}

			// 답변 삭제시 실공수(헤더) 수정
			srManageService.updateSrRealExpectTime(srVO);

			status.setComplete();
			retMap.put("msgType","S");
			retMap.put("msg",egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType","E");
			retMap.put("msg",egovMessageSource.getMessage("fail.common.delete"));
		}

		return retMap;

	}

	/**
	 * SR일괄결재한다.
	 * 
	 * @param loginVO
	 * @param sr
	 * @param model
	 * @return "forward:/sr/EgovSrList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrSanctnAll.do")
	@ResponseBody
	public Map<String, Object> sanctnAll(@RequestParam("srNoSanctnAllArr") String srNoSanctnAllArr,
			@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO, SrAnswerVO srAnswerVO,
			ModelMap model, SessionStatus status, HttpServletRequest request
	// , final MultipartHttpServletRequest multiRequest
	) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			String[] strSrNoSanctnAllArr = srNoSanctnAllArr.split(";");
			for (int i = 0; i < strSrNoSanctnAllArr.length; i++) {

				srVO.setStatus("1002"); // SR접수대기
				srVO.setSrNo(strSrNoSanctnAllArr[i]);
				srVO.setSanctnerAt("Y"); // 결재(승인)
				
				// kpmg 2021.07.14 결재자 id
				srVO.setSanctnerId(user.getId());

				srManageService.updateSrSanctner(srVO);

				// SR정보
				SrVO srReq = srManageService.selectSrDetail(srVO);

				// 2. 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
				srVO.setComment(unscript(srReq.getComment())); // XSS 방지
				String subject = (srReq.getSubject() == null) ? "" : srReq.getSubject(); // 메일제목
				String emailCn = (srReq.getComment() == null) ? "<p>&nbsp;</p>" : srReq.getComment(); // 메일내용

				srMngrSendEmail(srReq, subject, emailCn, "charger", srVO.getAnsFileId());

			}
			status.setComplete();

			// Exception 없이 진행시 성공메시지
			//model.addAttribute("resultMsg", "success.common.sanctn");
			retMap.put("msgType","S");
			retMap.put("msg",egovMessageSource.getMessage("success.common.sanctn"));
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType","E");
			retMap.put("msg",egovMessageSource.getMessage("fail.common.msg"));
		}
		
		return retMap;
	}

	/**
	 * SR 엑셀다운로드(월간보고서)을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr/EgovSrListExcelReport.do")
	public ModelAndView selectSrListExcelReport(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") SrVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())) {
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())) {
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		/** 검색-완료일 */
		if (!"".equals(searchVO.getSearchCompleteDateFView())) {
			searchVO.setSearchCompleteDateF(searchVO.getSearchCompleteDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchCompleteDateTView())) {
			searchVO.setSearchCompleteDateT(searchVO.getSearchCompleteDateTView().replaceAll("-", ""));
		}

		if ("ROLE_ADMIN".equals(user.getAuthorCode())) { // Admin
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				List<String> strStatus = new ArrayList<String>();
				// strStatus.add("1000"); //임시저장(검색 초기용)
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_CHARGER".equals(user.getAuthorCode())) { // 담당자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRid(user.getId());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_MNGR".equals(user.getAuthorCode())) { // 관리자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRid(user.getId());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) { // 고객
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchCustomerNm(user.getName());
				List<String> strStatus = new ArrayList<String>();
				// strStatus.add("1000"); //임시저장(검색 초기용)
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 결재자
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001"); // SR등록(결재자 검색 초기용)
				searchVO.setSearchStatus(strStatus);
			}
		}	

		// model.addAttribute("resultList", srManageService.selectSrList(searchVO));
		List srReportList = srManageService.excelDownSrReportList(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("srReport", srReportList);

		return new ModelAndView("srReportExcelView", "srReportMap", map);
	}

	/**
	 * SR 엑셀다운로드(월간보고서)을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel/sr/EgovSrListExcelReport.do")
	@ResponseBody
	public Map<String, Object> selectSrListExcelReportMap(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") SrVO searchVO, ModelMap model, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, req);

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())) {
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())) {
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		/** 검색-완료일 */
		if (!"".equals(searchVO.getSearchCompleteDateFView())) {
			searchVO.setSearchCompleteDateF(searchVO.getSearchCompleteDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchCompleteDateTView())) {
			searchVO.setSearchCompleteDateT(searchVO.getSearchCompleteDateTView().replaceAll("-", ""));
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if("".equals(searchVO.getSearchConfirmDateT())) {
			Date today = new Date();
			
			String strDate = sdf.format(today);
			searchVO.setSearchConfirmDateT(strDate);
		}
		
		if("".equals(searchVO.getSearchConfirmDateF())) {
			String strDateT= searchVO.getSearchConfirmDateT();
			Calendar cal = Calendar.getInstance(); // 날짜 계산을 위해 Calendar 추상클래스 선언 및 getInstance() 메서드 사용
	        cal.set(Integer.parseInt(strDateT.substring(0, 4)), Integer.parseInt(strDateT.substring(4, 6)) - 1, Integer.parseInt(strDateT.substring(6))  );
	        
	        cal.add(Calendar.YEAR, -1);   
	        String strDateF = sdf.format(cal.getTime());
	        searchVO.setSearchConfirmDateF(strDateF);
		}
		List<String> strStatus = new ArrayList<String>();
		
		if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) { // 고객(현업)
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			//if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchCustomerNm(user.getName());
				strStatus.add("1000"); // 임시저장(검색 초기용)
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				strStatus.add("1007"); // 반려
				searchVO.setSearchStatus(strStatus);
			//}
		} else if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 결재자
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			//if ("".equals(searchVO.getSearchAt())) {
				strStatus.add("1001"); // 등록(결재자 검색 초기용)
				searchVO.setSearchStatus(strStatus);
			//}

		}
		List srReportList = new ArrayList<Object>(); 
		
		try {
			// model.addAttribute("resultList", srManageService.selectSrList(searchVO));
			//srReportList = srManageService.excelDownSrReportList(searchVO);
			int index = 0;
			
			while(true) {
				searchVO.setFirstIndex(index);
				List srReportTempList = srManageService.excelDownSrReportList(searchVO);
				
				if(srReportTempList.size() == 0) break;
				else {
					index += 500;
					srReportList.addAll(srReportTempList);
				}
			}			
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");			
			retMap.put("msg", egovMessageSource.getMessage("sr.error.fail.excelDownload"));
			return retMap;
		}
		
		if(srReportList.size() > 0) {
			XSSFWorkbook wb = null;
			ByteArrayOutputStream bos = null;
			try {
				//Sheet 1 (SR List)
				wb = new XSSFWorkbook();
				//저장일
				Calendar cal = Calendar.getInstance();
		    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
		    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
		    	Date saveDate = sdfmt.parse(strSaveDate);
		    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);

		    	XSSFCell cell = null;
		    	int idx = 0;
		    	XSSFSheet sheet = null;
		    	String fileName = "";
		    	
		    	//헤더 스타일
		    	XSSFCellStyle headerStyle= (XSSFCellStyle) wb.createCellStyle();
		    	headerStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
		    	headerStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
		    	headerStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
		    	headerStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
		    	headerStyle.setAlignment(HorizontalAlignment.CENTER);
		    	headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    	
		    	//배경색
		    	IndexedColorMap colorMap =  wb.getStylesSource().getIndexedColors();
		    	headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(184,204,228), colorMap));
		    	headerStyle.setFillBackgroundColor(new XSSFColor(new java.awt.Color(184,204,228), colorMap));
		    	headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    	
		    	//폰트
		    	XSSFFont headerFont = wb.createFont();
		    	headerFont.setBold(true);
		    	headerFont.setFontHeight(9);
		    	headerFont.setFontName("맑은 고딕");
		    	headerStyle.setFont(headerFont);
		    	///헤더
		    	
		    	//셀 스타일 
		    	XSSFCellStyle cellStyle= (XSSFCellStyle) wb.createCellStyle();
		    	cellStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
		    	cellStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
		    	cellStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
		    	cellStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
		    	cellStyle.setAlignment(HorizontalAlignment.CENTER);
		    	cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
		    	
		    	//폰트
		    	XSSFFont cellFont = wb.createFont();
		    	cellFont.setFontHeight(9);
		    	cellFont.setFontName("맑은 고딕");
		    	cellStyle.setFont(cellFont);
		    	
		    	
		    	XSSFCellStyle leftCellStyle= (XSSFCellStyle) wb.createCellStyle();
		    	leftCellStyle.setBorderBottom(BorderStyle.THIN); // 아랫쪽에 얇은 실선 적용.
		    	leftCellStyle.setBorderLeft(BorderStyle.THIN);	// 셀 좌측에 얇은 실선 적용.
		    	leftCellStyle.setBorderRight(BorderStyle.THIN);	// 셀 우측에 얇은 실선 적용.
		    	leftCellStyle.setBorderTop(BorderStyle.THIN);	// 셀 윗쪽에 얇은 실선 적용.
		    	leftCellStyle.setAlignment(HorizontalAlignment.LEFT);
		    	leftCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
		    	
		    	leftCellStyle.setFont(cellFont);
		    	
		    	
				if("en".equals((String)req.getSession().getAttribute("language"))){

					fileName = "Excel Download(For the monthly report)_"+strSaveDate+".xlsx";
					
					sheet = (XSSFSheet)wb.createSheet("SR List");
			        XSSFRow row = sheet.createRow(0);
			        cell = row.createCell(0);
			        cell.setCellValue("Excel Download(For the monthly report)");
			        cell.setCellStyle(headerStyle);
			        // set header information
			        idx = 0;
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("SR Number");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Title");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Module");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Processing division");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Status");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Requester");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Request date");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Expected completion date");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("The person in charge");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Processing completion date");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Customers confirmation Completion Date");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Real labour hours");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("ABAP labour hours");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Satisfaction");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Request content");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Answers");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("Client");
			        cell.setCellStyle(headerStyle);   		
		    		
		    	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
		    		
					fileName = "下载文件（月报表）_"+strSaveDate+".xlsx";

					sheet = (XSSFSheet)wb.createSheet("系統需求清单");
			        XSSFRow row = sheet.createRow(0);
			        row.createCell(0).setCellValue("下载文件（月报表）");
			        // set header information
			        idx = 0;
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("系统需求编码");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("标题");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("模块");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("处理状态");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("状态");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("提交者");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("提交日期");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("预计完成日期");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("负责人");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("处理完成日期");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("客户确认日期");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("实际处理小时数");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("ABAP开发工时");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("满意度");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("提交内容");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("处理内容");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("客户");
			        cell.setCellStyle(headerStyle);
		    		
		    	}else{
		    		
					fileName = "SR리스트(월간보고서용)_"+strSaveDate+".xlsx";
					

					sheet = (XSSFSheet)wb.createSheet("SR리스트");
			        //sheet.setDefaultColumnWidth((short) 12);

			        // put text in first cell
//					        cell = createCell(sheet, 0, 0);
//					        setText(cell, "SR리스트(월간보고서용)");
			        XSSFRow row = sheet.createRow(0);
			        row.createCell(0).setCellValue("SR리스트(월간보고서용)");
			        // set header information
			        idx = 0;
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("SR 번호");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("제목");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("모듈");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("처리구분");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("상태");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("요청자");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("요청일시");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("완료예정일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("담당자");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("처리완료일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("고객확인완료일");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("전체공수");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("ABAP공수");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("만족도");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("요청내역");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("답변");
			        cell.setCellStyle(headerStyle);
			        cell =  row.createCell(idx++);
	        		cell.setCellValue("고객사");
			        cell.setCellStyle(headerStyle);
			        
		    	}
				
				sheet.createFreezePane(0, 1);
				
				
		        XSSFRow row = null;
		        Double realSum = 0.0;
		        Double abapSum = 0.0;
		        String prevStatus = "";
		        int headerRowCnt = 1;
		        for (int i = 0; i < srReportList.size(); i++) {
		        	Object obj = srReportList.get(i);
		        	SrVO srReportVO = (SrVO) obj;
		            idx = 0;
		            
		            
		            if(( "1006".equals(prevStatus) && !prevStatus.equals(srReportVO.getStatus()) )
		            		|| ( "1005".equals(prevStatus) && !prevStatus.equals(srReportVO.getStatus()) )
				    		){
		            	row = sheet.createRow(headerRowCnt+i);
		    			//합 계 Row
		            	cell = row.createCell(0);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(1);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(2);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(3);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(4);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(5);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(6);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(7);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(8);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(9);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(10);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        
		            	sheet.addMergedRegion(new CellRangeAddress(headerRowCnt+i,headerRowCnt+i,0,10));
		            	
		            	cell = row.createCell(11);
		        		cell.setCellValue(realSum);
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(12);
		        		cell.setCellValue(abapSum);
				        cell.setCellStyle(cellStyle);
		            	sheet.createRow(headerRowCnt+i+1);
		            	
		            	row = sheet.createRow(headerRowCnt+i+2);
		            	
		            	if("1005".equals(srReportVO.getStatus())) {
		            		row.createCell(0).setCellValue("Customer confirmation Service Request");
		            	}else {
		            		row.createCell(0).setCellValue("Recept and resolving Service Request");
		            	}
		            	
		            	headerRowCnt+=3;
		            	realSum = 0.0;
		            	abapSum = 0.0;
		    		}
		            
		            row = sheet.createRow(headerRowCnt+i);
		            


		            cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getSrNo());
			        cell.setCellStyle(cellStyle);
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getSubject());
			        cell.setCellStyle(leftCellStyle);          
		            if("en".equals((String)req.getSession().getAttribute("language"))){
		            	cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getModuleNmEn());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getCategoryNmEn());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getStatusNmEn());
				        cell.setCellStyle(cellStyle);   
				        
		        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
		        		cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getModuleNmCn());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getCategoryNmCn());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getStatusNmCn());
				        cell.setCellStyle(cellStyle);   
		        	}else{
		        		cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getModuleNm());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getCategoryNm());
				        cell.setCellStyle(cellStyle);   
				        cell = row.createCell(idx++);
		        		cell.setCellValue(srReportVO.getStatusNm());
				        cell.setCellStyle(cellStyle);  
		        	}
		            cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getCustomerNm());
			        cell.setCellStyle(leftCellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getSignDate());
			        cell.setCellStyle(cellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getScheduleDate());
			        cell.setCellStyle(cellStyle); 
			        
			        cell = row.createCell(idx++);
			        if("en".equals((String)req.getSession().getAttribute("language"))){	
		        		cell.setCellValue(srReportVO.getRnameEn());
		        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){ 
		        		cell.setCellValue(srReportVO.getRnameEn());
		        	}else{ 
		        		cell.setCellValue(srReportVO.getRname());				        
		        	}
			        cell.setCellStyle(leftCellStyle);
			        
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getCompleteDate());
			        cell.setCellStyle(cellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getTestCompleteDate());
			        cell.setCellStyle(cellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getRealExpectTime());
			        cell.setCellStyle(cellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getAbapRealExpectTime());
			        cell.setCellStyle(cellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getPoint());
			        cell.setCellStyle(cellStyle);
			        htmlRemove(srReportVO);	
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getComment());
			        cell.setCellStyle(leftCellStyle); 
			        cell = row.createCell(idx++);
	        		cell.setCellValue(srReportVO.getAnsComment());
			        cell.setCellStyle(leftCellStyle);
			        
			        cell = row.createCell(idx++);
		    		if("en".equals((String)req.getSession().getAttribute("language"))){
		        		cell.setCellValue(srReportVO.getPstinstNmEn());
		        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
		        		cell.setCellValue(srReportVO.getPstinstNmEn());
		        	}else{
		        		cell.setCellValue(srReportVO.getPstinstNm());				        
		        	}		    		
		    		cell.setCellStyle(leftCellStyle); 
		    		
		    		
		    		prevStatus = srReportVO.getStatus();
		    		
		    		if(srReportVO.getRealExpectTime() != null && !"".equals(srReportVO.getRealExpectTime())) {
		            	realSum += Double.parseDouble(srReportVO.getRealExpectTime());
		            }
		            if(srReportVO.getAbapRealExpectTime() != null && !"".equals(srReportVO.getAbapRealExpectTime())) {
		            	abapSum += Double.parseDouble(srReportVO.getAbapRealExpectTime());
		            }
		            
		            if(i == srReportList.size() - 1 ) {
		            	row = sheet.createRow(headerRowCnt+i+1);
		    			//합 계 Row
		            	cell = row.createCell(0);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(1);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(2);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(3);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(4);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(5);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(6);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(7);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(8);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(9);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(10);
		        		cell.setCellValue("Total");
				        cell.setCellStyle(cellStyle);
		            	
		            	sheet.addMergedRegion(new CellRangeAddress(headerRowCnt+i+1,headerRowCnt+i+1,0,10));
		            	
		            	cell = row.createCell(11);
		        		cell.setCellValue(realSum);
				        cell.setCellStyle(cellStyle);
				        cell = row.createCell(12);
		        		cell.setCellValue(abapSum);
				        cell.setCellStyle(cellStyle);
		            }
		        }
		        
		        
//		        //Sheet 2 (SR KPI)
//		        XSSFSheet kpiSheet = (XSSFSheet)wb.createSheet("SR-KPI");
//		        
//		        kpiSheet.createRow(0);
//		        
//		        //헤더 스타일
//		    	XSSFCellStyle kpiTitleStyle= (XSSFCellStyle) wb.createCellStyle();
//		    	kpiTitleStyle.setAlignment(HorizontalAlignment.CENTER);
//		    	kpiTitleStyle.setVerticalAlignment(VerticalAlignment.CENTER);		    	
//		    	
//		    	//폰트
//		    	XSSFFont kpiTitleFont = wb.createFont();
//		    	kpiTitleFont.setBold(true);
//		    	kpiTitleFont.setUnderline(FontUnderline.SINGLE);
//		    	kpiTitleFont.setFontHeight(12);
//		    	kpiTitleFont.setFontName("맑은 고딕");
//		    	kpiTitleStyle.setFont(kpiTitleFont);
//		    	///헤더
//		    	
//		    	//------- 만족도 현황
//		    	int rowCnt = 1;
//		        XSSFRow kpiRow = kpiSheet.createRow(rowCnt++);
//		        
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue(egovMessageSource.getMessage("sr.satisfactionStatus"));
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(1);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(2);
//		        
//		        cell.setCellStyle(kpiTitleStyle);
//		        cell = kpiRow.createCell(3);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(4);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(5);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(6);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(7);
//		        cell.setCellStyle(kpiTitleStyle);
//		        kpiSheet.addMergedRegion(new CellRangeAddress(1,1,0,7));
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.completionDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        
//		        idx = 0;
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.5point"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.4point"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.3point"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.2point"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.1point"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.average"));
//		        cell.setCellStyle(headerStyle);
//		        
//		        
//		        StsfdgSttusVO stsfdgSttusVO = new StsfdgSttusVO();
//		        
//		        stsfdgSttusVO.setSearchDateF(searchVO.getSearchConfirmDateF());
//		        stsfdgSttusVO.setSearchDateT(searchVO.getSearchConfirmDateT());
//		        stsfdgSttusVO.setPstinstCode(searchVO.getSearchPstinstCode());
//		        
//		        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
//						"ROLE_CHARGER".equals(user.getAuthorCode()) ||
//						"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
//				}else{																//현업, 결재자
//					stsfdgSttusVO.setPstinstCode(user.getPstinstCode());
//				}	        
//		        
//		        List stsfdgSttusReportList =  stsfdgSttusService.excelDownSrStsfdgSttusReportList(stsfdgSttusVO);
//		        
//		        for (int i = 0; i < stsfdgSttusReportList.size(); i++) {
//		        	Object obj = stsfdgSttusReportList.get(i);
//		        	StsfdgSttusVO reportVO = (StsfdgSttusVO) obj;
//		            idx = 0;
//		    		row = kpiSheet.createRow(rowCnt++);
//		    		cell = row.createCell(idx++);
//		    		if("en".equals((String)req.getSession().getAttribute("language"))){		            	
//		        		cell.setCellValue(reportVO.getModuleNameEn());
//		        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
//		        		cell.setCellValue(reportVO.getModuleNameCn());				        
//		        	}else{
//		        		cell.setCellValue(reportVO.getModuleName());
//		        	}
//		            cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getCompleteCount());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getValue5());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getValue4());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getValue3());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getValue2());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getValue1());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getAvgValue());
//		    		cell.setCellStyle(cellStyle);
//		        }
//		        
//		        //--------만족도 현황
//		        
//		        //---------접수 및 납기 접수
//		        
//		        rowCnt+=2;
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue(egovMessageSource.getMessage("sr.receptionAndCompleteOnTime"));
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(1);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(2);
//		        cell.setCellStyle(kpiTitleStyle);
//		        cell = kpiRow.createCell(3);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(4);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(5);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(6);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(7);
//		        cell.setCellStyle(kpiTitleStyle);
//		        kpiSheet.addMergedRegion(new CellRangeAddress(rowCnt-1,rowCnt-1,0,7));
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.requestDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        idx = 0;
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.requestCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.receiptCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.dayReceptCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.dayRecpetPercent"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completeOnTimeCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completeOnTimePercent"));
//		        cell.setCellStyle(headerStyle);
//		        
//		        
//		        SrObservanceRateVO srObservanceRateVO = new SrObservanceRateVO();
//		        
//		        srObservanceRateVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateF());
//		        srObservanceRateVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateT());
//		        srObservanceRateVO.setPstinstCode(searchVO.getSearchPstinstCode());
//		        
//		        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
//						"ROLE_CHARGER".equals(user.getAuthorCode()) ||
//						"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
//				}else{																//현업, 결재자
//					srObservanceRateVO.setPstinstCode(user.getPstinstCode());
//				}	     
//		        
//		        List srObservanceRateReportList =  srObservanceRateService.excelDownProcessRateReportList(srObservanceRateVO);		        
//		        
//		        for (int i = 0; i < srObservanceRateReportList.size(); i++) {
//	        		
//		    		Object obj = srObservanceRateReportList.get(i);
//		    		SrObservanceRateVO reportVO = (SrObservanceRateVO) obj;
//		    		idx = 0;
//		    		row = kpiSheet.createRow(rowCnt++);
//		    		
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getModuleName());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getSignCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getConfirmCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getInConfirmCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getInConfirmRate());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getCompleteCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getInCompleteCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getInCompleteRate());
//		    		cell.setCellStyle(cellStyle);
//		    		
//		        }
//		        
//		        //---------접수 및 납기 접수
//		        //---------처리율
//		        rowCnt+=2;
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue(egovMessageSource.getMessage("sr.processingRatio"));
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(1);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(2);
//		        cell.setCellStyle(kpiTitleStyle);
//		        cell = kpiRow.createCell(3);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(4);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(5);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(6);
//		        cell.setCellStyle(kpiTitleStyle);		        
//		        cell = kpiRow.createCell(7);
//		        cell.setCellStyle(kpiTitleStyle);
//		        kpiSheet.addMergedRegion(new CellRangeAddress(rowCnt-1,rowCnt-1,0,8));
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        cell = kpiRow.createCell(0);
//		        cell.setCellValue("("+egovMessageSource.getMessage("sr.list.requestDate")+":"+searchVO.getSearchConfirmDateF() + "~" + searchVO.getSearchConfirmDateT()+")");
//		        
//		        kpiRow = kpiSheet.createRow(rowCnt++);
//		        idx = 0;
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.module"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.requestCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.receiptCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.beingSolvedCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.customerConfirmCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completionCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.completionRatio"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.evaluationCnt"));
//		        cell.setCellStyle(headerStyle);
//		        cell = kpiRow.createCell(idx++);
//        		cell.setCellValue(egovMessageSource.getMessage("sr.evaluationReceipt"));
//		        cell.setCellStyle(headerStyle);
//		        
//		        
//		        ProcessRateVO processRateVO = new ProcessRateVO();
//		        
//		        processRateVO.setSearchDateF(searchVO.getSearchConfirmDateF());
//		        processRateVO.setSearchDateT(searchVO.getSearchConfirmDateT());
//		        processRateVO.setPstinstCode(searchVO.getSearchPstinstCode());
//		        processRateVO.setRid(searchVO.getSearchRid());
//		        
//		        if("ROLE_ADMIN".equals(user.getAuthorCode()) || 
//						"ROLE_CHARGER".equals(user.getAuthorCode()) ||
//						"ROLE_MNGR".equals(user.getAuthorCode())){					//Admin, 담당자, 관리자
//					
//				}else{																//현업, 결재자
//					processRateVO.setPstinstCode(user.getPstinstCode());
//				}	
//				
//				List processRateReportList =  srProcessRateService.excelDownProcessRateReportList(processRateVO);
//		        
//				for (int i = 0; i < processRateReportList.size(); i++) {
//	        		
//		    		Object obj = processRateReportList.get(i);
//		    		ProcessRateVO reportVO = (ProcessRateVO) obj;
//		    		idx = 0;
//		    		row = kpiSheet.createRow(rowCnt++);
//		    		
//		    		
//		    		cell = row.createCell(idx++);
//		    		if("en".equals((String)req.getSession().getAttribute("language"))){		            	
//		        		cell.setCellValue(reportVO.getModuleNameEn());
//		        	}else if("cn".equals((String)req.getSession().getAttribute("language"))){
//		        		cell.setCellValue(reportVO.getModuleNameCn());				        
//		        	}else{
//		        		cell.setCellValue(reportVO.getModuleName());
//		        	}
//		            cell.setCellStyle(cellStyle);
//		            cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getSrTotalCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getSignCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getResolveCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getTestAtCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getCompleteCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getCompleteRate());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getEvalCnt());
//		    		cell.setCellStyle(cellStyle);
//		    		cell = row.createCell(idx++);
//		    		cell.setCellValue(reportVO.getEvalPoint());
//		    		cell.setCellStyle(cellStyle);		    		
//		        }
		        
		        //resp.setContentType("application/octetstream");
		        //resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));
		        bos = new ByteArrayOutputStream();
		        wb.write(bos);
		        
		        retMap.put("filename", fileName);
		        retMap.put("fileBinary", new JSONArray(bos.toByteArray()).toString());
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(wb != null) wb.close();
				if(bos != null) bos.close();
			}
			
			
		}
		
		
		return retMap;
		
		
	}

	
	/**
	 * SR 엑셀다운로드(상세내역)을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/sr/EgovSrListExcelDetail.do")
	public ModelAndView selectSrListExcelDetail(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") SrVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);
 
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		/** 검색-요청일(접수확인일) */
		if (!"".equals(searchVO.getSearchConfirmDateFView())) {
			searchVO.setSearchConfirmDateF(searchVO.getSearchConfirmDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchConfirmDateTView())) {
			searchVO.setSearchConfirmDateT(searchVO.getSearchConfirmDateTView().replaceAll("-", ""));
		}
		/** 검색-완료일 */
		if (!"".equals(searchVO.getSearchCompleteDateFView())) {
			searchVO.setSearchCompleteDateF(searchVO.getSearchCompleteDateFView().replaceAll("-", ""));
		}
		if (!"".equals(searchVO.getSearchCompleteDateTView())) {
			searchVO.setSearchCompleteDateT(searchVO.getSearchCompleteDateTView().replaceAll("-", ""));
		}

		if ("ROLE_ADMIN".equals(user.getAuthorCode())) { // Admin
			List<String> strStatus = new ArrayList<String>();
			// strStatus.add("1000"); //임시저장(검색 초기용)
			strStatus.add("1001"); // 등록
			strStatus.add("1002"); // 접수대기
			strStatus.add("1003"); // 접수완료
			strStatus.add("1004"); // 해결중
			strStatus.add("1005"); // 고객테스트
			strStatus.add("1006"); // 완료
			searchVO.setSearchStatus(strStatus);
		} else if ("ROLE_CHARGER".equals(user.getAuthorCode())) { // 담당자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRname(user.getName());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_MNGR".equals(user.getAuthorCode())) { // 관리자
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchRname(user.getName());
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_MEMBER".equals(user.getAuthorCode())) { // 고객
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				searchVO.setSearchCustomerNm(user.getName());
				List<String> strStatus = new ArrayList<String>();
				// strStatus.add("1000"); //임시저장(검색 초기용)
				strStatus.add("1001"); // 등록
				strStatus.add("1002"); // 접수대기
				strStatus.add("1003"); // 접수완료
				strStatus.add("1004"); // 해결중
				strStatus.add("1005"); // 고객테스트
				strStatus.add("1006"); // 완료
				searchVO.setSearchStatus(strStatus);
			}
		} else if ("ROLE_USER_SANCTNER".equals(user.getAuthorCode())) { // 결재자
			searchVO.setSearchPstinstCode(user.getPstinstCode());
			// 검색에 의한 조회 아닐때 초기값 부여
			if ("".equals(searchVO.getSearchAt())) {
				List<String> strStatus = new ArrayList<String>();
				strStatus.add("1001"); // SR등록(결재자 검색 초기용)
				searchVO.setSearchStatus(strStatus);
			}
		}

		// model.addAttribute("resultList", srManageService.selectSrList(searchVO));
		List srDetailList = srManageService.excelDownSrDetailList(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("srDetail", srDetailList);

		return new ModelAndView("srDetailExcelView", "srDetailMap", map);
	}
	
	
	/**
	 * SR 엑셀다운로드(상세내역)을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/sr/EgovSrList"
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/excel/sr/EgovSrListExcelDetail.do")
	@ResponseBody
	public Map<String, Object> selectSrListExcelDetailMap(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") SrVO searchVO, ModelMap model, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, req);
 
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		List srDetailList = srManageService.excelDownSrDetailList(searchVO);

		Map<String, Object> retMap = new HashMap<String, Object>();
		
		if(srDetailList.size() > 0) {
			Workbook wb = null;
			ByteArrayOutputStream bos = null;
			try {
				wb = new XSSFWorkbook();
				Calendar cal = Calendar.getInstance();
		    	String strSaveDate = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
		    	SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
		    	Date saveDate = sdfmt.parse(strSaveDate);
		    	strSaveDate = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(saveDate);
				
				String fileName = "SR리스트(상세내역)_"+strSaveDate+".xlsx";
				resp.setContentType("application/octetstream");
				resp.setHeader("Content-Disposition","attachment; filename=" + new String(fileName.getBytes("KSC5601"), "8859_1"));

		        XSSFCell cell = null;
		        int idx = 0;

		        Sheet sheet = wb.createSheet("SR리스트");


		        Row row = sheet.createRow(0);
		        row.createCell(0).setCellValue("SR리스트(상세내역)");

		        idx = 0;
		        row = sheet.createRow(0);
		        
		        row.createCell(idx++).setCellValue("SR번호");
		        row.createCell(idx++).setCellValue("제목");
		        row.createCell(idx++).setCellValue("모듈");
		        row.createCell(idx++).setCellValue("처리구분");
		        row.createCell(idx++).setCellValue("상태");
		        row.createCell(idx++).setCellValue("요청자");
		        row.createCell(idx++).setCellValue("요청일시");
		        row.createCell(idx++).setCellValue("완료예정일");
		        row.createCell(idx++).setCellValue("담당자");
		        row.createCell(idx++).setCellValue("처리완료일");
		        row.createCell(idx++).setCellValue("고객확인완료일");
		        row.createCell(idx++).setCellValue("요청내역");
		        row.createCell(idx++).setCellValue("답변");
		        row.createCell(idx++).setCellValue("실제공수");
		        row.createCell(idx++).setCellValue("처리모듈");
		        row.createCell(idx++).setCellValue("고객사");


		        for (int i = 0; i < srDetailList.size(); i++) {
		        	Object obj = srDetailList.get(i);
		        	SrVO srDetailVO = (SrVO) obj;
		            idx = 0;
		            row = sheet.createRow(1+i);
		            row.createCell(idx++).setCellValue(srDetailVO.getSrNo());
		            row.createCell(idx++).setCellValue(srDetailVO.getSubject());
		            row.createCell(idx++).setCellValue(srDetailVO.getModuleNm());
		            row.createCell(idx++).setCellValue(srDetailVO.getCategoryNm());
		            row.createCell(idx++).setCellValue( srDetailVO.getStatusNm());
		            row.createCell(idx++).setCellValue( srDetailVO.getCustomerNm());
		            row.createCell(idx++).setCellValue( srDetailVO.getSignDate());
		            row.createCell(idx++).setCellValue( srDetailVO.getScheduleDate());
		            row.createCell(idx++).setCellValue( srDetailVO.getRname());
		            row.createCell(idx++).setCellValue( srDetailVO.getCompleteDate());		            
		            row.createCell(idx++).setCellValue( srDetailVO.getTestCompleteDate());
		            htmlRemove(srDetailVO);
		            row.createCell(idx++).setCellValue( srDetailVO.getComment()==null?"":srDetailVO.getComment());
		            row.createCell(idx++).setCellValue( srDetailVO.getAnsComment()==null?"":srDetailVO.getAnsComment());
		            row.createCell(idx++).setCellValue( srDetailVO.getAnsRealExpectTime());		            
		            row.createCell(idx++).setCellValue( srDetailVO.getAnsModuleNm());		            
		            row.createCell(idx++).setCellValue( srDetailVO.getPstinstNm());
		        }
		        
		        bos = new ByteArrayOutputStream();
		        wb.write(bos);
		        
		        retMap.put("filename", fileName);
		        retMap.put("fileBinary", new JSONArray(bos.toByteArray()).toString());
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(wb != null) wb.close();
				if(bos != null) bos.close();
			}
			
			
		}
		
		return retMap;
	}
	
	/**
	 * html 코드 삭제
	 * @param srReportVO
	 */
	private void htmlRemove(SrVO srDetailVO) {
		//요청내용
		srDetailVO.setComment(srDetailVO.getComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
		if(srDetailVO.getComment().length() > 32767) {
			srDetailVO.setComment(srDetailVO.getComment().substring(0,32767));
		}
		//답변내용
		srDetailVO.setAnsComment(srDetailVO.getAnsComment().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("&nbsp;", "").replaceAll("\\<.*?\\>", "").replaceAll("<!--.*-->",""));
		if(srDetailVO.getAnsComment().length() > 32767) {
			srDetailVO.setAnsComment(srDetailVO.getAnsComment().substring(0,32767));
		}
	}
 
	/**
	 * 변경된 담당자에게 메일발송을 한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sr/sendMail.do")
	@ResponseBody
	public Map<String, Object> sendMail(MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("srVO") SrVO srVO,
			@ModelAttribute("searchVO") SrVO searchVO, @ModelAttribute("srchargerVO") SrAnswerVO srchargerVO,
			@ModelAttribute("srchargerVO") SrAnswerVO srAnswerVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult,
			SessionStatus status, HttpServletRequest request, ModelMap model) throws Exception {
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 다국어 조회 HttpServletRequest request
		getLanguage(model, request);

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		try {
			// 모듈코드를 코드정보로부터 조회 - SR0003
			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCodeId("SR0003");
			codeVO.setCode(srVO.getModuleCode());
			srVO.setModuleNm(cmmUseService.selectCodeNm(codeVO));
	
			// 처리구분코드를 코드정보로부터 조회 - SR0005
			codeVO.setCodeId("SR0005");
			codeVO.setCode(srVO.getCategory());
			srVO.setCategoryNm(cmmUseService.selectCodeNm(codeVO));
	
			// 우선순위코드를 코드정보로부터 조회 - SR0006
			codeVO.setCodeId("SR0006");
			codeVO.setCode(srVO.getPriority());
			srVO.setPriorityNm(cmmUseService.selectCodeNm(codeVO));
	
			SrVO srReq = srManageService.selectSrDetail(srVO);
			srVO.setComment(srReq.getComment()); // 메일내용
			srVO.setFileId(srReq.getFileId()); // 파일ID
	
			// 변경된 담당자에게 메일발송
			srVO.setComment(unscript(srVO.getComment())); // XSS 방지
			String subject = (srVO.getSubject() == null) ? "" : srVO.getSubject(); // 메일제목
			String emailCn = (srVO.getComment() == null) ? "<p>&nbsp;</p>" : srVO.getComment(); // 메일내용
	
			subject = "[".concat(srVO.getPstinstNm().concat("-SR] ".concat(subject)));
	
			String strComment = "";
	
			strComment = strComment.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>제목</th><td width='80%' colspan='3'>"
							+ srVO.getSubject() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>고객사</th><td width='30%'>"
							+ srVO.getPstinstNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청자</th><td width='30%'>"
							+ srVO.getCustomerNm() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(내선)</th><td width='30%'>"
							+ srVO.getTel1()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(이동전화)</th><td width='30%'>"
							+ srVO.getTel2() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>이메일</th><td width='30%'>"
							+ srVO.getEmail()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>모듈</th><td width='30%'>"
							+ srVO.getModuleNm() + "</td></tr>  ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>처리구분</th><td width='30%'>"
							+ srVO.getCategoryNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>우선순위</th><td width='30%'>"
							+ srVO.getPriorityNm() + "</td></tr>  ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
							+ srVO.getSignDate()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>완료희망일</th><td width='30%'>"
							+ srVO.getHopeDate() + "</td></tr> ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>검색키워드</th><td width='80%' colspan='3'>"
							+ srVO.getTcode() + "</td></tr>	");
	
			strComment = strComment.concat(
					"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>요청내용</th></tr>");
			strComment = strComment.concat("<tr><td width='100%' colspan='4'>" + emailCn + "</td></tr>	");
			strComment = strComment.concat("</table>");
	
			String strRid = "";
			SrVO srEmailVo = srManageService.selectChargerEmail(srVO); // 담당자 메일조회
			strRid = srVO.getRid(); // 변경된 담당자 id
	
			egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
			egovMultiPartEmail.setSenderName(srVO.getCustomerNm()); // 보내는사람 이름
			egovMultiPartEmail.send(srEmailVo.getRemail(), subject, strComment, srVO.getFileId(), srVO.getSrNo(),
					srVO.getAnswerNo()); // 받는사람 메일
	
			// Exception 없이 진행시 성공메시지
			model.addAttribute("resultMsg", "success.common.sendMail");
	
			// 저장 처리후 화면조회
			String returnUrl = "";
	
			// 권한코드
			model.addAttribute("authorCode", user.getAuthorCode());
	
			// SR정보
			SrVO result = srManageService.selectSrDetail(srVO);
	
			// 변경된 담당자 id
			result.setRid(strRid);
	
			// 답변 처리자 초기화
			result.setAnsRid(user.getId());
			
			// Exception 없이 진행시 수정성공메시지
			retMap.put("msgType", "S");			
			retMap.put("msg", egovMessageSource.getMessage("success.common.sendMail"));
			
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.msg"));
		}finally {
			
		}	
		
		return retMap;
//		// SR답변
//		model.addAttribute("answerList", srManageService.selectSrAnswerList(srAnswerVO));
//		// SR답변(임시저장)
//		model.addAttribute("answerListTemp", srManageService.selectSrAnswerListTemp(srAnswerVO));
//
//		// 모듈코드를 코드정보로부터 조회 - SR0003
//		ComDefaultCodeVO vo = new ComDefaultCodeVO();
//		vo.setCodeId("SR0003");
//		vo.setPstinstCode(user.getPstinstCode());
//		model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//		// 상태코드를 코드정보로부터 조회 - SR0004
//		vo.setCodeId("SR0004");
//		model.addAttribute("statusCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//		// 처리구분코드를 코드정보로부터 조회 - SR0005
//		vo.setCodeId("SR0005");
//		model.addAttribute("classCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//		// 우선순위코드를 코드정보로부터 조회 - SR0006
//		vo.setCodeId("SR0006");
//		model.addAttribute("priortCode_result", cmmUseService.selectCmmCodeDetail(vo));
//
//		// 고객사별 요청자 목록
//		vo.setCodeId(result.getPstinstCode());
//		model.addAttribute("cstmrCode_result", cmmUseService.selectCstmrDetail(vo));
//
//		// 담당자 및 관리자 목록
//		model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
//
//		// Admin, 담당자, 관리자
//		if ("ROLE_ADMIN".equals(user.getAuthorCode()) || "ROLE_CHARGER".equals(user.getAuthorCode())
//				|| "ROLE_MNGR".equals(user.getAuthorCode())) {
//			returnUrl = "/sr/EgovSrSelectUpdtMng";
//		} else {
//			returnUrl = "/sr/EgovSrSelectUpdt";
//		}
//
//		model.addAttribute("srVO", result);
//
//		return returnUrl;

	}

	/**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}

	/**
	 * 메일발송(담당자 및 관리자에게 발송)
	 * 
	 * @param srVO
	 * @param subject
	 * @param emailCn
	 * @throws Exception
	 * @throws EmailException
	 */
	private void srMngrSendEmail(SrVO srVO, String subject, String emailCn, String rolltype, String atchFileId)
			throws Exception, EmailException {

		// 모듈코드를 코드정보로부터 조회 - SR0003
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("SR0003");
		codeVO.setCode(srVO.getModuleCode());
		srVO.setModuleNm(cmmUseService.selectCodeNm(codeVO));

		// 처리구분코드를 코드정보로부터 조회 - SR0005
		codeVO.setCodeId("SR0005");
		codeVO.setCode(srVO.getCategory());
		srVO.setCategoryNm(cmmUseService.selectCodeNm(codeVO));

		// 우선순위코드를 코드정보로부터 조회 - SR0006
		codeVO.setCodeId("SR0006");
		codeVO.setCode(srVO.getPriority());
		srVO.setPriorityNm(cmmUseService.selectCodeNm(codeVO));

		String strCstmrName = srManageService.strCstmrName(srVO); // 고객명

		List<SrVO> mngrEmailList = null; // 관리자 이메일
		if ("charger".equals(rolltype)) { // 담당자에게 메일발송(담당자 없을시 관리자에게 메일발송)
			mngrEmailList = (List<SrVO>)srManageService.selectMngrEmail(srVO);
			if(mngrEmailList.size() == 0) {
				mngrEmailList =(List<SrVO>)srManageService.selectEmptyMngrEmail(srVO);
			}
			subject = "[".concat(srVO.getPstinstNm().concat("-SR] ".concat(subject)));
		} else if ("sanctner".equals(rolltype)) { // 결재자에게 메일발송
			subject = "[ISTN-SR] ".concat(subject).concat(" - 결재요청합니다");
		} else if ("member".equals(rolltype)) { // 요청자에게 반려 메일 발송
			subject = "[ISTN-SR] ".concat(subject).concat(" - 결재 반려되었습니다");
		}

		// 담당자 및 관리자 목록(고객사,모듈)
		List<SrVO> chargerList = null;
		if ("charger".equals(rolltype)) {
			chargerList = srManageService.selectChargerMailList(srVO); // 모듈담당자
		} else if ("sanctner".equals(rolltype)) {
			chargerList = srManageService.selectSanctnerEmailList(srVO); // 결재자
		} else if ("member".equals(rolltype)) {
			chargerList = srManageService.selectMemberEmailList(srVO); // 고객(현업)
		}

		String strComment = ""; // 메일 내용
		String strSendLanguage = ""; // 전송 Language
		if (chargerList.size() != 0) { // 담당자 및 결재자에게 메일발송
			SrVO vo;
			Iterator<SrVO> iter = chargerList.iterator();
			while (iter.hasNext()) {
				vo = (SrVO) iter.next();
				if ("charger".equals(rolltype)) { // 모듈담당자
					egovMultiPartEmail.setSenderName(strCstmrName); // 보내는사람 이름
					egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
					// egovMultiPartEmail.setSenderName(strCstmrName.concat("[".concat(srVO.getEmail().concat("]"))));
					// //보내는사람 이름
					if (!"".equals(vo.getSendLanguage())) {
						strSendLanguage = vo.getSendLanguage();
					} else {
						strSendLanguage = "ko";
					}
					strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, strSendLanguage);
					strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, strSendLanguage);
				} else if ("sanctner".equals(rolltype)) { // 결재자는 SR시스템 admin메일 계정으로 발송
					egovMultiPartEmail.setSenderName("SR System"); // 보내는사람 이름
					egovMultiPartEmail.setEmailAddress("istncc@istn.co.kr"); // 보내는사람 메일
					if (!"".equals(vo.getSendLanguage())) {
						strSendLanguage = vo.getSendLanguage();
						if ("en".equals(strSendLanguage)) {
							subject = "[ISTN-SR] ".concat(subject).concat(" - Approval Request");
						} else if ("cn".equals(strSendLanguage)) {
							subject = "[ISTN-SR] ".concat(subject).concat(" - 批准 提交");
						}
					} else {
						strSendLanguage = "ko";
					}
					strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, strSendLanguage);
				} else if ("member".equals(rolltype)) { // 고객(현업)
					egovMultiPartEmail.setSenderName("SR System"); // 보내는사람 이름
					egovMultiPartEmail.setEmailAddress("istncc@istn.co.kr"); // 보내는사람 메일
					if (!"".equals(vo.getSendLanguage())) {
						strSendLanguage = vo.getSendLanguage();
						if ("en".equals(strSendLanguage)) {
							subject = "[ISTN-SR] ".concat(subject).concat(" - Approval Return");
						} else if ("cn".equals(strSendLanguage)) {
							subject = "[ISTN-SR] ".concat(subject).concat(" - 批准 拒绝");
						}
					} else {
						strSendLanguage = "ko";
					}
					strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, strSendLanguage);
				}

				egovMultiPartEmail.send(vo.getEmail(), subject, strComment, atchFileId, srVO.getSrNo(),
						srVO.getAnswerNo()); // 받는사람 메일
			}
		} else { // 관리자에게 메일발송
			if (mngrEmailList.size() > 0 ) {
				for(SrVO mngrEmail : mngrEmailList) {
					strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, "ko");
					egovMultiPartEmail.setSenderName(strCstmrName); // 보내는사람 이름
					egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
					egovMultiPartEmail.send(mngrEmail.getEmail(), subject, strComment, atchFileId, srVO.getSrNo(),
							srVO.getAnswerNo()); // 받는사람 메일
				}				
				//strComment = getSendComment(srVO, emailCn, rolltype, strCstmrName, "ko");
				//egovMultiPartEmail.setSenderName(strCstmrName); // 보내는사람 이름
				//egovMultiPartEmail.setEmailAddress(srVO.getEmail()); // 보내는사람 메일
				// //보내는사람 이름
				//egovMultiPartEmail.send(strMngrEmail, subject, strComment, atchFileId, srVO.getSrNo(),
						//srVO.getAnswerNo()); // 받는사람 메일
				
			}
		}
	}

	// 20200619 SHS 완료 메일 내용
	// 기존 내용 : fromVO
	// 신규 내용 : srVO
	private String getSendCompleteComment(SrVO srVO, SrVO fromVO) {
		String strComment = "";
		strComment = strComment.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>제목</th><td width='80%' colspan='3'>"
						+ fromVO.getSubject() + "</td></tr>");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>고객사</th><td width='30%'>"
						+ fromVO.getPstinstNm()
						+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청자</th><td width='30%'>"
						+ fromVO.getCustomerNm() + "</td></tr>");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(내선)</th><td width='30%'>"
						+ fromVO.getTel1()
						+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(이동전화)</th><td width='30%'>"
						+ fromVO.getTel2() + "</td></tr>");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>이메일</th><td width='30%'>"
						+ fromVO.getEmail()
						+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>모듈</th><td width='30%'>"
						+ fromVO.getModuleNm() + "</td></tr>  ");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>처리구분</th><td width='30%'>"
						+ fromVO.getCategoryNm()
						+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>우선순위</th><td width='30%'>"
						+ fromVO.getPriorityNm() + "</td></tr>  ");
		strComment = strComment.concat(
				"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
						+ fromVO.getSignDate()
						+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>완료희망일</th><td width='30%'>"
						+ fromVO.getHopeDate() + "</td></tr> ");
		strComment = strComment.concat("</table>");
		strComment = strComment.concat(
				"<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'><tr><td colspan='2' bgcolor='#0257a6' height='2'></td></tr><tr><th width='20%' height='23'style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>고객확인완료일</th><td width='80%'>");
		strComment = strComment.concat(srVO.getCompleteDate());
		strComment = strComment.concat(
				"</td></tr><tr><th width='20%' height='23'style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>확인내역</th><td width='80%' >");
		strComment = strComment.concat(srVO.getTestContent());
		strComment = strComment.concat(
				"</td></tr><tr><th width='20%' height='23'style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>만족도</th><td width='80%' >");
		strComment = strComment.concat(srVO.getPoint().toString());
		strComment = strComment.concat(
				"</td></tr><tr><th width='20%' height='23'style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>기타의견</th><td width='80%' >");
		strComment = strComment.concat(srVO.getPointContent());
		strComment = strComment.concat("</td></tr></table>");
		return strComment;
	}

	private String getSendComment(SrVO srVO, String emailCn, String rolltype, String strCstmrName,
			String sendLanguage) {
		String strComment = "";

		if ("en".equals(sendLanguage)) {

			strComment = strComment
					.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Title</th><td width='80%' colspan='3'>"
							+ srVO.getSubject() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Client</th><td width='30%'>"
							+ srVO.getPstinstNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Requester</th><td width='30%'>"
							+ strCstmrName + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Office phone number</th><td width='30%'>"
							+ srVO.getTel1()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Mobile phone number</th><td width='30%'>"
							+ srVO.getTel2() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>E-mail</th><td width='30%'>"
							+ srVO.getEmail()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Module</th><td width='30%'>"
							+ srVO.getModuleNm() + "</td></tr>  ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Processing division</th><td width='30%'>"
							+ srVO.getCategoryNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Priority</th><td width='30%'>"
							+ srVO.getPriorityNm() + "</td></tr>  ");
			if ("charger".equals(rolltype)) { // 모듈담당자
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDate()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Complete Hope Date</th><td width='30%'>"
								+ srVO.getHopeDate() + "</td></tr> ");
			} else if ("sanctner".equals(rolltype) || "member".equals(rolltype)) { // 결재자, 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDateDisp()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>Complete Hope Date</th><td width='30%'>"
								+ srVO.getHopeDateDisp() + "</td></tr> ");
			}
			// strComment = strComment.concat("<tr><th width='20%' height='23'
			// style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>검색키워드</th><td
			// width='80%' colspan='3'>"+srVO.getTcode()+"</td></tr> ");

			strComment = strComment.concat(
					"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>Request content</th></tr>");
			strComment = strComment.concat("<tr><td width='100%' colspan='4'>" + emailCn + "</td></tr>	");
			if ("member".equals(rolltype)) { // 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>The reason for the return</th></tr>");
				strComment = strComment
						.concat("<tr><td width='100%' colspan='4'>" + srVO.getReturnResn() + "</td></tr>	");
			}
			strComment = strComment.concat("</table>");

		} else if ("cn".equals(sendLanguage)) {

			strComment = strComment
					.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>标题</th><td width='80%' colspan='3'>"
							+ srVO.getSubject() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>客户</th><td width='30%'>"
							+ srVO.getPstinstNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>提交者</th><td width='30%'>"
							+ strCstmrName + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>办公室</th><td width='30%'>"
							+ srVO.getTel1()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>手机</th><td width='30%'>"
							+ srVO.getTel2() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>邮箱</th><td width='30%'>"
							+ srVO.getEmail()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>模块</th><td width='30%'>"
							+ srVO.getModuleNm() + "</td></tr>  ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>处理状态</th><td width='30%'>"
							+ srVO.getCategoryNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>处理优先级</th><td width='30%'>"
							+ srVO.getPriorityNm() + "</td></tr>  ");
			if ("charger".equals(rolltype)) { // 모듈담당자
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDate()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>期望完成日期</th><td width='30%'>"
								+ srVO.getHopeDate() + "</td></tr> ");
			} else if ("sanctner".equals(rolltype) || "member".equals(rolltype)) { // 결재자, 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDateDisp()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>期望完成日期</th><td width='30%'>"
								+ srVO.getHopeDateDisp() + "</td></tr> ");
			}
			// strComment = strComment.concat("<tr><th width='20%' height='23'
			// style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>검색키워드</th><td
			// width='80%' colspan='3'>"+srVO.getTcode()+"</td></tr> ");

			strComment = strComment.concat(
					"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>提交内容</th></tr>");
			strComment = strComment.concat("<tr><td width='100%' colspan='4'>" + emailCn + "</td></tr>	");
			if ("member".equals(rolltype)) { // 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>拒绝原因</th></tr>");
				strComment = strComment
						.concat("<tr><td width='100%' colspan='4'>" + srVO.getReturnResn() + "</td></tr>	");
			}
			strComment = strComment.concat("</table>");

		} else {

			strComment = strComment
					.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>제목</th><td width='80%' colspan='3'>"
							+ srVO.getSubject() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>고객사</th><td width='30%'>"
							+ srVO.getPstinstNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청자</th><td width='30%'>"
							+ strCstmrName + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(내선)</th><td width='30%'>"
							+ srVO.getTel1()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(이동전화)</th><td width='30%'>"
							+ srVO.getTel2() + "</td></tr>");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>이메일</th><td width='30%'>"
							+ srVO.getEmail()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>모듈</th><td width='30%'>"
							+ srVO.getModuleNm() + "</td></tr>  ");
			strComment = strComment.concat(
					"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>처리구분</th><td width='30%'>"
							+ srVO.getCategoryNm()
							+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>우선순위</th><td width='30%'>"
							+ srVO.getPriorityNm() + "</td></tr>  ");
			if ("charger".equals(rolltype)) { // 모듈담당자
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDate()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>완료희망일</th><td width='30%'>"
								+ srVO.getHopeDate() + "</td></tr> ");
			} else if ("sanctner".equals(rolltype) || "member".equals(rolltype)) { // 결재자, 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>요청일</th><td width='30%'>"
								+ srVO.getSignDateDisp()
								+ "</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>완료희망일</th><td width='30%'>"
								+ srVO.getHopeDateDisp() + "</td></tr> ");
			}
			// strComment = strComment.concat("<tr><th width='20%' height='23'
			// style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>검색키워드</th><td
			// width='80%' colspan='3'>"+srVO.getTcode()+"</td></tr> ");

			strComment = strComment.concat(
					"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>요청내용</th></tr>");
			strComment = strComment.concat("<tr><td width='100%' colspan='4'>" + emailCn + "</td></tr>	");
			if ("member".equals(rolltype)) { // 고객(현업)
				strComment = strComment.concat(
						"<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>반려사유</th></tr>");
				strComment = strComment
						.concat("<tr><td width='100%' colspan='4'>" + srVO.getReturnResn() + "</td></tr>	");
			}
			strComment = strComment.concat("</table>");

		}

		return strComment;
	}

}