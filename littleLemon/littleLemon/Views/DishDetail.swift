import SwiftUI

struct DishDetail: View {
    @EnvironmentObject var model: DishModel
    let dish: Dish
    
    init(_ dish: Dish) {
        self.dish = dish
    }
    
    var body: some View {
        NavView {
            VStack(alignment: .center, spacing: 20) {
                
                Text(dish.nameValue)
                    .font(.custom("MarkaziText-Bold", size: 32))
                
                Image(dish.imageValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .clipShape(Rectangle())
                
                Text(dish.descValue)
                    .font(.custom("Karla-Regular", size: 18))
                    .padding([.leading, .trailing], 20)
                
                Text(dish.priceValue)
                    .font(.custom("Karla-Regular_Medium", size: 22))
                
                Spacer()
            }
            .onDisappear {
                model.selectedDish = nil
            }
            .padding()
        }
    }
    
}

#Preview {
    DishDetail(DishModel.preview.dishes.first!)
        .environmentObject(DishModel.preview)
}
