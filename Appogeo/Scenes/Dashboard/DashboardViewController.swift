import UIKit

class DashboardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let embassyListVC = EmbassyListViewController(nibName: "EmbassyListView", bundle: nil)
        embassyListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let searchHistoryVC = SearchHistoryViewController(nibName: "SearchHistoryView", bundle: nil)
        searchHistoryVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let locationSearchVC = LocationSearchViewController(nibName: "LocationSearchView", bundle: nil)
        locationSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        viewControllers = [embassyListVC, searchHistoryVC, locationSearchVC].map { UINavigationController(rootViewController: $0) }
    }
}
