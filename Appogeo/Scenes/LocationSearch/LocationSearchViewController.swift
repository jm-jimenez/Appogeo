import UIKit
import CoreLocation

protocol LocationSearchViewControllerProtocol: BaseViewControllerProtocol {
    func updateTextfields(latitude: String, longitude: String)
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
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router = LocationSearchRouter(navigation: navigationController)
        interactor?.router = router
    }
    
    func updateTextfields(latitude: String, longitude: String) {
        latitudeTf.text = latitude
        longitudeTf.text = longitude
    }
    
    @IBAction func continueBtnTap(_ sender: UIButton) {
        interactor?.didTapOnContinue(latitude: latitudeTf.text, longitude: longitudeTf.text)
    }
}
