//
//  CFgoogleLoginViewModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 22/04/22.
//

import Foundation
import GoogleSignIn

class GoogleLogin {
    var objLoginVM = CFLoginViewModel()
    var googleLoginCredentials = GoogleLoginCredentials()
    var onSuccessfullyLoggingInClosure : (() -> Void)?
    var onGoogleLoginFailure : (() -> Void)?
    func googleConfigure(_ vc : UIViewController) {
        let signInConfig = GIDConfiguration.init(clientID: "567586162875-3kvn1tk9gpbdtjcobta04mc8hvdln3hi.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: vc) { user, error in
            guard error == nil else { return }
            guard let userName = user?.profile?.name else {return}
            guard let userId = user?.profile?.email else {return}
            self.loginThroughGoogle(userName : userName , userId : userId)
        }
    }
    func apiCall() {
        let networkManager = NetworkManager(endpoint: APIEndPoint.googleLogin.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(googleLoginCredentials)
            networkManager.postApiDataWithAny(requestBody: encodedRequest, resultType: ApiResponceModel<GoogleLoginClass>.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    let data = data as? NSDictionary
                    let token =  data!["data"] as? String
                    CommonFunction.shared.sessionCreate(token ?? "")
                    DispatchQueue.main.async {
                        self.onSuccessfullyLoggingInClosure?()
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            self.onGoogleLoginFailure?()
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
extension GoogleLogin {
    func loginThroughGoogle(userName : String , userId : String) {
        apiCall()
}
}
