//
//  RepoHeaderView.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

enum RepoAction : Int {
    case watch = 0
    case star = 1
    case fork = 2
}

class RepoHeaderView: UICollectionViewCell {
    static let nibName = "RepoHeaderView"
    static let identifier = "repoHeaderView"
    
    var repository: RepositorySummary?
    
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var watches: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var watchImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var forkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.watchImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapped(tapGestureRecognizer:))))
        self.starImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapped(tapGestureRecognizer:))))
        self.forkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapped(tapGestureRecognizer:))))
    }
    
    //    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    //        UIView.beginAnimations("", context: nil)
    //
    //        let attributes = layoutAttributes as! IOStickyHeaderFlowLayoutAttributes
    //
    //        if attributes.progressiveness <= 0.58 {
    //            self.topName.alpha = 1.0
    //            self.name.alpha = 0.0
    //            self.detail.alpha = 0.0
    //            self.type.alpha = 0.0
    //        } else {
    //            self.topName.alpha = 0
    //            self.name.alpha = 1.0
    //            self.detail.alpha = 1.0
    //            self.type.alpha = 1.0
    //        }
    //
    //        if attributes.progressiveness >= 1 {
    //            self.searchBar.alpha = 1
    //        } else {
    //            self.searchBar.alpha = 0
    //        }
    //
    //        UIView.commitAnimations()
    //    }
    
    func reloadData() {
        self.topName.text = self.repository?.name
        self.name.text = self.repository?.nameWithOwner
        if let detail = self.repository?.repoDescription {
            self.detail.text = detail
        } else {
            self.detail.text = "No description"
        }
        self.type.text = (self.repository?.isPrivate)! ? "Private" : "Public"
        self.type.backgroundColor = (self.repository?.isPrivate)! ? UIColor.GMColor.Red : UIColor.GMColor.Blue
        self.watches.text = String(describing: self.repository!.watchers.totalCount)
        self.stars.text = String(describing: self.repository!.stargazers.totalCount)
        self.forks.text = String(describing: self.repository!.forks.totalCount)
        self.watchImage.image = self.repository!.viewerSubscription == .subscribed ? UIImage(named: "watching") : UIImage(named: "unwatching")
        self.starImage.image = self.repository!.viewerHasStarred ? UIImage(named: "starred") : UIImage(named: "unstarred")
    }
    
    // MARK: IBAction
    
    @objc func actionTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch RepoAction(rawValue: tappedImage.tag)! {
        case .watch:
            if self.repository?.viewerSubscription == .subscribed {
                let unwatchRepoMutation = UnwatchRepositoryMutation(repositoryId: (self.repository?.id)!)
                Network.shared.apollo.perform(mutation: unwatchRepoMutation) { [weak self] result in
                    guard let repo = try? result.get().data?.updateSubscription?.subscribable?.fragments.repositorySummary else { return }
                    self?.repository = repo
                    self?.reloadData()
                }
            } else {
                let watchRepoMutation = WatchRepositoryMutation(repositoryId: (self.repository?.id)!)
                Network.shared.apollo.perform(mutation: watchRepoMutation) { [weak self] result in
                    guard let repo = try? result.get().data?.updateSubscription?.subscribable?.fragments.repositorySummary else { return }
                    self?.repository = repo
                    self?.reloadData()
                }
            }
        case .star:
            if (self.repository?.viewerHasStarred)! {
                let removeStarMutation = RemoveStarToRepositoryMutation(repositoryId: (self.repository?.id)!)
                Network.shared.apollo.perform(mutation: removeStarMutation) { [weak self] result in
                    guard let repo = try? result.get().data?.removeStar?.starrable?.fragments.repositorySummary else { return }
                    self?.repository = repo
                    self?.reloadData()
                }
            } else {
                let addStarMutation = AddStarToRepositoryMutation(repositoryId: (self.repository?.id)!)
                Network.shared.apollo.perform(mutation: addStarMutation) { [weak self] result in
                    guard let repo = try? result.get().data?.addStar?.starrable?.fragments.repositorySummary else { return }
                    self?.repository = repo
                    self?.reloadData()
                }
            }
        case .fork:
            print("GitHub GraphQL API not supported")
        }
    }
    
    @IBAction func back(_ sender: Any) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("could not get scene delegate ")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "repositoriesController")
        let window = sceneDelegate.window!
        UIView.transition(with: window, duration: 0.8, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
    
}
