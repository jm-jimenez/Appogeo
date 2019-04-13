import UIKit

protocol EmbassyListViewControllerProtocol: BaseViewControllerProtocol {
    func displayFetchedEmbassies(viewModel: EmbassyList.GetEmbassies.ViewModel)
}

class EmbassyListViewController: BaseViewController, EmbassyListViewControllerProtocol {

    @IBOutlet var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var interactor: EmbassyListInteractorProtocol? {
        didSet {
            setBaseInteractorWith(interactor)
        }
    }
    
    var router: EmbassyListRouterProtocol?
    
    var displayedEmbassies: [EmbassyList.GetEmbassies.ViewModel.DisplayedEmbassy] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filteredEmbassies: [EmbassyList.GetEmbassies.ViewModel.DisplayedEmbassy] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func setupVIP() {
        let viewController = self
        let interactor = EmbassyListInteractor()
        let presenter = EmbassyListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
    
    override func viewDidLoad() {
        configTable()
        configNavBar()
        configSearchBar()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        router = EmbassyListRouter(navigation: navigationController)
        interactor?.router = router
    }
    
    private func configNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "main_list".localized
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    private func configTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EmbassyCell", bundle: nil), forCellReuseIdentifier: Constants.EMBASSY_CELL_REUSE_IDENTIFIER)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
    
    private func configSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func displayFetchedEmbassies(viewModel: EmbassyList.GetEmbassies.ViewModel) {
        displayedEmbassies = viewModel.displayedEmbassies
    }
}

extension EmbassyListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredEmbassies.count : displayedEmbassies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.EMBASSY_CELL_REUSE_IDENTIFIER, for: indexPath) as? EmbassyCell else {
            return EmbassyCell()
        }
        let model = isFiltering() ? filteredEmbassies[indexPath.item] : displayedEmbassies[indexPath.item]
        cell.config(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            if let found = displayedEmbassies.first(where: { $0 == filteredEmbassies[indexPath.item] }) {
                if let index = displayedEmbassies.firstIndex(of: found) {
                    interactor?.showInMapEmbassy(at: index)
                }
            }
        } else {
            interactor?.showInMapEmbassy(at: indexPath.item)
        }
    }
}

extension EmbassyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredEmbassies = displayedEmbassies.filter { $0.title.lowercased().contains(searchController.searchBar.text!.lowercased())  }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
