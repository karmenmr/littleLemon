import SwiftUI

struct Navbar: View {
    @Environment(\.dismiss) var dismiss
    
    let hideBackButton: Bool
    let showTitleView: Bool
    let showRightView: Bool
    
    var body: some View {
        HStack {
            if !hideBackButton { BackButton }
            Spacer()
            if showTitleView { TitleView }
            Spacer()
            if showRightView { RightView }
        }
        .padding(showRightView || showTitleView || !hideBackButton ? 10 : 0)
        .background(
            Color.white.ignoresSafeArea()
        )
    }
}

#Preview {
    Navbar(hideBackButton: false, showTitleView: true, showRightView: true)
}

extension Navbar {
    private var BackButton: some View {
        Button("", systemImage: "arrow.backward.circle.fill") { dismiss() }
            .accentColor(Color.primGreen)
            .frame(width: 40, height: 40)
    }
    
    private var TitleView: some View {
        LogoView()
    }
    private var RightView: some View {
        Image("sample-profile")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}
