//
//  LoginTestViewModel.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/25/23.
//

import XCTest
@testable import VinmoApp
class LoginTestViewModel: XCTestCase {
    var loginViewModel = LoginViewModel(validator: Validator())
   
    func test_LoginRequest() {
        loginViewModel.login(userName: "asifhussain358@gmail.com", password: "123456")
    }
    
    
}
