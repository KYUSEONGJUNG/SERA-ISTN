package egovframework.let.main.service.com.cmm.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.let.main.service.com.cmm.service.EgovFileMngService;
import egovframework.let.main.service.com.cmm.service.FileVO;
import egovframework.let.main.service.com.cmm.util.EgovUserDetailsHelper;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.25  이삼섭          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
@Controller
public class EgovFileMngController {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfById.do")
    @ResponseBody
    public Map<String, Object> selectFileInfById(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
    	Map<String, Object> retMap = new HashMap<String, Object>();
    	
    	if(null != fileVO.getAtchFileId() && !"".equals(fileVO.getAtchFileId())) {
    		List<FileVO> result = fileService.selectFileInfs(fileVO);    		
    		retMap.put("fileList", result);
    	}
		
		return retMap;
    }
    
    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfs.do")
    public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmm/fms/EgovFileList";
    }
    
    /**
     * 첨부파일(SR답변)에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfsSr.do")
    public String selectFileInfsSr(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmm/fms/EgovFileListSr";
    }
    
    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfsForUpdate.do")
    public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);

	List<FileVO> result = fileService.selectFileInfs(fileVO);
	
	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "Y");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmm/fms/EgovFileList";
    }
    
    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfsForUpdateAns.do")
    public String selectFileInfsForUpdateAns(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);

	List<FileVO> result = fileService.selectFileInfs(fileVO);
	
	model.addAttribute("fileListAns", result);
	model.addAttribute("updateFlagAns", "Y");
	model.addAttribute("fileListCntAns", result.size());
	model.addAttribute("atchFileIdAns", atchFileId);
	
	return "cmm/fms/EgovFileListAnswer";
    }

    /**
     * 첨부파일에 대한 삭제를 처리한다.
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/deleteFileInfs.do")
    @ResponseBody
    public void deleteFileInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
			String atchFileId = (String)request.getParameter("atchFileId");
			String fileSn = (String)request.getParameter("fileSn");
			FileVO fileVO = new FileVO();
		    fileVO.setAtchFileId(atchFileId);
		    fileVO.setFileSn(fileSn);
		    
			fileService.deleteFileInf(fileVO);
		}
	//--------------------------------------------
	// contextRoot가 있는 경우 제외 시켜야 함
	//--------------------------------------------
	////return "forward:/cmm/fms/selectFileInfs.do";
	//return "forward:" + returnUrl;
	
	/*
	 * if ("".equals(request.getContextPath()) ||
	 * "/".equals(request.getContextPath())) { return "forward:" + returnUrl; }
	 * 
	 * if (returnUrl.startsWith(request.getContextPath())) { return "forward:" +
	 * returnUrl.substring(returnUrl.indexOf("/", 1)); } else { return "forward:" +
	 * returnUrl; }
	 */
	////------------------------------------------
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectImageFileList(fileVO);
	
	model.addAttribute("fileList", result);

	return "cmm/fms/EgovImgFileList";
    }
}
