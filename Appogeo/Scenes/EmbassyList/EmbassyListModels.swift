import Foundation
import UIKit

enum EmbassyList {
    enum GetEmbassies {
        struct Request {
            
        }
        
        struct Response: Decodable {
            let graph: [EmbassyModel]
            
            enum CodingKeys: String, CodingKey {
                case graph = "@graph"
            }
        }
        
        struct ViewModel {
            struct DisplayedEmbassy {
                let icon: UIImage?
                let title: String
                let locality: String
                let address: String
            }
            var displayedEmbassies: [DisplayedEmbassy]
        }
    }
}
