import Foundation
import UIKit

protocol EmbassyListRouterProtocol {
    func showInMapEmbassy(embassyModel: EmbassyModel)
}

class EmbassyListRouter: EmbassyListRouterProtocol {
    private var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func showInMapEmbassy(embassyModel: EmbassyModel) {
        let vc = MapDetailViewController(nibName: "MapDetailView", bundle: nil)
        vc.interactor?.itemsToShow = [embassyModel]
        navigation?.pushViewController(vc, animated: true)
    }
}
