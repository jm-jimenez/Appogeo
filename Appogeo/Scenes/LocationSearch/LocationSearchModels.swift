import Foundation
import UIKit

enum LocationSearch {
    enum Search {
        struct Request: Encodable {
            let latitude: Double
            let longitude: Double
            let distance: Int
            
            enum CodingKeys: String, CodingKey {
                case latitude = "latitud"
                case longitude = "longitud"
                case distance = "distancia"
            }
        }
        
        struct Response: Decodable {
            let graph: [EmbassyGeoModel]
            
            enum CodingKeys: String, CodingKey {
                case graph = "@graph"
            }
        }
    }
}

struct EmbassyGeoModel: Decodable, POIRepresentable {
    let title: String
    let location: Location
    
    var type: EmbassyOrConsulate {
        if title.lowercased().contains("embajada") {
            return .embassy
        } else if title.lowercased().contains("consulado") {
            return .consulate
        } else {
            return .undefined
        }
    }
    
    var latitude: Double {
        return location.latitude
    }
    
    var longitude: Double {
        return location.longitude
    }
    
    var image: UIImage {
        return type.iconPOI
    }
}
