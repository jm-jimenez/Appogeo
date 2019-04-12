import Foundation

class SearchWorker {
    var searchStore: SearchStoreProtocol
    
    init(searchStore: SearchStoreProtocol) {
        self.searchStore = searchStore
    }
    
    func saveSearch() {
        searchStore.saveSearch { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Saved")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


protocol SearchStoreProtocol {
    func saveSearch(completion: SearchStoreSaveCompletionHandler)
}

enum SearchStoreResult<T> {
    case success(result: T)
    case failure(error: SearchStoreError)
}

enum SearchStoreError: Error {
    case saveFailed(String)
}

typealias SearchStoreSaveCompletionHandler = (SearchStoreResult<Void>) -> ()
