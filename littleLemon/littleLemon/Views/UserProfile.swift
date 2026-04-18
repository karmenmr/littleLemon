import SwiftUI

struct UserProfile: View {
    @EnvironmentObject private var model: UserModel
    
    var body: some View {
        VStack(alignment: .center) {
            Title
            UserImage
            UserInfo
            Spacer()
            EditButton
            FeedbackButton
        }
        .padding()
    }
}

#Preview {
    UserProfile()
        .environmentObject(UserModel())
        .environment(\.font, .custom("Karla-Regular", size: 18))
}

extension UserProfile {
    private func editProfile() {
        model.showEditProfile = true
    }
    private func sendFeedback() {
        model.showFeedback = true
    }
}

extension UserProfile {
    private var Title: some View {
        Text("Personal information")
            .font(.custom("Karla-Regular_Medium", size: 24))
            .padding([.top, .bottom], 10)
    }
    
    private var UserImage: some View {
        HStack(spacing: 20) {
            Image("sample-profile")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipShape(Circle())
        }
    }
    
    private var UserInfo: some View {
        VStack(spacing: 20)  {
            Text("\(model.user.firstName) \(model.user.lastName)")
                .font(.custom("Karla-Regular_Bold", size: 28))
            Text(model.user.email)
                .font(.custom("Karla-Regular_Light", size: 22))
            Text(model.user.phoneNumber)
                .font(.custom("Karla-Regular_Light", size: 16))
        }
    }
    
    private var EditButton: some View {
        HStack {
            Button("Edit profile", action: editProfile)
                .frame(maxWidth: .infinity)
                .modifier(ButtonModifierPrimary(Color.primYellow, textColor: Color.darkAccent))
        }
        .padding()
    }
    
    private var FeedbackButton: some View {
        HStack {
            Button("Send Us Feedback", action: sendFeedback)
                .frame(maxWidth: .infinity)
                .modifier(ButtonModifierPrimary(Color.primYellow, textColor: Color.darkAccent))
        }
        .padding()
    }
}

extension UserProfile {
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


