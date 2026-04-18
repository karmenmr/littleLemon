import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("littleLemon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        }
    }
}

#Preview {
    LogoView()
}
