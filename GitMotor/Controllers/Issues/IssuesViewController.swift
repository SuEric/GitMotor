//
//  IssueListViewController.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

enum IssueFilter: Int {
    case open =  0
    case closed =  1
}

class IssuesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    static let sectionHeaderIdentifier = "issueHeader"

    var repository: RepositorySummary? {
        return (self.tabBarController as? RepositoryTabViewController)?.repository
    }

    var issues: (open: [IssueSummary], closed: [IssueSummary]) = ([], []) {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var issueFilter = IssueFilter.open {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var filteredIssues: [IssueSummary] {
        switch self.issueFilter {
        case .open:
            return self.issues.open
        case .closed:
            return self.issues.closed
        }
    }

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var collectionFlowLayout: IOStickyHeaderFlowLayout!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loader.startAnimating()
        self.fetchIssues()

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

    func fetchIssues() {
        let issues = RepositoryIssuesQuery(repositoryOwner: self.repository!.owner.login, repositoryName: self.repository!.name)
        Network.shared.apollo.fetch(query: issues) { [weak self] result in
            guard let openIssues = try? result.get().data?.repository?.openIssues.nodes else { return }
            self?.issues.open =  openIssues.map{ ($0?.fragments.issueSummary)! }
            guard let closedIssues = try? result.get().data?.repository?.closedIssues.nodes else { return }
            self?.issues.closed = closedIssues.map{ ($0?.fragments.issueSummary)! }
            self?.loader.stopAnimating()
        }
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredIssues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoItem.identifier, for: indexPath) as! RepoItem

        let issue = self.filteredIssues[indexPath.row]


        cell.name.text = issue.title
        cell.detail.text = "#\(issue.number) \(issue.author?.fragments.issueAuthor.login ?? "Unknown") \(issue.createdAt)"
        cell.leftImage.image = issue.state == .open ? UIImage(named: "issues") : UIImage(named: "issue_closed")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let issueHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssuesViewController.sectionHeaderIdentifier, for: indexPath)
            return issueHeader
        default:  fatalError("Unexpected element kind")
        }
    }

    // MARK: UICollectionViewDelegate

    // MARK: IBAction

    @IBAction func filterDidChange(_ sender: UISegmentedControl) {
        self.issueFilter = IssueFilter(rawValue: sender.selectedSegmentIndex)!
        self.collectionView.reloadData()
    }

}
