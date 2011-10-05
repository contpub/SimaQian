package org.contpub.simaqian

public enum RepoType {
	GitHub,
	SVN;
}

class RepoBook extends Book {

	RepoType type
	String url

	def getTypeList() {
		RepoType.values()
	}

    static constraints = {
    	url (url: true)
    }
}
