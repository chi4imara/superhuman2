import Foundation

extension Notification.Name {
    static let humanFavoriteDidChange = Notification.Name("SuperHuman.humanFavoriteDidChange")
}

class ModelData {
    static var shared = ModelData()

    var human: [HumanModel] = []

    init() {
        loadData()
    }

    func loadData() {
        self.human = load("human.json")
    }

    func human(withId id: Int) -> HumanModel? {
        human.first { $0.id == id }
    }

    func setFavorite(id: Int, isFavorite: Bool) {
        guard let index = human.firstIndex(where: { $0.id == id }) else { return }
        var updated = human[index]
        updated.isFavorite = isFavorite
        human[index] = updated
        NotificationCenter.default.post(name: .humanFavoriteDidChange, object: nil)
    }
}
