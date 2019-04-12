import Foundation
import UIKit

struct EmbassyModel: Decodable {
    let idUrl: String
    let typeUrl: String
    let title: String
    let address: Address
    let location: Location?
    
    
    var type: EmbassyOrConsulate {
        if title.lowercased().contains("embajada") {
            return .embassy
        } else if title.lowercased().contains("consulado") {
            return .consulate
        } else {
            return .undefined
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case idUrl = "@id"
        case typeUrl = "@type"
        case title = "title"
        case address = "address"
        case location = "location"
    }
}

struct Address: Decodable {
    let locality: String
    let street_address: String
    
    enum CodingKeys: String, CodingKey {
        case locality = "locality"
        case street_address = "street-address"
    }
}

enum EmbassyOrConsulate {
    case embassy
    case consulate
    case undefined
    
    var icon: UIImage? {
        switch self {
        case .embassy:
            return #imageLiteral(resourceName: "embassyIcon")
        case .consulate:
            return #imageLiteral(resourceName: "consulateIcon")
        case .undefined:
            return nil
        }
    }
    
    var iconPOI: UIImage? {
        switch self {
        case .embassy:
            return #imageLiteral(resourceName: "embassyPOI")
        case .consulate:
            return #imageLiteral(resourceName: "consulatePOI")
        case .undefined:
            return nil
        }
    }
}

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
}
