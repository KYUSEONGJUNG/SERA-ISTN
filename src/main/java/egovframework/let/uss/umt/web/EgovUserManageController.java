package egovframework.let.uss.umt.web;

import java.util.Collection;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.poifs.crypt.temp.AesZipFileZipEntrySource;
//import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.main.service.com.cmm.ComDefaultCodeVO;
import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.main.service.com.cmm.LoginVO;
import egovframework.let.main.service.com.cmm.service.EgovCmmUseService;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.pstinst.service.EgovPstinstManageService;
import egovframework.let.pstinst.service.PstinstVO;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import egovframework.let.sec.rgm.service.AuthorGroup;
import egovframework.let.sec.rgm.service.EgovAuthorGroupService;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;
import egovframework.let.utl.sim.service.EgovFileScrty;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.string.EgovObjectUtil;
import org.egovframe.rte.ptl.mvc.bind.annotation.CommandMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

//아래 추가 wbpark
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;


/**
 * 업무사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *	 2024.02.20  최대묵			전자정부 프레임워크 버전 업그레이드로 인한 소스변경
 * </pre>
 */
@Controller
public class EgovUserManageController {

	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	/** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    /** PstinstManageService */
    @Resource(name = "PstinstManageService")
    private EgovPstinstManageService pstinstManageService;
        
    /** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
    
    @Resource(name = "egovAuthorGroupService")
    private EgovAuthorGroupService egovAuthorGroupService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** Log Info */
    protected Log log = LogFactory.getLog(this.getClass());
    
    /** DefaultBeanValidator beanValidator */
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    /**
     * 사용자목록을 조회한다. (pageing)
     * @param searchVO 검색조건정보
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserManage
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/user/EgovUserManage.do")
    public String selectUserList(@ModelAttribute("searchVO") UserManageVO searchVO,
    		@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
            ModelMap model,
            HttpServletRequest request)
            throws Exception {
    	
//    	// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
//    	request.getSession().setAttribute("baseMenuNo","4000000");
    	
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
        
        //삭제여부 초기화
        if("".equals(searchVO.getSearchDelAt()) || searchVO.getSearchDelAt() == null){
        	searchVO.setSearchDelAt("N");
        }
        
        model.addAttribute("resultList", userManageService.selectUserList(searchVO));
        
        int totCnt = userManageService.selectUserListTotCnt(searchVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        //사용자상태코드를 코드정보로부터 조회
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("COM013");
        model.addAttribute("emplyrSttusCode_result",cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
        
        //삭제여부코드를 코드정보로부터 조회 - COM002
        vo.setCodeId("COM002");
        model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo)); 
        
        //권한코드
        authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
        
        return "cmm/uss/umt/EgovUserManage";
    } 
    
    /**
     * 사용자등록화면으로 이동한다.
     * @param searchVO 검색조건정보
     * @param userManageVO 사용자초기화정보
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserInsert
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovUserInsertView.do")
    public String insertUserView(
            @ModelAttribute("searchVO") UserManageVO searchVO,
            @ModelAttribute("userManageVO") UserManageVO userManageVO,
            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
            Model model
            )throws Exception {
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        
        //패스워드힌트목록을 코드정보로부터 조회
        vo.setCodeId("COM022");
        model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));     //패스워트힌트목록
        
        //권한코드
        authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
        
//        //사용자상태코드를 코드정보로부터 조회
//        vo.setCodeId("COM013");
//        model.addAttribute("emplyrSttusCode_result",cmmUseService.selectCmmCodeDetail(vo));
//        
//        //소속기관코드를 코드정보로부터 조회 - COM025
//        vo.setCodeId("COM025");
//        model.addAttribute("insttCode_result", cmmUseService.selectCmmCodeDetail(vo)); 
//        
//        //조직정보를 조회 - ORGNZT_ID정보
//        vo.setTableNm("LETTNORGNZTINFO");
//        model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
//        
//        //그룹정보를 조회 - GROUP_ID정보
//        vo.setTableNm("LETTNORGNZTINFO");
//        model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
        
        return "cmm/uss/umt/EgovUserInsert";
    }
    
    /**
     * 사용자등록처리후 목록화면으로 이동한다.
     * @param userManageVO 사용자등록정보
     * @param bindingResult 입력값검증용 bindingResult
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovUserInsert.do")
    @ResponseBody
    public Map<String, Object> insertUser(
            @ModelAttribute("userManageVO") UserManageVO userManageVO,
            @ModelAttribute("authorGroup") AuthorGroup authorGroup,
            BindingResult bindingResult,
            Model model
            )throws Exception {
        
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		beanValidator.validate(userManageVO, bindingResult);
        	if (bindingResult.hasErrors()){
        		//return "cmm/uss/umt/EgovUserInsert";
                
                retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
                
    		}else{
    			
    			userManageService.insertUser(userManageVO);
    			
    			//권한등록
    			authorGroup.setUniqId(userManageVO.getUniqId());
    			authorGroup.setMberTyCode("USR03");
    			authorGroup.setAuthorCode(userManageVO.getAuthorCode());
    			egovAuthorGroupService.insertAuthorGroup(authorGroup);
    			
    			//Exception 없이 진행시 등록성공메시지
    	        //model.addAttribute("resultMsg", "success.common.insert");
    	        
    	        retMap.put("msgType", "S");
        		retMap.put("msg",  egovMessageSource.getMessage("success.common.insert"));
    	        
    		}
        	//return "forward:/uss/umt/user/EgovUserManage.do";
    		
        	return retMap;
        	
    	}catch (Exception e) {
    		e.printStackTrace();
    		
    		retMap.put("msgType", "E");
    		retMap.put("msg",  egovMessageSource.getMessage("fail.common.insert"));
    		    		
    		return retMap;
    	}
    	
        
    }
    
    /**
     * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
     * @param uniqId 상세조회대상 사용자아이디
     * @param searchVO 검색조건
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserSelectUpdt
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovUserSelectUpdtView.do")
    public String updateUserView(
            @RequestParam("selectedId") String uniqId ,
            @ModelAttribute("searchVO") UserManageVO searchVO, Model model,
            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO)
            throws Exception {
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        
        //패스워드힌트목록을 코드정보로부터 조회
        vo.setCodeId("COM022");
        model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));
        
        //권한코드
        authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        
        //삭제여부코드를 코드정보로부터 조회 - COM002
        vo.setCodeId("COM002");
        model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo)); 
        
        UserManageVO userManageVO = new UserManageVO();
        //uniqId = searchVO.getUniqId();
        userManageVO = userManageService.selectUser(uniqId);
//        model.addAttribute("searchVO", searchVO);
        model.addAttribute("userManageVO", userManageVO);
        
        return "cmm/uss/umt/EgovUserSelectUpdt";
    }
    
    
    
    /**
     * 사용자정보 수정후 목록조회 화면으로 이동한다.
     * @param userManageVO 사용자수정정보
     * @param bindingResult 입력값검증용 bindingResult
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovUserSelectUpdt.do")
    @ResponseBody
    public Map<String, Object> updateUser(
            @ModelAttribute("userManageVO") UserManageVO userManageVO,
            @ModelAttribute("authorGroup") AuthorGroup authorGroup,
            BindingResult bindingResult,
            Model model
            )throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	
    	try {
    		
    		beanValidator.validate(userManageVO, bindingResult);
        	if (bindingResult.hasErrors()){
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
    		}else{
    			
    			if(userManageVO.getEmailYn()==null || ("").equals(userManageVO.getEmailYn())) {
    				int count = 0;
    				
    				count = userManageService.selectEmailYn(userManageVO);
    				
    				if(count == 0 ) {
    					retMap.put("msgType", "E");
    	        		retMap.put("msg", "반드시 한 사람은 관리자 알림 지정이 필요합니다.");
    	        		return retMap;
    				}
    			}
    			
    			//업무사용자 수정시 히스토리 정보를 등록한다.
    	        userManageService.insertUserHistory(userManageVO);
    	        userManageService.updateUser(userManageVO);
    	        
    	        //권한등록
    			authorGroup.setUniqId(userManageVO.getUniqId());
    			authorGroup.setMberTyCode("USR03");
    			authorGroup.setAuthorCode(userManageVO.getAuthorCode());
    	        if(userManageVO.getRegYn().equals("N")){
        		    egovAuthorGroupService.insertAuthorGroup(authorGroup);
    	        }else{ 
        		    egovAuthorGroupService.updateAuthorGroup(authorGroup);
        		}
    	        //Exception 없이 진행시 수정성공메시지
    	        //model.addAttribute("resultMsg", "success.common.update");
    	        retMap.put("msgType", "S");
    	        retMap.put("msg", egovMessageSource.getMessage("success.common.update"));
    		}
        	
    	
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    	}
    	
    	return retMap;
                
        
    }
    
    /**
     * 사용자정보삭제후 목록조회 화면으로 이동한다.
     * @param checkedIdForDel 삭제대상아이디 정보
     * @param searchVO 검색조건
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovUserDelete.do")
    @ResponseBody
    public Map<String, Object> deleteUser(
            @RequestParam("checkedIdForDel") String checkedIdForDel ,
            @ModelAttribute("searchVO") UserManageVO searchVO, Model model)
            throws Exception {
    	//log.debug("jjycon_delete-->"+checkedIdForDel);
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		userManageService.deleteUser(checkedIdForDel);
            //Exception 없이 진행시 등록성공메시지
            model.addAttribute("resultMsg", "success.common.delete");
            //return "forward:/uss/umt/user/EgovUserManage.do";
            retMap.put("msgType", "S");
    		retMap.put("msg", egovMessageSource.getMessage("success.common.delete"));
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
    	}
        
        return retMap;
    }
    
    /**
     * 입력한 사용자아이디의 중복확인화면 이동
     * @param model 화면모델
     * @return cmm/uss/umt/EgovIdDplctCnfirm
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/cmm/EgovIdDplctCnfirmView.do")
    public String checkIdDplct(ModelMap model)
            throws Exception {
        model.addAttribute("checkId", "");
        model.addAttribute("usedCnt", "-1");
        return "cmm/uss/umt/EgovIdDplctCnfirm";
    }
    
    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
     * @param commandMap 파라메터전달용 commandMap
     * @param model 화면모델
     * @return cmm/uss/umt/EgovIdDplctCnfirm
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/cmm/EgovIdDplctCnfirm.do")
    public String checkIdDplct(
    		Map<String, Object> commandMap,
            ModelMap model
            )throws Exception {
        
    	String checkId = (String)commandMap.get("checkId");
    	checkId =  new String(checkId.getBytes("ISO-8859-1"), "UTF-8");
        
    	if (checkId==null || checkId.equals("")) return "forward:/uss/umt/EgovIdDplctCnfirmView.do";
        
        int usedCnt = userManageService.checkIdDplct(checkId);
        model.addAttribute("usedCnt", usedCnt);
        model.addAttribute("checkId", checkId);
        
        return "cmm/uss/umt/EgovIdDplctCnfirm";
    }
    
    /**
     * 업무사용자 암호 수정처리 후 화면 이동
     * @param model 화면모델
     * @param commandMap 파라메터전달용 commandMap
     * @param searchVO 검색조 건
     * @param userManageVO 사용자수정정보(비밀번호)
     * @return cmm/uss/umt/EgovUserPasswordUpdt
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/user/EgovUserPasswordUpdt.do")
    @ResponseBody
    public Map<String, Object> updatePassword(ModelMap model, 
    		  					 @RequestParam Map<String, Object> commandMap,
    		  					 @ModelAttribute("searchVO") UserManageVO searchVO,
    		  					 @ModelAttribute("userManageVO") UserManageVO userManageVO) 
    							throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
        
        try {
        	
        	String oldPassword = (String)commandMap.get("oldPassword");
            String newPassword = (String)commandMap.get("newPassword");
            String newPassword2 = (String)commandMap.get("newPassword2");
            String uniqId = (String)commandMap.get("uniqId");
            
            boolean isCorrectPassword=false;
            UserManageVO resultVO = new UserManageVO();
            userManageVO.setPassword(newPassword);
            userManageVO.setOldPassword(oldPassword);
            userManageVO.setUniqId(uniqId);
            
            String resultMsg = "";
            
            SecurityContext context = SecurityContextHolder.getContext();
    		Authentication authentication = context.getAuthentication();
        	
        	if (EgovObjectUtil.isNull(authentication)) {
    			return null;
    		}
            // 2024.02.20 프레임워크 버전업으로 인한 소스 변경
            // ConfigAttributeDefinition ⇒ Collection<ConfigAttribute>
//    		GrantedAuthority[] authorities = authentication.getAuthorities();
//    		userManageVO.setAuthorSe("N");
//    		for (int i = 0; i < authorities.length; i++) {
//    			//권한여부(SR-관리자, Admin만 처리권한 부여)
//    			if ("ROLE_ADMIN".equals(authorities[i].getAuthority()) || "ROLE_MNGR".equals(authorities[i].getAuthority())) {
//    				userManageVO.setAuthorSe("Y");
//    				break;
//    			}
//    		}        
    		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) authentication.getAuthorities();
    		userManageVO.setAuthorSe("N");
    		
    		for (GrantedAuthority authority : authorities) {
    			if ("ROLE_ADMIN".equals(authority.getAuthority()) || "ROLE_MNGR".equals(authority.getAuthority())) {
    				userManageVO.setAuthorSe("Y");				
    				break;
    			}	
    		}
    		
            //SR-관리자및 Admin
            if (userManageVO.getAuthorSe() == "Y") {
            	isCorrectPassword = true;
            }else{
            	resultVO = userManageService.selectPassword(userManageVO);
            	//패스워드 암호화
            	String encryptPass = EgovFileScrty.encryptPassword(oldPassword);
            	if (encryptPass.equals(resultVO.getPassword())){
            		if (newPassword.equals(newPassword2)){
            			isCorrectPassword = true;
            		}else{
            			isCorrectPassword = false;
            			resultMsg="fail.user.passwordUpdate2";
            			retMap.put("msgType", "E");
            			retMap.put("msg", egovMessageSource.getMessage(resultMsg));
            		}
            	}else{
            		isCorrectPassword = false;
            		resultMsg="fail.user.passwordUpdate1";         		
            		retMap.put("msgType", "E");
        			retMap.put("msg", egovMessageSource.getMessage(resultMsg));
            	}
            }
            
        	
        	if (isCorrectPassword){
        		userManageVO.setPassword(EgovFileScrty.encryptPassword(newPassword));
        		userManageService.updatePassword(userManageVO);
                model.addAttribute("userManageVO", userManageVO);
                resultMsg = "success.common.update";
                
                retMap.put("msgType", "S");
    			retMap.put("msg", egovMessageSource.getMessage(resultMsg));
                
            }else{
            	model.addAttribute("userManageVO", userManageVO);      
            }
//        	model.addAttribute("searchVO", searchVO); 
//        	model.addAttribute("resultMsg", resultMsg);
        	
        	
        }catch (Exception e) {
        	e.printStackTrace();
        	retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.user.passwordUpdate2"));
        }
        
    	
		
		
        
        return retMap;
    }
    
    /**
     * 업무사용자 암호 수정  화면 이동
     * @param model 화면모델
     * @param commandMap 파라메터전달용 commandMap
     * @param searchVO 검색조건
     * @param userManageVO 사용자수정정보(비밀번호)
     * @return cmm/uss/umt/EgovUserPasswordUpdt
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/user/EgovUserPasswordUpdtView.do")
    public String updatePasswordView(ModelMap model, 
    								Map<String, Object> commandMap,
    								@ModelAttribute("searchVO") UserManageVO searchVO,
    								@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {
    	
    	SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		
		if (EgovObjectUtil.isNull(authentication)) {
			return null;
		}
		// 2024.02.20 프레임워크 버전업으로 인한 소스 변경
        // ConfigAttributeDefinition ⇒ Collection<ConfigAttribute>
//		GrantedAuthority[] authorities = authentication.getAuthorities();
//		userManageVO.setAuthorSe("N");
//		for (int i = 0; i < authorities.length; i++) {
//			//log.debug("########## EgovUserDetailsHelper.getAuthorities : Authority is " + authorities[i].getAuthority());
//
//			//권한여부(SR-관리자, Admin만 처리권한 부여)
//			if ("ROLE_ADMIN".equals(authorities[i].getAuthority()) || "ROLE_MNGR".equals(authorities[i].getAuthority())) {
//				userManageVO.setAuthorSe("Y");
//				break;
//			}
//		}
    	
		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) authentication.getAuthorities();
		userManageVO.setAuthorSe("N");
		
		for (GrantedAuthority authority : authorities) {
			if ("ROLE_ADMIN".equals(authority.getAuthority()) || "ROLE_MNGR".equals(authority.getAuthority())) {
				userManageVO.setAuthorSe("Y");				
				break;
			}	
		}
		
    	String userTyForPassword = (String)commandMap.get("userTyForPassword");
    	userManageVO.setUserTy(userTyForPassword);
    	
    	model.addAttribute("userManageVO", userManageVO);
//        model.addAttribute("searchVO", searchVO);
        
        
        
    	return "cmm/uss/umt/EgovUserPasswordUpdt";
    }
    
    /**
     * 고객(사용자)정보 수정을 위해 사용자정보를 상세조회한다.
     * @param uniqId 상세조회대상 사용자아이디
     * @param searchVO 검색조건
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserSelectUpdt
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovCstmrSelectUpdtView.do")
    public String updateCstmrView(
            @ModelAttribute("searchVO") UserManageVO searchVO, Model model, HttpServletRequest request, 
            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, @ModelAttribute("userManageVO") UserManageVO userManageVO)
            throws Exception {
        
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
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        
        //패스워드힌트목록을 코드정보로부터 조회
        vo.setCodeId("COM022");
        model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));
                
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        //UserManageVO userManageVO = new UserManageVO();
        userManageVO = userManageService.selectUser(user.getId());
//        model.addAttribute("searchVO", searchVO);
        model.addAttribute("userManageVO", userManageVO);
        
        return "cmm/uss/umt/EgovCstmrSelectUpdt";
    }
    
    /**
     * 고객(사용자) 수정후 목록조회 화면으로 이동한다.
     * @param userManageVO 사용자수정정보
     * @param bindingResult 입력값검증용 bindingResult
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovCstmrSelectUpdt.do")
    @ResponseBody
    public Map<String, Object> updateCstmr(
            @ModelAttribute("userManageVO") UserManageVO userManageVO,
            @ModelAttribute("authorGroup") AuthorGroup authorGroup,
            BindingResult bindingResult,
            Model model
            )throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		beanValidator.validate(userManageVO, bindingResult);
        	if (bindingResult.hasErrors()){
//        		ComDefaultCodeVO vo = new ComDefaultCodeVO();
//                
//                //패스워드힌트목록을 코드정보로부터 조회
//                vo.setCodeId("COM022");
//                model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));
//                
//        		return "cmm/uss/umt/EgovCstmrSelectUpdt";
        		retMap.put("msgType", "E");
        		retMap.put("msg", egovMessageSource.getMessage(bindingResult.getFieldError().getCode(),bindingResult.getFieldError().getArguments()));
        		
    		}else{
    			//업무사용자 수정시 히스토리 정보를 등록한다.
    	        userManageService.insertUserHistory(userManageVO);
    	        userManageService.updateUser(userManageVO);
    	        
    	        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();    	        

    			user.setEmail(userManageVO.getEmailAdres());
    			user.setName(userManageVO.getEmplyrNm());
    			user.setOffmTelno(userManageVO.getOffmTelno()); // 연락처(내선)
    			user.setMbtlnum(userManageVO.getMoblphonNo()); // 연락처(이동전화)

    	        //Exception 없이 진행시 수정성공메시지
    	        model.addAttribute("resultMsg", "success.common.update");
                // 2. 메인 페이지 이동
//    			return "forward:/cmm/main/mainPage.do";
    			//return "forward:/sr/EgovSrList.do";
    	        retMap.put("msgType", "S");
    	        retMap.put("msg", egovMessageSource.getMessage("success.common.update"));
    	        
    	        
    	        
    		}
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		
    		retMap.put("msgType", "S");
	        retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    	}
    	
    	return retMap;
    }
    
    /**
     * 고객(사용자) 암호 수정  화면 이동
     * @param model 화면모델
     * @param commandMap 파라메터전달용 commandMap
     * @param searchVO 검색조건
     * @param userManageVO 사용자수정정보(비밀번호)
     * @return cmm/uss/umt/EgovUserPasswordUpdt
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/user/EgovCstmrPasswordUpdtView.do")
    public String updateCstmrPasswordView(ModelMap model, 
    								Map<String, Object> commandMap,
    								@ModelAttribute("searchVO") UserManageVO searchVO,
    								@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {
    	
    	SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		
		if (EgovObjectUtil.isNull(authentication)) {
			return null;
		}
    	
    	String userTyForPassword = (String)commandMap.get("userTyForPassword");
    	userManageVO.setUserTy(userTyForPassword);
    	
    	model.addAttribute("userManageVO", userManageVO);
//        model.addAttribute("searchVO", searchVO);
        
    	return "cmm/uss/umt/EgovCstmrPasswordUpdt";
    }
    
    /**
     * 고객(사용자) 암호 수정처리 후 화면 이동
     * @param model 화면모델
     * @param commandMap 파라메터전달용 commandMap
     * @param searchVO 검색조 건
     * @param userManageVO 사용자수정정보(비밀번호)
     * @return cmm/uss/umt/EgovUserPasswordUpdt
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/user/EgovCstmrPasswordUpdt.do")
    @ResponseBody
    public Map<String, Object> updateCstmrPassword(ModelMap model, 
    		  					 @CommandMap Map<String, Object> commandMap,
    		  					 @ModelAttribute("searchVO") UserManageVO searchVO,
    		  					 @ModelAttribute("userManageVO") UserManageVO userManageVO) 
    							throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		String oldPassword = (String)commandMap.get("oldPassword");
            String newPassword = (String)commandMap.get("newPassword");
            String newPassword2 = (String)commandMap.get("newPassword2");
            String uniqId = (String)commandMap.get("uniqId");
            
            boolean isCorrectPassword=false;
            UserManageVO resultVO = new UserManageVO();
            userManageVO.setPassword(newPassword);
            userManageVO.setOldPassword(oldPassword);
            userManageVO.setUniqId(uniqId);
            
            String resultMsg = "";
            
        	SecurityContext context = SecurityContextHolder.getContext();
    		Authentication authentication = context.getAuthentication();
    		
    		if (EgovObjectUtil.isNull(authentication)) {
    			return null;
    		}
    		
        	resultVO = userManageService.selectPassword(userManageVO);
        	//패스워드 암호화
        	String encryptPass = EgovFileScrty.encryptPassword(oldPassword);
        	if (encryptPass.equals(resultVO.getPassword())){
        		if (newPassword.equals(newPassword2)){
        			isCorrectPassword = true;
        		}else{
        			isCorrectPassword = false;
        			resultMsg="fail.user.passwordUpdate2";
        			retMap.put("msgType", "E");
        		}
        	}else{
        		isCorrectPassword = false;
        		resultMsg="fail.user.passwordUpdate1";
        		retMap.put("msgType", "E");
        	}
            
        	
        	if (isCorrectPassword){
        		userManageVO.setPassword(EgovFileScrty.encryptPassword(newPassword));
        		userManageService.updatePassword(userManageVO);
                model.addAttribute("userManageVO", userManageVO);
                resultMsg = "success.common.update";
                retMap.put("msgType", "S");
            }else{
            	model.addAttribute("userManageVO", userManageVO);
            	retMap.put("msgType", "E");
            }
        	model.addAttribute("searchVO", searchVO); 
        	model.addAttribute("resultMsg", resultMsg);
        	retMap.put("msg", egovMessageSource.getMessage(resultMsg));
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.user.passwordUpdate2"));
    	}
    	
    	
        
//        return "cmm/uss/umt/EgovCstmrPasswordUpdt";
     // 2. 사용자정보 상세페이지로 이동
        //return "forward:/uss/umt/user/EgovCstmrSelectUpdtView.do";
    	return retMap;
    }    
    
    /**
     * 고객(사용자) 정보삭제후 목록조회 화면으로 이동한다.
     * @param checkedIdForDel 삭제대상아이디 정보
     * @param searchVO 검색조건
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @RequestMapping("/uss/umt/user/EgovCstmrDelete.do")
    @ResponseBody
    public Map<String, Object> deleteCstmr(
            @RequestParam("checkedIdForDel") String checkedIdForDel ,
            @ModelAttribute("searchVO") UserManageVO searchVO, Model model)
            throws Exception {
    	
    	Map <String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		//log.debug("jjycon_delete-->"+checkedIdForDel);
            userManageService.deleteUser(checkedIdForDel);
            //Exception 없이 진행시 등록성공메시지
            model.addAttribute("resultMsg", "success.common.delete");
            
            retMap.put("msgType", "S");
    		retMap.put("msg", egovMessageSource.getMessage("success.common.delete"));
    	}catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
    		retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
    	}  	
    	
        
        //return "forward:/uat/uia/egovLoginUsr.do";
        return retMap;
    }
    
    
    /**
     * 사용자목록을 조회한다. (pageing)
     * @param searchVO 검색조건정보
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserManage
     * @throws Exception
     */
    @RequestMapping(value="/select/umt/user/EgovUserManage.do")
    @ResponseBody
    public Map<String, Object> selectUserListGrid(@ModelAttribute("searchVO") UserManageVO searchVO,
    		@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
            ModelMap model,
            HttpServletRequest request)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();
    	
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
        
        //삭제여부 초기화
        if("".equals(searchVO.getSearchDelAt()) || searchVO.getSearchDelAt() == null){
        	searchVO.setSearchDelAt("N");
        }
        
        model.addAttribute("resultList", userManageService.selectUserList(searchVO));
        retMap.put("resultList", userManageService.selectUserList(searchVO));
        
        int totCnt = userManageService.selectUserListTotCnt(searchVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
        
        //사용자상태코드를 코드정보로부터 조회
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("COM013");
        model.addAttribute("emplyrSttusCode_result",cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
        retMap.put("emplyrSttusCode_result",cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
        
        //삭제여부코드를 코드정보로부터 조회 - COM002
        vo.setCodeId("COM002");
        model.addAttribute("delAt_result", cmmUseService.selectCmmCodeDetail(vo)); 
        retMap.put("delAt_result", cmmUseService.selectCmmCodeDetail(vo)); 
        
        //권한코드
//        authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
//        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
//        retMap.put("authorManageList", authorManageVO.getAuthorManageList());
        
        //고객사정보
        PstinstVO PstinstVO = new PstinstVO();
		model.addAttribute("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
		retMap.put("pstinstList", pstinstManageService.selectPstinstAllList(PstinstVO));
        
        return retMap;
    }
    
    
    /* 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
    * @param commandMap 파라메터전달용 commandMap
    * @param model 화면모델
    * @return cmm/uss/umt/EgovIdDplctCnfirm
    * @throws Exception
    */
   @RequestMapping(value="/select/umt/cmm/EgovIdDplctCnfirm.do")
   @ResponseBody
   public Map<String, Object> checkIdDplctBtn(
   		Map<String, Object> commandMap,
   		@ModelAttribute("userManageVO") UserManageVO userManageVO,
           ModelMap model
           )throws Exception {
       
	   
	   Map<String, Object> retMap = new HashMap<String, Object> ();
	   
	   //String checkId = (String)commandMap.get("emplyrId");
	   String checkId = (String)userManageVO.getEmplyrId();
	   checkId =  new String(checkId.getBytes("ISO-8859-1"), "UTF-8");
	   
	   
	       
	   if (checkId==null || checkId.equals("")) {
		   retMap.put("result", "fail");
		   retMap.put("message", "아이디를 입력해주세요");
	   } else {
		   
		   int usedCnt = userManageService.checkIdDplct(checkId);
		   if(usedCnt == 1) {
			   retMap.put("result", "fail");
			   retMap.put("message", "중복되는 아이디입니다.");
		   } else {
			   retMap.put("result", "success");
			   retMap.put("message", "사용할 수 있는 아이디입니다.");
			   retMap.put("id", checkId);
		   }	   
		   
	   }  
	   
	   
	return retMap;
       
      
   }
   
   /**
    * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
    * @param uniqId 상세조회대상 사용자아이디
    * @param searchVO 검색조건
    * @param model 화면모델
    * @return cmm/uss/umt/EgovUserSelectUpdt
    * @throws Exception
    */
//   @RequestMapping("/select/user/EgovUserSelectUpdtView.do")
//   @ResponseBody
//   public Map<String, Object> updateUserViewGrid(
//           @RequestParam("selectedId") String uniqId ,
//           @ModelAttribute("searchVO") UserManageVO searchVO, Model model,
//           @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO)
//           throws Exception {
//       
//       ComDefaultCodeVO vo = new ComDefaultCodeVO();
//       
//       Map <String, Object> retMap = new HashMap<String, Object>();
//
//       
//       UserManageVO userManageVO = new UserManageVO();
//       //uniqId = searchVO.getUniqId();
//       userManageVO = userManageService.selectUser(uniqId);
////       model.addAttribute("searchVO", searchVO);
//       retMap.put("userManageVO", userManageVO);
//       
//       return retMap;
//   }
    
}
