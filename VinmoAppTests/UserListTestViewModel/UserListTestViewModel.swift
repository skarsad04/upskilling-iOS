//
//  UserListTestViewModel.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/27/23.
//

import XCTest
@testable import VinmoApp
class UserListTestViewModel: XCTestCase {
    let listViewModel = UsersListViewModel()
    
    func test_userListFetch() {
        listViewModel.fetchUsers()
    }

}
