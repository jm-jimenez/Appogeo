import Foundation
import UIKit
import MapKit

protocol MapDetailPresenterProtocol: BasePresenterProtocol {
    func presentPOIs(response: [POIRepresentable], searchLocation: (lat: Double, lon: Double, dist: Int)?)
}

protocol POIRepresentable {
    var latitude: Double { get }
    var longitude: Double { get }
    var title: String { get }
    var image: UIImage { get }
}

class MapDetailPresenter: BasePresenter, MapDetailPresenterProtocol {
    weak var view: MapDetailViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
    
    func presentPOIs(response: [POIRepresentable], searchLocation: (lat: Double, lon: Double, dist: Int)?) {
        let displayedPOIs = response.map{ (POIRepresentable) -> MapDetail.LoadPOIs.ViewModel.DisplayedPOI in
            return MapDetail.LoadPOIs.ViewModel.DisplayedPOI(latitude: POIRepresentable.latitude, longitude: POIRepresentable.longitude, title: POIRepresentable.title, image: POIRepresentable.image)
        }
        
        let viewModel = MapDetail.LoadPOIs.ViewModel(displayedPOIs: displayedPOIs)
        view?.displayPOIs(viewModel: viewModel)
        if let searchLocation = searchLocation {
            let coordinate = CLLocationCoordinate2D(latitude: searchLocation.lat, longitude: searchLocation.lon)
            view?.centerInCoordinate(coordinate: coordinate, radius: searchLocation.dist)
        } else {
            view?.centerInCoordinate(coordinate: viewModel.displayedPOIs[0].coordinate, radius: 1000)
        }
    }
}
