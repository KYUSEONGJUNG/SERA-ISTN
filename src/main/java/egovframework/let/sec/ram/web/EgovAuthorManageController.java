package egovframework.let.sec.ram.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.sec.ram.service.AuthorManage;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 권한관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
 
@Controller
public class EgovAuthorManageController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    /**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/sec/ram/EgovAuthorListView.do")
    public String selectAuthorListView()
            throws Exception {
        return "/sec/ram/EgovAuthorManage";
    }    
    
    /**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sec/ram/EgovAuthorList.do")
    public String selectAuthorList(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                        ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	//authorManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	//authorManageVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());
		
		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorList(authorManageVO));
        //model.addAttribute("authorList", authorManageVO.getAuthorManageList());
        
        int totCnt = egovAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        return "/sec/ram/EgovAuthorManage";
    } 
    
    /**
	 * 권한 세부정보를 조회한다.
	 * @param authorCode String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */   
    @RequestMapping(value="/sec/ram/EgovAuthor.do")
    public String selectAuthor(@RequestParam("authorCode") String authorCode,
    	                       @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                    ModelMap model) throws Exception {
    	
    	authorManageVO.setAuthorCode(authorCode);
    	
    	if(authorCode.equals("")) {
    		return "/sec/ram/EgovAuthorUpdate";
    	} else {
    		model.addAttribute("authorManage", egovAuthorManageService.selectAuthor(authorManageVO));
    	}    	
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
    	return "/sec/ram/EgovAuthorUpdate";
    }     

    /**
	 * 권한 등록화면 이동
	 * @return String
	 * @exception Exception
	 */     
    @RequestMapping("/sec/ram/EgovAuthorInsertView.do")
    public String insertAuthorView()
            throws Exception {
        return "/sec/ram/EgovAuthorInsert";
    }
    
    /**
	 * 권한 세부정보를 등록한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */ 
    @RequestMapping(value="/sec/ram/EgovAuthorInsert.do")
    @ResponseBody
    public Map<String, Object> insertAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
    		                    BindingResult bindingResult,
    		                    SessionStatus status, 
    		                    ModelMap model) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		
    		beanValidator.validate(authorManage, bindingResult); //validation 수행
        	
    		if (bindingResult.hasErrors()) { 
    			//return "/sec/ram/EgovAuthorInsert";
    			retMap.put("msgType", "E");
    	        retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
    		} else {
    	    	egovAuthorManageService.insertAuthor(authorManage);
    	        status.setComplete();
    	        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
    	        //return "forward:/sec/ram/EgovAuthor.do";
    	        retMap.put("msgType", "S");
    	        retMap.put("msg", egovMessageSource.getMessage("success.common.insert"));
    		}
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		retMap.put("msgType", "E");
	        retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
    	}
    	
    	return retMap;
    	
    }
    
    /**
	 * 권한 세부정보를 수정한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */   
    @RequestMapping(value="/sec/ram/EgovAuthorUpdate.do")
    @ResponseBody
    public Map<String, Object> updateAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
    		                    BindingResult bindingResult,
    		                    SessionStatus status, 
    		                    Model model) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	try {
    		beanValidator.validate(authorManage, bindingResult); //validation 수행
        	
    		if (bindingResult.hasErrors()) {
    			//return "/sec/ram/EgovAuthorUpdate";
    			retMap.put("msgType", "E");
    	        retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    		} else {
    	    	egovAuthorManageService.updateAuthor(authorManage);
    	        status.setComplete();
    	        model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
    	        //return "forward:/sec/ram/EgovAuthor.do";
    	        retMap.put("msgType", "S");
    	        retMap.put("msg", egovMessageSource.getMessage("success.common.update"));
    		}   		
    		
    		
    	}catch(Exception e) {
    		
    		e.printStackTrace();
    		retMap.put("msgType", "E");
	        retMap.put("msg", egovMessageSource.getMessage("fail.common.update"));
    		
    	}
    	
    	return retMap;
    }    

    /**
   	 * 권한 세부정보를 삭제한다.
   	 * @param authorManage AuthorManage
   	 * @return String
   	 * @exception Exception
   	 */  
       @RequestMapping(value="/sec/ram/EgovAuthorDelete.do")
       @ResponseBody
       public Map<String, Object> deleteAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
       		                    SessionStatus status,
       		                    Model model) throws Exception {
       	Map<String, Object> retMap = new HashMap<String, Object>();
       	
       	try {
       		egovAuthorManageService.deleteAuthor(authorManage);
           	status.setComplete();
           	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
               //return "forward:/sec/ram/EgovAuthorList.do";
           	
           	retMap.put("msgType", "S");
           	retMap.put("msg", egovMessageSource.getMessage("success.common.delete"));
           	
       	}catch(Exception e) {
       		e.printStackTrace();
       		
       		retMap.put("msgType", "E");
           	retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
       	}
       	
       	return retMap;
       }   
       
       /**
   	 * 권한목록을 삭제한다.
   	 * @param authorCodes String
   	 * @param authorManage AuthorManage
   	 * @return String
   	 * @exception Exception
   	 */  
       @RequestMapping(value="/sec/ram/EgovAuthorListDelete.do")
       @ResponseBody
       public Map<String, Object> deleteAuthorList(@RequestParam("authorCodes") String authorCodes,
       		                       @ModelAttribute("authorManage") AuthorManage authorManage, 
       		                        SessionStatus status,
       		                        Model model) throws Exception {
       	
       	Map<String, Object> retMap = new HashMap<String, Object>();
       	
       	try {
       		
       		String [] strAuthorCodes = authorCodes.split(",");
           	for(int i=0; i<strAuthorCodes.length;i++) {
           		authorManage.setAuthorCode(strAuthorCodes[i]);
           		egovAuthorManageService.deleteAuthor(authorManage);
           	}
           	status.setComplete();
           	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
           	
           	retMap.put("msgType", "S");
           	retMap.put("msg", egovMessageSource.getMessage("success.common.delete"));
       		
       	}catch(Exception e) {
       		e.printStackTrace();
       		
       		retMap.put("msgType", "E");
           	retMap.put("msg", egovMessageSource.getMessage("fail.common.delete"));
       	}
       	
       	
           return retMap;
       }    
       
    
    /**
	 * 권한제한 화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/sec/ram/accessDenied.do")
    public String accessDenied()
            throws Exception {
    	SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
    	
		if(null == authentication) {
			return "redirect:/uat/uia/egovLoginUsr.do";
		} 
        return "sec/accessDenied";
        
    }
    
    
    /**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/ram/EgovAuthorList.do")
    @ResponseBody
    public Map<String, Object> selectAuthorListGrid(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                        ModelMap model)
            throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();
    	
    	/** EgovPropertyService.sample */
    	//authorManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	//authorManageVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());
		
		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorList(authorManageVO));
        model.addAttribute("authorList", authorManageVO.getAuthorManageList());
        //retMap.put("authorList", egovAuthorManageService.selectAuthorList(authorManageVO));
        //retMap.put("resultList", egovAuthorManageService.selectAuthorList(authorManageVO));
        
        List<AuthorManageVO> authorData = authorManageVO.getAuthorManageList();
        List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
        
    	for(int i=0 ; i < authorData.size() ; i++) {
        	
        	Map<String, Object> resultMap = new HashMap<String, Object>();
        	resultMap.put("authorCode", authorData.get(i).getAuthorCode());
        	resultMap.put("authorNm", authorData.get(i).getAuthorNm());
        	resultMap.put("authorDc", authorData.get(i).getAuthorDc());
        	resultMap.put("authorCreatDe", authorData.get(i).getAuthorCreatDe());
        	
        	resultList.add(resultMap);
        }
    	retMap.put("resultList", resultList); 
        int totCnt = egovAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        retMap.put("message", egovMessageSource.getMessage("success.common.select"));

        return retMap;
    } 
}
