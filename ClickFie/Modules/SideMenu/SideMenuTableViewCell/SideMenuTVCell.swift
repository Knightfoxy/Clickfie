//
//  SideMenuTVCell.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/05/22.
//

import UIKit

class SideMenuTVCell: UITableViewCell {
    @IBOutlet private(set) weak var categeoriesLabel: UILabel!
    @IBOutlet private(set) weak var categeogiesImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
