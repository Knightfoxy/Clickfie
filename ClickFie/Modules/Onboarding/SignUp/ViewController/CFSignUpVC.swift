//
//  CFSignUpVC.swift
//  ClickFie
//
//  Created by Admin on 07/04/22.
//

import UIKit

class CFSignUpVC : CFBaseVC {
    // MARK: - STORED PROPERTIES
    var image : String = StringConstants.space.rawValue
    var imagePicker = UIImagePickerController()
    var objSignUpViewModel : CFSignUpViewModel? = CFSignUpViewModel()
    // MARK: - IBOUTLETS
    @IBOutlet weak private(set) var spinner: UIActivityIndicatorView!
    @IBOutlet weak private(set) var progressView: UIView!
    @IBOutlet weak private(set) var profileImage: UIImageView!
    @IBOutlet weak private(set) var countryCodeLbl: UILabel!
    @IBOutlet weak private(set) var phoneNumTF: UITextField!
    @IBOutlet weak private(set) var emailTF: UITextField!
    @IBOutlet weak private(set) var cameraBtn: UIButton!
    @IBOutlet weak private(set) var nameTF: UITextField!
    @IBOutlet weak private(set) var signUpOutlet: UIButton!
    @IBOutlet weak private(set) var swipeLineOutlet: UIImageView!
    @IBOutlet weak private(set) var countryImage: UIImageView!
    @IBOutlet weak private(set) var statusLabel: UILabel!
    // MARK: - LIFECYCLE METHODS
    override func initialSetup() {
        self.initialSettings()
        objSignUpViewModel?.alertPopupClosure = { [self] (popUptitle , mssg) in
        objSignUpViewModel?.openPopUp(title: popUptitle, message: mssg , vc : self)
        }
        objSignUpViewModel?.alertWarningsOnSignupTf = { [self] mssg in
            statusLabel.isHidden = false
            statusLabel.text = mssg
        }
        objSignUpViewModel?.designProfile(profileImage: profileImage)
        CommonFunction.shared.shadowShades(signUpOutlet, 4, 0, 0, 0.90, 2, 6, 0.3, 5,2)
        self.navigationController?.isNavigationBarHidden = true
        objSignUpViewModel?.signUpSuccess = {
            self.activityOnSucess()
        }
        CommonFunction.shared.closureToImageAction = {_ in
            self.profileImage.image=UIImage(named: AlertMessages.profileImage.rawValue )
        }
        CommonFunction.shared.closureToPickImage = {
            self.imagePick()
        }
        countryCodeClosure = { (cCode , image) in
            self.countryCodeLbl.text = cCode
            self.countryImage.image = image
        }
        objSignUpViewModel!.signUpFail = {
            self.activityOnFailure()
        }
        onSuccessSignUpClosure = { token in
            self.dismiss(animated: true, completion: nil)
            CommonFunction.shared.sessionCreate(token)
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CFHomeVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    // MARK: - IBACTIONS
    @IBAction private func cameraAction(_ sender: Any) {
        objSignUpViewModel?.openCamera(vc: self)
    }
    @IBAction private func countryCodeBtn(_ sender: Any) {
        CountryData.shared.parseJSON()
    }
    // MARK: - SignUp Button Action
    @IBAction private func signUpBtn(_ sender: Any) {
        self.actionOnSignupTap()
    }
    // MARK: - CUSTOM METHODS
    @objc func imageViewTapped(_ imageView: UIImage) {
        guard let imageCheck = UIImage(named: AlertMessages.profileImage.rawValue) else {
            return
        }
        objSignUpViewModel!.popUp(profileImage, imageCheck, vc: self)
    }
    func actionOnSignupTap() {
        if (objSignUpViewModel?.fetchSignUpDetail(name: nameTF.text! ,phoneNum: phoneNumTF.text! ,email: emailTF.text! ,cCode: countryCodeLbl.text!)) == true {
            CommonFunction.shared.waitingResponse(progressView: progressView, spinner: spinner)
        }
    }
}
extension CFSignUpVC : UITextFieldDelegate ,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString : NSString = (textField.text ?? StringConstants.space.rawValue) as NSString
        let newString : NSString = currentString.replacingCharacters(in: range, with: string)  as NSString
        let str = String(newString)
        if textField == nameTF {
            return str.isAlphabets
        } else if textField == phoneNumTF {
            return str.isNumeric ?  newString.length <= maxLength :  false
        } else {
            return true
        }
    }
    // on completing on one TextField cursor moves to second TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        objSignUpViewModel?.textFieldResponder(textField, nameTF, emailTF, phoneNumTF)
        return true
    }
}
extension CFSignUpVC {
    func activityOnSucess() {
        self.statusLabel.isHidden = true
        self.progressView.isHidden = true
        self.spinner.isHidden = true
        otpSheetViewer(phoneNumTF.text!,"Signup")
    }
    func initialSettings() {
        self.phoneNumTF.delegate = self
        self.emailTF.delegate = self
        self.nameTF.delegate = self
        self.statusLabel.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            profileImage.isUserInteractionEnabled = true
            profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    func activityOnFailure() {
        self.progressView.isHidden = true
        self.statusLabel.isHidden = false
        self.statusLabel.text = "Sign Up failed, Try again later"
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {return}
        profileImage.image = image
        profileImage.contentMode = .scaleAspectFill
    }
    func imagePick() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
}
