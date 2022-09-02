//
//  CFBadgeDetailsTC.swift
//  ClickFie
//
//  Created by Ayush Mishra on 16/06/22.
//

import UIKit

class CFBadgeDetailsTC: UITableViewCell {

    @IBOutlet private(set) weak var badgeImage: UIImageView!
    @IBOutlet private(set) weak var badgeDetailsLbl: UILabel!
    @IBOutlet private(set) weak var badgeNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
