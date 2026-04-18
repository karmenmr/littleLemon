import SwiftUI
internal import CoreData

struct Menu: View {
    @EnvironmentObject private var model: DishModel
    @State var searchText = ""
        
    var body: some View {
//        ScrollView {
            VStack(alignment: .center) {
                VStack {
                    Topbar
                    OrderForDelivery
                }
//                .layoutPriority(1)
//                Spacer()
                MenuItems
            }
//        }
    }
}

#Preview {
    Menu()
        .environmentObject(DishModel.preview)
}

extension Menu {
    private func categorySelected(_ category: String) {
        
    }
}

extension Menu {
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
                        Button(category, action:categorySelected) 
                            .font(.custom("Karla-Regular_Bold", size: 18))
                            .foregroundStyle(Color.primGreen)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.primGreen.opacity(0.1))
                            }
                        Spacer()
                    }
                }
                
            }
            .defaultScrollAnchor(.center)
        }
        .padding()
    }
    
    private var MenuItems: some View {
        VStack {
            List {
                ForEach(model.dishes) { dish in
                    DishItemDetail(dish)
                }
            }
            .listStyle(.plain)
        }
    }
    
}
