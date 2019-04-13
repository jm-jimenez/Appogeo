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
    
    func fetchSearchs(completion: SearchStoreFetchAllCompletionHandler) {
        do {
            let background = CoreDataManager.shared.persistentContainer.newBackgroundContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedEmbassy")
            let results = try background.fetch(fetchRequest) as! [ManagedEmbassy]
            let embassies = results.map { $0.toEmbassy() }
            completion(.success(result: embassies))
        } catch {
            completion(.failure(error: .fetchFailed(error.localizedDescription)))
        }
    }
}
