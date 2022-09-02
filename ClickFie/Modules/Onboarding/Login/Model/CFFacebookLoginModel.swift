//
//  CFFacebookLoginModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/06/22.
//

import Foundation

// fb Login Model
struct FbLoginCredentials : Encodable {
    var name : String?
    var email: String?
  }

// MARK: - DataClass
struct FbLoginClass : Codable {
    let statusCode : Int?
    let token: String?
    let message: String?
    let otp : String?
}
