package de.bkersten.aop.cflow;

import java.net.URL;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

/**
 * Aspect for logging complete control flow of a Java application.
 * For black-box/3rd-party apps, it might help to trace method flow
 * of (parts of) program execution.
 * Just define this aspect and apply it to packages of interest (via
 * aop.xml) and run your app with javaagent option.
 * This aspect will then log any method-execution to std-out (redirect
 * yourself to file if desired).
 * Nested method executions are indented for better readability. Indention
 * is decreased on return of method.
 * 
 * This Aspect allows for conditional logging. By default, logging is enabled,
 * which might produce lots of logs. If you are interested in logging 
 * specific parts / at specific times only, you can disable logging by 
 * touching a file named ".disablecflow" anywhere on classpath (current 
 * directory). To enable again, just remove "disablecflow".
 * 
 * @author bkersten
 *
 */
@Aspect
public class ControlFlowLogger {
	
	private static final String PREFIX = "[aspectj-utils]";
	private static final String POSTFIX = "[" + ControlFlowLogger.class.getSimpleName() + "]";
	private static DateTimeFormatter DTF = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
	
	
	
	private int indent = 0;

	@Pointcut("execution(* *.*(..)) && !within(de.bkersten.aop..*)")
	void allMethods(){}
	
	@Before("allMethods()")
	public void beforeAllMethods(JoinPoint.EnclosingStaticPart thisJoinPointStaticPart){
		logMethodSignature( "->", thisJoinPointStaticPart );
		indent++;
	}
	
	@After("allMethods()")
	public void afterAllMethods(JoinPoint.EnclosingStaticPart thisJoinPointStaticPart){
		indent--;
		logMethodSignature( "<-", thisJoinPointStaticPart );
	}	
	
	private void logMethodSignature(String symbol, JoinPoint.StaticPart staticPart){
		if( isEnabled() ){
			System.out.println( PREFIX + 
								"[" + getDateTime() + "]" +
								indent() + 
								" " + 
								symbol + 
								" " + 
								staticPart + 
								"  " +
								POSTFIX);
			
		}
	}
	
	/**
	 * Checks for existence of ".disablecflow" file on classpath. If true, 
	 * logging of cflow will be omitted.
	 * @return
	 */
	private boolean isEnabled(){
		URL url = this.getClass().getClassLoader().getResource(".disablecflow");
		// System.out.println("isEnabled-check: url="+url);
		if( url != null ){
			return false;
		}
		return true;
	}
	
	private String indent(){
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < indent; i++) {
			sb.append("   "); // 3 spaces
		}
		return sb.toString();
	}
	
	private String getDateTime(){
		return LocalDateTime.now().toString();
	}
	
}
