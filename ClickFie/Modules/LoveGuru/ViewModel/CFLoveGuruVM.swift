//
//  CFLoveGuruVM.swift
//  ClickFie
//
//  Created by Ayush Mishra on 31/05/22.
//

import Foundation
import UIKit

class CFLoveGuruVM {
    func fieldCurve(_ tf : UITextField,_ borderColor : CGColor) {
        tf.layer.cornerRadius = 25
        tf.clipsToBounds = true
        tf.layer.borderWidth = 1.5
        tf.layer.borderColor = borderColor
    }
    func viewCurve(_ endView : UIView,_ middleView : UIView) {
        endView.layer.cornerRadius = endView.frame.size.width/2
        endView.clipsToBounds = true
        middleView.layer.cornerRadius = middleView.frame.size.width/2
        middleView.clipsToBounds = true
    }
    func actionOnGo(_ yourName : UITextField,_ crushName : UITextField,_ nameAlert : UILabel,_ crushAlert : UILabel,beforeView : UIView ,_ afterView : UIView) {
        if yourName.text?.isEmpty == true {
            nameAlert.isHidden = false
        } else if crushName.text?.isEmpty == true {
            crushAlert.isHidden = false
        } else {
            beforeView.isHidden = true
            afterView.isHidden = false
        }
    }
}
