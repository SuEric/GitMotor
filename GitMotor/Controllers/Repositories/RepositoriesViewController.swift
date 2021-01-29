//
//  ViewController.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var repos: [RepositorySummary] = [] {
        didSet {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loader.startAnimating()
        self.fetchRepositories()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.loader.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Data fetch

    func fetchRepositories() {
        let reposQuery = RepositoriesSummaryQuery()
        Network.shared.apollo.fetch(query: reposQuery) { [weak self] result in
            guard let repos = try? result.get().data?.viewer.repositories.nodes else { return }
            self?.repos = repos.map{ ($0?.fragments.repositorySummary)! }
            self?.loader.stopAnimating()
        }
    }

    // PRAGMA: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier) as! RepositoryTableViewCell

        let repo = repos[indexPath.row]

        cell.name.text = repo.nameWithOwner
        cell.type.text = repo.isPrivate ? "Private" : "Public"
        cell.type.backgroundColor = repo.isPrivate ? UIColor.GMColor.Red : UIColor.darkGray
        cell.stars.text = String(describing: repo.stargazers.totalCount)
        cell.forks.text = String(describing: repo.forks.totalCount)

        return cell
    }

    // PRAGMA: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        let viewController = storyboard.instantiateViewController(withIdentifier: "rootController") as! RepositoryTabViewController
        viewController.repository = self.repos[indexPath.row]
        UIView.transition(with: self.view.window!, duration: 0.8, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
            self.view.window?.rootViewController = viewController
        }, completion: nil)
    }
}

