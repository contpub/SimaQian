package org.contpub.simaqian

class RepoBook extends Book {

	RepoType type
	String url;

    static constraints = {
    	url (url: true)
    }
}
