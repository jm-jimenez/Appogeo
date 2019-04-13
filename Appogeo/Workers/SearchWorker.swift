import Foundation

class SearchWorker {
    var searchStore: SearchStoreProtocol
    
    init(searchStore: SearchStoreProtocol) {
        self.searchStore = searchStore
    }
    
    func saveSearch(searchToSave: EmbassyModel) {
        searchStore.saveSearch(searchToSave: searchToSave) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    print("\(result.title) saved")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


protocol SearchStoreProtocol {
    func saveSearch(searchToSave: EmbassyModel, completion: SearchStoreSaveCompletionHandler)
}

enum SearchStoreResult<T> {
    case success(result: T)
    case failure(error: SearchStoreError)
}

enum SearchStoreError: Error {
    case saveFailed(String)
}

typealias SearchStoreSaveCompletionHandler = (SearchStoreResult<EmbassyModel>) -> ()
