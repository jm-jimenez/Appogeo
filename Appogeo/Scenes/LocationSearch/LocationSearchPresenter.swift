import Foundation

protocol LocationSearchPresenterProtocol: BasePresenterProtocol {
    func updateCurrentPosition(latitude: Double, longitude: Double)
    func shouldPresentLoading(_ show: Bool)
    func presentGPSFailed()
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
        
        guard let correctLat = nf.string(from: NSNumber(value: latitude)), let correctLon = nf.string(from: NSNumber(value: longitude)) else {
            presentGPSFailed()
            return
        }
        
        view?.updateTextfields(latitude: correctLat, longitude: correctLon)
    }
    
    func shouldPresentLoading(_ show: Bool) {
        view?.shouldDisplayLoading(show)
    }
    
    func presentGPSFailed() {
        view?.displayAlertWith(title: "Error", message: "gps_error".localized)
    }
}
