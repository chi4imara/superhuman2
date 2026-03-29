import Foundation
import UIKit

struct HumanModel: Codable, Hashable, Identifiable {
    let id: Int
    var name: String
    var category: String
    var state: [String: Int]
    var colors: String
    var titleImage: String
    var isFavorite: Bool
    
    var color: UIColor { UIColor.hex(colors) }
    
    enum CodingKeys: String, CodingKey {
        case name, id, isFavorite, category, state, titleImage
        case colors = "colors"
    }
    
    init(id: Int, name: String, category: String, state: [String: Int], colors: String, titleImage: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.state = state
        self.colors = colors
        self.titleImage = titleImage
        self.isFavorite = isFavorite
    }
}
