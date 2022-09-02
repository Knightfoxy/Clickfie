//
//  CFAPIManager.swift
//  ClickFie
//
//  Created by Ayush Mishra on 29/04/22.
//

import Foundation

class WebServices {
    static func callPost(url : URL, params : [String:Any], purpose1 : String , finish : @escaping ((message:String, data:Data?, statusCheckCode : Int, purpose1 : String)) -> Bool) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       if let postString = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
        request.httpBody = postString
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        }
        var result:(message:String, data:Data? , statusCheckCode : Int , purpose1 : String  ) = (message: "Fail", data: nil , statusCheckCode : 0 , purpose1 : "")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                result.message = "Fail Error not null : \(error.debugDescription)"
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    result.statusCheckCode = httpResponse.statusCode
                    result.message = httpResponse.description
               }
                result.data = data
                result.purpose1 = purpose1
            }
            finish(result)
        }
        task.resume()
    }
  }
