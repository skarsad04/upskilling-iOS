//
//  SignupTestViewModel.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/27/23.
//

import XCTest
@testable import VinmoApp
class SignupTestViewModel: XCTestCase {

    var signUpViewModel = SignUpViewModel(validator: Validator())
   
    func test_LoginRequest() {
        signUpViewModel.signUpRequest(userName: "asif1234", password: "123456", email: "asif1234@gmail.com", firstName: "asif", lastName: "hussain", imageData: nil)
    }
    
    func test_LoginWithoutImage() {
        signUpViewModel.signUpRequest(userName: "asif1234", password: "123456", email: "asif1234@gmail.com", firstName: "asif", lastName: "hussain")
    }

}
