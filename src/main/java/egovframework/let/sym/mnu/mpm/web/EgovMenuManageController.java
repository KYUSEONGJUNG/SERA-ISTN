package egovframework.let.sym.mnu.mpm.web;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.main.service.com.cmm.ComDefaultVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;
import egovframework.let.sym.prm.service.EgovProgrmManageService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/** 
 * 메뉴목록 관리및 메뉴생성, 사이트맵 생성을 처리하는 비즈니스 구현 클래스
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *	 2011.07.01	 서준식	   메뉴정보 삭제시 참조되고 있는 하위 메뉴가 있는지 체크하는 로직 추가
 *	 2011.07.27	 서준식	   deleteMenuManageList() 메서드에서 메뉴 멀티 삭제 버그 수정
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 * </pre>
 */
@Controller
public class EgovMenuManageController {

	protected Log log = LogFactory.getLog(this.getClass());
	/* Validator */
	@Autowired
	private DefaultBeanValidator beanValidator;
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

    /** EgovMenuManageService */
	@Resource(name = "progrmManageService")	
	private EgovProgrmManageService progrmManageService;
	
	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;	

   
    /**
     * 메뉴정보목록을 상세화면 호출 및 상세조회한다. 
     * @param req_menuNo  String
     * @return 출력페이지정보 "sym/mnu/mpm/EgovMenuDetailSelectUpdt"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuManageListDetailSelect.do")
    public String selectMenuManage(
    		@RequestParam("req_menuNo") String req_menuNo ,
    		@ModelAttribute("searchVO") MenuManageVO searchVO, 
    		ModelMap model)
            throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated==null || !isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
    	
    	if(!req_menuNo.equals("empty")) {
    		searchVO.setSearchKeyword(req_menuNo);
        	
        	MenuManageVO resultVO = menuManageService.selectMenuManage(searchVO);
            model.addAttribute("menuManageVO", resultVO);
    	}   	

        return "sym/mnu/mpm/EgovMenuDetailSelectUpdt";
    }
	
    /**
     * 메뉴목록 리스트조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mnu/mpm/EgovMenuManage"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuManageSelect.do")
    public String selectMenuManageList(
    		@ModelAttribute("searchVO") MenuManageVO searchVO, 
    		ModelMap model)
            throws Exception { 
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated==null || !isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
    	// 내역 조회
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
		
		model.addAttribute("list_menumanage", menuManageService.selectMenuManageList(searchVO));
        
        int totCnt = menuManageService.selectMenuManageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
      	return "sym/mnu/mpm/EgovMenuManage";
    }

    /**
     * 메뉴목록 멀티 삭제한다. 
     * @param checkedMenuNoForDel  String
     * @return 출력페이지정보 "forward:/sym/mnu/mpm/EgovMenuManageSelect.do"
     * @exception Exception
     */
    @RequestMapping("/sym/mnu/mpm/EgovMenuManageListDelete.do")
    @ResponseBody
    public Map<String, Object> deleteMenuManageList(
            @RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel ,
            @ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
            ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		// 0. Spring Security 사용자권한 처리
        	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        	if(isAuthenticated==null || !isAuthenticated) {
        		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
            	//return "uat/uia/EgovLoginUsr";
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage("fail.common.login"));
        	}
    		String sLocationUrl = null;
        	String resultMsg    = "";
        	
    		String [] delMenuNo = checkedMenuNoForDel.split(",");
    		menuManageVO.setMenuNo(Integer.parseInt(delMenuNo[0]));
    		
    		if (menuManageService.selectUpperMenuNoByPk(menuManageVO) != 0){ 
        		resultMsg = egovMessageSource.getMessage("fail.common.delete.upperMenuExist");
        		sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
    		}else if (delMenuNo == null || (delMenuNo.length ==0)){ 
        		resultMsg = egovMessageSource.getMessage("fail.common.delete");
        		sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
    		}else{
    			menuManageService.deleteMenuManageList(checkedMenuNoForDel);
    			resultMsg = egovMessageSource.getMessage("success.common.delete");
    			sLocationUrl ="forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
    		}
    		model.addAttribute("resultMsg", resultMsg);
    		
    		retMap.put("msgType", "S");
    		retMap.put("msg", resultMsg);
    		
    	} catch(Exception e) {
    		e.printStackTrace();
    		
    		retMap.put("msgType", "S");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
    	}
    	
        return retMap;
    }
    
    /**
     * 메뉴정보를 등록화면으로 이동 및 등록 한다. 
     * @param menuManageVO    MenuManageVO
     * @param commandMap      Map
     * @return 출력페이지정보 등록화면 호출시 "sym/mnu/mpm/EgovMenuRegist",
     *         출력페이지정보 등록처리시 "forward:/sym/mnu/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuRegistInsert.do")
    @ResponseBody
    public Map<String, Object> insertMenuManage(
    		Map commandMap, 
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		String sLocationUrl = null;
        	String resultMsg    = "";
            // 0. Spring Security 사용자권한 처리
        	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        	if(isAuthenticated==null || !isAuthenticated) {
        		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage("fail.common.login"));
            	//return "uat/uia/EgovLoginUsr";
        	}
            String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
    		//if(sCmd.equals("insert")){
                beanValidator.validate(menuManageVO, bindingResult);
        		if (bindingResult.hasErrors()){
        			sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
        			//return sLocationUrl;
        			retMap.put("msgType", "E");
        			retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
        		}
        		if(menuManageService.selectMenuNoByPk(menuManageVO) == 0){
        			ComDefaultVO searchVO = new ComDefaultVO();
        			searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
        			if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
        	    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
        		        sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
        		        retMap.put("msgType", "E");
        			}else{
        	        	menuManageService.insertMenuManage(menuManageVO);
                		resultMsg = egovMessageSource.getMessage("success.common.insert");
        		        sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
        		        retMap.put("msgType", "S");
        			}
        		}else{
            		resultMsg = egovMessageSource.getMessage("common.isExist.msg");
            		sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
            		retMap.put("msgType", "E");
        		}
        		model.addAttribute("resultMsg", resultMsg);
        		
        		retMap.put("msg", resultMsg);
        		
    		//}else{
                //sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
            //}
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
    	}
    	
		
		return retMap; 
    } 

    /**
     * 메뉴정보를 수정 한다. 
     * @param menuManageVO  MenuManageVO
     * @return 출력페이지정보 "forward:/sym/mnu/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do")
    @ResponseBody
    public Map<String, Object> updateMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		String sLocationUrl = null;
        	String resultMsg    = "";
        	// 0. Spring Security 사용자권한 처리
        	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        	if(isAuthenticated==null || !isAuthenticated) {
        		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage("fail.common.login"));
            	//return "uat/uia/EgovLoginUsr";
        	}
            beanValidator.validate(menuManageVO, bindingResult);
    		if (bindingResult.hasErrors()){
    			sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
    			//return sLocationUrl;
    			retMap.put("msgType", "E");
    			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    		}
    		ComDefaultVO searchVO = new ComDefaultVO();
    		searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
    		if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
        		resultMsg = egovMessageSource.getMessage("fail.common.update");
    	        sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageListDetailSelect.do";
    	        retMap.put("msgType", "E");
    		}else{
    			menuManageService.updateMenuManage(menuManageVO);
    	    	resultMsg = egovMessageSource.getMessage("success.common.update");
    	       	sLocationUrl = "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
    	       	retMap.put("msgType", "S");
    		}
        	model.addAttribute("resultMsg", resultMsg);
        	retMap.put("msg", resultMsg);
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    	}
    	
        
		return retMap; 
    }    

    /**
     * 메뉴정보를 삭제 한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "forward:/sym/mnu/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuManageDelete.do")
    @ResponseBody
    public Map<String, Object> deleteMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		String resultMsg    = "";
        	// 0. Spring Security 사용자권한 처리
        	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        	if(isAuthenticated==null || !isAuthenticated) {
        		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
            	//return "uat/uia/EgovLoginUsr";
        		
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage("fail.common.login"));
        	}
        	if (menuManageService.selectUpperMenuNoByPk(menuManageVO) != 0){ 
        		resultMsg = egovMessageSource.getMessage("fail.common.delete.upperMenuExist");
        		model.addAttribute("resultMsg", resultMsg);
        		//return "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
        		retMap.put("msgType", "E");
        		retMap.put("msg", resultMsg);
    		}
        	
        	menuManageService.deleteMenuManage(menuManageVO);
        	resultMsg = egovMessageSource.getMessage("success.common.delete");
        	String _MenuNm = "%";
        	menuManageVO.setMenuNm(_MenuNm);
        	model.addAttribute("resultMsg", resultMsg);
        	retMap.put("msgType", "S");
    		retMap.put("msg", resultMsg);
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
    	}
    	
    	
      	//return "forward:/sym/mnu/mpm/EgovMenuManageSelect.do";
    	return retMap;
    } 

        
    /*### 일괄처리 프로세스 ###*/

    /**
     * 메뉴생성 일괄삭제프로세스  
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "sym/mnu/mpm/EgovMenuBndeRegist" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuBndeAllDelete.do")
    public String menuBndeAllDelete(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated==null || !isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
    	menuManageService.menuBndeAllDelete();
    	resultMsg = egovMessageSource.getMessage("success.common.delete");
    	model.addAttribute("resultMsg", resultMsg);
        return "sym/mnu/mpm/EgovMenuBndeRegist";  
    }
    
    /**
     * 메뉴일괄등록화면 호출 및  메뉴일괄등록처리 프로세스  
     * @param commandMap    Map
     * @param menuManageVO  MenuManageVO
     * @param request       HttpServletRequest
     * @return 출력페이지정보 "sym/mnu/mpm/EgovMenuBndeRegist" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mnu/mpm/EgovMenuBndeRegist.do")
    public String menuBndeRegist(
    		Map commandMap, 
    		final HttpServletRequest request,
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
        String resultMsg = "";
        String sMessage  = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated==null || !isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
        if(sCmd.equals("bndeInsert")){
	    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file = null;
			InputStream fis = null;
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				try{
					file = entry.getValue();
					fis = file.getInputStream();
					if (!"".equals(file.getOriginalFilename())) {
						// 2011.10.07 업로드 파일에 대한 확장자를 체크
						if (file.getOriginalFilename().toLowerCase().endsWith(".xls")
								|| file.getOriginalFilename().toLowerCase().endsWith(".xlsx") ) {
							if(menuManageService.menuBndeAllDelete()){
								sMessage = menuManageService.menuBndeRegist(menuManageVO, fis);
					    	    resultMsg = sMessage;
							}else{
								resultMsg = egovMessageSource.getMessage("fail.common.msg");
								menuManageVO.setTmp_Cmd("EgovMenuBndeRegist Error!!");
						        model.addAttribute("resultVO", menuManageVO);
							}
						}else{
							//log.info("xls, xlsx 파일 타입만 등록이 가능합니다.");
							resultMsg = egovMessageSource.getMessage("fail.common.msg");
							model.addAttribute("resultMsg", resultMsg);
							return "egovframework/com/sym/mnu/mpm/EgovMenuBndeRegist";
						}
						// *********** 끝 ***********
						
					}else{
						resultMsg = egovMessageSource.getMessage("fail.common.msg");
					}
				
				}catch(Exception e){
					log.debug(e);
				}finally{
					try{
						if(fis != null){
							fis.close();
						}
					}catch(Exception ee){
						log.debug(ee);
					}finally{
						fis.close();
					}
				}
				
			}
			sLocationUrl = "sym/mnu/mpm/EgovMenuBndeRegist";
	    	model.addAttribute("resultMsg", resultMsg);
        }else{
            sLocationUrl = "sym/mnu/mpm/EgovMenuBndeRegist";
        }
    	return sLocationUrl; 
    }
    
    /**
     * 메뉴목록 리스트조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mnu/mpm/EgovMenuManage"
     * @exception Exception
     */
    @RequestMapping(value="/select/mnu/mpm/EgovMenuManageSelect.do")
    @ResponseBody
    public Map<String, Object> selectMenuManageListGrid(
    		@ModelAttribute("searchVO") MenuManageVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashedMap();
    	
    	// 내역 조회
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
		
		model.addAttribute("list_menumanage", menuManageService.selectMenuManageList(searchVO));
		retMap.put("resultList", menuManageService.selectMenuManageList(searchVO));
        
        int totCnt = menuManageService.selectMenuManageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		retMap.put("paginationInfo", paginationInfo);
    	
      	return retMap;
    }
        
}
