//
//  StringModel.swift
//  ClickFie
//
//  Created by Admin on 06/04/22.
//

import Foundation

enum ApiCallType : String {
    case login = "login"
    case signup = "signup"
    case fblogin = "fbLogin"
    case googleLogin = "googleLogin"
    case verifyOtp = "verifyOtp"
}

enum APIResponces : String {
    case invalidCredentials = "Invalid Credentials"
    case loginFailed = "Login Failed"
    case userNotRegistered = "User Not Registered Signup first"
    case alreadyLogginIn = "User  already LoggedIn"
    case userAlreadyExists = "User alreadyExist Signedup "
    case serverError = "Network error reconnect or Api Server ERROR"
}
enum IdentifierNames : String {
    case cFOtpSheetVC = "CFOtpSheetVC"
    case cFProfileVC = "CFProfileVC"
    case cFCountryCodeTableCell = "CFCountryCodeTableCell"
    case cFSignUpVC = "CFSignUpVC"
    case cFProfileTVCell = "CFProfileTVCell"
}
enum StoryBoard : String {
    case main = "Main"
    case profile = "Profile"
}
enum PopUpMessage : String {
    case camera = "Camera"
    case cancel = "Cancel"
    case remove = "Remove"
    case success = "success"
    case gallery = "Gallery"
}
enum AlertMessages : String {
    case otpAdded = "OTP Added"
    case blankFields = "Blank Entry"
    case profileImage = "profileImage"
    case invalidFields = "Invalid Entry"
    case invalidName = "Enter valid Name"
    case blankName = "Name can'nt be empty"
    case invalidEmail = "Enter valid Email"
    case blankEmail = "Email can'nt be empty"
    case blankPhone = "Mobile Number can'nt be empty"
    case invalidMobileNumber = "Enter valid Mobile Number"
    case selectProfilePicture = "Select Profile Picture"
    case phoneNumber = "phoneNumber"
    case noData = " .......data not available......"
    case validMobileDigits = "Enter 10 Digit Phone Number"
}
enum StringConstants  : String {
    case ok = "ok"
    case space = ""
    case zero = "00:"
    case twoI = "%.2i"
}
enum APIEndPoint : String {
    case login = "login"
    case signUp = "signup"
    case googleLogin = "socialMediaGoogle"
    case fbLogin = "socialMediaFb"
    case otpVerify = "verifyOtp"
}
enum APIBaseURL : String {
case baseURL =  "http://44.202.78.173:5002/"
}

var homeCategories : [String] = [ "homeCategories1", "homeCategories2", "homeCategories3", "homeCategories4","homeCategories5" ]
