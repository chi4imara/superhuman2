import UIKit

final class SupervillainsViewController: SuperHumanViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHumanTable(filterCategory: "Supervillains")
        
        setupNavigationBar(title: "Supervillains")
    }
}
