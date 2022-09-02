//
//  CFLoginModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/06/22.
//

import Foundation

// Login Model
struct Credentials : Encodable {
    var phoneNumber : String?
}

// MARK: - DataClass
struct LoginClass : Codable {
     var statusCode : Int
     var status : Bool
     var message : String
}
