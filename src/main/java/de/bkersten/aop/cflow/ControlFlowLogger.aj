package de.bkersten.aop.cflow;

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
 * @author bkersten
 *
 */
@Aspect
public class ControlFlowLogger {

	
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
		System.out.println(indent() + symbol + " " + staticPart);
	}
	
	private String indent(){
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < indent; i++) {
			sb.append("   "); // 3 spaces
		}
		return sb.toString();
	}
	
}
