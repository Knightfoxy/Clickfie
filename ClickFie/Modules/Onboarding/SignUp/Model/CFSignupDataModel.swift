//
//  CFSignupDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/06/22.
//

import Foundation

// Login Model
struct SignUpCredentials : Encodable {
    var name : String?
    var email: String?
    var phoneNumber: String?
    var imageUrl: String?
  }

// MARK: - DataClass
struct SignupClass : Codable {
    let statusCode : Int?
    let token: String?
    let message: String?
    let otp : String?
}
