import UIKit

protocol SearchHistoryViewControllerProtocol: BaseViewControllerProtocol {

}

class SearchHistoryViewController: BaseViewController, SearchHistoryViewControllerProtocol {

    var interactor: SearchHistoryInteractorProtocol? {
        didSet {
            setBaseInteractorWith(interactor)
        }
    }
    
    override func setupVIP() {
        let viewController = self
        let interactor = SearchHistoryInteractor()
        let presenter = SearchHistoryPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
}
