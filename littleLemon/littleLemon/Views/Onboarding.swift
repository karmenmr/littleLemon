import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var model: UserModel
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    
    enum Field: Hashable { case firstName, lastName, email, phoneNumber }
    @FocusState private var focusField: Field?
    
    var body: some View {
        ScrollView {
            VStack {
                Tobbar
                VStack(alignment: .center, spacing: 20) {
                    FirstNameField
                    LastNameField
                    EmailField
                    PhoneNumberField
                    Spacer()
                    Register
                }
                .padding()
                .onAppear {
                    firstName = ""
                    lastName = ""
                    email = ""
                    phoneNumber = ""
                    focusField = nil //.firstName
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Onboarding()
        .environment(\.font, .custom("Karla-Regular", size: 18))
}


extension Onboarding {
    private var Tobbar: some View {
        TopView()
    }
    
    private var FirstNameField: some View {
        VStack(alignment: .leading) {
            Text("First Name*")
                .modifier(TextLabelModifier())
            TextField("First Name", text: $firstName)
                .modifier(FieldModifier())
                .focused($focusField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit { focusField = .lastName }
        }
    }
    
    private var LastNameField: some View {
        VStack(alignment: .leading) {
            Text("Last Name*")
                .modifier(TextLabelModifier())
            TextField("Last Name", text: $lastName)
                .modifier(FieldModifier())
                .focused($focusField, equals: .lastName)
                .submitLabel(.next)
                .onSubmit { focusField = .email }
        }
    }
    
    private var EmailField: some View {
        VStack(alignment: .leading) {
            Text("Email*")
                .modifier(TextLabelModifier())
            TextField("Email", text: $email)
                .modifier(FieldModifier())
                .focused($focusField, equals: .email)
                .keyboardType(.emailAddress)
                .submitLabel(.next)
                .onSubmit { focusField = .phoneNumber }
        }
    }
    
    private var PhoneNumberField: some View {
        VStack(alignment: .leading) {
            Text("Phone Number")
                .modifier(TextLabelModifier())
            TextField("Phone Number", text: $phoneNumber)
                .modifier(FieldModifier())
                .focused($focusField, equals: .phoneNumber)
                .keyboardType(.phonePad)
                .submitLabel(.done)
                .onSubmit { focusField = nil }
        }
    }
    
    private var Register: some View {
        Button("Register") {
            if  isValid(email) && model.user.save(firstName: firstName, lastname: lastName, email: email, phoneNumber: phoneNumber) {
                model.isLoggedIn = true
            } else {
                print("no validation")
            }
        }
        .frame(maxWidth: .infinity)
        .modifier(ButtonModifierPrimary())
    }
}
