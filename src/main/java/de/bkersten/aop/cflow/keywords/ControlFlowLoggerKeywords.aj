package de.bkersten.aop.cflow.keywords;

import org.aspectj.lang.JoinPoint;

import de.bkersten.aop.cflow.ControlFlowLogger;

/**
 * Aspect for logging complete control flow of a Java application.
 * Same as {@link ControlFlowLogger}, but with old-style AOP-keywords instead
 * of modern annotions.
 * 
 * @see ControlFlowLogger
 * 
 * @author bkersten
 * 
 */
public privileged aspect ControlFlowLoggerKeywords {

	
	private int indent = 0;

	pointcut AllMethods() : execution(* *.*(..))
							&& !within(de.bkersten.aop..*);
	
	
	before() : AllMethods(){
		logMethodSignature( "->", thisJoinPointStaticPart );
		indent++;
	}
	
	after() : AllMethods(){
		indent--;
		logMethodSignature( "<-", thisJoinPointStaticPart );
	}	
	
	private void logMethodSignature(String symbol, JoinPoint.StaticPart staticPart){
		System.out.println(indent() + symbol + " " + staticPart + "  [by +"+this.getClass().getSimpleName()+"]");
	}
	
	private String indent(){
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < indent; i++) {
			sb.append("   "); // 3 spaces
		}
		return sb.toString();
	}
	
}
