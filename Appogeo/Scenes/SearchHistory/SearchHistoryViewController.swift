import UIKit

protocol SearchHistoryViewControllerProtocol: BaseViewControllerProtocol {
    func displayFetchedSearchs(viewModel: SearchHistory.GetSearchs.ViewModel)
}

class SearchHistoryViewController: BaseViewController, SearchHistoryViewControllerProtocol {

    @IBOutlet var tableView: UITableView!
    var interactor: SearchHistoryInteractorProtocol? {
        didSet {
            setBaseInteractorWith(interactor)
        }
    }
    
    private var displayedSearchs: [SearchHistory.GetSearchs.ViewModel.DisplayedSearch] = [] {
        didSet {
            tableView.reloadData()
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
    
    override func viewDidLoad() {
        configTable()
        super.viewDidLoad()
    }
    
    private func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchHistoryCell", bundle: nil), forCellReuseIdentifier: Constants.SEARCH_HISTORY_CELL_REUSE_IDENTIFIER)
    }
    
    func displayFetchedSearchs(viewModel: SearchHistory.GetSearchs.ViewModel) {
        displayedSearchs = viewModel.displayedSearchs
    }
}

extension SearchHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSearchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SEARCH_HISTORY_CELL_REUSE_IDENTIFIER, for: indexPath) as? SearchHistoryCell else { return SearchHistoryCell() }
        cell.config(with: displayedSearchs[indexPath.item])
        return cell
    }
}
