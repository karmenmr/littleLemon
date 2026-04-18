import SwiftUI

struct TopView: View {
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: -15) {
                HStack {
                    Text("Little Lemon")
                        .font(.custom("MarkaziText-Medium", size: 48))
                        .foregroundStyle(Color.primYellow)
                    Spacer()
                }
                .padding(.leading, 10)
                HStack {
                    Text("Chicago")
                        .font(.custom("MarkaziText-Medium", size: 38))
                    Spacer()
                }
                .padding(.leading, 10)
                
                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.custom("Karla-Regular_Medium", size: 18))
                        .layoutPriority(1)
                        .frame(minHeight: 120)
                        .padding(.leading, 10)
                        
                        
                    Image("littlelemon-hero")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.leading, 5)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                }
                
            }
            .foregroundStyle(Color.lightAccent)
            .background(Rectangle().fill(Color.primGreen))
            
        }
    }
}

#Preview {
    TopView()
}
