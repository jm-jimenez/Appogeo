import UIKit
import CoreLocation

protocol LocationSearchViewControllerProtocol: BaseViewControllerProtocol {

}

class LocationSearchViewController: BaseViewController, LocationSearchViewControllerProtocol {
    
    @IBOutlet var latitudeLbl: UILabel!
    @IBOutlet var latitudeTf: UITextField!
    @IBOutlet var longitudeLbl: UILabel!
    @IBOutlet var longitudeTf: UITextField!
    @IBOutlet var continueBtn: UIButton!
    
    private var locationManager: CLLocationManager = CLLocationManager()
    private var isFetchingLocation: Bool = false
    
    var interactor: LocationSearchInteractorProtocol? {
        didSet {
            setBaseInteractorWith(interactor)
        }
    }
    var router: LocationSearchRouterProtocol?
    
    override func setupVIP() {
        let viewController = self
        let interactor = LocationSearchInteractor()
        let presenter = LocationSearchPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
    
    override func viewDidLoad() {
        latitudeLbl.text = "latitude".localized
        longitudeLbl.text = "longitude".localized
        continueBtn.setTitle("continue".localized, for: .normal)
        continueBtn.layer.cornerRadius = 10
        configLocationManager()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router = LocationSearchRouter(navigation: navigationController)
        interactor?.router = router
        if !isFetchingLocation { locationManager.requestLocation() }
    }
    
    private func configLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        isFetchingLocation = true
        locationManager.requestLocation()
    }
    
    @IBAction func continueBtnTap(_ sender: UIButton) {
        interactor?.didTapOnContinue(latitude: latitudeTf.text, longitude: longitudeTf.text)
    }
}

extension LocationSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            isFetchingLocation = true
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        isFetchingLocation = false
        latitudeTf.text = String(locations[0].coordinate.latitude)
        longitudeTf.text = String(locations[0].coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isFetchingLocation = false
        print(error)
    }
}
