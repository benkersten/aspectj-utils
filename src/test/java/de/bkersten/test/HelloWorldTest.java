package de.bkersten.test;

import org.junit.Test;

public class HelloWorldTest {
	
	/**
	 * Does nothing but printing 'Hello World'.
	 * This is to be instrumented by aspects.
	 */
	@Test
	public void helloWorld(){		
		System.out.println("Hello World");		
	}
	
	/**
	 * Prints "Hello World n" five times n=1-5, with 5s-sleep 
	 * in-between. This gives a chance to test conditional 
	 * logging (disable cflow logger by touching a ".disablecflow"-file).
	 * 
	 * @throws InterruptedException
	 */
	@Test
	public void longRunningHelloWorld() throws InterruptedException{		
		
		long sleepTime = 5000L;
		longRunningHelloWorld1();
		Thread.currentThread().sleep(sleepTime);
		longRunningHelloWorld2();
		Thread.currentThread().sleep(sleepTime);
		longRunningHelloWorld3();
		Thread.currentThread().sleep(sleepTime);
		longRunningHelloWorld4();
		Thread.currentThread().sleep(sleepTime);
		longRunningHelloWorld5();
		
	}
	private void longRunningHelloWorld1(){
		System.out.println("Hello World 1");
	}
	private void longRunningHelloWorld2(){
		System.out.println("Hello World 2");
	}
	private void longRunningHelloWorld3(){
		System.out.println("Hello World 3");
	}
	private void longRunningHelloWorld4(){
		System.out.println("Hello World 4");
	}
	private void longRunningHelloWorld5(){
		System.out.println("Hello World 5");
	}
	
	
}
