//
//  CFAddReviewsVM.swift
//  ClickFie
//
//  Created by Ayush Mishra on 27/05/22.
//

import Foundation
import UIKit

class CFAddReviewsVM {
    func reviewTypeShaper(_ button : UIButton,_ borderColor : CGColor) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.5
        button.layer.borderColor = borderColor
    }
    func submitButtonShaper(_ button : UIButton) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
    }
}
