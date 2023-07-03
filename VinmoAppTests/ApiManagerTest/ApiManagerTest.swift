//
//  ApiManagerTest.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/28/23.
//

import XCTest
@testable import VinmoApp
class ApiManagerTest: XCTestCase {

    func test_RequestWithValidData() {
        let loginData = LoginPostModel(password: "Modi@1234", username: "modi@gmail.com")
        let expactation = self.expectation(description: "Valid_Request_Return_Valid_Response")
        ApiManager.shared.request(modelType: LoginResponseModel.self, type: EndPoints.login(login: loginData)) { response in
            switch response {
            case .success(let loginModel):
              XCTAssertNotNil(loginModel)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expactation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
   
    func test_MultipartRequestWithValidData() {
        let param = [
            "username" : "arhan@gmail.com",
            "password" : "Arhan@1234",
            "email" : "arhan@gmail.com",
            "first_name" : "Arhan",
            "last_name" : "Hussain"
        ]
        let imageData = UIImage(named: "placeholder")?.jpegData(compressionQuality: 0.7)
        let imageParam = "profile_icon"
        let expactation = self.expectation(description: "Valid_Request_Return_Valid_Response")
        ApiManager.shared.multipartRequest(modelType: SignUpRequestModel.self, type: EndPoints.multiSignUp, param: param, imageData: imageData, imageParam: imageParam) { response in
            switch response {
            case .success(let loginModel):
              XCTAssertNotNil(loginModel)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expactation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
}
