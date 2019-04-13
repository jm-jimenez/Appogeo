import Foundation

protocol LocationSearchPresenterProtocol: BasePresenterProtocol {
    func updateCurrentPosition(latitude: Double, longitude: Double)
}

class LocationSearchPresenter: BasePresenter, LocationSearchPresenterProtocol {
    weak var view: LocationSearchViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
    
    func updateCurrentPosition(latitude: Double, longitude: Double) {
        let nf = NumberFormatter()
        nf.locale = Locale.current
        nf.numberStyle = .decimal
        
        let correctLat = nf.string(from: NSNumber(value: latitude))
        let correctLon = nf.string(from: NSNumber(value: longitude))
        
        view?.updateTextfields(latitude: correctLat!, longitude: correctLon!)
    }
}
