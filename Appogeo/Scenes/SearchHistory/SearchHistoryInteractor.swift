import Foundation

protocol SearchHistoryInteractorProtocol: BaseInteractorProtocol {

}

class SearchHistoryInteractor: BaseInteractor, SearchHistoryInteractorProtocol {
    var presenter: SearchHistoryPresenterProtocol? {
        didSet {
            setBasePresenterWith(presenter)
        }
    }
    private var searchsWorker: SearchWorker = SearchWorker(searchStore: SearchCoreDataStore())
    
    override func viewDidLoad() {
        getSearchHistory(request: SearchHistory.GetSearchs.Request())
    }
    
    private func getSearchHistory(request: SearchHistory.GetSearchs.Request) {
        searchsWorker.fetchSearchs { embassies in
            print(embassies)
        }
    }
}
