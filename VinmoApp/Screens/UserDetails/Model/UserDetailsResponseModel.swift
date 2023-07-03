//
//  UserDetailsResponseModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation

struct UserDetailsResponseModel: Codable {

    let message: String?
    let success: Bool?
    let data: UserDetailsData?
    let status: Int?

    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case success = "success"
        case data = "data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent(UserDetailsData.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}

struct UserDetailsData: Codable {
    let id: Int?
    let username: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let profileIcon: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileIcon = "profile_icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profileIcon = try values.decodeIfPresent(String.self, forKey: .profileIcon)
    }

}
