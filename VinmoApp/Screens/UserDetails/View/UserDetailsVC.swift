//
//  UserDetailsVC.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    let viewModel = UserDetailsViewModel()
    //MARK: - @IBOUTLETS
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: CustomImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    //MARK:- LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserDeatils()
        
    }
    
    func fetchUserDeatils() {
        DispatchQueue.global(qos: .utility).async {
            self.viewModel.fetchUserDetails()
        }
    }
    
    func initialSetup() {
        imgUser.addBorder(2)
        imgUser.dropShadow()
        btnBack.addBorder(1)
        btnBack.cornerRadius(radius: 5)
        imgUser.cornerRadius(radius: imgUser.bounds.height/2)
        observeEvent()
    }

    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showUIWhenDataAvailable() {
        if let firstName = viewModel.userDeatails?.firstName,let lastName = viewModel.userDeatails?.lastName {
            lblName.text = "\(firstName) \(lastName)"
        }
        if let email = viewModel.userDeatails?.email {
            lblEmail.text = email
        }
        if let imageStr = viewModel.userDeatails?.profileIcon {
            imgUser.loadImageUsingUrlString(urlString: imageStr)
        }
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
    
}

extension UserDetailsVC {
    
    //MARK: - Data binding
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
                DispatchQueue.main.async {
                    self.showUIWhenDataAvailable()
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
