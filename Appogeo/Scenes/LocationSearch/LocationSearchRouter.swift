import Foundation
import UIKit

protocol LocationSearchRouterProtocol {
    func showResultsInMap(embassies: [EmbassyGeoModel], searchLocation: LocationSearch.Search.Request?)
}

class LocationSearchRouter: LocationSearchRouterProtocol {
	
    private var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func showResultsInMap(embassies: [EmbassyGeoModel], searchLocation: LocationSearch.Search.Request?) {
        let vc = MapDetailViewController(nibName: "MapDetailView", bundle: nil)
        vc.interactor?.itemsToShow = embassies
        if let searchLocation = searchLocation {
            vc.interactor?.searchLocation = (lat: searchLocation.latitude, lon: searchLocation.longitude, dist: searchLocation.distance)
        }
        navigation?.pushViewController(vc, animated: true)
    }
}
