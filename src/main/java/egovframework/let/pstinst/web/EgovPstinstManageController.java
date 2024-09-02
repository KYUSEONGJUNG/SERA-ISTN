package egovframework.let.pstinst.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.util.UriComponentsBuilder;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;
import com.squareup.okhttp.Address;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngService;
import egovframework.let.main.service.com.cmm.service.EgovFileMngUtil;
import egovframework.let.main.service.com.cmm.service.FileVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.Pstinst;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.pstinst.service.SrconnectVO;
import egovframework.let.pstinst.service.SrchargerVO;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.JSONObject;

//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;


/**
 * 
 * 고객사에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovPstinstManageController {
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;
	
	/** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

	@Autowired
	private DefaultBeanValidator beanValidator;
	
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
	/**
	 * 고객사 찾기 팝업 메인창을 호출한다.
	 * @param model
	 * @return "/pstinst/EgovPstinstSearchPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/pstinst/EgovPstinstSearchPopup.do")
 	public String callNormalCalPopup (ModelMap model
 			) throws Exception {
		return "/pstinst/EgovPstinstSearchPopup";
	}    
    		
    /**
	 * 고객사 찾기 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "/pstinst/EgovPstinstSearchList"
     * @throws Exception
     */
    @RequestMapping(value="/pstinst/EgovPstinstSearchList.do")
	public String selectPstinstSearchList (@ModelAttribute("searchVO") PstinstVO searchVO
			, ModelMap model
			) throws Exception {
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
		
		//사용자 검색용 고객은 삭제되지 안은것만 조회
		//searchVO.setSearchDelAt("N");
		
        model.addAttribute("resultList", pstinstManageService.selectPopupPstinstList(searchVO));
        
        int totCnt = pstinstManageService.selectPopupPstinstListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/pstinst/EgovPstinstSearchList";
	}
	
    /**
	 * 고객사 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/pstinst/EgovPstinstList"
     * @throws Exception
     */
    @RequestMapping(value="/pstinst/EgovPstinstList.do")
	public String selectPstinstList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") PstinstVO searchVO
			, ModelMap model
			) throws Exception {
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
		
        model.addAttribute("resultList", pstinstManageService.selectPstinstList(searchVO));
        
        int totCnt = pstinstManageService.selectPstinstListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList2(PstinstVO));
        
        return "/pstinst/EgovPstinstList";
	}
    
    
    @RequestMapping(value="/pstinst/EgovPstinstSelectDisplay.do")
    public String selectPstinstConnectView(@ModelAttribute("loginVO") LoginVO loginVO
    		,@ModelAttribute("pstinstVO") PstinstVO pstinstVO
    		,@ModelAttribute("srconnectVO") SrconnectVO srconnectVO
    		, ModelMap model
    		)throws Exception {
    	
    	
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
        //접속방법코드를 코드정보로부터 조회 - SR0010
        vo.setCodeId("SR0010");
        model.addAttribute("connMethodCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //운영코드 코드정보로부터 조회 - SR0011
        vo.setCodeId("SR0011");
        model.addAttribute("type_result", cmmUseService.selectCmmCodeDetail(vo));
        
        
        //고객사정보
        PstinstVO searchVO = new PstinstVO();
        List<Map> pstinstAllList = pstinstManageService.selectPstinstAllList2(searchVO);
		model.addAttribute("pstinstList", pstinstAllList);
		
		List<PstinstVO> searchList = new ArrayList<PstinstVO>();
    	if(pstinstVO.getPstinstCode().equals("ALL")){
    		for(Map map : pstinstAllList){
    			PstinstVO search = new PstinstVO();
    			search.setPstinstCode(map.get("pstinstCode").toString());
    			searchList.add(search);
    		}    		
    	}else if(pstinstVO.getPstinstCode().equals("")){
    		//do nothing
    	}
    	else{
    		searchList.add(pstinstVO);
    	}
    	    	
		List<Pstinst> pstinstList = new ArrayList<Pstinst>();
	
		Map<String, List<SrconnectVO>> srconnectList = new HashMap<String, List<SrconnectVO>>();
		for(Pstinst result : searchList){		
			result = pstinstManageService.selectPstinstDetail(result);
    		pstinstList.add(result);    		
    		String code = result.getPstinstCode();
    		code = code.replaceAll("\\s+", "");
    		srconnectVO.setPstinstCode(code);
            //접속 정보 목록
    		srconnectList.put(code, pstinstManageService.selectSrconnectList(srconnectVO));
		}

    	model.addAttribute("pstinstVO", pstinstList);
    	model.addAttribute("srconnectList", srconnectList);
		
    	return "/pstinst/EgovPstinstSelectDisplay";
    }
	/**
	 * 고객사정보 수정을 위해 사용자정보를 상세조회한다.
	 * @param loginVO
	 * @param pstinst
	 * @param model
	 * @return "/pstinst/EgovPstinstSelectUpdt"
	 * @throws Exception
	 */
	@RequestMapping(value="/pstinst/EgovPstinstSelectUpdtView.do")
 	public String updatePstinstView (@ModelAttribute("loginVO") LoginVO loginVO
 			,@ModelAttribute("pstinst") Pstinst pstinst
 			,@ModelAttribute("searchVO") PstinstVO searchVO
 			,@ModelAttribute("pstinstVO") PstinstVO pstinstVO
 			,@ModelAttribute("srchargerVO") SrchargerVO srchargerVO
 			,@ModelAttribute("srconnectVO") SrconnectVO srconnectVO
 			,@ModelAttribute("userManageVO") UserManageVO userManageVO
 			, ModelMap model
 			) throws Exception {
		
		
		String pstinstId = pstinst.getPstinstCode();
		
		if(!pstinstId.equals("")) {
			//고객사정보
	    	Pstinst result = pstinstManageService.selectPstinstDetail(pstinst);
	    	
	    	String remark = result.getRemark();
	    	
	    	if(remark != null ) {
	    		if(!remark.equals("")) {
		    		String newRemark = remark.replaceAll("&amp;", "&").replaceAll("&lt;", "<").replaceAll("&gt;", ">");
		    		
		    		result.setRemark(newRemark);
	    		}
	    	}
			model.addAttribute("pstinstVO", result);
			
			//모듈담당자정보
			model.addAttribute("srchargerList", pstinstManageService.selectSrchargerList(srchargerVO));
			
	        //접속 정보 목록
	        model.addAttribute("srconnectList", pstinstManageService.selectSrconnectList(srconnectVO));
		} 
		
			
		//삭제여부코드를 코드정보로부터 조회 - COM002
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("COM002");
        model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //업종코드를 코드정보로부터 조회 - COM002
        vo.setCodeId("SR0002");
        model.addAttribute("jobCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //모듈코드를 코드정보로부터 조회 - SR0003
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //접속방법코드를 코드정보로부터 조회 - SR0010
        vo.setCodeId("SR0010");
        model.addAttribute("connMethodCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //운영코드 코드정보로부터 조회 - SR0011
        vo.setCodeId("SR0011");
        model.addAttribute("type_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //담당자 및 관리자 목록
        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
		

		return "/pstinst/EgovPstinstSelectUpdt";
	}
	
	/**
	 * 고객사를 수정한다.
	 * @param loginVO
	 * @param pstinst
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/pstinst/EgovPstinstModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/pstinst/EgovPstinstSelectUpdt.do")
    @ResponseBody
	public Map<String, Object> updatePstinst (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("pstinstVO") PstinstVO pstinstVO
			, @ModelAttribute("searchVO") PstinstVO searchVO
			, @ModelAttribute("srchargerVO") SrchargerVO srchargerVO
			, @ModelAttribute("srconnectVO") SrconnectVO srconnectVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			, HttpServletRequest request
			, final MultipartHttpServletRequest multiRequest
			) throws Exception {
    	
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	
    	try {
    		beanValidator.validate(pstinstVO, bindingResult);
        	if (bindingResult.hasErrors()){
        		retMap.put("msgType", "E");
				retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));

    		}else{
    			
    			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    			
    			String strPstinstAbrb = "";
    			strPstinstAbrb = pstinstManageService.strPstinstAbrb(pstinstVO);
    			
    			
    			if (pstinstVO.getContractTime().equals("")){
    				pstinstVO.setContractTime("0");
    			}			
    			
    			
    			//파일 처리
    		    String atchFileId = pstinstVO.getFileId();
    		    List<FileVO> result = null;
    		    List<FileVO> _result = null;
    		    //final Map<String, MultipartFile> files = multiRequest.getFileMap();
    		    List<MultipartFile> files = multiRequest.getFiles("files");
    		    if (!files.isEmpty()) {
    				if ("".equals(atchFileId)) {
    				    //List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
    					
    					result = fileUtil.parseFileList(files, "SR_", 0, "", "Globals.fileStorePathSr");
    				    atchFileId = fileMngService.insertFileInfs(result);
    				    pstinstVO.setFileId(atchFileId);
    				} else {
    				    FileVO fvo = new FileVO();
    				    fvo.setAtchFileId(atchFileId);
    				    int cnt = fileMngService.getMaxFileSN(fvo);
    				    //List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
    				    _result = fileUtil.parseFileList(files, "SR_", cnt, atchFileId, "Globals.fileStorePathSr");
    				    fileMngService.updateFileInfs(_result);
    				}
    			}
    		    
    		    String getPstinstCode = pstinstVO.getPstinstCode();
    		    
    		  //계약공수 데이터 타입으로 인한 초기화 처리
    		    if("".equals(getPstinstCode) || getPstinstCode.equals(null)) {
    		    	if("".equals(strPstinstAbrb) || strPstinstAbrb == null) {
        				pstinstVO.setCreatorId(user.getId());
        				pstinstVO.setNameDetails(srconnectVO.getNameDetails());
        				pstinstVO.setTypeCodes(srconnectVO.getTypeCodes());
        				pstinstVO.setSids(srconnectVO.getSids());
        				pstinstVO.setInss(srconnectVO.getInss());
        				pstinstVO.setIpAddrs(srconnectVO.getIpAddrs());
        				pstinstVO.setSapIds(srconnectVO.getSapIds());
        				pstinstVO.setSapPasswds(srconnectVO.getSapPasswds());
        				pstinstVO.setClients(srconnectVO.getClients());
        				
        				pstinstManageService.insertPstinst(pstinstVO);     				
        				
        			} else {
        				retMap.put("msgType", "E");
        				retMap.put("msg", "동일한 약어가 존재합니다.");
        				
        				return retMap;
        			}
    		    	
    		    } else {
    				//고객사를 수정한다.
    				pstinstVO.setEditorId(user.getId());
    		    	pstinstManageService.updatePstinst(pstinstVO);
    			}		
    		    
    			 	
    		    
    			
    	    	
    	    	//이전 접속정보를 삭제한다.
    	    	pstinstManageService.deleteSrconnect(srconnectVO);
    	    	
    	    	//접속정보를 저장한다
    	    	if(srconnectVO.getNameDetails() != null){
    	    		for(int i=0; i<srconnectVO.getNameDetails().length;i++){
    	    			srconnectVO.setNameDetail(srconnectVO.getNameDetails()[i]);
    	    			srconnectVO.setTypeCode(srconnectVO.getTypeCodes()[i]);
    	    			srconnectVO.setSid(srconnectVO.getSids()[i]);
    	    			srconnectVO.setIns(srconnectVO.getInss()[i]);
    	    			srconnectVO.setIpAddr(srconnectVO.getIpAddrs()[i]);
    	    			srconnectVO.setSapId(srconnectVO.getSapIds()[i]);
    	    			srconnectVO.setSapPasswd(srconnectVO.getSapPasswds()[i]);
    	    			srconnectVO.setClient(srconnectVO.getClients()[i]);
    	    			srconnectVO.setPstinstCode(pstinstVO.getPstinstCode());
    	    			
    	    			if("".equals(strPstinstAbrb) || strPstinstAbrb == null) {
    	    				pstinstManageService.insertSrconnectNew(srconnectVO);
    	    			} else {
    	    				pstinstManageService.insertSrconnect(srconnectVO);
    	    			}
    	    			
        				
    	    		}
    	    	}
    	    	
    	    	if(srchargerVO.getModuleCodes() != null || srchargerVO.getModuleCode() != null){
    	    		//이전 모듈담당자 전체를 삭제한다.
    	    		pstinstManageService.deleteSrcharger(srchargerVO);
    	    	}
    	    	
    	    	if(srchargerVO.getModuleCodes() != null){
    	    		
    	    		String [] moduleCodes = srchargerVO.getModuleCodes();
    	    		String [] userIdAs = srchargerVO.getUserIdAs();
    	    		String [] userIdBs = srchargerVO.getUserIdBs();
    	    		
    	    		srchargerVO.setPstinstCode(pstinstVO.getPstinstCode());	    		
    	    		
    	    		for(int i=0; i<srchargerVO.getModuleCodes().length; i++){	
    	    			
    	    			srchargerVO.setModuleCode(moduleCodes[i]);
    	    			if(!"".equals(userIdAs[i])){
    	    				srchargerVO.setMainAt("Y");		//정
    	    				srchargerVO.setUserId(userIdAs[i]);
    	    				srchargerVO.setCreatorId(user.getId());
    	    				srchargerVO.setEditorId(user.getId());
    	    				
    	    				pstinstManageService.insertSrcharger(srchargerVO);
    	    				
    	    			}
    	    			if(!"".equals(userIdBs[i])){
    	    				srchargerVO.setMainAt("N");		//부
    	    				srchargerVO.setUserId(userIdBs[i]);
    	    				srchargerVO.setCreatorId(user.getId());
    	    				srchargerVO.setEditorId(user.getId());
    	    				
    	    				pstinstManageService.insertSrcharger(srchargerVO);
    	    				
    	    			}
    	    			
    	    		}
    	    		
    	    	}
    	        
    	        //Exception 없이 진행시 수정성공메시지
    	    	//egovMessageSource.getMessage("success.common.select");
    	        //model.addAttribute("resultMsg", "success.common.update");
    	        
    	        if("".equals(strPstinstAbrb) || strPstinstAbrb == null) {
    	        	retMap.put("msg", egovMessageSource.getMessage("success.common.insert"));
    	        } else {
    	        	retMap.put("msg", egovMessageSource.getMessage("success.common.update"));
    	        }
    	        
    	        
    	        retMap.put("msgType", "S");
    	        
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");    		
    		retMap.put("msg",  egovMessageSource.getMessage("fail.common.update"));
    	}
    	
    	return retMap;
    }
    
    /**
     * 고객사등록화면으로 이동한다.
     * @param searchVO 검색조건정보
     * @param userManageVO 고객사초기화정보
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserInsert
     * @throws Exception
     */
    @RequestMapping("/psinst/EgovPsinstInsertView.do")
    public String insertUserView(
    		@ModelAttribute("pstinstVO") PstinstVO pstinstVO,
			@ModelAttribute("searchVO") PstinstVO searchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO,
            Model model
            )throws Exception {
    	
    	//담당자 및 관리자 목록
        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
        
        //삭제여부코드를 코드정보로부터 조회 - COM002
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("COM002");
        model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //업종코드를 코드정보로부터 조회 - COM002
        vo.setCodeId("SR0002");
        model.addAttribute("jobCode_result", cmmUseService.selectCmmCodeDetail(vo)); 
        
        //모듈코드를 코드정보로부터 조회 - SR0003
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        return "/pstinst/EgovPstinstRegist";
    }    
    
	/**
	 * 고객사를 등록한다.
	 * @param loginVO
	 * @param pstinst
	 * @param bindingResult
	 * @param model
	 * @return "/pstinst/EgovPstinstRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/pstinst/EgovPstinstRegist.do")
	public Map<String, Object> insertPstinst (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("pstinstVO") PstinstVO pstinstVO
			, @ModelAttribute("srchargerVO") SrchargerVO srchargerVO
			, @ModelAttribute("userManageVO") UserManageVO userManageVO
			, @ModelAttribute("srconnectVO") SrconnectVO srconnectVO
			, BindingResult bindingResult
			, ModelMap model
			, final MultipartHttpServletRequest multiRequest
			) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
	        beanValidator.validate(pstinstVO, bindingResult);
			if (bindingResult.hasErrors()){
	
			}else{
				
				//고객사 약어를 조회한다.
				String strPstinstAbrb = "";
				strPstinstAbrb = pstinstManageService.strPstinstAbrb(pstinstVO);
				if("".equals(strPstinstAbrb) || strPstinstAbrb == null){
					LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
					
					//계약공수 데이터 타입으로 인한 초기화 처리
					if (pstinstVO.getContractTime().equals("")){
						pstinstVO.setContractTime("0");
					}
					
					pstinstVO.setCreatorId(user.getId());
					pstinstManageService.insertPstinst(pstinstVO);
					
					//모듈별 담당자를 등록한다.
			    	if(srchargerVO.getModuleCodes() != null){
			    		
			    		String [] moduleCodes = srchargerVO.getModuleCodes();
			    		String [] userIdAs = srchargerVO.getUserIdAs();
			    		String [] userIdBs = srchargerVO.getUserIdBs();
			    		
			    		srchargerVO.setPstinstCode(pstinstVO.getPstinstCode());	    		
			    		
			    		for(int i=0; i<srchargerVO.getModuleCodes().length; i++){	
			    			
			    			srchargerVO.setModuleCode(moduleCodes[i]);
			    			if(!"".equals(userIdAs[i])){
			    				srchargerVO.setMainAt("Y");		//정
			    				srchargerVO.setUserId(userIdAs[i]);
			    				srchargerVO.setCreatorId(user.getId());
			    				srchargerVO.setEditorId(user.getId());
			    				
			    				pstinstManageService.insertSrcharger(srchargerVO);
			    				
			    			}
			    			if(!"".equals(userIdBs[i])){
			    				srchargerVO.setMainAt("N");		//부
			    				srchargerVO.setUserId(userIdBs[i]);
			    				srchargerVO.setCreatorId(user.getId());
			    				srchargerVO.setEditorId(user.getId());
			    				
			    				pstinstManageService.insertSrcharger(srchargerVO);
			    				
			    			}
			    			
			    		}
			    		
			    	}
			    	
			    	//접속정보를 저장한다
			    	if(srconnectVO.getNameDetails() != null){
			    		for(int i=0; i<srconnectVO.getNameDetails().length;i++){
			    			srconnectVO.setNameDetail(srconnectVO.getNameDetails()[i]);
			    			srconnectVO.setTypeCode(srconnectVO.getTypeCodes()[i]);
			    			srconnectVO.setSid(srconnectVO.getSids()[i]);
			    			srconnectVO.setIns(srconnectVO.getInss()[i]);
			    			srconnectVO.setIpAddr(srconnectVO.getIpAddrs()[i]);
			    			srconnectVO.setSapId(srconnectVO.getSapIds()[i]);
			    			srconnectVO.setSapPasswd(srconnectVO.getSapPasswds()[i]);
			    			srconnectVO.setClient(srconnectVO.getClients()[i]);
			    			
	
		    				pstinstManageService.insertSrconnect(srconnectVO);
			    		}
			    	}
			    	
			    	//파일 처리
				    String atchFileId = pstinstVO.getFileId();
				    List<FileVO> result = null;
				    List<FileVO> _result = null;
				    //final Map<String, MultipartFile> files = multiRequest.getFileMap();
				    List<MultipartFile> files = multiRequest.getFiles("files");
				    if (!files.isEmpty()) {
						if ("".equals(atchFileId)) {
						    //List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
							
							result = fileUtil.parseFileList(files, "SR_", 0, "", "Globals.fileStorePathSr");
						    atchFileId = fileMngService.insertFileInfs(result);
						    pstinstVO.setFileId(atchFileId);
						} else {
						    FileVO fvo = new FileVO();
						    fvo.setAtchFileId(atchFileId);
						    int cnt = fileMngService.getMaxFileSN(fvo);
						    //List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
						    _result = fileUtil.parseFileList(files, "SR_", cnt, atchFileId, "Globals.fileStorePathSr");
						    fileMngService.updateFileInfs(_result);
						}
					}
					
					//Exception 없이 진행시 성공메시지
					model.addAttribute("resultMsg", "success.common.insert");
				}else{
					
					//담당자 및 관리자 목록
			        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
					
					//에러메시지
					model.addAttribute("resultMsg", "success.common.abrvError");
					
					//삭제여부코드를 코드정보로부터 조회 - COM002
		    		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		            vo.setCodeId("COM002");
		            model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo));
		            
		            //업종코드를 코드정보로부터 조회 - COM002
		            vo.setCodeId("SR0002");
		            model.addAttribute("jobCode_result", cmmUseService.selectCmmCodeDetail(vo));
		            
		            //모듈코드를 코드정보로부터 조회 - SR0003
		            vo.setCodeId("SR0003");
		            model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
		            
				}
				
				
			}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}

        return retMap;
    }    
    
	/**
	 * 고객사를 삭제한다.
	 * @param loginVO
	 * @param pstinst
	 * @param model
	 * @return "forward:/pstinst/EgovPstinstList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/pstinst/EgovPstinstRemove.do")
    @ResponseBody
	public Map<String, Object> deletePstinst (@ModelAttribute("loginVO") LoginVO loginVO
			, Pstinst pstinst
			, ModelMap model
			) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		
    		pstinstManageService.deletePstinst(pstinst);
        	
        	//Exception 없이 진행시 성공메시지
            model.addAttribute("resultMsg", "success.common.delete");
            
            retMap.put("msgType", "S");
            retMap.put("msgT", egovMessageSource.getMessage("success.common.delete"));
    		
    		
    	} catch (Exception e) {
    		
    		e.printStackTrace();
    		
    		retMap.put("msgType", "E");
            retMap.put("msgT", egovMessageSource.getMessage("fail.common.delete"));
    	}
    	
    	
        return retMap;
	}
       
    /**
	 * 고객사별 모듈 담당자를 조회한다.
	 * @param loginVO
	 * @param pstinst
	 * @param model
	 * @return "/pstinst/EgovPstinstSelectUpdt"
	 * @throws Exception
	 */
	@RequestMapping(value="/pstinst/EgovPstinstChargerList.do")
 	public String EgovPstinstChargerList (@ModelAttribute("loginVO") LoginVO loginVO
 			,@ModelAttribute("srchargerVO") SrchargerVO srchargerVO
 			,@ModelAttribute("userManageVO") UserManageVO userManageVO
 			, ModelMap model
 			, HttpServletRequest request
 			) throws Exception {
		
    	//다국어 wbpark 2016.05.24    	
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
    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();		
		srchargerVO.setPstinstCode(user.getPstinstCode());
		
		//모듈담당자정보
		model.addAttribute("srchargerList", pstinstManageService.selectSrchargerList(srchargerVO));
		
        //모듈코드를 코드정보로부터 조회 - SR0003
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("SR0003");
        model.addAttribute("moduleCode_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //담당자 및 관리자 목록
        model.addAttribute("chargerList", userManageService.selectChargerList(userManageVO));
		
		return "/pstinst/EgovPstinstChargerList";
	}

    /**
	 * 담당자별 고객사를 조회하는 페이지를 로드한다
	 * @param loginVO
	 * @return "/pstinst/EgovChargerPstinstListView"
	 * @throws Exception
	 */
	@RequestMapping(value="/pstinst/EgovChargerPstinstListView.do")
 	public String EgovChargerPstinstListView (@ModelAttribute("loginVO") LoginVO loginVO
 			, HttpServletRequest request
 			) throws Exception {
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();		

		return "/pstinst/EgovChargerPstinstListView";
	}
	

	
//	@RequestMapping(value="/pstinst/EgovChargerPstinstList.do")
//	@ResponseBody
//	public void EgovChargerPstinstList(@ModelAttribute("loginVO") LoginVO loginVO
// 									, HttpServletRequest request
// 									, HttpServletResponse response) throws Exception {
//
//		JSONParser parser = new JSONParser();
//
//		SrchargerVO srchargerVO = new SrchargerVO();
//		List<Map> result = pstinstManageService.selectChargerPstinstList(srchargerVO);
//
//		JSONArray jsonArray = new JSONArray();
//		
//		for(Map map : result){
//			jsonArray.add(convertMapToJson(map));
//		}    		
//		
//
//		String jsonString = jsonArray.toJSONString();
//		response.setHeader("Content-Type", "application/xml"); 
//		response.setContentType("text/xml;charset=UTF-8"); 
//		response.setCharacterEncoding("utf-8");
//		response.getWriter().print(jsonString);
//
//
//	}
//	
//	public static JSONObject convertMapToJson(Map<String, Object> map) {
//
//
//	    JSONObject json = new JSONObject();
//	    for (Map.Entry<String, Object> entry : map.entrySet()) {
//	        String key = entry.getKey();
//	        Object value = entry.getValue();
//	        json.put(key, value);
//	    }
//	    return json;
//	}
	
	
	
	/**
	 * 고객사 찾기 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "/pstinst/EgovPstinstSearchList"
     * @throws Exception
     */
    @RequestMapping(value="/select/pstinst/EgovPstinstSearchList.do")
    @ResponseBody
	public Map<String, Object> selectPstinstSearchListGrid (@ModelAttribute("searchVO") PstinstVO searchVO
			, ModelMap model
			) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
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
		
		//사용자 검색용 고객은 삭제되지 안은것만 조회
		//searchVO.setSearchDelAt("N");
		
        model.addAttribute("resultList", pstinstManageService.selectPstinstList(searchVO));
        retMap.put("resultList", pstinstManageService.selectPstinstList(searchVO));
        
        int totCnt = pstinstManageService.selectPstinstListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
        
        return retMap;
	}
    

    
    /**
     * 우편번호 주소 검색 API 통신
     *
     * @param request
     * @param response
     * @param dataRequest
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/select/pstinst/EgovPstinstAddress.do")
    @ResponseBody
    public Map<String, Object> addrSearch(HttpServletRequest request, HttpServletResponse response, @RequestParam String keyword, @RequestParam String currentPage) throws Exception {
        BufferedReader br = null;
        
        Map<String, Object> result = new HashMap<String,Object>();
        Map<String, Object> resultData = new HashMap<String,Object>();
        Map<String, Object> juso = new HashMap<String,Object>();
        
        try {
            //localhost 2022-04-10까지
        	//String url = "https://business.juso.go.kr/addrlink/addrLinkUrl.do";
        	//String confmKey = "devU01TX0FVVEgyMDI0MDMxOTE0NTA0MDExNDYxMDk=";
        	//String confmKey = "devU01TX0FVVEgyMDI0MDMxOTE0NDgxMjExNDYxMDg=";
        	
            String confirm_key = propertiesService.getString("addr.confirmKey");
            //String currentPage = "1";
            String countPerPage = "10";
            String resultType = "json";

            //Map<String, String> dmParam = dataRequest.getParameterGroup("dmParam").getSingleValueMap();;
            //currentPage = "1";
            countPerPage = "10";
            //keyword = "산본천로";

            //공공 도로명주소 API
            String apiUrl = "https://business.juso.go.kr/addrlink/addrLinkApi.do";
            apiUrl = apiUrl+"?confmKey="+confirm_key+"&currentPage="+currentPage+"&countPerPage="+countPerPage;
            apiUrl = apiUrl+"&keyword="+keyword+"&resultType="+resultType;

            URL url = new URL(apiUrl);
            br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
            StringBuffer sb = new StringBuffer();
            String tempStr = null;

            while(true) {
                tempStr = br.readLine();
                if(tempStr == null) break;
                sb.append(tempStr);
            }
            br.close();
            
            JSONObject jsonObj = new JSONObject(sb.toString());
           
        	result = (Map<String, Object>) jsonObj.toMap().get("results");
        	
        	resultData = (Map<String, Object>) result.get("common");
        	
        	if(resultData.get("totalCount").equals("0")) {
        		result.put("juso", "");
        	}
            

        } catch (Exception e) {
        	
        	
            
        } finally {
            if(br != null) br.close();
        }

        // datamap 내려주기 다건 데이타
        
        return result;
    }
    
    /**
	 * 고객사를 수정한다.
	 * @param loginVO
	 * @param pstinst
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/pstinst/EgovPstinstModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/select/pstinst/EgovPstinstSelectUpdt.do")
    @ResponseBody
	public Map<String, Object> updatePstinstAjax (@ModelAttribute("pstinstVO") PstinstVO pstinstVO
			, @ModelAttribute("searchVO") PstinstVO searchVO
			, @ModelAttribute("srchargerVO") SrchargerVO srchargerVO
			, @ModelAttribute("srconnectVO") SrconnectVO srconnectVO
			, BindingResult bindingResult
			, Map commandMap
			, HttpServletRequest request
			, final MultipartHttpServletRequest multiRequest
			) throws Exception {
    	
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		beanValidator.validate(pstinstVO, bindingResult);
        	if (bindingResult.hasErrors()){
        		//삭제여부코드를 코드정보로부터 조회 - COM002
        		ComDefaultCodeVO vo = new ComDefaultCodeVO();
                vo.setCodeId("COM002");
                retMap.put("delAt_result", cmmUseService.selectCmmCodeDetail(vo));
                
                //업종코드를 코드정보로부터 조회 - COM002
                vo.setCodeId("SR0002");
                retMap.put("jobCode_result", cmmUseService.selectCmmCodeDetail(vo)); 
                
                retMap.put("msgType", "E");
                
        		//return "/pstinst/EgovPstinstSelectUpdt";
    		}else{
    			
    			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    			
    			String strPstinstAbrb = "";
    			strPstinstAbrb = pstinstManageService.strPstinstAbrb(pstinstVO);
    			
    			//계약공수 데이터 타입으로 인한 초기화 처리
    			if (pstinstVO.getContractTime().equals("")){
    				pstinstVO.setContractTime("0");
    			}
    			
    			
    			if("".equals(strPstinstAbrb) || strPstinstAbrb == null) {
    				// 고객사 추가
    				pstinstVO.setCreatorId(user.getId());
    				pstinstVO.setNameDetails(srconnectVO.getNameDetails());
    				pstinstVO.setTypeCodes(srconnectVO.getTypeCodes());
    				pstinstVO.setSids(srconnectVO.getSids());
    				pstinstVO.setInss(srconnectVO.getInss());
    				pstinstVO.setIpAddrs(srconnectVO.getIpAddrs());
    				pstinstVO.setSapIds(srconnectVO.getSapIds());
    				pstinstVO.setSapPasswds(srconnectVO.getSapPasswds());
    				pstinstVO.setClients(srconnectVO.getClients());
    				
    				pstinstManageService.insertPstinst(pstinstVO);    				
    				
    			} else {
    				//고객사를 수정한다.
    				pstinstVO.setEditorId(user.getId());
    		    	pstinstManageService.updatePstinst(pstinstVO);
    			}			
    			
    			
    			
    			//파일 처리
    		    String atchFileId = pstinstVO.getFileId();
    		    List<FileVO> result = null;
    		    List<FileVO> _result = null;
    		    //final Map<String, MultipartFile> files = multiRequest.getFileMap();
    		    List<MultipartFile> files = multiRequest.getFiles("files");
    		    if (!files.isEmpty()) {
    				if ("".equals(atchFileId)) {
    				    //List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
    					
    					result = fileUtil.parseFileList(files, "SR_", 0, "", "Globals.fileStorePathSr");
    				    atchFileId = fileMngService.insertFileInfs(result);
    				    pstinstVO.setFileId(atchFileId);
    				} else {
    				    FileVO fvo = new FileVO();
    				    fvo.setAtchFileId(atchFileId);
    				    int cnt = fileMngService.getMaxFileSN(fvo);
    				    //List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
    				    _result = fileUtil.parseFileList(files, "SR_", cnt, atchFileId, "Globals.fileStorePathSr");
    				    fileMngService.updateFileInfs(_result);
    				}
    			}
    		    
    			
    	    	
    	    	//이전 접속정보를 삭제한다.
    	    	pstinstManageService.deleteSrconnect(srconnectVO);
    	    	
    	    	//접속정보를 저장한다
    	    	if(srconnectVO.getNameDetails() != null){
    	    		for(int i=0; i<srconnectVO.getNameDetails().length;i++){
    	    			srconnectVO.setNameDetail(srconnectVO.getNameDetails()[i]);
    	    			srconnectVO.setTypeCode(srconnectVO.getTypeCodes()[i]);
    	    			srconnectVO.setSid(srconnectVO.getSids()[i]);
    	    			srconnectVO.setIns(srconnectVO.getInss()[i]);
    	    			srconnectVO.setIpAddr(srconnectVO.getIpAddrs()[i]);
    	    			srconnectVO.setSapId(srconnectVO.getSapIds()[i]);
    	    			srconnectVO.setSapPasswd(srconnectVO.getSapPasswds()[i]);
    	    			srconnectVO.setClient(srconnectVO.getClients()[i]);

        				pstinstManageService.insertSrconnect(srconnectVO);
    	    		}
    	    	}
    	    	
    	    	if(srchargerVO.getModuleCodes() != null || srchargerVO.getModuleCode() != null){
    	    		//이전 모듈담당자 전체를 삭제한다.
    	    		pstinstManageService.deleteSrcharger(srchargerVO);
    	    	}
    	    	
    	    	if(srchargerVO.getModuleCodes() != null){
    	    		
    	    		String [] moduleCodes = srchargerVO.getModuleCodes();
    	    		String [] userIdAs = srchargerVO.getUserIdAs();
    	    		String [] userIdBs = srchargerVO.getUserIdBs();
    	    		
    	    		srchargerVO.setPstinstCode(pstinstVO.getPstinstCode());	    		
    	    		
    	    		for(int i=0; i<srchargerVO.getModuleCodes().length; i++){	
    	    			
    	    			srchargerVO.setModuleCode(moduleCodes[i]);
    	    			if(!"".equals(userIdAs[i])){
    	    				srchargerVO.setMainAt("Y");		//정
    	    				srchargerVO.setUserId(userIdAs[i]);
    	    				srchargerVO.setCreatorId(user.getId());
    	    				srchargerVO.setEditorId(user.getId());
    	    				
    	    				pstinstManageService.insertSrcharger(srchargerVO);
    	    				
    	    			}
    	    			if(!"".equals(userIdBs[i])){
    	    				srchargerVO.setMainAt("N");		//부
    	    				srchargerVO.setUserId(userIdBs[i]);
    	    				srchargerVO.setCreatorId(user.getId());
    	    				srchargerVO.setEditorId(user.getId());
    	    				
    	    				pstinstManageService.insertSrcharger(srchargerVO);
    	    				
    	    			}
    	    			
    	    		}
    	    		
    	    	}
    	        
    	        //Exception 없이 진행시 수정성공메시지
    	    	//egovMessageSource.getMessage("success.common.select");
    	        
    	        retMap.put("msgType", "S");
    	        
    	        if("".equals(strPstinstAbrb) || strPstinstAbrb == null) {
    	        	retMap.put("msg", egovMessageSource.getMessage("success.common.select"));
    	        }else {
    	        	retMap.put("msg", egovMessageSource.getMessage("success.common.update"));
    	        }
    	        
    	        //return "forward:/pstinst/EgovPstinstList.do";
    	        
    		}
        	
        	return retMap;
        	
    	}catch(Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
    		return retMap;
    	}
    	
    }
    
    @RequestMapping(value="/select/EgovPstinstSelectDisplay.do")
    @ResponseBody
    public Map<String, Object> selectPstinstConnectViewSearch(@ModelAttribute("loginVO") LoginVO loginVO
    		,@ModelAttribute("pstinstVO") PstinstVO pstinstVO
    		,@ModelAttribute("srconnectVO") SrconnectVO srconnectVO
    		, ModelMap model
    		)throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		ComDefaultCodeVO vo = new ComDefaultCodeVO();
            //접속방법코드를 코드정보로부터 조회 - SR0010
            vo.setCodeId("SR0010");
            model.addAttribute("connMethodCode_result", cmmUseService.selectCmmCodeDetail(vo));
            retMap.put("connMethodCode_result", cmmUseService.selectCmmCodeDetail(vo));
            
            //운영코드 코드정보로부터 조회 - SR0011
            vo.setCodeId("SR0011");
            model.addAttribute("type_result", cmmUseService.selectCmmCodeDetail(vo));
            retMap.put("type_result", cmmUseService.selectCmmCodeDetail(vo));
            
            
            //고객사정보
            PstinstVO searchVO = new PstinstVO();
            List<Map> pstinstAllList = pstinstManageService.selectPstinstAllList2(searchVO);
    		model.addAttribute("pstinstList", pstinstAllList);
    		retMap.put("pstinstList", pstinstAllList);
    		
    		List<PstinstVO> searchList = new ArrayList<PstinstVO>();
        	if(pstinstVO.getPstinstCode().equals("ALL")){
        		for(Map map : pstinstAllList){
        			PstinstVO search = new PstinstVO();
        			search.setPstinstCode(map.get("pstinstCode").toString());
        			searchList.add(search);
        		}    		
        	}else if(pstinstVO.getPstinstCode().equals("")){
        		//do nothing
        	}
        	else{
        		searchList.add(pstinstVO);
        	}
        	    	
    		List<Pstinst> pstinstList = new ArrayList<Pstinst>();
    	
    		Map<String, List<SrconnectVO>> srconnectList = new HashMap<String, List<SrconnectVO>>();
    		for(Pstinst result : searchList){		
    			result = pstinstManageService.selectPstinstDetail(result);
        		pstinstList.add(result);    		
        		String code = result.getPstinstCode();
        		code = code.replaceAll("\\s+", "");
        		srconnectVO.setPstinstCode(code);
                //접속 정보 목록
        		srconnectList.put(code, pstinstManageService.selectSrconnectList(srconnectVO));
    		}

        	model.addAttribute("pstinstVO", pstinstList);
        	model.addAttribute("srconnectList", srconnectList);
        	
        	retMap.put("pstinstVO", pstinstList);
        	retMap.put("srconnectList", srconnectList);
        	
        	retMap.put("msgType", "S");
    		
    	} catch (Exception e) {
    		
    		retMap.put("msgType", "E");
    		retMap.put("msg", "오류가 발생하였습니다.");
    		
    	}
		
    	return retMap;
    }
    
}