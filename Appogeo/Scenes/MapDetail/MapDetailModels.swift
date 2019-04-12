import Foundation
import MapKit

enum MapDetail {
    enum LoadPOIs {
        struct Request {
            
        }
        
        struct Response {
            let embassies: [EmbassyModel]
        }
        
        struct ViewModel {
            class DisplayedPOI: NSObject, MKAnnotation {
                var coordinate: CLLocationCoordinate2D
                var title: String?
                var subtitle: String?
                var image: UIImage?
                
                init(latitude: Double, longitude: Double, title: String? = nil, subtitle: String? = nil, image: UIImage?) {
                    coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    self.title = title
                    self.subtitle = subtitle
                    self.image = image
                }
            }
            
            var displayedPOIs: [DisplayedPOI]
        }
    }
}
