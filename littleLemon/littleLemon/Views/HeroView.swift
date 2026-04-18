import SwiftUI

struct HeroView: View {
    @EnvironmentObject private var model: DishModel
    @State var searchText = ""

    var body: some View {
        VStack(alignment: .center) {
            Topbar
            OrderForDelivery
        }
    }
}

#Preview {
    HeroView()
        .environmentObject(DishModel.preview)
}

extension HeroView {
    private var Topbar: some View {
        VStack(spacing: 0) {
            TopView()
            HStack {
                Searchbar(searchText: $model.searchText)
                    .padding([.leading, .trailing, .top], 15)
                    .padding(.bottom, 30)
            }.background(Color.primGreen)
        }
    }
    
    private var OrderForDelivery: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Order For Delivery!".uppercased())
                    .font(.custom("MarkaziText-Bold", size: 32))
                Spacer()
            }
            ScrollView([.horizontal], showsIndicators: false) {
                HStack {
                    ForEach(model.categories, id: \.self) { category in
                        Spacer()
                        let selected = model.selectedCategory == category
                        Button(category) {
                            model.selectedCategory = selected ? nil : category
                        }
                        .font(.custom("Karla-Regular_Bold", size: 18))
                        .foregroundStyle(selected ? Color.lightAccent : Color.primGreen)
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.primGreen.opacity(selected ? 1.0 : 0.1))
                        }
                        
                        Spacer()
                    }
                }
                
            }
            .defaultScrollAnchor(.center)
        }
        .padding()
    }
}
