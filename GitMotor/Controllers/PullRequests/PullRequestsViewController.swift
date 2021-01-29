//
//  PullRequestsViewController.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

enum PullRequestFilter: Int {
    case open = 0
    case merged = 1
    case closed = 2
}

class PullRequestsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    static let sectionHeaderIdentifier = "pullRequestsHeader"

    var repository: RepositorySummary? {
        return (self.tabBarController as? RepositoryTabViewController)?.repository
    }

    var pullRequests : [String: [PullRequestSummary]] = [
        "open": [],
        "merged": [],
        "closed": []
        ] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var pullRequestFilter = PullRequestFilter.open {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var filteredPullRequests: [PullRequestSummary] {
        switch self.pullRequestFilter {
        case .open:
            return self.pullRequests["open"]!
        case .merged:
            return self.pullRequests["merged"]!
        case .closed:
            return self.pullRequests["closed"]!
        }
    }

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loader.startAnimating()
        self.fetchPullRequests()

        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

        self.collectionView.register(UINib(nibName: RepoItem.nibName, bundle: nil), forCellWithReuseIdentifier: RepoItem.identifier)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loader.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Data fetch

    func fetchPullRequests() {
        let pullRequestsQuery = RepositoryPullRequestsQuery(repositoryOwner: self.repository!.owner.login, repositoryName: self.repository!.name)
        Network.shared.apollo.fetch(query: pullRequestsQuery) { [weak self] result in
            guard let openPullRequests = try? result.get().data?.repository?.openPullRequests.nodes else { return }
            self?.pullRequests["open"] =  openPullRequests.map{ ($0?.fragments.pullRequestSummary)! }
            guard let mergedRequests = try? result.get().data?.repository?.mergedPullRequests.nodes else { return }
            self?.pullRequests["merged"] = mergedRequests.map{ ($0?.fragments.pullRequestSummary)! }
            guard let closedPullRequests = try? result.get().data?.repository?.closedPullRequests.nodes else { return }
            self?.pullRequests["closed"] = closedPullRequests.map{ ($0?.fragments.pullRequestSummary)! }
            self?.loader.stopAnimating()
        }
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredPullRequests.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoItem.identifier, for: indexPath) as! RepoItem

        let pullRequest = self.filteredPullRequests[indexPath.row]

        cell.name.text = pullRequest.title
        cell.detail.text = "#\(pullRequest.number) \(pullRequest.headRefName) to \(pullRequest.baseRefName) \(pullRequest.createdAt)"
        cell.leftImage.image = UIImage(named: "pull_request")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let issueHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PullRequestsViewController.sectionHeaderIdentifier, for: indexPath)
            return issueHeader
        default:  fatalError("Unexpected element kind")
        }
    }

    // MARK: UICollectionViewDelegate

    // MARK: IBAction

    @IBAction func filterDidChange(_ sender: UISegmentedControl) {
        self.pullRequestFilter = PullRequestFilter(rawValue: sender.selectedSegmentIndex)!
    }

}
