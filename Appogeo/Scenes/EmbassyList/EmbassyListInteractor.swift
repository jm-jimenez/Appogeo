import Foundation

protocol EmbassyListInteractorProtocol: BaseInteractorProtocol {
    var router: EmbassyListRouterProtocol? { get set }
    func showInMapEmbassy(at index: Int)
}

class EmbassyListInteractor: BaseInteractor, EmbassyListInteractorProtocol {
    private var embassies: [EmbassyModel]?
    var presenter: EmbassyListPresenterProtocol? {
        didSet {
            setBasePresenterWith(presenter)
        }
    }
    var router: EmbassyListRouterProtocol?
    
    private var embassiesWorker: EmbassiesWorker = EmbassiesWorker(embassiesStore: EmbassiesAPIStore())
    private var searchWorker: SearchWorker = SearchWorker(searchStore: SearchCoreDataStore())
    
    override func viewDidLoad() {
        getAllEmbassies(request: EmbassyList.GetEmbassies.Request())
    }
    
    private func getAllEmbassies(request: EmbassyList.GetEmbassies.Request) {
        embassiesWorker.fetchAllEmbassies { [weak self] embassies in
            self?.embassies = embassies
            self?.presenter?.presentFetchedEmbassies(response: EmbassyList.GetEmbassies.Response(graph: embassies))
        }
    }
    
    func showInMapEmbassy(at index: Int) {
        let embassy = embassies![index]
        searchWorker.saveSearch(searchToSave: embassy)
        router?.showInMapEmbassy(embassyModel: embassy)
    }
}
