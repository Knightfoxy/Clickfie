//
//  CFHomeDataModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 24/05/22.
//

import Foundation
import Photos
import UIKit

// MARK: - Data set to Send Photos
struct CFAddPostDataModel {
    var myImages:[Data]! = [Data]()
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    var photoDataArray :[Data]!  = [Data]()
}
// MARK: - Login Model
struct AddPostCredentials : Encodable {
    var title : String?
    var imageUrl: String?
  }
// MARK: - DataClass
struct AddPostClass : Codable {
    let statusCode : Int?
    let status : Bool?
    let message : String?
}
