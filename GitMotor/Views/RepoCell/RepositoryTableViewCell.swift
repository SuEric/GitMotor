//
//  RepositoryTableViewCell.swift
//  GitMotor
//
//  Created by Eric García on 25/01/21.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let identifier = "repoCell"
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
