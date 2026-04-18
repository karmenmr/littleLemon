import Foundation
import Combine

struct User: Codable {
    
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var isLoggedIn = false
    
    var isOrderEnabled = true
    var isPasswordChangesEnabled = true
    var isSpecialOffersEnabled = true
    var isNewsLetterEnabled = true
    
    init(firstName: String = "", lastName: String = "", email: String = "", phoneNumber: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    mutating func updateOrderEnabled(_ isEnabled: Bool) {
        self.isOrderEnabled = isEnabled
    }
    
    mutating func updatePasswordChangesEnabled(_ isEnabled: Bool) {
        self.isPasswordChangesEnabled = isEnabled
    }
    
    mutating func updateSpecialOffersEnabled(_ isEnabled: Bool) {
        self.isSpecialOffersEnabled = isEnabled
    }
    
    mutating func updateNewsletterEnabled(_ isEnabled: Bool) {
        self.isNewsLetterEnabled = isEnabled
    }
    
    func saveChanges() {
        save()
    }
    
    @discardableResult
    mutating func save(firstName: String, lastname: String, email: String, phoneNumber: String = "") -> Bool {
        let user = User(firstName: firstName, lastName: lastname, email: email, phoneNumber: phoneNumber)
        if user.save() {
            self.firstName = user.firstName
            self.lastName = user.lastName
            self.email = user.email
            self.phoneNumber = user.phoneNumber
            return true
        }
        return false
    }
    
    mutating func logout() {
        guard UserDefaults.standard.data(forKey: "littleLemonkUser") != nil else { return }
        UserDefaults.standard.removeObject(forKey: "littleLemonkUser")
        email = ""
        firstName = ""
        lastName = ""
        phoneNumber = ""
        isOrderEnabled = true
        isPasswordChangesEnabled = true
        isSpecialOffersEnabled = true
        isNewsLetterEnabled = true
    }
}

extension User {
    static var shared: User = {
        if let data = UserDefaults.standard.data(forKey: "littleLemonkUser"),
           var user = try? PropertyListDecoder().decode(User.self, from: data) {
            user.isLoggedIn = true
            return user
        }
        return User()
    }()
}

extension User {
    
    @discardableResult
    fileprivate func save() -> Bool {
        guard !(firstName.isEmpty || lastName.isEmpty || email.isEmpty) else { return false }
        if let encoded = try? PropertyListEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "littleLemonkUser")
            User.shared = self
            User.shared.isLoggedIn = true
            return true
        }
        return false
    }
}
