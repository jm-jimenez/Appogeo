import Foundation

protocol MapDetailInteractorProtocol: BaseInteractorProtocol {
    var itemsToShow: [POIRepresentable]? { get set }
    var searchLocation: (lat: Double, lon: Double, dist: Int)? { get set }
}

class MapDetailInteractor: BaseInteractor, MapDetailInteractorProtocol {
    var presenter: MapDetailPresenterProtocol? {
        didSet {
            setBasePresenterWith(presenter)
        }
    }
    
    var itemsToShow: [POIRepresentable]?
    var searchLocation: (lat: Double, lon: Double, dist: Int)?
    
    override func viewDidLoad() {
        getItemsToShow(request: MapDetail.LoadPOIs.Request())
    }
    
    private func getItemsToShow(request: MapDetail.LoadPOIs.Request) {
        if let itemsToShow = itemsToShow {
            presenter?.presentPOIs(response: itemsToShow, searchLocation: searchLocation)
        }
    }
}
