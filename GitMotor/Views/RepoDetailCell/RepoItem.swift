//
//  RepoItemCollectionViewCell.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//
import UIKit

class RepoItem: UICollectionViewCell {
    static let nibName = "RepoItemCell"
    static let identifier = "repoItemCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        name.textColor = UIColor.black
        detail.textColor = UIColor.black
    }

}
