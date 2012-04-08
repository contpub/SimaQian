package simaqian

import com.threecrickets.jygments.format.*
import com.threecrickets.jygments.grammar.*

class JygmentsTagLib {
	static namespace = 'jygments'

	/**
	 * <jygments:format lexer="rst" formatter="html"></jygments:format>
	 */
	def createLink = { attr, body ->
		//def lexer = Lexer.getForFileName( args[0] );
		//Formatter formatter = Formatter.getByName( "html" );
		//String code = IOUtils.toString( new FileInputStream( args[0] ) );
		//formatter.format( lexer.getTokens( code ), new PrintWriter( System.out ) );
	}
}
