import SwiftUI

struct DishItemDetail: View {
    let dish: Dish
    init(_ dish: Dish) { self.dish = dish }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(dish.nameValue)
                    .font(.custom("Karla-Regular_Bold", size: 18))
                Spacer()
            }
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading) {
                    Text(dish.descValue)
                        .font(.custom("Karla-Regular", size: 15))
                    Spacer()
                    HStack {
                        Text(dish.priceValue)
                            .font(.custom("Karla-Regular_Medium", size: 18))
                        Spacer()
                    }
                }
                Spacer()
                Image(dish.imageValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Rectangle())
                
            }
            
        }
        .padding()
    }
}

#Preview {
    DishItemDetail(DishModel.preview.dishes.first!)
}
