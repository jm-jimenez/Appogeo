import Foundation

protocol MapDetailInteractorProtocol: BaseInteractorProtocol {
    var itemsToShow: [EmbassyModel]? { get set }
}

class MapDetailInteractor: BaseInteractor, MapDetailInteractorProtocol {
    var presenter: MapDetailPresenterProtocol? {
        didSet {
            setBasePresenterWith(presenter)
        }
    }
    
    var itemsToShow: [EmbassyModel]?
    
    override func viewDidLoad() {
        getItemsToShow(request: MapDetail.LoadPOIs.Request())
    }
    
    private func getItemsToShow(request: MapDetail.LoadPOIs.Request) {
        if let itemsToShow = itemsToShow {
            presenter?.presentPOIs(response: MapDetail.LoadPOIs.Response(embassies: itemsToShow))
        }
    }
}
