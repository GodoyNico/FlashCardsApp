import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController === viewControllers?.first {
            return true
        }
        
        let storyBoard = UIStoryboard(name: "Deck", bundle: .main)
        
        guard let singleDeckController = storyBoard.instantiateInitialViewController() else { return false }
        
        navigationController?.pushViewController(singleDeckController, animated: true)
        
        return false
        
    }
    
}
