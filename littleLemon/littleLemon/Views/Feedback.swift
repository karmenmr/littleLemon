import SwiftUI

struct Feedback: View {
    @State var name: String = ""
    @State var email: String = ""
    
    enum Field: Hashable { case name, email }
    @FocusState private var focusField: Field?
    
    var body: some View {
        VStack {
            TopView()
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Name *")
                        .modifier(TextLabelModifier())
                    TextField("Name", text: $name)
                        .modifier(FieldModifier())
                        .focused($focusField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit { focusField = .email }
                }
                .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text("Email *")
                        .modifier(TextLabelModifier())
                    TextField("Email", text: $email)
                        .modifier(FieldModifier())
                        .focused($focusField, equals: .email)
                        .keyboardType(.emailAddress)
                        .submitLabel(.done)
                        .onSubmit { focusField = nil }
                }
                .padding(.bottom, 10)
                Button("Send Feedback") {
                    if  isValid(email) {
                    } else {
                        print("no validation")
                    }
                }
                .modifier(ButtonModifierPrimary())
                
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    Feedback()
}
