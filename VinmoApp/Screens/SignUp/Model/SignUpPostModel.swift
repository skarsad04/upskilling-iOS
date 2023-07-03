//
//  SignUpPostModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
struct signUpPostModel: Codable {
    let username: String
    let password: String
    let email: String
    let first_name: String
    let last_name: String
    let profile_icon: String
}
