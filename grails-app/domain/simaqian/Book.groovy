package simaqian

/**
 * Repository type
 */
public enum RepoType {
    EMBED,
    GIT,
    SVN,
    DROPBOX;
}

/**
 * Book domain object
 */
class Book {
    String name             // name
    String title            // title
    String subtitle         // sub-title
    String authors          // authors
    
    BookProfile profile     //Profile

    Boolean isCooking       = false     // true for cooking status
    Integer countCook       = 0         // cooking counter
    String cookSecret                   // secret code    
    Date cookUpdated                    // cooking updated date time
    Date cookCreated                    // cooking created date time

    Boolean isDeleted       = false     // book deleted?
    Boolean isAvailable     = false     // default is not available
    Boolean isVisible       = true      // default is visible
    Boolean isPublic        = true      // public book => 公版書/免費書
    
    Boolean hasCover        = false     // has cover or not
    
    String formats          = "epub,mobi,pdf"   // availabled formats

    RepoType type = RepoType.EMBED  // repository Type (ex. GIT, SVN)
    String url                      // repository URL (ex. git@github.com:user/project)
    String vhost                    // virtualhost

    Date dateCreated                // created datetime
    Date lastUpdated                // modified datetime

    static hasMany = [
        users: UserAndBook
    ]

    static constraints = {
        name (nullable: false, blank: false, size: 5..30, unique: true, matches: /[a-zA-Z0-9\-\_]+/)
        title (nullable: false, blank: false)
        subtitle (nullable: true, blank: true)
        authors (nullable: true, blank: true)
        profile (nullable: true)
        cookSecret (nullable: true, blank: true)
        cookUpdated (nullable: true)
        cookCreated (nullable: true)
        formats (nullable: true, blank: true)
        type (nullable: true)
        url (nullable: true, url: true)
        vhost (nullable: true, blank: true)
    }

    /**
     * Repository type (enum to list)
     */ 
    def getTypeList() {
        RepoType.values()
    }
    
    /**
     * Generate permalinks for a book
     */
    def getLink() {
        new String("/read/${name}")
    }
    
    /**
     * Generate download links for a book
     */
    def getDownloadLink(type = 'pdf') {
        new String("/download/${name}.${type}")
    }

    /**
     * Get contents as array list
     */
    def getContentsAsList() {
        def result = []

        if (profile && profile.contents) {
            def xml = new XmlParser().parseText(profile.contents)
            def files = xml.file
            println files
            if (files) {
                files.each { file ->
                    result << file.text()
                }
            }
        }

        return result
    }
}
