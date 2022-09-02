//
//  CommonFunctions.swift
//  ClickFie
//
//  Created by Admin on 07/04/22.
//

import Foundation
import UIKit

class CommonFunction {
    static var shared = CommonFunction()
    var closureToPickImage : (() -> Void)?
    var closureToImageAction : ((_ photoName : String) -> Void)?
    func openPopUP(vc: UIViewController, title: String = "", message: String = "", okTitle: String, cancel: String = "", okAction: (() -> Void)? = nil, cancelAction:(() -> Void)? = nil,
                   photoLib:(() -> Void)? = nil, camera: (() -> Void)? = nil, removePhoto: (() -> Void)? = nil , removeTitle : String , photoTitle : String , cameraTitle : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if !okTitle.isEmpty {
            let ok = UIAlertAction(title: okTitle, style: .default, handler: { _  in
                okAction?()
            })
            alert.addAction(ok)
        }
    if !photoTitle.isEmpty {
            let ok = UIAlertAction(title: photoTitle, style:.default, handler: {(_:UIAlertAction) in
                self.closureToPickImage?()
            })
            alert.addAction(ok)
        }
        if !removeTitle.isEmpty {
            let ok = UIAlertAction(title: removeTitle, style:.default, handler: {(_:UIAlertAction) in self.closureToImageAction?(AlertMessages.profileImage.rawValue)
            })
              alert.addAction(ok)
        }
        if !cameraTitle.isEmpty {
            let camera = UIAlertAction(title: cameraTitle, style: .default, handler: { _  in
                self.closureToPickImage?()
            })
            alert.addAction(camera)
        }
        if !cancel.isEmpty {
            let cancel = UIAlertAction(title: cancel, style: .cancel, handler: { _  in
                cancelAction?()
            })
            alert.addAction(cancel)
        }
        vc.present(alert, animated: true, completion: nil)
    }
    func shadowShades(_ btn : UIButton, _ redColor :Float , _ greenColor :Float , _ blueColor :Float , _ alpha : Double, _ width :Int , _ height :Int , _ shadowOpacity :Float , _ shadowRadius :Float , _ cornerRadius :Float) { btn.layer.shadowColor = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: alpha).cgColor
        btn.layer.shadowOffset = CGSize(width: width, height: height)
        btn.layer.shadowOpacity = shadowOpacity
        btn.layer.shadowRadius = CGFloat(shadowRadius)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = CGFloat(cornerRadius)
    }
    func otpTextfieldsCirculate(_ otpTF : [UITextField]) {
        otpTF.forEach { item in
            item.layer.cornerRadius = 24
            item.layer.masksToBounds = true
            item.layer.borderWidth = 1
            item.layer.borderColor = UIColor.systemPink.cgColor
        }
    }
    func firstResponder(_ otpTF : [UITextField] , vc: Any) {
        otpTF .forEach { item in
            item.addTarget( vc, action: #selector((vc as AnyObject).changeCharacter), for: .editingChanged)
        }
    }
}
extension CommonFunction {
    func waitingResponse(progressView : UIView , spinner : UIActivityIndicatorView) {
      progressView.isHidden = false
      spinner.isHidden = false
      spinner.startAnimating()
    }
}
