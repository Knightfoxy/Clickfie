//
//  CFOtpDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 21/06/22.
//

import Foundation
// fb Login Model
struct OtpCredentials : Encodable {
    var phoneNumber : String?
    var code : String?
    var vcId : String?
  }

// MARK: - DataClass
struct OtpLoginClass : Decodable {
    let statusCode : Int?
    let status : Bool?
    let message: String?
    let data : String?
}
