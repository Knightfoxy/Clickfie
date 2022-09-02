//
//  CFAPIManager.swift
//  ClickFie
//
//  Created by Ayush Mishra on 29/04/22.
//
import Foundation
import UIKit

class NetworkManager {
    var requestUrl : URLRequest
    var authToken : String?
    let caseURL = "https://firebasestorage.googleapis.com:443/v0/b/clickfie-8c656.appspot.com/o/image%2Fmynextimage.png?alt=media&token=94b542de-a8cf-4eef-b72f-13ecd1b5047b"
    init(endpoint : String) {
        let baseURL = "http://44.202.78.173:5002/\(endpoint)"
        guard let resourceURL = URL(string: baseURL) else {
            fatalError()
        }
        var request = URLRequest(url: resourceURL)
        self.requestUrl = request
        request.addValue(authToken ?? "", forHTTPHeaderField: "Authorization")
    }
    func postApiDataWithAny<T:Decodable>(requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<Any,ApiError>) -> Void) {
        requestUrl.httpMethod = "POST"
        requestUrl.httpBody = requestBody
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse , error) in
            guard let jsonData = data, let urlResponse = httpUrlResponse as? HTTPURLResponse  else {
                completionHandler(.failure(.responseProblem))
                return
            }
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            print(prettyPrintedString!)
            print(urlResponse.statusCode)
            if !(200...300).contains(urlResponse.statusCode) {
                completionHandler(.failure(.responseProblem))
                return
            }
            do {
                let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                print(prettyPrintedString!)
                let parsedData = try JSONSerialization.jsonObject(with: jsonData, options:JSONSerialization.ReadingOptions.allowFragments)
                     print(parsedData)
                 _=completionHandler(.success(parsedData))
            } catch let error {
                debugPrint(error)
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
    func postApiData<T:Decodable>(requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T,ApiError>) -> Void) {
        requestUrl.httpMethod = "POST"
        requestUrl.httpBody = requestBody
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse , error) in
            guard let jsonData = data, let urlResponse = httpUrlResponse as? HTTPURLResponse  else {
                completionHandler(.failure(.responseProblem))
                return
            }
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            print(prettyPrintedString!)
            print(urlResponse.statusCode)
            if !(200...300).contains(urlResponse.statusCode) {
                completionHandler(.failure(.responseProblem))
                return
            }
            do {
                let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                print(prettyPrintedString!)
                let response = try JSONDecoder().decode(T.self, from: jsonData)
                _=completionHandler(.success(response))
            } catch let error {
                debugPrint(error)
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
    func getApiData<T:Decodable>(resultType: T.Type, completionHandler:@escaping(Result<T,ApiError>) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            guard let jsonData = responseData , let urlResponse = httpUrlResponse as? HTTPURLResponse else {
                return
            }
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            print(prettyPrintedString!)
            print(urlResponse.statusCode)
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                _=completionHandler(.success(result))
            } catch let error {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
}
enum ApiError : Error {
    case decodingProblem
    case otherProblem
    case responseProblem
}
