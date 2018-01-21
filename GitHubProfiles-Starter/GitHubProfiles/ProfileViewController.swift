
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

    }

    func loadRepositories(withUsername username: String) {

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

    }

}

