//
//  LoginValidator.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
enum ValidationError: LocalizedError {
    case invalidUserName
    case passwordTooShort
    case passwordTooLong
    case invalidEmail
    case enterFirstName
    case enterLastName
    case enterEmail
    case enterPassword
    case enterUserName
    case passwordFormate
    var errorDescription: String? {
        switch self {
        case .invalidUserName:
            return "Invalid Username"
        case .passwordTooShort:
            return "Password is too short"
        case .passwordFormate:
            return "Password field must be contains min 6 characters with special character and numeric digits"
        case .passwordTooLong:
            return "Your password is too long."
        case .invalidEmail:
            return "Invalid Email"
        case .enterFirstName:
            return "Enter First Name"
        case .enterLastName:
            return "Enter Last Name"
        case .enterEmail:
            return "Enter Email"
        case .enterPassword:
            return "Enter Password"
        case .enterUserName:
            return "Enter Username"
        }
        
    }
}
struct Validator {
    func validateUserName (_ userName: String?) throws -> String {
        guard let userName = userName, !userName.isEmpty else { throw ValidationError.enterUserName}
        guard isValidEmail(userName) else { throw ValidationError.invalidUserName }
        return userName
    }
    
    func isValidInput(input:String) -> Bool {
        let RegEx = "\\w{7,18}"
        let text = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return text.evaluate(with: input)
    }
    
    func validatePassword (_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.enterPassword }
        guard password.count >= 6 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        guard isValidPassword(password) else { throw ValidationError.passwordFormate }
        return password
    }
    
    func validateEmail (_ email: String?) throws -> String {
        guard let email = email, !email.isEmpty else { throw ValidationError.enterPassword}
        guard isValidEmail(email) else { throw ValidationError.invalidEmail }
        return email
    }
    
    func validateFirstName (_ firstname: String?) throws -> String {
        guard let firstname = firstname, !firstname.isEmpty else { throw ValidationError.enterFirstName}
        return firstname
    }
    
    func validateLastName (_ lastName: String?) throws -> String {
        guard let lastName = lastName, !lastName.isEmpty else { throw ValidationError.enterLastName}
        return lastName
    }
    
    func isValidEmail(_ email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let password = password
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
}
