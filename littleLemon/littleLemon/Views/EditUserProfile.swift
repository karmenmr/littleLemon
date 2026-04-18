import SwiftUI


struct EditUserProfile: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: UserModel
       
    var body: some View {
        NavView {
            ScrollView {
                VStack(alignment: .leading) {
                    PersonalInformation
                    Avatar
                    VStack(alignment: .leading, spacing: 20)  {
                        FirstName
                        LastName
                        Email
                        PhoneNumber
                    }
                    NotificationLabel
                    NotificationOptions
                    
                    VStack(alignment: .center, spacing: 40) {
                        LogoutButton
                        BottomButtons
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    EditUserProfile()
        .environmentObject(UserModel.preview)
        .environment(\.font, .custom("Karla-Regular", size: 18))
}

extension EditUserProfile {
    fileprivate func logout() {
        dismiss()
        model.isLoggedIn = false
    }
    func change() {}
    func remove() {}
    
    func discardChanges() {
        dismiss()
    }
    func saveChanges() {
        model.saveChanges()
    }
}

extension EditUserProfile {
    private var PersonalInformation: some View {
        HStack {
            Text("Personal information")
                .font(.custom("Karla-Regular_Medium", size: 22))
            Spacer()
        }
        .padding([.top, .bottom], 10)
    }
    
    private var Avatar: some View {
        VStack(alignment: .leading) {
            Text("Avatar")
                .modifier(TextLabelModifier())
            
            HStack(spacing: 20) {
                Image("sample-profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                Button("Change", action: change)
                    .modifier(ButtonModifierPrimary())
                Button("Remove", action: remove)
                    .modifier(ButtonModifierSecondary())
            }
        }
    }
    
    private var FirstName: some View {
        VStack(alignment: .leading) {
            Text("First name")
                .modifier(TextLabelModifier())
            Text(model.user.firstName)
                .modifier(FieldModifier())
        }
    }
    
    private var LastName: some View {
        VStack(alignment: .leading) {
            Text("Last name")
                .modifier(TextLabelModifier())
            Text(model.user.lastName)
                .modifier(FieldModifier())
        }
    }
    
    private var Email: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .modifier(TextLabelModifier())
            Text(model.user.email)
                .modifier(FieldModifier())
        }
    }
    
    private var PhoneNumber: some View {
        VStack(alignment: .leading) {
            Text("Phone number")
                .modifier(TextLabelModifier())
            Text(model.user.phoneNumber)
                .modifier(FieldModifier())
        }
    }
    
    private var NotificationLabel: some View {
        HStack {
            Text("Email notifications")
                .font(.custom("Karla-Regular_Medium", size: 22))
            Spacer()
        }
        .padding([.top, .bottom], 10)
    }
    
    private var NotificationOptions: some View {
        VStack(alignment:.leading, spacing: 20) {
            
            Button {
                model.isOrderEnabled.toggle()
            } label: {
                Label("Order statuses", systemImage: model.isOrderEnabled ? "checkmark.rectangle.fill" : "checkmark.rectangle")
            }

            Button {
                model.isPasswordChangesEnabled.toggle()
            } label: {
                Label("Password changes", systemImage: model.isPasswordChangesEnabled ? "checkmark.rectangle.fill" : "checkmark.rectangle")
            }
            
            Button {
                model.isSpecialOffersEnabled.toggle()
            } label: {
                Label("Special Offers", systemImage: model.isSpecialOffersEnabled ? "checkmark.rectangle.fill" : "checkmark.rectangle")
            }
            
            Button {
                model.isNewsLetterEnabled.toggle()
            } label: {
                Label("Newsletter", systemImage: model.isNewsLetterEnabled ? "checkmark.rectangle.fill" : "checkmark.rectangle")
            }
        }
        .foregroundStyle(Color.darkAccent)
        .padding(.bottom, 30)
    }
    
    private var LogoutButton: some View {
        HStack(alignment: .center) {
            Button("Log out", action: logout)
            .frame(maxWidth: .infinity)
            .modifier(ButtonModifierPrimary(Color.primYellow, textColor: Color.darkAccent))
        }
    }
    
    private var BottomButtons: some View {
        HStack(spacing: 10) {
            Button("Discard changes", action: discardChanges)
                .modifier(ButtonModifierSecondary())
            Button("Save changes", action: saveChanges)
                .modifier(ButtonModifierPrimary())
        }
    }
}

extension EditUserProfile {
    struct FieldModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.5))
                        .fill(Color.gray)
                )
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.leading)
        }
    }
}

