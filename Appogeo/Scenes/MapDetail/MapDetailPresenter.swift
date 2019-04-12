import Foundation

protocol MapDetailPresenterProtocol: BasePresenterProtocol {
    func presentPOIs(response: MapDetail.LoadPOIs.Response)
}

class MapDetailPresenter: BasePresenter, MapDetailPresenterProtocol {
    weak var view: MapDetailViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
    
    func presentPOIs(response: MapDetail.LoadPOIs.Response) {
        let displayedPOIs = response.embassies.compactMap{ (EmbassyModel) -> MapDetail.LoadPOIs.ViewModel.DisplayedPOI? in
            guard let location = EmbassyModel.location else { return nil }
            return MapDetail.LoadPOIs.ViewModel.DisplayedPOI(latitude: location.latitude, longitude: location.longitude, title: EmbassyModel.title, image: EmbassyModel.type.iconPOI)
        }
        
        let viewModel = MapDetail.LoadPOIs.ViewModel(displayedPOIs: displayedPOIs)
        view?.displayPOIs(viewModel: viewModel)
        if viewModel.displayedPOIs.count == 1 {
            view?.centerInCoordinate(coordinate: viewModel.displayedPOIs[0].coordinate, radius: 1000)
        }
    }
}
