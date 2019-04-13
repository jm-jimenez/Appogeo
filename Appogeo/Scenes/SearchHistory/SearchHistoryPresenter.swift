import Foundation

protocol SearchHistoryPresenterProtocol: BasePresenterProtocol {
    func presentFetchedSearchs(response: SearchHistory.GetSearchs.Response)
}

class SearchHistoryPresenter: BasePresenter, SearchHistoryPresenterProtocol {
    weak var view: SearchHistoryViewControllerProtocol? {
        didSet {
            setBaseViewWith(view)
        }
    }
    
    func presentFetchedSearchs(response: SearchHistory.GetSearchs.Response) {
        let searchs = response.searchs
        let calendar = Calendar.current
        let displayedSearchs = searchs.map { (EmbassyModel) -> SearchHistory.GetSearchs.ViewModel.DisplayedSearch in
            var displayDate: String = ""
            if let date = EmbassyModel.creationDate {
                if calendar.isDateInToday(date) {
                    let df = DateFormatter()
                    df.dateFormat = "HH:mm:ss"
                    displayDate = "HOY \(df.string(from: date))"
                } else {
                    let df = DateFormatter()
                    df.dateStyle = .medium
                    df.timeStyle = .medium
                    displayDate = df.string(from: date)
                }
            }
            return SearchHistory.GetSearchs.ViewModel.DisplayedSearch.init(icon: EmbassyModel.type.icon, title: EmbassyModel.title, date: displayDate)
        }
        let viewModel = SearchHistory.GetSearchs.ViewModel(displayedSearchs: displayedSearchs)
        view?.displayFetchedSearchs(viewModel: viewModel)
    }
}
