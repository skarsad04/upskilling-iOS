//
//  UsersListViewModel.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation

class UsersListViewModel {
    var userList: [UserListData] = []
    var eventHandler: ((_ event: Event) -> Void)?
    func fetchUsers() {
        self.eventHandler?(.loading)
        ApiManager.shared.request(
            modelType: UserListResponseModel.self,
            type: EndPoints.userList) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let userListModel):
                    if let users = userListModel.data {
                        self.userList = users
                        self.eventHandler?(.dataLoaded)
                    }
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
}


