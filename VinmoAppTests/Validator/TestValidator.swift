//
//  TestValidator.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/25/23.
//

import XCTest
@testable import VinmoApp
class TestValidator: XCTestCase {

    var validator = Validator()
    
    func test_UserName() throws {
        for result in ValidationData.getTestUserName() {
            let resultString = result.expecteResult.1
            let expectedResult = result.expecteResult
            let actualResult = try validator.validateUserName(result.userName)
            assert(expected: expectedResult.1, actual: actualResult, dataSet: resultString)
        }
    }
    
    func test_Password() throws {
        for result in ValidationData.getTestPassword() {
            let resultString = result.expecteResult.1
            let expectedResult = result.expecteResult
            let actualResult = try validator.validatePassword(result.password)
            assert(expected: expectedResult.1, actual: actualResult, dataSet: resultString)
        }
    }
    
    func test_ValidateEmail() throws {
        for result in ValidationData.getTestEmail() {
            let resultString = result.expecteResult.1
            let expectedResult = result.expecteResult
            let actualResult = try validator.validateEmail(result.email)
            assert(expected: expectedResult.1, actual: actualResult, dataSet: resultString)
        }
    }
    
    func test_ValidateFirstName() throws {
        for result in ValidationData.getTestFirstName() {
            let resultString = result.expecteResult.1
            let expectedResult = result.expecteResult
            let actualResult = try validator.validateFirstName(result.firstName)
            assert(expected: expectedResult.1, actual: actualResult, dataSet: resultString)
        }
    }
    
    func test_ValidateLastName() throws {
        for result in ValidationData.getTestFirstName() {
            let resultString = result.expecteResult.1
            let expectedResult = result.expecteResult
            let actualResult = try validator.validateLastName(result.firstName)
            assert(expected: expectedResult.1, actual: actualResult, dataSet: resultString)
        }
    }
    
    func test_ValidEmail() throws {
        for result in ValidationData.getTestEmail() {
            let expectedResult = result.expecteResult.0
            let actualResult = validator.isValidEmail(result.email)
            XCTAssertEqual(expectedResult, actualResult)
        }
    }
    
    func test_ValidateUserInput()  {
        for result in ValidationData.getTestInputUser() {
            let expectedResult = result.expecteResult
            let actualResult = validator.isValidInput(input: result.user)
            XCTAssertEqual(expectedResult, actualResult)
        }
    }

}
