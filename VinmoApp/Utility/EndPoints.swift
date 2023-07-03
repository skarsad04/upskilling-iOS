//
//  EndPoints.swift
//  VinmoApp
//
//  Created by asif hussain on 3/16/23.
//

import Foundation
enum EndPoints {
    case userList
    case login(login: LoginPostModel)
    case signUp(signUp: signUpPostModel)
    case multiSignUp
    case userDetails
}

extension EndPoints: EndPointType {

    var path: String {
        switch self {
        case .userList:
            return "account/list_users/"
        case .login :
           return "login/"
        case .signUp :
           return "account/create_user/"
        case .multiSignUp :
            return "account/create_user/"
        case .userDetails :
            return "account/details_users/"
        }
    }

    var baseURL: String {
        return "http://13.233.102.144:8000/"
    }
      

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .userList:
            return .get
        case .login :
            return .post
        case .signUp :
            return .post
        case .multiSignUp :
            return .post
        case .userDetails :
            return .post
        }
       
    }

    var body: Encodable? {
        switch self {
        case .userList :
            return nil
        case .userDetails :
            return nil
        case .signUp(let signUp) :
            return signUp
        case .multiSignUp :
            return nil
        case .login(let login) :
            return login
        }
    }

    var headers: [String : String]? {
        switch self {
        case .login ,.signUp ,.multiSignUp :
            return ApiManager.commonHeaders
        case .userDetails, .userList :
            return ApiManager.loginHeaders
        }
        
    }
}
