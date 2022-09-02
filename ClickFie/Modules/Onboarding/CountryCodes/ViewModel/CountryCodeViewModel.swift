//
//  CountryCodeViewModel.swift
//  ClickFie
//
//  Created by Ayush Mishra on 12/04/22.
//

import Foundation
import UIKit

class CountryData {
    static var shared = CountryData()
    var allCountryDataArray = [CountryCodeModel]()
    func parseJSON() {
       guard let path = Bundle.main.path(forResource: "CountryCode", ofType: "json")
       else {
           return
       }
       let url = URL(fileURLWithPath: path)
       do {
           let jsonData = try Data(contentsOf: url)
           allCountryDataArray = try JSONDecoder().decode([CountryCodeModel].self, from: jsonData)
           print(allCountryDataArray)
       } catch let error {
           print(error)
       }
   }
}
