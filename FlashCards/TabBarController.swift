import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        tabBar.items?[0].title = "Decks"
        //tabBar.items?[1].title = "Praticar"
        tabBar.items?[2].title = "Ajustes"

        tabBar.items?[0].image = UIImage(systemName: selectedIndex == 0 ? "list.bullet.rectangle.fill":"list.bullet.rectangle")
        tabBar.items?[2].image = UIImage(systemName: selectedIndex == 2 ? "gearshape.fill":"gearshape")

        tabBar.tintColor = UIColor(designSystem: DesignSystem.AssetsColor.tabBarTint)
        setupMiddleButton()
        
        tabBar.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.tabBar)
        setupMiddleButton()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.tabBar)
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
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
        
        if viewController === viewControllers?.first || viewController === viewControllers?.last {
            return true
        }
        
        return false
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[0] {
            tabBar.items?[0].image = UIImage(systemName: "list.bullet.rectangle.fill")
            tabBar.items?[2].image = UIImage(systemName: "gearshape")
        } else {
            tabBar.items?[0].image = UIImage(systemName: "list.bullet.rectangle")
            tabBar.items?[2].image = UIImage(systemName: "gearshape.fill")
        }
    }
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 30, y: -30, width: 60, height: 60))
        
        middleButton.setBackgroundImage(UIImage(named: "tabBarButton"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        
        var myDecksCount = 0

        do {
            myDecksCount = try context.fetch(Deck.fetchRequest()).count
        } catch { }
                
        if myDecksCount == 0 {
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("without_decks", comment: ""), preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default) { (action) in
               return
            }
            
            alert.addAction(okButton)

            self.present(alert, animated: true, completion: nil)
            
        } else {
            randomPractice()
        }
        
    }
    
    
    func randomPractice() {
        
        let storyBoard = UIStoryboard(name: "Deck", bundle: .main)
        
        guard let singleDeckController = storyBoard.instantiateInitialViewController()
        else { return }
        
        navigationController?.pushViewController(singleDeckController, animated: true)
        
    }
    
}
