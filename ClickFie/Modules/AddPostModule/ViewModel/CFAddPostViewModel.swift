//
//  CFAddPostViewModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 20/05/22.
//

import Foundation
import UIKit
import Photos
import BSImagePicker
import FirebaseStorage// pod

var photoStringArray : [String] = [""]
var photoString : String?
class CFAddPostViewModel {
    // MARK: - Stored Properties
    lazy var objAddPostDataModel : CFAddPostDataModel? = CFAddPostDataModel()
    var objAddPostCred = AddPostCredentials()
    private let storage = Storage.storage().reference()
    var addPostOnApiSuccessful : (() -> Void)?
    var addPostOnApiFailure : (() -> Void)?
    // MARK: - Custom Methods
    // image converting to Data then appending to photo array
    func convertAssetsToImages(_ collectionView : UICollectionView) {
        if objAddPostDataModel?.selectedAssets.isEmpty == false {
            objAddPostDataModel?.myImages.removeAll()
            objAddPostDataModel?.photoArray.removeAll()
            for imageInAsset in 0..<objAddPostDataModel!.selectedAssets.count {
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: objAddPostDataModel!.selectedAssets[imageInAsset], targetSize: CGSize(width: 320, height: 275), contentMode: PHImageContentMode.aspectFill, options: option, resultHandler: { (result, _) -> Void in
                    thumbnail = result!
                })
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                objAddPostDataModel?.photoArray.append(newImage! as UIImage)
                let imagedata = newImage?.pngData()
                objAddPostDataModel?.photoDataArray.append(imagedata!)
                print(objAddPostDataModel?.photoArray as Any)
                // This for send images data to another view controller for make request
                objAddPostDataModel?.myImages.append(data!)
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
    // Upload to firebase then download its url
    func onHitLoadBtn( _ caption : String ) {
        var count = 0
       // for item in objAddPostDataModel!.photoDataArray {
            let imgName = "mynextimage"
            // count += 1
        storage.child("image/\(imgName).png").putData(objAddPostDataModel!.photoDataArray[0], metadata: nil, completion: {_,error in guard error == nil else {
                print("Failed")
                    return
                  }
                // download image url
                self.storage.child("image/\(imgName).png").downloadURL(completion: { url , error in
                    guard let url = url , error == nil else {
                        return
                    }
                    let urlString = url.absoluteString
                    photoString = urlString
                    print("Download String:\(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                    let urlAsString : String = String(urlString)
                    print(urlAsString)
                    photoStringArray.append(urlAsString)
                    if photoString != nil {
                        // api call.
                        self.objAddPostCred.title = caption
                        self.objAddPostCred.imageUrl = photoString
                        print("call to api")
                        self.addPostApiCall()
                    }
                    print(".....................................\(photoString)")
                })
            })
        // }
    }
    // image placeholder active when no image present
    func showImgPlaceholder(_ initialPicOutlet : UIImageView) {
        if objAddPostDataModel?.myImages.isEmpty != nil {
            initialPicOutlet.isHidden = true
        } else {
            initialPicOutlet.isHidden = false
        }
    }
    // to delete any image from the selected image
    func toDeleteImagePost(_ baseCollectionView : UICollectionView,_ sender : UIButton) {
        objAddPostDataModel?.myImages.remove(at: (sender).tag)
        objAddPostDataModel?.photoArray.remove(at: (sender).tag)
        objAddPostDataModel?.selectedAssets.remove(at: (sender).tag)
        baseCollectionView.reloadData()
    }
    // appending the images to selected Asset
    func addingSelectedImage(_ item : Int, assets : [PHAsset]) {
        objAddPostDataModel?.selectedAssets.append(assets[item])
    }
    func numberOfItemsInSection() -> Int {
        print("count = " , objAddPostDataModel?.myImages?.count ?? 0)
        return objAddPostDataModel?.myImages?.count ?? 0
    }
    func addingDataToPhotoArray(_ item : Int) -> UIImage {
        return (objAddPostDataModel?.photoArray[item])!
    }
    func onTapUpload(_ caption : String,_ progressView : UIView,_ progressSpinner : UIActivityIndicatorView,_ statusLabel : UILabel) {
        progressView.isHidden = false
        progressSpinner.isHidden = false
        progressSpinner.startAnimating()
        onHitLoadBtn(caption)
    }
//    var dataToken : String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmI1OWNhY2I3NmNmNTIxNjgzYjdmNzEiLCJpYXQiOjE2NTYwNjkzMjIsImV4cCI6MTY1NjE1NTcyMn0.zHsD3mpA1ncOEFiD9STQiYagOoMW9pBRPonZnmDz3OA"
    var dataToken = keyChainAccess["token"]
    func addPostApiCall() {
        let networkManager = NetworkManager(endpoint: APIEndPoint.addPost.rawValue)
        if let token = dataToken {
            networkManager.requestUrl.addValue(token ,forHTTPHeaderField: "Authorization")
            networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        } else {
            return
        }
        do {
            let encodedRequest = try JSONEncoder().encode(objAddPostCred)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<AddPostClass>.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        self.addPostOnApiSuccessful?()
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                        DispatchQueue.main.async {
                            self.addPostOnApiFailure?()
                        }
                    case .responseProblem :
                        DispatchQueue.main.async {
                            self.addPostOnApiFailure?()
                        }
                        debugPrint("response problem")
                    case .otherProblem :
                        debugPrint("other problem")
                        DispatchQueue.main.async {
                            self.addPostOnApiFailure?()
                        }
                    }
                }
            }
        } catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
