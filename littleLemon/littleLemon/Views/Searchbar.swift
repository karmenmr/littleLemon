import SwiftUI

struct Searchbar: View {
    
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.secondary : Color.primGreen)
            TextField("search", text: $searchText)
                .font(.custom("Karla-Regular", size: 18))
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10, y: 0)
                        .foregroundStyle(Color.secondary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    , alignment: .trailing
                    )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.darkAccent.opacity(0.15), radius: 3)
        )
    }
}

#Preview {
    Searchbar(searchText: .constant(""))
}

