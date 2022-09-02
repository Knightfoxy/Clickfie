//
//  CFfacebookLoginViewModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 22/04/22.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

class FacebookLogin {
    static var shared = FacebookLogin()
   // var objLoginVM = CFLoginViewModel()
    var fbLoginCredentials = FbLoginCredentials()
    var onSuccessfullyLoggingInClosure : (() -> Void)?
    var onFbLoginFailure : (() -> Void)?
    func fbPermission( _ vc : UIViewController) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: vc) { result, error in
            if error == nil {
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions.contains("email") {
                    self.getFBUserData()
                }
            }
        }
    }
    func getFBUserData() {
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me", parameters: ["fields":"email,name"]).start {_, result,_ in
            guard let json = result as? NSDictionary else { return }
                if let name = json["name"] as? String , let email = json["email"] as? String {
                    self.loginThroughFB(userName: name, userId: email)
                    }
            }
        }
    }
    func facebookLogin() {
        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": " email, picture, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (_, result,_) in
                print("\(result ?? "")")
            }
        }
    }
    func apiCall() {
        let networkManager = NetworkManager(endpoint: APIEndPoint.fbLogin.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(fbLoginCredentials)
            networkManager.postApiDataWithAny(requestBody: encodedRequest, resultType: ApiResponceModel<FbLoginClass>.self) { userRegistrationResponse in
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
                            self.onFbLoginFailure?()
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
extension FacebookLogin {
    func loginThroughFB(userName : String , userId : String) {
        apiCall()
    }
}
