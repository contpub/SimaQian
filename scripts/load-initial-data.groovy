import org.contpub.simaqian.*

println 'Add [User] ...'

new User(email: 'test@contpub.org', account: 'test', password: 'test').save()
new User(email: 'test2@contpub.org', account: 'test2', password: 'test').save()
