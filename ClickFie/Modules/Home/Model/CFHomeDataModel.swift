// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import UIKit

// MARK: - WelcomeElement
struct WelcomeElement : Codable {
    let id, userID: String
    let imageURL: String
    let title, createdAt: String
    let postCreatedBy2: PostCreatedBy2
    let lastestComment, commentedBy: [String]
    let totalLikes, totalComments: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case imageURL = "imageUrl"
        case title, createdAt, lastestComment, commentedBy, totalLikes, totalComments
        case postCreatedBy2 = "postCreatedBy"
    }
}
var testImage : UIImage!

typealias Welcome = [WelcomeElement]
// MARK: - PostCreatedBy
struct PostCreatedBy2: Codable {
    let name, imageURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "imageUrl"
    }
}
struct PostImage {
    var imageUrl : String
    var photo : UIImage
}
