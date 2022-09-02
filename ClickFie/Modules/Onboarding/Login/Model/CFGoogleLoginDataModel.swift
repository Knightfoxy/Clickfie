//
//  CFGoogleLoginDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 21/06/22.
//

import Foundation
// fb Login Model
struct GoogleLoginCredentials : Encodable {
    var name : String?
    var email: String?
  }

// MARK: - DataClass
struct GoogleLoginClass : Codable {
    let statusCode : Int?
    let token: String?
    let message: String?
    let otp : String?
}
