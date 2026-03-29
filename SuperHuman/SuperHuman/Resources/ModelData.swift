import Foundation

class ModelData {
    static var shared = ModelData()
    
    var human: [HumanModel] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.human = load("human.json")
    }
}
