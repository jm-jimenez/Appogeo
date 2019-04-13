import UIKit

class DashboardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let embassyListVC = EmbassyListViewController(nibName: "EmbassyListView", bundle: nil)
        embassyListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let searchHistoryVC = SearchHistoryViewController(nibName: "SearchHistoryView", bundle: nil)
        searchHistoryVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        viewControllers = [embassyListVC, searchHistoryVC].map { UINavigationController(rootViewController: $0) }
    }
}
