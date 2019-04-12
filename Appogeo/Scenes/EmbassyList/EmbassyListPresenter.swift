import Foundation

protocol EmbassyListPresenterProtocol: BasePresenterProtocol {
    func presentFetchedEmbassies(response: EmbassyList.GetEmbassies.Response)
}

class EmbassyListPresenter: BasePresenter, EmbassyListPresenterProtocol {
    weak var view: EmbassyListViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
    
    func presentFetchedEmbassies(response: EmbassyList.GetEmbassies.Response) {
        let embassies = response.graph
        let displayedEmbassies = embassies.map { (EmbassyModel) -> EmbassyList.GetEmbassies.ViewModel.DisplayedEmbassy in
            return EmbassyList.GetEmbassies.ViewModel.DisplayedEmbassy(icon: EmbassyModel.type.icon, title: EmbassyModel.title, locality: EmbassyModel.address.locality, address: EmbassyModel.address.street_address)
        }
        let viewModel = EmbassyList.GetEmbassies.ViewModel(displayedEmbassies: displayedEmbassies)
        view?.displayFetchedEmbassies(viewModel: viewModel)
    }
}
