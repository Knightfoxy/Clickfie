//
//  CFCountryCodeTableCell.swift
//  ClickFie
//
//  Created by Admin on 05/04/22.
//

import UIKit

class CFCountryCodeTableCell: UITableViewCell {

    // MARK: - Component Outlets
    @IBOutlet weak private(set) var countryImage: UIImageView!
    @IBOutlet weak private(set) var countryCodeLbl: UILabel!
    @IBOutlet weak private(set) var countryNameLbl: UILabel!
    // MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
