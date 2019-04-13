import Foundation

protocol LocationSearchPresenterProtocol: BasePresenterProtocol {

}

class LocationSearchPresenter: BasePresenter, LocationSearchPresenterProtocol {
    weak var view: LocationSearchViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
}
