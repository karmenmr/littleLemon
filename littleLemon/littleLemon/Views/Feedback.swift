import SwiftUI

struct Feedback: View {
    @State var reason: String = ""
    @State var message: String = ""
    
    @State var showAlert = false
    @State private var alertMessage = ""
    enum Field: Hashable { case reason, message }
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavView {
            VStack {
                TopView()
                VStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Reason *")
                            .modifier(TextLabelModifier())
                        TextField("Type reason here", text: $reason)
                            .modifier(FieldModifier())
                            .focused($focusField, equals: .reason)
                            .submitLabel(.next)
                            .onSubmit { focusField = .message }
                    }
                    .padding(.bottom, 10)
                    VStack(alignment: .leading) {
                        Text("Message *")
                            .modifier(TextLabelModifier())
                        TextField("Let us know what you think", text: $message)
                            .modifier(FieldModifier())
                            .focused($focusField, equals: .message)
                            .keyboardType(.default)
                            .submitLabel(.done)
                            .onSubmit { focusField = nil }
                    }
                    .padding(.bottom, 10)
                    Button("Send Feedback") {
                        alertMessage = if reason.isEmpty || message.isEmpty {
                            "Please fill required fields first!"
                        } else {
                            "Thanks for your feedback! Let's stay in touch!"
                        }
                        showAlert.toggle()
                    }
                    .modifier(ButtonModifierPrimary())
                }
                .padding()
                
                Spacer()
            }
        }
        .alert(alertMessage, isPresented: $showAlert, actions: {
            Button("Okay") {}
        })
    }
}

#Preview {
    Feedback()
}
