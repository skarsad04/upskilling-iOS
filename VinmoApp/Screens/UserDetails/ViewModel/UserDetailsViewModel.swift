//
//  UserDetailsViewModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation

class UserDetailsViewModel {
    var userDeatails: UserDetailsData?
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchUserDetails() {
        ApiManager.shared.request(
            modelType: UserDetailsResponseModel.self,
            type: EndPoints.userDetails) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let userDetailsResponse):
                    if let userDetails = userDetailsResponse.data {
                        self.userDeatails = userDetails
                        self.eventHandler?(.dataLoaded)
                    }
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
}

