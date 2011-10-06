package org.contpub.simaqian

public enum RepoType {
	GIT,
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
