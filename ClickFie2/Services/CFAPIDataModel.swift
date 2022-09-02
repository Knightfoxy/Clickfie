//
//  CFAPIDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 29/04/22.
//

import Foundation

struct SignUpData : Codable {
  let userName: String
  let userPhoneNumber : String
  var parameters: [String: Any] {[
    "userName": userName,
    "phoneNumber": userPhoneNumber
    ]}
}

struct DataResponse : Codable {
    var data : UserData
}
struct UserData : Codable {
    var statusCode: Int
    var success:Bool
    var message:String
    var name:String
}
struct LoginData :Codable {
    let phoneNumber : String
    var  parameters :  [String : Any] {[
        "phoneNumber" : phoneNumber
    ]}
}
struct VerifyOtpData : Codable {
    let phoneNumber : String
    let otpCode : String
    var  parameters :  [String : Any] {[
        "phoneNumber" : phoneNumber ,
        "otp" : otpCode
    ]}
}
struct GoogleSignIn : Codable {
    let name : String
    let email : String
    var parameters : [String :Any] {[
          "name": name ,
          "email": email
    ]}
}
struct FBSignIn: Codable {
    let name : String
    let email : String
    var parameters : [String :Any] {[
          "name": name ,
          "email": email
    ]}
}
