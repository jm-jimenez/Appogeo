import Foundation
import MapKit

class EmbassyAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let displayedPOI = newValue as? MapDetail.LoadPOIs.ViewModel.DisplayedPOI else {return}
            let size = CGSize(width: 75, height: 90)
            UIGraphicsBeginImageContext(size)
            displayedPOI.image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            image = resizedImage
            centerOffset = CGPoint(x: 0, y: image!.size.height / -2)
        }
    }
}
