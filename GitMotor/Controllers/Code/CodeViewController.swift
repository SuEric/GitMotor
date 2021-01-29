//
//  RepositoryViewController.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

enum CodeFilter: Int {
    case commits = 0
    case releases = 1
    case contributors = 2
}

class CodeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    static let sectionHeaderIdentifier = "codeFooter"

    var repository: RepositorySummary? {
        return (self.tabBarController as? RepositoryTabViewController)?.repository
    }

    var commits: [CommitSummary] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var releases: [ReleaseSummary] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var collaborators: [AuthorInfo] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var codeFilter = CodeFilter.commits

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loader.startAnimating()
        fetchCommits()
        fetchReleases()

        self.updateHeaderSize(self.view.frame.size)

        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

        self.collectionView.register(UINib(nibName: RepoItem.nibName, bundle: nil), forCellWithReuseIdentifier: RepoItem.identifier)
        self.collectionView.register(UINib(nibName: RepoHeaderView.nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RepoHeaderView.identifier)
    }

    // MARK: Layout

    func updateHeaderSize(_ size: CGSize) {
        self.collectionViewFlowLayout.headerReferenceSize = CGSize(width: size.width, height: 264.0)
//        self.collectionFlowLayout.parallaxHeaderMinimumReferenceSize = CGSize(width: size.width, height: 118.0)
        self.collectionViewFlowLayout.itemSize = CGSize(width: size.width, height: 44.0);
//        self.collectionFlowLayout.parallaxHeaderAlwaysOnTop = true
//        self.collectionFlowLayout.disableStickyHeaders = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loader.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Data fetch

    func fetchCommits() {
        let commitsQuery = RepositoryCommitsQuery(repositoryOwner: (self.repository?.owner.login)!, repositoryName: (self.repository?.name)!)
        Network.shared.apollo.fetch(query: commitsQuery) { [weak self] result in
            guard let commits = try? result.get().data?.repository?.object?.asCommit?.history.nodes else { return }
            self?.commits =  commits.map{ ($0?.fragments.commitSummary)! }
        }
    }

    func fetchReleases() {
        let releasesQuery = RepositoryCollaboratorsQuery(repositoryOwner: self.repository!.owner.login, repositoryName: self.repository!.name)
        Network.shared.apollo.fetch(query: releasesQuery) { [weak self] result in
            guard let collaborators = try? result.get().data?.repository?.collaborators?.nodes else { return }
            self?.collaborators =  collaborators.map{ ($0?.fragments.authorInfo)! }
        }
    }

    func fetchCollaborators() {
        let releasesQuery = RepositoryReleasesQuery(repositoryOwner: self.repository!.owner.login, repositoryName: self.repository!.name)
        Network.shared.apollo.fetch(query: releasesQuery) { [weak self] result in
            guard let releases = try? result.get().data?.repository?.releases.nodes else { return }
            self?.releases =  releases.map{ ($0?.fragments.releaseSummary)! }
        }
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.codeFilter {
        case .commits:
            return self.commits.count
        case .releases:
            return self.releases.count
        case .contributors:
            return self.collaborators.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoItem.identifier, for: indexPath) as! RepoItem

        switch self.codeFilter {
        case .commits:
            let commit = self.commits[indexPath.row]
            cell.name.text = "\(commit.abbreviatedOid) - \(commit.message)"
            cell.detail.text = "\(commit.author?.fragments.authorSummary.name ?? "Unknown") \(commit.committedDate)"
            cell.leftImage.image = UIImage(named: "commits")
        case .releases:
            let release = self.releases[indexPath.row]
            cell.name.text = release.name
            cell.detail.text = "\(release.author?.fragments.authorInfo.name ?? "Unknown") Released \(release.publishedAt!)"
            cell.leftImage.image = UIImage(named: "tag")
        case .contributors:
            let collaborator = self.collaborators[indexPath.row]
            cell.name.text = collaborator.name
            cell.detail.text = collaborator.email
            cell.leftImage.image = UIImage(named: "octocat")
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RepoHeaderView.identifier, for: indexPath) as! RepoHeaderView

            headerView.repository = self.repository
            headerView.addButton.isHidden = true
            headerView.reloadData()

            return headerView
        case UICollectionView.elementKindSectionFooter:
            let issueHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CodeViewController.sectionHeaderIdentifier, for: indexPath)
            return issueHeader
        default:  fatalError("Unexpected element kind")
        }
    }

    // MARK: UICollectionViewDelegate

    // MARK: IBAction

    @IBAction func filterDidChange(_ sender: UISegmentedControl) {
        self.codeFilter = CodeFilter(rawValue: sender.selectedSegmentIndex)!
        self.collectionView.reloadData()
    }

}
