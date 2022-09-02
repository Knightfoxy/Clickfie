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
    case addPost = "addPost"
    case getAllPost = "getAllPost"
}

enum APIResponces : String {
    case invalidCredentials = "Invalid Credentials"
    case loginFailed = "Login Failed ,Try Again Later"
    case userNotRegistered = "User Not Registered, Signup first"
    case alreadyLogginIn = "User  already LoggedIn"
    case userAlreadyExists = "User already Exists"
    case serverError = "Unable to Join Network Failure"
}
enum IdentifierNames : String {
    case cFOtpSheetVC = "CFOtpSheetVC"
    case cFHomeVC = "CFHomeVC"
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
    case invalidInput = "Enter 10 digit Mobile Number."
    case captionEmpty = "Caption cannot be empty"
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
    case addPost = "addPost"
    case getAllPost = "getAllPost"
}
enum APIBaseURL : String {
case baseURL =  "http://44.202.78.173:5002/"
}

var homeCategories : [String] = [ "homeCategories1", "homeCategories2", "homeCategories3", "homeCategories4","homeCategories5" ]

var sideMenuCategeories : [String] = ["icSideMenu1","icSideMenu2","icSideMenu3","icSideMenu4","icSideMenu5","icSideMenu6","icSideMenu7","icSideMenu8","icSideMenu9","icSideMenu10","icSideMenu11","icSideMenu12","icSideMenu13","icSideMenu14","icSideMenu15"]

var sideCategeoriesTopics : [String] = ["Home","Mad About Movies","Love Guru","Chit Chat","Winfie Game","WarFie Game","Notifications","Settings","Money Talks","Funfie","Profile","Badges","Chat With US","Contact Us","Tutorial"]
var tutorialCategories : [String] = [ "tutorial1", "tutorial2", "tutorial3"]
var badgeNames : [String] = ["Fire starter","Swag Master","Social Champ","Klickfie Rockstar"]
var badgeImages : [String] = ["badgeImage1","badgeImage2","badgeImage3","badgeImage4"]
