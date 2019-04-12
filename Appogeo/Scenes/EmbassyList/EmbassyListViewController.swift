import UIKit

protocol EmbassyListViewControllerProtocol: BaseViewControllerProtocol {
    func displayFetchedEmbassies(viewModel: EmbassyList.GetEmbassies.ViewModel)
}

class EmbassyListViewController: BaseViewController, EmbassyListViewControllerProtocol {

    @IBOutlet var tableView: UITableView!
    
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
    
    override func setupVIP() {
        let viewController = self
        let interactor = EmbassyListInteractor()
        let presenter = EmbassyListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        router = EmbassyListRouter(navigation: navigationController)
        interactor?.router = router
    }
    
    private func configTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EmbassyCell", bundle: nil), forCellReuseIdentifier: Constants.EMBASSY_CELL_REUSE_IDENTIFIER)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
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
        return displayedEmbassies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.EMBASSY_CELL_REUSE_IDENTIFIER, for: indexPath) as? EmbassyCell else {
            return EmbassyCell()
        }
        cell.config(with: displayedEmbassies[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.showInMapEmbassy(at: indexPath.item)
    }
}
