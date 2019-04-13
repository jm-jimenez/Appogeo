import Foundation
import CoreData

@objc(ManagedEmbassy)
public class ManagedEmbassy: NSManagedObject {

    func fromEmbassy(embassy: EmbassyModel, dateOfCreation: Date? = nil) {
        idUrl = embassy.idUrl
        typeUrl = embassy.typeUrl
        title = embassy.title
        locality = embassy.address.locality
        streetAddress = embassy.address.street_address
        latitude = embassy.location?.latitude ?? 0
        longitude = embassy.location?.longitude ?? 0
        date = dateOfCreation
    }
    
    func toEmbassy() -> EmbassyModel {
        var location: Location?
        if latitude == 0 && longitude == 0 {
            location = nil
        } else {
            location = Location.init(latitude: latitude, longitude: longitude)
        }
        let address = Address.init(locality: locality!, street_address: streetAddress!)
        let embassy = EmbassyModel.init(idUrl: idUrl!, typeUrl: typeUrl!, title: title!, address: address, location: location)
        return embassy
    }
}
