//
//  ApiHelper.swift
//  ClickFie
//
//  Created by Ayush Mishra on 06/05/22.
//

import Foundation

class ApiResponses {
    static var shared = ApiResponses()
    var authToken : String?
    var closureApiSuccess : ((_ purpose1 : String) -> Void)?
    var showStatusClosure : ((_ statusCheckCode : Int) -> Void)?
    func finishPost (message:String ,data:Data? ,statusCheckCode:Int ,purpose : String) -> Bool {
        do {
            if let jsonData = data {
               let parsedData = try JSONSerialization.jsonObject(with: jsonData, options:JSONSerialization.ReadingOptions.allowFragments)
                    print(parsedData)
                let nsdict = parsedData as? NSDictionary
                if let token = nsdict?["data"] as? String {
                    authToken = token
                }
                print("this is token -- " , authToken as Any)
            }
          } catch {
              print("parsing error check your codable structure.")
        }
        switch statusCheckCode {
        case 200 :
            DispatchQueue.main.async {
                self.closureApiSuccess?(purpose)
            }
        case 400 :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        case 401 :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        case 404 :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        case 406 :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        case 409 :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        default :
            DispatchQueue.main.async {
                self.showStatusClosure?(statusCheckCode)
            }
        }
        return false
    }
}
