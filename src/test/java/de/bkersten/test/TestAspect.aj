package de.bkersten.test;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class TestAspect {
	
	public static final String INJECTION_SUFFIX = "-AOP";

	@Around("execution(String de.bkersten.test.HelloWorldTest.getterMethod())")
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable{
		
		Object result = joinPoint.proceed();
		if( result instanceof String ){
			return ((String)result) + INJECTION_SUFFIX;
		}
		return result;
		
	}
	
}
