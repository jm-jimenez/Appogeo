import Foundation

protocol BasePresenterProtocol: class {
    
}

class BasePresenter: BasePresenterProtocol {
    weak private var baseView: BaseViewControllerProtocol?
    
    func setBaseViewWith(_ baseView: BaseViewControllerProtocol?) {
        self.baseView = baseView
    }
}
