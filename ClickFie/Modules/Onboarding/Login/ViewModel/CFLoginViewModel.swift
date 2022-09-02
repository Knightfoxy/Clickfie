//
//  CFLoginViewModel.swift
//  ClickFie
//
//  Created by Admin on 07/04/22.
//

import Foundation
import UIKit

class CFLoginViewModel {
    static var shared = CFLoginViewModel()
    var otpSheetDisplay : (() -> Void)?
    var navigateToProfile : (() -> Void)?
    var onLoginAPISuccess : (() -> Void)?
    var onLoginAPIFailure : (() -> Void)?
    var credentials = Credentials()
    func statusResponses(displayMssg : UILabel, statusView : UIView , indicator : UIActivityIndicatorView) {
        statusView.isHidden = true
        indicator.isHidden = true
        displayMssg.isHidden = false
        displayMssg.text = "Phone Number not found"
    }
    func apiCall() {
        let networkManager = NetworkManager(endpoint: APIEndPoint.login.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(credentials)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<LoginClass>.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        self.onLoginAPISuccess?()
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            self.onLoginAPIFailure?()
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
extension CFLoginViewModel {
    func validateUserData(phoneNumber : String) -> Bool {
        if phoneNumber.count != 10 {
            return false
        } else {
            credentials.phoneNumber = phoneNumber
            return true
        }
    }
}
