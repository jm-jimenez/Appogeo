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
}

protocol EmbassiesStoreProtocol {
    func fetchAllEmbassies(completion: @escaping EmbassiesStoreFetchAllEmbassiesCompletionHandler)
}

enum EmbassiesStoreResult<T> {
    case success(result: T)
    case failure(error: EmbassiesStoreError)
}

enum EmbassiesStoreError: Error {
    case FetchFailed(String)
}

typealias EmbassiesStoreFetchAllEmbassiesCompletionHandler = (EmbassiesStoreResult<[EmbassyModel]>) -> ()
