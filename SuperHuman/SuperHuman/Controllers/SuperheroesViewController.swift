import UIKit

final class SuperheroesViewController: SuperHumanViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHumanTable(filterCategory: "Superheroes")
        
        setupNavigationBar(title: "Superheroes")
    }
}
