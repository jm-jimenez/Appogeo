import Foundation

class EmbassiesWorker {
    var embassiesStore: EmbassiesStoreProtocol
    
    init(embassiesStore: EmbassiesStoreProtocol) {
        self.embassiesStore = embassiesStore
    }
    
    func fetchAllEmbassies(completion: @escaping ([EmbassyModel]) -> ()) {
        embassiesStore.fetchAllEmbassies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    completion(result)
                case .failure:
                    completion([])
                }
            }
        }
    }
    
    func fetchEmbassiesWith(params: LocationSearch.Search.Request, completion: @escaping EmbassiesStoreFetchGeoEmbassies) {
        embassiesStore.fetchEmbassiesWith(params: params) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

protocol EmbassiesStoreProtocol {
    func fetchAllEmbassies(completion: @escaping EmbassiesStoreFetchAllEmbassiesCompletionHandler)
    func fetchEmbassiesWith(params: LocationSearch.Search.Request, completion: @escaping EmbassiesStoreFetchGeoEmbassies)
}

enum EmbassiesStoreResult<T> {
    case success(result: T)
    case failure(error: EmbassiesStoreError)
}

enum EmbassiesStoreError: Error {
    case FetchFailed(String)
    case WrongInput(String)
}

typealias EmbassiesStoreFetchAllEmbassiesCompletionHandler = (EmbassiesStoreResult<[EmbassyModel]>) -> ()
typealias EmbassiesStoreFetchGeoEmbassies = (EmbassiesStoreResult<[EmbassyGeoModel]>) -> ()
