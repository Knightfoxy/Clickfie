//
//  ViewController.swift
//  ClickFie
//
//  Created by Admin on 04/04/22.
//

import UIKit
import GoogleSignIn
import CoreData

class CFLoginVC: CFBaseVC {
    // MARK: - Stored Properties
    var vcId : String = ""
    lazy var objLoginVM = CFLoginViewModel()
    lazy var objGoogleSignin = GoogleLogin()
    var newUserPhoneNum : String?
    // MARK: - IBOutlets
    @IBOutlet weak private(set) var phoneNumTF: UITextField!
    @IBOutlet weak private(set) var flagImage: UIImageView!
    @IBOutlet weak private(set) var countryCodeLbl: UILabel!
    @IBOutlet weak private(set) var btnFacebook: UIButton!
    @IBOutlet weak private(set) var statusLabel: UILabel!
    @IBOutlet weak private(set) var progressView: UIView!
    @IBOutlet weak private(set) var loginBtn: UIButton!
    @IBOutlet weak private(set) var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak private(set) var googleBtn: UIButton!
    // MARK: - Lifecycle Methods
     override func initialSetup() {
         self.statusLabel.isHidden = true
         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
         hideKeyboardWhenTappedAround()
         swipeLeft.direction = .left
         self.phoneNumTF.delegate = self
         phoneNumTF.text = newUserPhoneNum
         FacebookLogin.shared.facebookLogin()
         self.view.addGestureRecognizer(swipeLeft)
         self.navigationController?.isNavigationBarHidden = true
         CommonFunction.shared.shadowShades(loginBtn, 3, 0, 0, 0.90, 2, 6, 0.25, 5,2)
         CommonFunction.shared.shadowShades(googleBtn, 1, 0, 0, 0.90, 2, 6, 0.15, 5,2)
         CommonFunction.shared.shadowShades(btnFacebook, 1, 0, 0, 0.90, 2, 6, 0.15, 5,2)
         objLoginVM.onLoginAPISuccess = {
             self.activityOnSuccess()
         }
         objLoginVM.onLoginAPIFailure = {
             self.progressView.isHidden = true
             self.progressSpinner.isHidden = true
             self.statusLabel.isHidden = false
             self.statusLabel.text = "Login Failed, Try again later"
         }
         countryCodeClosure = { (cCode , image) in
             self.countryCodeLbl.text = cCode
             self.flagImage.image = image
         }
         onSuccessLoginClosure = { token in
             CommonFunction.shared.sessionCreate(token)
             self.navigateVC(sbName: "Profile", vcId: "CFHomeVC")
         }
    }
    // MARK: - IBActions
    @IBAction private func countrySheetBtn(_ sender: Any) {
        CountryData.shared.parseJSON()
    }
    @IBAction private func loginButtonAction(_ sender: Any) {
        guard let phoneNum = phoneNumTF.text else {return}
        if objLoginVM.validateUserData(phoneNumber : phoneNum) {
            objLoginVM.apiCall()
            self.progressView.isHidden = false
            self.progressSpinner.isHidden = false
            self.progressSpinner.startAnimating()
        } else {
            self.statusLabel.text = AlertMessages.invalidInput.rawValue
            self.statusLabel.isHidden = false
        }
    }
    @IBAction private func countrySheetAction(_ sender: Any) {
        CountryData.shared.parseJSON()
    }
    @IBAction private func googleBtn(_ sender: Any) {
        objGoogleSignin.googleConfigure(self)
        self.progressView.isHidden = false
        self.progressSpinner.startAnimating()
        objGoogleSignin.onSuccessfullyLoggingInClosure = {
            self.googleFBLoginCLosureAction()
        }
    }
    @IBAction private func btnFacebookAction(_ sender: Any) {
        FacebookLogin.shared.fbPermission(self)
        self.progressView.isHidden = false
        self.progressSpinner.startAnimating()
        FacebookLogin.shared.onSuccessfullyLoggingInClosure = {
            self.googleFBLoginCLosureAction()
        }
    }
    // MARK: - Custom Methods
    @objc func swipedLeft() {
        self.navigateVC(sbName: "Main", vcId: "CFSignUpVC")
    }
}
extension CFLoginVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.statusLabel.isHidden = true
        self.phoneNumTF.text = nil
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString : NSString = (textField.text ?? StringConstants.space.rawValue) as NSString
        let newString : NSString = currentString.replacingCharacters(in: range, with: string)  as NSString
        let str = String(newString)
        if textField == phoneNumTF {
            return str.isNumeric ?  newString.length <= maxLength :  false
        }
        return true
    }
}
extension CFLoginVC {
    func activityOnSuccess() {
        self.progressView.isHidden = true
        self.progressSpinner.isHidden = true
        self.otpSheetViewer()
    }
    func navigateVC(sbName : String , vcId : String) {
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func otpSheetViewer() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CFOtpSheetVC") as? CFOtpSheetVC else { return }
        if let pc = vc.presentationController as? UISheetPresentationController {
            pc.detents = [.medium()]
            vc.phoneNum = phoneNumTF.text!
            vc.vcId = "Login"
            self.present(vc,animated: true)
        }
    }
    func googleFBLoginCLosureAction() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CFHomeVC") as? CFHomeVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
