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
    
    override func viewWillAppear() {
        getSearchHistory(request: SearchHistory.GetSearchs.Request())
    }
    
    private func getSearchHistory(request: SearchHistory.GetSearchs.Request) {
        searchsWorker.fetchSearchs { [weak self] embassies in
            self?.presenter?.presentFetchedSearchs(response: SearchHistory.GetSearchs.Response(searchs: embassies))
        }
    }
}
