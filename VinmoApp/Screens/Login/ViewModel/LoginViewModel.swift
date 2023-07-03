//
//  LoginViewModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
class LoginViewModel {
    
    let validator:Validator
    var eventHandler: ((_ event: Event) -> Void)?
    var loginResponse: LoginResponseModel?
    init(validator: Validator) {
        self.validator = validator
    }
    
    func login(userName: String?, password: String?) {
        do {
            let userName = try validator.validateUserName(userName)
            let password = try validator.validatePassword(password)
            let loginParam = LoginPostModel(password: password, username:userName)
            self.eventHandler?(.loading)
            ApiManager.shared.request(
                modelType: LoginResponseModel.self,
                type: EndPoints.login(login: loginParam)) { response in
                    self.eventHandler?(.stopLoading)
                    switch response {
                    case .success(let loginModel):
                        self.loginResponse = loginModel
                        self.eventHandler?(.dataLoaded)
                        Constant.userDefaults.set(true, forKey: UserDefaultKeys.kIsLoggedIn)
                        Constant.userDefaults.set(loginModel.access ?? "", forKey: UserDefaultKeys.accessToken)
                    case .failure(let error):
                        self.eventHandler?(.error(error))
                    }
                }
        } catch {
            self.eventHandler?(.error(error))
        }
        
    }

}

