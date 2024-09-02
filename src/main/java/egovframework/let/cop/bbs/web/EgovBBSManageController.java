package egovframework.let.cop.bbs.web;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovFileMngService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngUtil;
import egovframework.let.main.service.com.cmm.service.FileVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.main.service.com.cop.ems.service.EgovMultiPartEmail;
import egovframework.let.cop.bbs.service.Board;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;
import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.19
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  이삼섭          최초 생성
 *  2009.06.29  한성곤	       2단계 기능 추가 (댓글관리, 만족도조사)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovBBSManageController {

    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;
    
    /** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	//  첨부파일 사용시
	@Resource(name="egovMultiPartEmail")
    private EgovMultiPartEmail egovMultiPartEmail;
	
	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    //---------------------------------
    // 2009.06.29 : 2단계 기능 추가
    //---------------------------------
    //SHT-CUSTOMIZING//@Resource(name = "EgovBBSCommentService")
    //SHT-CUSTOMIZING//private EgovBBSCommentService bbsCommentService;
    
    //SHT-CUSTOMIZING//@Resource(name = "EgovBBSSatisfactionService")
    //SHT-CUSTOMIZING//private EgovBBSSatisfactionService bbsSatisfactionService;
    
    //SHT-CUSTOMIZING//@Resource(name = "EgovBBSScrapService")
    //SHT-CUSTOMIZING//private EgovBBSScrapService bbsScrapService;
    ////-------------------------------

    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());
    
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
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/selectBoardList.do")
    public String selectBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

	//다국어 wbpark 2016.05.24 
	getLanguage(model, request);
    	
    // 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId(user.getUniqId());
	
	BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
	//-------------------------------
	// 게시판 유형이 고객게시판일 경우 권한에 따라 리스트를 내용이 달라진다.
	//-------------------------------
//	if (master.getBbsTyCode().equals("BBST04")) {						//고객자료실
//		if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || 
//			"ROLE_USER_SANCTNER".equals(user.getAuthorCode())){			//고객, 결제자
//			//업체코드만 셋팅. 자신의 업체글이 전부 보인다.
//			boardVO.setSearchPstinstCode(user.getPstinstCode());
//		}
//	}else if(master.getBbsTyCode().equals("BBST05")) {					//고객의견 
//		if("ROLE_USER_MEMBER".equals(user.getAuthorCode())){			//고객
//			//ID, 업체코드 셋팅. 자신의 글만 보인다.
//			boardVO.setSearchCreatorId(user.getId());
//			boardVO.setSearchPstinstCode(user.getPstinstCode());
//		}else if("ROLE_USER_SANCTNER".equals(user.getAuthorCode())){	//결제자													//담당자,관리자,admin
//			//업체코드만 셋팅. 자신의 업체글이 전부 보인다.
//			boardVO.setSearchPstinstCode(user.getPstinstCode());
//		}
//	}
	////-----------------------------

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	//권한코드
	model.addAttribute("authorCode", user.getAuthorCode());
	
	if("ROLE_ADMIN".equals(user.getAuthorCode()) ||
	   "ROLE_CHARGER".equals(user.getAuthorCode()) || 
	   "ROLE_MNGR".equals(user.getAuthorCode())){			//Admin, 담당자, 관리자
		//고객사정보
		PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
	}

	return "cop/bbs/EgovNoticeList";
    }
    
    /**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/select/cop/bbs/selectBoardList.do")
    @ResponseBody
    public Map<String, Object> selectEgovBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {


    Map<String, Object> retMap = new HashMap<String, Object> ();
    	
	//다국어 wbpark 2016.05.24 
	getLanguage(model, request);
    	
    // 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId(user.getUniqId());
	
	BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	


	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	retMap.put("resultList", map.get("resultList"));
	retMap.put("resultCnt", map.get("resultCnt"));
	retMap.put("boardVO", boardVO);
	retMap.put("brdMstrVO", master);
	retMap.put("paginationInfo", paginationInfo);
	
	//권한코드
	model.addAttribute("authorCode", user.getAuthorCode());
	retMap.put("authorCode", user.getAuthorCode());
	
	if("ROLE_ADMIN".equals(user.getAuthorCode()) ||
	   "ROLE_CHARGER".equals(user.getAuthorCode()) || 
	   "ROLE_MNGR".equals(user.getAuthorCode())){			//Admin, 담당자, 관리자
		//고객사정보
		PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
	}

	return retMap;
    }

    /**
     * //다국어 wbpark 2016.05.24    	
     * @param model
     * @param request
     */
	private void getLanguage(ModelMap model, HttpServletRequest request) {
		String language = (String)request.getSession().getAttribute("language");
		if("ko".equals(language)){
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		}else if("en".equals(language)){
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
			model.addAttribute("srLanguage", "en");
		}else if("cn".equals(language)){
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.CHINA);
			model.addAttribute("srLanguage", "cn");
		}else{
			request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREA);
			model.addAttribute("srLanguage", "ko");
		}
	}

    /**
     * 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/selectBoardArticle.do")
    public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
	getLanguage(model, request);	
	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(true);

	//---------------------------------
	// 2009.06.29 : 2단계 기능 추가
	//---------------------------------
	if (!boardVO.getSubPageIndex().equals("")) {
	    boardVO.setPlusCount(false);
	}
	////-------------------------------

	boardVO.setLastUpdusrId(user.getUniqId());
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	//CommandMap의 형태로 개선????

	model.addAttribute("sessionUniqId", user.getUniqId());

	//----------------------------
	// template 처리 (기본 BBS template 지정  포함)
	//----------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId(user.getUniqId());
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

	if (masterVo.getTmplatCours() == null || masterVo.getTmplatCours().equals("")) {
	    masterVo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", masterVo);
	
	//권한코드
	model.addAttribute("authorCode", user.getAuthorCode());
			
	////-----------------------------
	
	//----------------------------
	// 2009.06.29 : 2단계 기능 추가
	//----------------------------
	//SHT-CUSTOMIZING//if (bbsCommentService.canUseComment(boardVO.getBbsId())) {
	//SHT-CUSTOMIZING//    model.addAttribute("useComment", "true");
	//SHT-CUSTOMIZING//}
	
	//SHT-CUSTOMIZING//if (bbsSatisfactionService.canUseSatisfaction(boardVO.getBbsId())) {
	//SHT-CUSTOMIZING//    model.addAttribute("useSatisfaction", "true");
	//SHT-CUSTOMIZING//}
	
	//SHT-CUSTOMIZING//if (bbsScrapService.canUseScrap()) {
	//SHT-CUSTOMIZING//    model.addAttribute("useScrap", "true");
	//SHT-CUSTOMIZING//}
	////--------------------------

	return "cop/bbs/EgovNoticeInqire";
    }

    /**
     * 게시물 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/addBoardArticle.do")
    public String addBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
	getLanguage(model, request);
    	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	BoardMasterVO bdMstr = new BoardMasterVO();

	if (isAuthenticated) {

	    BoardMasterVO vo = new BoardMasterVO();
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId(user.getUniqId());
	    
	    bdMstr = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", bdMstr);
	}

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bdMstr.getTmplatCours() == null || bdMstr.getTmplatCours().equals("")) {
	    bdMstr.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", bdMstr);
	////-----------------------------
	
	//권한코드
	model.addAttribute("authorCode", user.getAuthorCode());
	
	if("ROLE_ADMIN".equals(user.getAuthorCode()) ||
	   "ROLE_CHARGER".equals(user.getAuthorCode()) || 
	   "ROLE_MNGR".equals(user.getAuthorCode())){			//Admin, 담당자, 관리자
		//고객사정보
		PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
	}

	return "cop/bbs/EgovNoticeRegist";
    }

    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/insertBoardArticle.do")
    @ResponseBody
    public Map<String, Object> insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model, HttpServletRequest request) throws Exception {
    
	Map<String, Object> retMap = new HashMap<String , Object>();	
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
	getLanguage(model, request);
    	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	BoardMasterVO master = new BoardMasterVO();
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId(user.getUniqId());
	
	master = bbsAttrbService.selectBBSMasterInf(vo);
	
	
	try {
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
			/*
			 * model.addAttribute("bdMstr", master); //---------------------------- // 기본
			 * BBS template 지정 //---------------------------- if (master.getTmplatCours() ==
			 * null || master.getTmplatCours().equals("")) {
			 * master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css"); }
			 * 
			 * model.addAttribute("brdMstrVO", master);
			 */
		    ////-----------------------------
		    retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
		    return retMap;
		}

		if (isAuthenticated) {
		    List<FileVO> result = null;
		    String atchFileId = "";
		    
		    List<MultipartFile> files = multiRequest.getFiles("files");
			if (!files.isEmpty()) {
				//result = fileUtil.parseFileInf(files, "SR_", 0, "", "Globals.fileStorePathSr");
				/*신규 File List 변경*/
				result = fileUtil.parseFileList(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
				board.setAtchFileId(atchFileId);
			}
		    
		    System.out.println("================================================ user.getUniqId() : " + user.getUniqId());
		    System.out.println("================================================ board.getBbsId() : " + board.getBbsId());
		    //board.setAtchFileId(atchFileId);
		    board.setFrstRegisterId(user.getUniqId());
		    board.setBbsId(board.getBbsId());
		    //생성자ID와 업체코드 셋팅..
		    board.setCreatorId(user.getId());
		    
		    //고객, 결제자
		    if("ROLE_USER_MEMBER".equals(user.getAuthorCode()) || "ROLE_USER_SANCTNER".equals(user.getAuthorCode())){			
				//업체코드만 셋팅. 자신의 업체글이 전부 보인다.
		    	board.setPstinstCode(user.getPstinstCode());
			}	    
		    
		    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    bbsMngService.insertBoardArticle(board);
		    
		    //게시판 고객 의견을 입력하면 그 의견은 Mail로 저와 김은수 이사에게 전달
		    if(master.getBbsTyCode().equals("BBST05")) {					//고객의견 
				String subject = (board.getNttSj() == null) ? "" : board.getNttSj();            // 메일제목
				String emailCn = (board.getNttCn() == null) ? "" : board.getNttCn();            // 메일내용
				
				subject = "[".concat(user.getPstinstNm().concat("-SR고객의견] ".concat(subject)));
				
				String strComment = "";
				
				strComment = strComment.concat("<table border='0' cellSpacing='1' cellPadding='0' width='700' align='center'>");
				strComment = strComment.concat("<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>제목</th><td width='80%' colspan='3'>"+board.getNttSj()+"</td></tr>");
				strComment = strComment.concat("<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>고객사</th><td width='30%'>"+user.getPstinstNm()+"</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>등록자</th><td width='30%'>"+user.getName()+"</td></tr>");
				strComment = strComment.concat("<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(내선)</th><td width='30%'>"+user.getOffmTelno()+"</td><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>연락처(이동전화)</th><td width='30%'>"+user.getMbtlnum()+"</td></tr>");
				strComment = strComment.concat("<tr><th width='20%' height='23' style='width:140px;height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;'>이메일</th><td width='80%' colspan='3'>"+user.getEmail()+"</td></tr>");
				
				strComment = strComment.concat("<tr><th width='100%' height='23' style='height:30px;color:#000;background:#edf5f8;text-align:center;font-weight:bold;' colspan='4'>의견내용</th></tr>");
				strComment = strComment.concat("<tr><td width='100%' colspan='4'>"+emailCn+"</td></tr>	");
				strComment = strComment.concat("</table>");
				
				//1. 정용길 상무이사 ykiljeong@isprint.co.kr
				//2. 김은수 이사     eskim62@isprint.co.kr
//			    egovMultiPartEmail.setEmailAddress(user.getEmail());						//보내는사람 메일
//			    egovMultiPartEmail.setSenderName(user.getName());							//보내는사람 이름
//			    egovMultiPartEmail.send("ykiljeong@istn.co.kr", subject, strComment, atchFileId, null, 0);	//받는사람 메일()
//			    egovMultiPartEmail.send("eskim62@istn.co.kr", subject, strComment, atchFileId, null, 0);		//받는사람 메일()
		    }
		}
		
		retMap.put("msgType", "S");			
		retMap.put("msg", egovMessageSource.getMessage("success.common.save"));		
		
	}catch(Exception e) {
		e.printStackTrace();
		retMap.put("msgType", "E");
		retMap.put("msg", egovMessageSource.getMessage("fail.common.save"));
	}finally {
		
	}	
	

	//status.setComplete();
		return retMap;
    }

    
    
    
    /**
     * 메일발송을 한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/sendMail.do")
    public String sendMail(MultipartHttpServletRequest multiRequest, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {
    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {

		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO vo = new BoardMasterVO();
		    
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setUniqId(user.getUniqId());
	
		    master = bbsAttrbService.selectBBSMasterInf(vo);
		    
		    model.addAttribute("bdMstr", master);
	
		    //----------------------------
		    // 기본 BBS template 지정 
		    //----------------------------
		    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
		    	master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
		    }

		    model.addAttribute("brdMstrVO", master);
		    ////-----------------------------

		    return "cop/bbs/EgovNoticeRegist";
		}
	
		// 첨부파일 처리로직...
		if (isAuthenticated) {
		    List<FileVO> result = null;
		    String atchFileId = "";
		    
		    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		    }
		    board.setAtchFileId(atchFileId);
		    board.setFrstRegisterId(user.getUniqId());
		    board.setBbsId(board.getBbsId());
		    
		    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    bbsMngService.insertBoardArticle(board);
		}

		// 메일발송 처리로직....
		String subject = (board.getNttSj() == null) ? "" : board.getNttSj();			// 메일제목
	    String emailCn = (board.getNttCn() == null) ? "" : board.getNttCn();            // 메일내용
	 
//	    SimpleMailMessage msg = new SimpleMailMessage();
//	    msg.setTo("goochunsa@naver.com");
//	    msg.setSubject(subject);
//	    msg.setText(emailCn);
	    egovMultiPartEmail.setEmailAddress("skpickup@nate.com");						//보내는사람 메일
	    egovMultiPartEmail.setSenderName("한정만");										//보내는사람 이름
	    egovMultiPartEmail.send("goochunsa@naver.com", subject, emailCn);		

		
		
		
		
		//status.setComplete();
		return "forward:/cop/bbs/selectBoardList.do";
    }
    

    
    
    /**
     * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/addReplyBoardArticle.do")
    public String addReplyBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
	getLanguage(model, request);
    	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	BoardMasterVO master = new BoardMasterVO();
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId(user.getUniqId());

	master = bbsAttrbService.selectBBSMasterInf(vo);
	
	model.addAttribute("bdMstr", master);
	model.addAttribute("result", boardVO);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", master);
	////-----------------------------

	return "cop/bbs/EgovNoticeReply";
    }

    /**
     * 게시물에 대한 답변을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/replyBoardArticle.do")
    public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status, HttpServletRequest request) throws Exception {

    	//다국어 wbpark 2016.05.24    	HttpServletRequest request
    	getLanguage(model, request);
    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO vo = new BoardMasterVO();
		    
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setUniqId(user.getUniqId());
	
		    master = bbsAttrbService.selectBBSMasterInf(vo);
		    
		    model.addAttribute("bdMstr", master);
		    model.addAttribute("result", boardVO);
	
		    //----------------------------
		    // 기본 BBS template 지정 
		    //----------------------------
		    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
			master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
		    }
	
		    model.addAttribute("brdMstrVO", master);
		    ////-----------------------------
	
		    return "cop/bbs/EgovNoticeReply";
		}
	
		if (isAuthenticated) {
		    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    String atchFileId = "";
	
		    if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		    }
	
		    board.setAtchFileId(atchFileId);
		    board.setReplyAt("Y");
		    board.setFrstRegisterId(user.getUniqId());
		    board.setBbsId(board.getBbsId());
		    board.setParnts(Long.toString(boardVO.getNttId()));
		    board.setSortOrdr(boardVO.getSortOrdr());
		    board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
		    
		    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
//		    if("".equals(board.getPstinstCode())){
//		    	board.setPstinstCode(user.getPstinstCode());
//		    }
		    
		    bbsMngService.insertBoardArticle(board);
		}
		
		return "forward:/cop/bbs/selectBoardList.do";
		
    }

    /**
     * 게시물 수정을 위한 수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/forUpdateBoardArticle.do")
    public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo, ModelMap model, HttpServletRequest request)
	    throws Exception {

	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());
    	
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
	getLanguage(model, request);
    	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	boardVO.setFrstRegisterId(user.getUniqId());
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId(user.getUniqId());

	if (isAuthenticated) {
		bdvo = bbsMngService.selectBoardArticle(boardVO);
	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	}

	model.addAttribute("result", bdvo);
	model.addAttribute("bdMstr", bmvo);
	
	//권한코드
	model.addAttribute("authorCode", user.getAuthorCode());
	
	if("ROLE_ADMIN".equals(user.getAuthorCode()) ||
	   "ROLE_CHARGER".equals(user.getAuthorCode()) || 
	   "ROLE_MNGR".equals(user.getAuthorCode())){			//Admin, 담당자, 관리자
		//고객사정보
		PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
	}

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bmvo.getTmplatCours() == null || bmvo.getTmplatCours().equals("")) {
	    bmvo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", bmvo);
	////-----------------------------
	
	return "cop/bbs/EgovNoticeUpdt";
    }

    /**
     * 게시물에 대한 내용을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/updateBoardArticle.do")
    @ResponseBody
    public Map<String, Object> updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status, HttpServletRequest request) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
	//다국어 wbpark 2016.05.24    	HttpServletRequest request
		getLanguage(model, request);
	    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		try {
			String atchFileId = boardVO.getAtchFileId();

			beanValidator.validate(board, bindingResult);
			if (bindingResult.hasErrors()) {

//			    boardVO.setFrstRegisterId(user.getUniqId());
//			    
//			    BoardMaster master = new BoardMaster();
//			    BoardMasterVO bmvo = new BoardMasterVO();
//			    BoardVO bdvo = new BoardVO();
//			    
//			    master.setBbsId(boardVO.getBbsId());
//			    master.setUniqId(user.getUniqId());
//
//			    bmvo = bbsAttrbService.selectBBSMasterInf(master);
//			    bdvo = bbsMngService.selectBoardArticle(boardVO);
//
//			    model.addAttribute("result", bdvo);
//			    model.addAttribute("bdMstr", bmvo);
			    retMap.put("msgType", "E");
				retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
			    return retMap;
			}
			
			/*
			boardVO.setFrstRegisterId(user.getUniqId());
			BoardMaster _bdMstr = new BoardMaster();
			BoardMasterVO bmvo = new BoardMasterVO();
			BoardVO bdvo = new BoardVO();
			vo.setBbsId(boardVO.getBbsId());
			_bdMstr.setBbsId(boardVO.getBbsId());
			_bdMstr.setUniqId(user.getUniqId());

			if (isAuthenticated) {
			    bmvo = bbsAttrbService.selectBBSMasterInf(_bdMstr);
			    bdvo = bbsMngService.selectBoardArticle(boardVO);
			}
			//*/
			//List<MultipartFile> files = multiRequest.getFiles("files");

			if (isAuthenticated) {
			    //final Map<String, MultipartFile> files = multiRequest.getFileMap();
			    List<MultipartFile> files = multiRequest.getFiles("files");
			    if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
//				    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
//				    atchFileId = fileMngService.insertFileInfs(result);
//				    board.setAtchFileId(atchFileId);
					List<FileVO> result = fileUtil.parseFileList(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					board.setAtchFileId(atchFileId);
				} 
				else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    
				    //List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				    List<FileVO> _result = fileUtil.parseFileList(files, "BBS_", cnt, atchFileId, "");
				    fileMngService.updateFileInfs(_result);
				}
			    }

			    board.setLastUpdusrId(user.getUniqId());
			    
			    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지

			   	bbsMngService.updateBoardArticle(board);

			}
			retMap.put("msgType", "S");			
			retMap.put("msg", egovMessageSource.getMessage("success.common.update"));		
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
		}finally {
			
		}	
	
	
		return retMap;
    }

    /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/deleteBoardArticle.do")
    @ResponseBody
    public Map<String, Object> deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model, HttpServletRequest request) throws Exception {
    	Map<String, Object> retMap = new HashMap<String, Object>();
		//다국어 wbpark 2016.05.24    	HttpServletRequest request
		getLanguage(model, request);
	    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		try {
			if (isAuthenticated) {
			    board.setLastUpdusrId(user.getUniqId());
			    
			    bbsMngService.deleteBoardArticle(board);
			}			
			retMap.put("msgType", "S");			
			retMap.put("msg", egovMessageSource.getMessage("success.common.delete"));		
			
		}catch(Exception e) {
			e.printStackTrace();
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
		}finally {
			
		}
		
		
	
		return retMap;
    }

   
    /**
     * 템플릿에 대한 미리보기용 게시물 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/previewBoardList.do")
    public String previewBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	String template = boardVO.getSearchWrd();	// 템플릿 URL
	
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsNm("미리보기 게시판");

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	BoardVO target = null;
	List<BoardVO> list = new ArrayList<BoardVO>();
	
	target = new BoardVO();
	target.setNttSj("게시판 기능 설명");
	target.setFrstRegisterId("ID");
	target.setFrstRegisterNm("관리자");
	target.setFrstRegisterPnttm("2009-01-01");
	target.setInqireCo(7);
	target.setParnts("0");
	target.setReplyAt("N");
	target.setReplyLc("0");
	target.setUseAt("Y");
	
	list.add(target);
	
	target = new BoardVO();
	target.setNttSj("게시판 부가 기능 설명");
	target.setFrstRegisterId("ID");
	target.setFrstRegisterNm("관리자");
	target.setFrstRegisterPnttm("2009-01-01");
	target.setInqireCo(7);
	target.setParnts("0");
	target.setReplyAt("N");
	target.setReplyLc("0");
	target.setUseAt("Y");
	
	list.add(target);
	
	boardVO.setSearchWrd("");

	int totCnt = list.size();
	
	paginationInfo.setTotalRecordCount(totCnt);

	master.setTmplatCours(template);
	
	model.addAttribute("resultList", list);
	model.addAttribute("resultCnt", Integer.toString(totCnt));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	model.addAttribute("preview", "true");

	return "cop/bbs/EgovNoticeList";
    }
}
