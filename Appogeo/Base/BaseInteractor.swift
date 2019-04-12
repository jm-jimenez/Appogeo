import Foundation

protocol BaseInteractorProtocol {
    func viewDidLoad()
    func viewWillAppear()
}

class BaseInteractor: BaseInteractorProtocol {
    private weak var basePresenter: BasePresenterProtocol?
    
    func setBasePresenterWith(_ basePresenter: BasePresenterProtocol?) {
        self.basePresenter = basePresenter
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
}
