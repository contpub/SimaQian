package org.contpub.simaqian

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*

import org.nuiton.jrst.*

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class TextLayoutTests {
	def textRst
	
	void setUp() {
		textRst = '''
Title
=====

Content
'''
	}
	
	void tearDown() {
		// Tear down logic here
	}
	
	void testRstToHtml() {
		def reader = new StringReader(textRst)
		
		def textHtml = JRST.generateString(JRST.TYPE_HTML, reader)
		
		def xmlObj = new XmlParser().parseText(textHtml)
		assert 'Title'.equals(xmlObj.body.h1[0].value()[0])
		assert 'Content'.equals(xmlObj.body.p[0].value()[0])		
	}
	
	void testRstToHtmlInnerBody() {
		def reader = new StringReader(textRst)
		
		def textHtml = JRST.generateString(JRST.TYPE_HTML_INNER_BODY, reader)
		
		def xmlObj = new XmlParser().parseText(textHtml)
		assert 'Title'.equals(xmlObj.h1[0].value()[0])
		assert 'Content'.equals(xmlObj.p[0].value()[0])
	}
}
