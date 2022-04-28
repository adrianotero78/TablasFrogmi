//
//  LocalesTableViewCell.swift
//  TablasFrogmi
//
//  Created by Adrian on 25-04-22.
//

import UIKit

class LocalesTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var codeLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
