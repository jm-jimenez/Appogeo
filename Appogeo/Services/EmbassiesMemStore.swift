import Foundation

class EmbassiesMemStore: EmbassiesStoreProtocol {
    func fetchAllEmbassies(completion: @escaping EmbassiesStoreFetchAllEmbassiesCompletionHandler) {
        let address = Address.init(locality: "MADRID", street_address: "Calle Sierra Vieja 37 28031 Madrid")
        let location = Location.init(latitude: 40.4103989, longitude: -3.701173516)
        let embassyModel = EmbassyModel.init(idUrl: "123", typeUrl: "12312", title: "Embajada de mis padres", address: address, location: location, creationDate: nil)
        
        let address2 = Address.init(locality: "Rivas Vaciamadrid", street_address: "Av de las naciones 28521")
        let location2 = Location.init(latitude: 40.3775811, longitude: -3.6281829)
        let embassyModel2 = EmbassyModel.init(idUrl: "123", typeUrl: "12312", title: "Consulado de mi casa", address: address2, location: location2, creationDate: nil)
        
        completion(.success(result: [embassyModel, embassyModel2]))
    }
}
