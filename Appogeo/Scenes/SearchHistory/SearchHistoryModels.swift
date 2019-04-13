import Foundation
import UIKit

enum SearchHistory {
    enum GetSearchs {
        struct Request {
            
        }
        
        struct Response {
            var searchs: [EmbassyModel]
        }
        
        struct ViewModel {
            struct DisplayedSearch {
                let icon: UIImage?
                let title: String
                let locality: String
                let address: String
            }
            var displayedSearchs: [DisplayedSearch]
        }
    }
}
