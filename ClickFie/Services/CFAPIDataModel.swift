//
//  CFAPIDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 29/04/22.
//

import Foundation

struct ApiResponceModel<T:Decodable> : Decodable {
    let statusCode: Int
    let status: Bool
    let message: String
    let data: T?
}
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
struct AddPost : Codable {
    let caption : String
    let post : String
    var parameters : [String : Any] {[
        "title" : caption,
        "imageUrl" : post
    ]}
}
struct GetAllPost : Codable {
    let id : String
    let userId : String
    let imageUrl : String
    let title : String
    let createdAt : String
    let postCreatedBy1 : PostCreatedBy
    let latestComment : [String]
    let commentedBy : [String]
    let totalLikes : Int
    let totalComments : Int
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "user_id"
        case imageUrl
        case title
        case createdAt
        case postCreatedBy1
        case latestComment
        case commentedBy
        case totalLikes
        case totalComments
    }
}
struct PostCreatedBy : Codable {
    let name : String
}
