//
//  UserDetailsTestViewModel.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/27/23.
//

import XCTest
@testable import VinmoApp
class UserDetailsTestViewModel: XCTestCase {
   let detailsViewModel = UserDetailsViewModel()
    
    func test_UserDetailsFetch() {
        detailsViewModel.fetchUserDetails()
    }
   
}
