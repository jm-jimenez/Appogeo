import UIKit
import MapKit

protocol MapDetailViewControllerProtocol: BaseViewControllerProtocol {
    func displayPOIs(viewModel: MapDetail.LoadPOIs.ViewModel)
    func centerInCoordinate(coordinate: CLLocationCoordinate2D, radius: Int)
}

class MapDetailViewController: BaseViewController, MapDetailViewControllerProtocol {
    
    @IBOutlet var mapView: MKMapView!
    
    var interactor: MapDetailInteractorProtocol? {
        didSet {
            setBaseInteractorWith(interactor)
        }
    }
    
    var displayedPOIs: [MapDetail.LoadPOIs.ViewModel.DisplayedPOI] = [] {
        didSet {
            mapView.addAnnotations(displayedPOIs)
        }
    }
    
    override func setupVIP() {
        let viewController = self
        let interactor = MapDetailInteractor()
        let presenter = MapDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
    
    override func viewDidLoad() {
        configMapView()
        super.viewDidLoad()
    }
    
    private func configMapView() {
        mapView.register(EmbassyAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    func displayPOIs(viewModel: MapDetail.LoadPOIs.ViewModel) {
        displayedPOIs = viewModel.displayedPOIs
    }
    
    func centerInCoordinate(coordinate: CLLocationCoordinate2D, radius: Int) {
        let centerRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(centerRegion, animated: true)
    }
}
