package egovframework.let.main.service.com.cmm;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.egovframe.rte.fdl.cmmn.exception.handler.ExceptionHandler;

public class EgovComOthersExcepHndlr implements ExceptionHandler {

    protected Log log = LogFactory.getLog(this.getClass());
    
    public void occur(Exception exception, String packageName) {
    	//log.debug(" EgovServiceExceptionHandler run...............");
	log.error(packageName, exception);
    }
}
