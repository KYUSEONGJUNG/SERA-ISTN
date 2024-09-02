package egovframework.let.sec.ram.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.let.main.service.com.cmm.EgovMessageSource;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.AuthorRoleManage;
import egovframework.let.sec.ram.service.AuthorRoleManageVO;
import egovframework.let.sec.ram.service.EgovAuthorRoleManageService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 권한별 롤관리에 관한 controller 클래스를 정의한다.
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
public class EgovAuthorRoleController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "egovAuthorRoleManageService")
    private EgovAuthorRoleManageService egovAuthorRoleManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /**
	 * 권한 롤 관계 화면 이동
	 * @return "/sec/ram/EgovDeptAuthorList"
	 * @exception Exception
	 */
    @RequestMapping("/sec/ram/EgovAuthorRoleListView.do")
    public String selectAuthorRoleListView() throws Exception {

        return "/sec/ram/EgovAuthorRoleManage";
    } 

	/**
	 * 권한별 할당된 롤 목록 조회
	 * 
	 * @param authorRoleManageVO AuthorRoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sec/ram/EgovAuthorRoleList.do")
	public String selectAuthorRoleList(@ModelAttribute("authorRoleManageVO") AuthorRoleManageVO authorRoleManageVO,
			                            ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorRoleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorRoleManageVO.getPageUnit());
		paginationInfo.setPageSize(authorRoleManageVO.getPageSize());
		
		authorRoleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorRoleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorRoleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorRoleManageVO.setAuthorRoleList(egovAuthorRoleManageService.selectAuthorRoleList(authorRoleManageVO));
        model.addAttribute("authorRoleList", authorRoleManageVO.getAuthorRoleList());
        
        int totCnt = egovAuthorRoleManageService.selectAuthorRoleListTotCnt(authorRoleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        
        return "/sec/ram/EgovAuthorRoleManage";
	}
    
	/**
	 * 권한정보에 롤을 할당하여 데이터베이스에 등록
	 * @param authorCode String
	 * @param roleCodes String
	 * @param regYns String
	 * @param authorRoleManage AuthorRoleManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/sec/ram/EgovAuthorRoleInsert.do")
	@ResponseBody
	public Map<String, Object> insertAuthorRole(@RequestParam("authorCode") String authorCode,
			                       @RequestParam("roleCodes") String roleCodes,
			                       @RequestParam("regYns") String regYns,
			                       @ModelAttribute("authorRoleManage") AuthorRoleManage authorRoleManage,
			                         SessionStatus status,
			                         ModelMap model) throws Exception {
		
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			
			String [] strRoleCodes = roleCodes.split(";");
	    	String [] strRegYns = regYns.split(";");
	    	
	    	authorRoleManage.setRoleCode(authorCode);
	    	
	    	for(int i=0; i<strRoleCodes.length;i++) {
	    		authorRoleManage.setRoleCode(strRoleCodes[i]);
	    		authorRoleManage.setRegYn(strRegYns[i]);
	    		if(strRegYns[i].equals("Y"))
	    			egovAuthorRoleManageService.insertAuthorRole(authorRoleManage);
	    		else 
	    			egovAuthorRoleManageService.deleteAuthorRole(authorRoleManage);
	    	}

	        status.setComplete();
	        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			retMap.put("msgType", "S");
			retMap.put("msg", egovMessageSource.getMessage("success.common.insert"));
	        
	        
		}catch (Exception e ) {
			e.printStackTrace();
			
			retMap.put("msgType", "E");
			retMap.put("msg", egovMessageSource.getMessage("fail.common.insert"));
		}
		
    			
		//return "forward:/sec/ram/EgovAuthorRoleList.do";
		return retMap;
	}
	
	
	/**
	 * 권한별 할당된 롤 목록 조회
	 * 
	 * @param authorRoleManageVO AuthorRoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/select/ram/EgovAuthorRoleList.do")
    @ResponseBody
	public Map<String, Object> selectAuthorRoleListGrid(@ModelAttribute("authorRoleManageVO") AuthorRoleManageVO authorRoleManageVO,
			                            ModelMap model) throws Exception {
    	
    	Map<String, Object> retMap = new HashMap<String, Object> ();

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorRoleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorRoleManageVO.getPageUnit());
		paginationInfo.setPageSize(authorRoleManageVO.getPageSize());
		
		authorRoleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorRoleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorRoleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorRoleManageVO.setAuthorRoleList(egovAuthorRoleManageService.selectAuthorRoleList(authorRoleManageVO));
        model.addAttribute("authorRoleList", authorRoleManageVO.getAuthorRoleList());
        //retMap.put("authorRoleList", authorRoleManageVO.getAuthorRoleList());
        
        List<AuthorRoleManageVO> authorRoleData = authorRoleManageVO.getAuthorRoleList();
        List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
        
    	for(int i=0 ; i < authorRoleData.size() ; i++) {
        	
        	Map<String, Object> resultMap = new HashMap<String, Object>();
        	resultMap.put("roleCode", authorRoleData.get(i).getRoleCode());
        	resultMap.put("roleNm", authorRoleData.get(i).getRoleNm());
        	resultMap.put("roleTyp", authorRoleData.get(i).getRoleTyp());
        	resultMap.put("roleSort", authorRoleData.get(i).getRoleSort());
        	resultMap.put("roleDc", authorRoleData.get(i).getRoleDc());
        	resultMap.put("creatDt", authorRoleData.get(i).getCreatDt());
        	resultMap.put("regYn", authorRoleData.get(i).getRegYn());
        	
        	resultList.add(resultMap);
        }
    	retMap.put("resultList", resultList);
        
        int totCnt = egovAuthorRoleManageService.selectAuthorRoleListTotCnt(authorRoleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        retMap.put("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        retMap.put("message", egovMessageSource.getMessage("success.common.select"));
        
        return retMap;
	}
    
    
    /**
	 * 권한정보에 롤을 할당하여 데이터베이스에 등록
	 * @param authorCode String
	 * @param roleCodes String
	 * @param regYns String
	 * @param authorRoleManage AuthorRoleManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/select/ram/EgovAuthorRoleInsert.do")
	public Map<String, Object> insertAuthorRoleA(@RequestParam("authorCode") String authorCode,
			                       @RequestParam("roleCodes") String roleCodes,
			                       @RequestParam("regYns") String regYns,
			                       @ModelAttribute("authorRoleManage") AuthorRoleManage authorRoleManage,
			                         SessionStatus status,
			                         ModelMap model) throws Exception {
		
    	Map<String, Object> retMap = new HashMap<String, Object>();
		
		String [] strRoleCodes = roleCodes.split(";");
    	String [] strRegYns = regYns.split(";");
    	
    	authorRoleManage.setRoleCode(authorCode);
    	
    	for(int i=0; i<strRoleCodes.length;i++) {
    		authorRoleManage.setRoleCode(strRoleCodes[i]);
    		authorRoleManage.setRegYn(strRegYns[i]);
    		if(strRegYns[i].equals("Y"))
    			egovAuthorRoleManageService.insertAuthorRole(authorRoleManage);
    		else 
    			egovAuthorRoleManageService.deleteAuthorRole(authorRoleManage);
    	}

        status.setComplete();
        
        retMap.put("message", egovMessageSource.getMessage("success.common.insert"));
        
        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));		
		return retMap;
	}
    
    
}