import Foundation
import SwiftUI
internal import CoreData

extension PreviewProvider {
    static var dev: DeveloperPreview { .preview }
}

class DeveloperPreview {
    static let preview = DeveloperPreview()
    let dishModel = DishModel.preview
    private init() {}
}
