import Foundation

class ModelData {
    static var shared = ModelData()
    
    var human: [HumanModel] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        do {
            self.human = load("human.json")
        } catch {
            fatalError("Ошибка загрузки: \(error)")
        }
    }
}
