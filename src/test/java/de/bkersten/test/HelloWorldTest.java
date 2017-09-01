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
	
}
