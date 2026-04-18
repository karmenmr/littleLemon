import SwiftUI
internal import CoreData

struct Home: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var userModel = UserModel()
    @StateObject var dishModel = DishModel.shared
      
    var body: some View {
        NavView {
            if !userModel.isLoggedIn {
                Onboarding()
                    .navbarItems(titleShow: true)
                    .environmentObject(userModel)
            } else {
                TabView {
                    Tab("Menu", systemImage: "list.bullet") {
                        Menu()
                            .environmentObject(dishModel)
                    }
                    Tab("Profile", systemImage: "square.and.pencil") {
                        UserProfile()
                            .environmentObject(userModel)
                    }
                }
                .navbarItems(titleShow: true, rightViewShow: true)
                .navigationDestination(isPresented: $userModel.showEditProfile) {
                    EditUserProfile()
                        .environmentObject(userModel)
                }
                .navigationDestination(isPresented: $userModel.showFeedback) {
                    Feedback()
                }
                .navigationDestination(isPresented: $dishModel.showDish) {
                    if let dish = dishModel.selectedDish { DishDetail(dish)
                            .environmentObject(dishModel)
                    } else {
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
}

