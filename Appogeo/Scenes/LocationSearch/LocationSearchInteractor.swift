import Foundation

protocol LocationSearchInteractorProtocol: BaseInteractorProtocol {
    var router: LocationSearchRouterProtocol? { get set }
    func didTapOnContinue(latitude: String?, longitude: String?)
}

class LocationSearchInteractor: BaseInteractor, LocationSearchInteractorProtocol {
    var presenter: LocationSearchPresenterProtocol? {
        didSet {
            setBasePresenterWith(presenter)
        }
    }
    var router: LocationSearchRouterProtocol?
    
    private var embassiesWorker = EmbassiesWorker(embassiesStore: EmbassiesAPIStore())
    private var searchLocation: LocationSearch.Search.Request?
    
    func didTapOnContinue(latitude: String?, longitude: String?) {
        guard let latitude = latitude, let longitude = longitude else {
            let error = EmbassiesStoreError.FetchFailed("Empty fields")
            let result = EmbassiesStoreResult<[EmbassyGeoModel]>.failure(error: error)
            handleResult(result: result)
            return
        }
        let correctLat = latitude.replacingOccurrences(of: Locale.current.groupingSeparator!, with: "").replacingOccurrences(of: Locale.current.decimalSeparator!, with: ".")
        let correctLon = longitude.replacingOccurrences(of: Locale.current.groupingSeparator!, with: "").replacingOccurrences(of: Locale.current.decimalSeparator!, with: ".")
        guard let lat = Double(correctLat), let lon = Double(correctLon) else {
            let error = EmbassiesStoreError.FetchFailed("Couldn't parse")
            let result = EmbassiesStoreResult<[EmbassyGeoModel]>.failure(error: error)
            handleResult(result: result)
            return
        }
        let request = LocationSearch.Search.Request.init(latitude: lat, longitude: lon, distance: 1000)
        searchLocation = request
        fetchGeoEmbassies(request: request)
    }
    
    private func fetchGeoEmbassies(request: LocationSearch.Search.Request) {
        embassiesWorker.fetchEmbassiesWith(params: request) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    private func handleResult(result: EmbassiesStoreResult<[EmbassyGeoModel]>) {
        switch result {
        case .success(let embassies):
            router?.showResultsInMap(embassies: embassies, searchLocation: searchLocation)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
