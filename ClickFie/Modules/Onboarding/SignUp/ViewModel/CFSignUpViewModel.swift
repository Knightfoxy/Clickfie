//
//  CFLoginViewModel.swift
//  ClickFie
//
//  Created by Admin on 07/04/22.
import Foundation
import UIKit

class CFSignUpViewModel {
    var objOnboardingUserData = OnboardingUserData()
    var signUpSuccess : (() -> Void)?
    var signUpFail : (() -> Void)?
    var credentials = SignUpCredentials(name: "", email: "", phoneNumber: "", imageUrl: "")
    var alertPopupClosure : ((_ popUptitle : String ,_ mssg : String) -> Void)?
    var alertWarningsOnSignupTf : ((_ mssg : String) -> Void)?
    func fetchSignUpDetail(name : String ,phoneNum : String ,email : String ,cCode : String) -> Bool {
        if signUpValidate(name: name, phoneNum: phoneNum, email: email, cCode: cCode) {
            credentials.name = name
            credentials.email = email
            credentials.phoneNumber = phoneNum
           apiCall()
            return true
        }
        return false
    }
    func getterSignUpData() -> CFUserDataModel {
        return objOnboardingUserData.signUpData
    }
    func designProfile(profileImage : UIImageView) {
        profileImage.layer.cornerRadius = 63
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
    func popUp(_ profileImage : UIImageView ,_ imageCheck : UIImage ,vc : UIViewController ) {
        if profileImage.image == imageCheck {
            CommonFunction.shared.openPopUP(vc: vc, title: AlertMessages.selectProfilePicture.rawValue, message: StringConstants.space.rawValue, okTitle: StringConstants.space.rawValue, cancel: PopUpMessage.cancel.rawValue, okAction: nil, cancelAction: nil, photoLib: nil, camera: nil, removePhoto: nil, removeTitle:StringConstants.space.rawValue, photoTitle: PopUpMessage.gallery.rawValue, cameraTitle: PopUpMessage.camera.rawValue)
        } else {
            CommonFunction.shared.openPopUP(vc: vc, title: AlertMessages.selectProfilePicture.rawValue, message: StringConstants.space.rawValue, okTitle: StringConstants.space.rawValue, cancel: PopUpMessage.cancel.rawValue, okAction: nil, cancelAction: nil, photoLib: nil, camera: nil, removePhoto: nil, removeTitle: PopUpMessage.remove.rawValue, photoTitle: PopUpMessage.gallery.rawValue, cameraTitle: PopUpMessage.camera.rawValue)
        }
    }
    func signUpValidate(name : String ,phoneNum : String ,email : String ,cCode : String) -> Bool {
        if name.isBlank == true {
            alertWarningsOnSignupTf?(AlertMessages.blankName.rawValue)
            return false
        } else if email.isBlank == true {
            alertWarningsOnSignupTf?(AlertMessages.blankEmail.rawValue)
            return false
        } else if phoneNum.isBlank == true {
            alertWarningsOnSignupTf?(AlertMessages.blankPhone.rawValue)
            return false
        } else if email.isValidEmail() == false {
            alertWarningsOnSignupTf?(AlertMessages.invalidEmail.rawValue)
            return false
        } else if phoneNum.isNumeric == false {
            alertWarningsOnSignupTf?(AlertMessages.invalidMobileNumber.rawValue)
            return false
        } else if phoneNum.count < 10 {
            alertWarningsOnSignupTf?(AlertMessages.invalidMobileNumber.rawValue)
            return false
        } else {
            return true
        }
    }
    func apiCall() {
        let networkManager = NetworkManager(endpoint: APIEndPoint.signUp.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(credentials)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<SignupClass>.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        self.signUpSuccess?()
                       // print(data.message)
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            self.signUpFail?()
                        }
                        debugPrint("response problem")
                    case .otherProblem :
                        debugPrint("other problem")
                    }
                }
            }
        } catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
extension CFSignUpViewModel {
    func openPopUp(title : String , message : String , vc : UIViewController) {
        CommonFunction.shared.openPopUP(vc:vc , title: title, message: message , okTitle: StringConstants.ok.rawValue, cancel: StringConstants.space.rawValue, okAction: nil, cancelAction: nil, photoLib: nil, camera: nil, removePhoto: nil, removeTitle: StringConstants.space.rawValue, photoTitle: StringConstants.space.rawValue, cameraTitle: StringConstants.space.rawValue)
    }
    func openCamera( vc : UIViewController) {
        CommonFunction.shared.openPopUP(vc: vc, title: AlertMessages.selectProfilePicture.rawValue, message: StringConstants.space.rawValue, okTitle: StringConstants.space.rawValue, cancel: PopUpMessage.cancel.rawValue, okAction: nil, cancelAction: nil, photoLib: nil, camera: nil, removePhoto: nil, removeTitle: PopUpMessage.remove.rawValue, photoTitle: PopUpMessage.gallery.rawValue, cameraTitle: PopUpMessage.camera.rawValue)
    }
    func textFieldResponder(_ textField : UITextField , _ nameTF : UITextField , _ emailTF : UITextField , _ phoneNumTF : UITextField ) {
        switch textField {
        case nameTF :
            textField.resignFirstResponder()
            emailTF.becomeFirstResponder()
        case emailTF :
            textField.resignFirstResponder()
            phoneNumTF.becomeFirstResponder()
        case phoneNumTF:
            textField.resignFirstResponder()
        default :
            break
        }
    }
    func statusComponents(displayMssg : UILabel, statusView : UIView , indicator : UIActivityIndicatorView) {
        statusView.isHidden = true
        indicator.isHidden = true
        displayMssg.isHidden = false
    }
}
