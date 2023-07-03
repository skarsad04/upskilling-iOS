//
//  LoginResponseModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
struct LoginResponseModel: Codable {

    let refresh: String?
    let access: String?

    private enum CodingKeys: String, CodingKey {
        case refresh, access
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        refresh = try values.decodeIfPresent(String.self, forKey: .refresh)
        access = try values.decodeIfPresent(String.self, forKey: .access)
    }

}
