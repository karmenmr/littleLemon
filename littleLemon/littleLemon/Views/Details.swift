import SwiftUI

struct Details: View {
    let dish: Dish
    init(_ dish: Dish) { self.dish = dish }
    var body: some View {
        HStack {
            Text("\(dish.nameValue)  \(dish.priceValue)")
            if let path = dish.image {
                AsyncImage(url: URL(string: path)) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Color.red
                    } else {
                        Color.green
                    }
                }
            }
        }
    }
}

#Preview {
    Details(DishModel.preview.dishes.first!)
}
