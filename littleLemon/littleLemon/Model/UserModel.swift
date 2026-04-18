import Foundation
import Combine

class UserModel: ObservableObject {
    var user: User = User.shared
    
    @Published var showEditProfile = false
    @Published var isLoggedIn = false {
        didSet {
            if !isLoggedIn {
                user.logout()
            }
        }
    }
    
    @Published var isOrderEnabled = false
    @Published var isPasswordChangesEnabled = false
    @Published var isSpecialOffersEnabled = false
    @Published var isNewsLetterEnabled = false
    
    
    init() {
        isLoggedIn = user.isLoggedIn
        isOrderEnabled = user.isOrderEnabled
        isPasswordChangesEnabled = user.isPasswordChangesEnabled
        isSpecialOffersEnabled = user.isSpecialOffersEnabled
        isNewsLetterEnabled = user.isNewsLetterEnabled
    }
    
    func saveChanges() {
        user.updateOrderEnabled(isOrderEnabled)
        user.updatePasswordChangesEnabled(isPasswordChangesEnabled)
        user.updateSpecialOffersEnabled(isSpecialOffersEnabled)
        user.updateNewsletterEnabled(isNewsLetterEnabled)
        
        user.saveChanges()
    }
}

extension UserModel {
    static var preview: UserModel = {
        let model = UserModel()
        model.user = User(firstName: "Tilly", lastName: "Doe", email: "tillydoe@example.com", phoneNumber: "(217) 555-0113")
        model.isLoggedIn = true
        
        return model
    }()
}
