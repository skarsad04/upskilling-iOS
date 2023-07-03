//
//  SignUpViewModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
class SignUpViewModel {
    
    let validator:Validator
    var eventHandler: ((_ event: Event) -> Void)?
    var signUpDataModel: SignUpData?
    init(validator: Validator) {
        self.validator = validator
    }
    
    func signUpRequest(userName: String?, password: String?, email: String?, firstName: String?, lastName: String?) {
        do {
            let userName = try validator.validateUserName(userName)
            let password = try validator.validatePassword(password)
            let email = try validator.validateEmail(email)
            let firstName = try validator.validateFirstName(firstName)
            let lastName = try validator.validateLastName(lastName)
            let signUpParam = signUpPostModel(username: userName,password: password, email: email, first_name: firstName, last_name: lastName, profile_icon: "")
            self.eventHandler?(.loading)
            ApiManager.shared.request(
                modelType: SignUpRequestModel.self,
                type: EndPoints.signUp(signUp: signUpParam)) { response in
                    self.eventHandler?(.stopLoading)
                    switch response {
                    case .success(let signUpModel):
                        if let signUpData = signUpModel.data {
                            self.signUpDataModel = signUpData
                            self.eventHandler?(.dataLoaded)
                        }
                    case .failure(let error):
                        self.eventHandler?(.error(error))
                    }
                }
        } catch {
            self.eventHandler?(.error(error))
        }
        
    }
    
    func signUpRequest(userName: String?, password: String?, email: String?, firstName: String?, lastName: String?, imageData: Data? = nil) {
        do {
            let userName = try validator.validateUserName(userName)
            let password = try validator.validatePassword(password)
            let email = try validator.validateEmail(email)
            let firstName = try validator.validateFirstName(firstName)
            let lastName = try validator.validateLastName(lastName)
            let param = [
                "username" : userName,
                "password" : password,
                "email" : email,
                "first_name" : firstName,
                "last_name" : lastName
            ]
            
            self.eventHandler?(.loading)
            ApiManager.shared.multipartRequest(modelType: SignUpRequestModel.self, type: EndPoints.multiSignUp, param: param, imageData: imageData, imageParam: "profile_icon") { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let signUpModel):
                    if let signUpData = signUpModel.data {
                        self.signUpDataModel = signUpData
                        self.eventHandler?(.dataLoaded)
                    }
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
        } catch {
            self.eventHandler?(.error(error))
        }
        
    }
    
    
}

