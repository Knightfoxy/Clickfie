//
//  CFSignUpDataModel.swift
//  ClickFie
//
//  Created by Admin on 07/04/22.
//

import Foundation
import UIKit
import CoreData

struct CFUserDataModel {

    var profilePhoto : UIImage?
    var name : String?
    var email : String?
    var phoneNumber : String?
    var countryCode : String?
}

class OnboardingUserData {
    var signUpData = CFUserDataModel()
}
struct UserModel {
    var name : String
    var email : String
    var phoneNum : String
    var cCode : String
}
struct UserParametersToApi {
    var name : String
    var email : String
    var phoneNumber : String
}
struct UserParameterToLoginApi {
    var phoneNumber : String
}
