import Foundation
import CoreData


extension ManagedEmbassy {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedEmbassy>
    {
        return NSFetchRequest<ManagedEmbassy>(entityName: "ManagedEmbassy")
    }

    @NSManaged public var idUrl: String?
    @NSManaged public var typeUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var locality: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date?

}
