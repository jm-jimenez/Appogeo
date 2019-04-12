import Foundation
import UIKit

protocol BaseViewControllerProtocol: class {

}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    private var baseInteractor: BaseInteractorProtocol?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIP()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIP()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        baseInteractor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        baseInteractor?.viewWillAppear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupVIP() {
        fatalError("setupVIP() needs to be overridden")
    }
    
    func setupUI() {
        
    }
    
    func setupNavBar(){
        
    }
    
    func setBaseInteractorWith(_ baseInteractor: BaseInteractorProtocol?) {
        self.baseInteractor = baseInteractor
    }
}
