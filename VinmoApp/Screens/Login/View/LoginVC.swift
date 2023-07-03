//
//  LoginVC.swift
//  VinmoApp
//

import UIKit

class LoginVC: UIViewController {
    
    let viewModel = LoginViewModel(validator: Validator())
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var passwordVw: UIView!
    @IBOutlet weak var userNameVw: UIView!
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialConfiguration()

    }
    
    //MARK: - PRIVATE METHODS
    func setupInitialConfiguration() {
        userNameVw.dropShadow()
        passwordVw.dropShadow()
        userNameVw.cornerRadius()
        passwordVw.cornerRadius()
        btnLogin.dropShadow()
        btnLogin.cornerRadius()
        observeEvent()
    }
    
    
    //MARK: - @IBACTION
    
    @IBAction func tapLogin(_ sender: UIButton) {
        view.endEditing(true)
        loginRequest()
    }
    
    @IBAction func tapSignUp(_ sender: UIButton) {
        view.endEditing(true)
        let vc = SignUpVC.instantiate(fromAppStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginRequest() {
        viewModel.login(userName: txtUserName.text, password: txtPassword.text)
    }
    
    func redirectToList() {
        let vc = UsersListVC.instantiate(fromAppStoryboard: .main)
        let nav: UINavigationController = UINavigationController(rootViewController: vc)
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = nav
            sd.window?.makeKeyAndVisible()
        }
    }

   
}

extension LoginVC {
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
                print("stopLoading")
//                DispatchQueue.main.async {
//                    MRActivityIndicator.shared.hide()
//                }
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.redirectToList()
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.alertWithMessage(error?.localizedDescription ?? "")
                }
            
            }
        }
    }
}
