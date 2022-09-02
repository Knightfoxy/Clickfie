//  CFotpSheetVC.swift
//  ClickFie
//
//  Created by Admin on 06/04/22.
import UIKit
class CFOtpSheetVC: CFBaseVC {
    // MARK: - Stored Properties
    var objOtpVM = OtpVM()
    var timerRunning = false
    var ourTimer = Timer()
    var timerDisplayed  = 50
    var phoneNum : String = ""
    var vcId : String = ""
    var objViewModel = CFLoginViewModel()
    var objCredentials = OtpCredentials()
    // MARK: - IB Outlets
    @IBOutlet weak private(set) var timerLabel: UILabel!
    @IBOutlet weak private(set) var otpTF1: UITextField!
    @IBOutlet weak private(set) var otpTF2: UITextField!
    @IBOutlet weak private(set) var otpTF3: UITextField!
    @IBOutlet weak private(set) var statusLabel: UILabel!
    @IBOutlet weak private(set) var otpTF4: UITextField!
    // MARK: - Lifecycle Methods
    override func initialSetup() {
        self.initialSetting()
        CommonFunction.shared.otpTextfieldsCirculate([otpTF1,otpTF2,otpTF3,otpTF4])
        CommonFunction.shared.firstResponder([otpTF1,otpTF2,otpTF3,otpTF4], vc: self)
        dismissKeyBoard()
        self.timerStart()
        hideKeyboardWhenTappedAround()
        objOtpVM.onOtpLoginFailure = {
            self.statusLabel.isHidden = false
            self.statusLabel.text = "OTP not verified, Try again"
        }
    }
    // MARK: - IB Actions
    @IBAction private func verifyOTPButton(_ sender: Any) {
        if otpTF1.text == nil || otpTF2.text == nil || otpTF3.text == nil || otpTF4.text == nil {
            self.statusLabel.isHidden = false
            self.statusLabel.text = "Fill Valid OTP"
        } else {
            objCredentials.phoneNumber = phoneNum
            objCredentials.vcId = vcId
            if let otp1 = otpTF1.text, let otp2 = otpTF2.text , let otp3 = otpTF3.text , let otp4 = otpTF4.text {
                objCredentials.code = otp1 + otp2 + otp3 + otp4
                objOtpVM.apiCall(objCredentials)
            } else { return }
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction private func backCrossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Custom Methods
    @IBAction private func resendOtpAction(_ sender: Any) {
        objOtpVM.nilAll(otpTF1, otpTF2, otpTF3, otpTF4)
    }
    @objc func action() {
        timerDisplayed -= 1
        timerLabel.text = StringConstants.zero.rawValue + (String(format : StringConstants.twoI.rawValue , timerDisplayed))
        if timerDisplayed == 0 {
            ourTimer.invalidate()
            timerLabel.textColor = UIColor.red
            timerRunning = false
        }
    }
    // function to get only single character in a field
    @objc func changeCharacter(textField : UITextField) {
        objOtpVM.singleCharacterEntry(textField, otpTF1, otpTF2, otpTF3, otpTF4)
    }
}
extension CFOtpSheetVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.utf8.count == 1 && !string.isEmpty {
            return false
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.keyboardType = .numberPad
        return true
    }
}
extension CFOtpSheetVC {
    func initialSetting() {
        self.statusLabel.isHidden = true
        if timerDisplayed == 0 {
            timerRunning = false
        }
        otpTF1.delegate = self
        otpTF2.delegate = self
        otpTF3.delegate = self
        otpTF4.delegate = self
    }
    func timerStart() {
        if timerRunning == false {
            timerLabel.textColor = UIColor.gray
            timerDisplayed = 51
            ourTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
}
