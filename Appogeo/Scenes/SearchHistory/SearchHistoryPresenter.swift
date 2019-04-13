import Foundation

protocol SearchHistoryPresenterProtocol: BasePresenterProtocol {

}

class SearchHistoryPresenter: BasePresenter, SearchHistoryPresenterProtocol {
    weak var view: SearchHistoryViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
}
