//
//  UsersListVC.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import UIKit

class UsersListVC: UIViewController {
    
    let viewModel = UsersListViewModel()
    //MARK: - @IBOUTLETS
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var userListTableVw: UITableView!
    @IBOutlet weak var btnLogout: UIButton!
    
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        
    }
    
    //MARK: - PRIVATE FUNCTIONS
    func configureTable() {
        btnLogout.addBorder(1)
        btnLogout.cornerRadius(radius: 5)
        self.navigationController?.isNavigationBarHidden = true
        self.lblNoRecord.isHidden = true
        userListTableVw.dataSource = self
        userListTableVw.delegate = self
        userListTableVw.register(UINib(nibName: UserListCell.identifier, bundle: .main), forCellReuseIdentifier: UserListCell.identifier)
        userListTableVw.rowHeight = UITableView.automaticDimension
        userListTableVw.estimatedRowHeight = 70
        observeEvent()
        DispatchQueue.global(qos: .utility).async {
            self.viewModel.fetchUsers()
        }
        
    }
    
    func navigateToUserDetails() {
        let vc = UserDetailsVC.instantiate(fromAppStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func logout() {
        Constant.userDefaults.set(nil, forKey: UserDefaultKeys.kIsLoggedIn)
        Constant.userDefaults.set(nil, forKey: UserDefaultKeys.accessToken)
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let nav: UINavigationController = UINavigationController(rootViewController: vc)
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = nav
            sd.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func tapLogout(_ sender: UIButton) {
        logout()
    }
    
}

extension UsersListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.identifier, for: indexPath) as? UserListCell else { return UITableViewCell() }
        let user = viewModel.userList[indexPath.row]
        cell.user = user
        return cell
    }

    
}

extension UsersListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToUserDetails()
    }
}

extension UsersListVC {
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }

            switch event {
            case .loading:
                print("loading")
//                DispatchQueue.main.async {
//                    MRActivityIndicator.shared.show()
//                }
            case .stopLoading:
                print("stop loading")
//                DispatchQueue.main.async {
//                    MRActivityIndicator.shared.hide()
//                }
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    self.userListTableVw.reloadData()
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.alertWithMessage(error?.localizedDescription ?? "")
                    self.logout()
                }
            }
        }
    }
}

