//
//  CFHomeVM .swift
//  ClickFie
//
//  Created by Ayush Mishra on 15/06/22.
//

import Foundation

class CFHomeVM {
    var getData : (() -> Void)?
    var getProfileData : ( (_ userData : Welcome) -> Void)?
    func getAllPostDataApiCall() {
        let networkManager = NetworkManager(endpoint: "getAllPost")
        let dataToken = keyChainAccess["token"]
        print("--------********------------" , dataToken as Any)
        networkManager.requestUrl.httpMethod = "get"
        networkManager.requestUrl.addValue(dataToken ?? "" ,forHTTPHeaderField: "Authorization")
        networkManager.getApiData(resultType : Welcome.self) { userRegistrationResponse in
            switch userRegistrationResponse {
            case .success(let data) :
                DispatchQueue.main.async {
                    // call a image dwnld function
                    print("total posts === " , data.count)
//                    let url : String = "https://firebasestorage.googleapis.com/v0/b/clickfie-8c656.appspot.com/o/image%2Fmynextimage.png?alt=media&token=94b542de-a8cf-4eef-b72f-13ecd1b5047b"
                    for item in data {
                        let urlString = item.imageURL
                    Networking.sharedInstance.getImage(imageURL: urlString) { _ in
                    }
                    }
                    self.getProfileData?(data)
                }
            case .failure(let error) :
                switch error {
                case .decodingProblem :
                    debugPrint("decoding problem")
                case .responseProblem :
                    debugPrint("Server authorization failed")
                case .otherProblem :
                    debugPrint("other problem")
                }
            }
        }
    }
}
// define img dwnld fn() {
