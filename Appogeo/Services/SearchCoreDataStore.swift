import Foundation
import CoreData

class SearchCoreDataStore: SearchStoreProtocol {
    func saveSearch(searchToSave: EmbassyModel, completion: SearchStoreSaveCompletionHandler) {
        do {
        let background = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        let managedEmbassy = NSEntityDescription.insertNewObject(forEntityName: "ManagedEmbassy", into: background) as! ManagedEmbassy
        
            managedEmbassy.fromEmbassy(embassy: searchToSave, dateOfCreation: Date())
        try background.save()
        completion(.success(result: searchToSave))
        } catch {
            let error = SearchStoreError.saveFailed("Failed to save \(searchToSave.title)")
            completion(.failure(error: error))
        }
        
    }
}
