import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let heroesVC = SuperheroesViewController()
        let villainsVC = SupervillainsViewController()
        
        heroesVC.tabBarItem = UITabBarItem(title: "Superheroes", image: UIImage(named: "superheroes"), tag: 0)
        villainsVC.tabBarItem = UITabBarItem(title: "Supervillains", image: UIImage(named: "supervillains 1"), tag: 1)
        
        let heroesNavController = UINavigationController(rootViewController: heroesVC)
        let villainsNavController = UINavigationController(rootViewController: villainsVC)
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .black

        tabBarController.viewControllers = [heroesNavController, villainsNavController]

        setupTabBarAppearance(tabBarController)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setupTabBarAppearance(_ tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
        ]
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.isTranslucent = true
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

