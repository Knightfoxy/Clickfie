//
//  CFDownloadManager.swift
//  ClickFie
//
//  Created by Ayush Mishra on 25/06/22.
//

import Foundation
import UIKit
var imageDownloadSuccessClosure : ((UIImage?) -> Void)? = nil
struct Networking {
    static let sharedInstance = Networking()
    let session = URLSession.shared
    func getImage(imageURL:String ,completion: @escaping(Result<Data?,UserError>) -> Void) -> String {
        guard let imageURL = URL(string: imageURL)
        else {
            return "Invalid Url"
        }
        let dataTask = session.downloadTask(with: imageURL) { (data,_,_) in
            guard let safeData = data else { return completion(.failure(.otherProblem)) }
            // alert code
            guard let image1 = try? Data(contentsOf: safeData) else {
                completion(.failure(.responseProblem))
                return
            }
            DispatchQueue.main.async {
                if let successImage =  UIImage(data: image1) {
                    imageDownloadSuccessClosure?(successImage)
                }
            }
        }
        dataTask.resume()
        return "success"
    }
}

enum UserError : Error {
    case decodingProblem
    case otherProblem
    case responseProblem
}
