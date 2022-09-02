//
//  CFOtpViewController.swift
//  ClickFie
//
//  Created by Ayush Mishra on 21/06/22.
//

import Foundation
import UIKit
var onSuccessLoginClosure : ((_ token : String) -> Void)?
var onSuccessSignUpClosure : ((_ token : String) -> Void)?
class OtpVM {
    var onOtpLoginFailure : (() -> Void)?
    var otpCredentials = OtpCredentials()
    func singleCharacterEntry(_ textField:UITextField,_ otpTF1:UITextField,_ otpTF2:UITextField,_ otpTF3:UITextField,_ otpTF4:UITextField) {
        if textField.text?.utf8.count == 1 {
            switch textField {
            case otpTF1:
                otpTF2.becomeFirstResponder()
            case otpTF2:
                otpTF3.becomeFirstResponder()
            case otpTF3:
                otpTF4.becomeFirstResponder()
            default:
                break
            }
        } else if textField.text!.isEmpty {
            switch textField {
            case otpTF4:
                otpTF1.becomeFirstResponder()
                self.nilAll(otpTF1, otpTF2, otpTF4, otpTF3)
            case otpTF3:
                otpTF1.becomeFirstResponder()
                self.nilAll(otpTF1, otpTF2, otpTF4, otpTF3)
            case otpTF2:
                otpTF1.becomeFirstResponder()
                self.nilAll(otpTF1, otpTF2, otpTF4, otpTF3)
            case otpTF1:
                otpTF1.becomeFirstResponder()
                self.nilAll(otpTF1, otpTF2, otpTF4, otpTF3)
            default:
                break
            }
        }
    }
    func nilAll(_ otpTF1:UITextField,_ otpTF2:UITextField,_ otpTF3:UITextField,_ otpTF4:UITextField) {
        otpTF3.text = nil
        otpTF4.text = nil
        otpTF2.text = nil
        otpTF1.text = nil
    }
    func apiCall(_ otpdata : OtpCredentials) {
        otpCredentials.phoneNumber = otpdata.phoneNumber
        otpCredentials.code = otpdata.code
        let networkManager = NetworkManager(endpoint: APIEndPoint.otpVerify.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(otpCredentials)
            networkManager.postApiDataWithAny(requestBody: encodedRequest, resultType: ApiResponceModel<OtpLoginClass>.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    guard let resData = data as? NSDictionary else { return }
                        DispatchQueue.main.async {
                            let rawToken = resData["data"]
                            guard let token = rawToken as? String else { return }
                        if otpdata.vcId == "Login" {
                            onSuccessLoginClosure?(token)
                        } else {
                            onSuccessSignUpClosure?(token)
                        }
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            self.onOtpLoginFailure?()
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
