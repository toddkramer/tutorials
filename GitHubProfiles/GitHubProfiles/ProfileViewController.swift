
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let baseURL = "https://api.github.com/users/"
    let repositoryCellIdentifier = "RepositoryCell"
    
    var repositories = [Repository]()
    var tasks = [URLSessionDataTask]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
    }

    func setupSearchBar() {
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
    }

    func loadData(withUsername username: String) {
        loadProfile(withUsername: username)
        loadRepositories(withUsername: username)
    }

    func loadProfile(withUsername username: String) {
        guard let url = URL(string: baseURL + username) else { return }
        let task = APIService.shared.request(url) { [weak self] (result: Result<Profile>) in
            switch result {
            case .success(let profile):
                self?.headerView.configure(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }

    func loadRepositories(withUsername username: String) {
        guard let url = URL(string: baseURL + username + "/repos") else { return }
        let task = APIService.shared.request(url) { [weak self] (result: Result<[Repository]>) in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.sorted(by: { $0.starCount > $1.starCount })
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }

}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellIdentifier) else { fatalError() }
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.description
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }

}

extension ProfileViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.count > 0 else { return }
        tasks.forEach { $0.cancel() }
        loadData(withUsername: query)
        searchBar.resignFirstResponder()
    }

}

