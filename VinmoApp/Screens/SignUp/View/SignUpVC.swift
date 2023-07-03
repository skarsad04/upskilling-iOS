//
//  SignUpVC.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import UIKit

class SignUpVC: UIViewController {
    
    let viewModel = SignUpViewModel(validator: Validator())
    //MARK: - @IBOUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var passwordVw: UIView!
    @IBOutlet weak var userNameVw: UIView!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var firstNameVw: UIView!
    @IBOutlet weak var lastNameVw: UIView!
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialConfiguration()
    }
    
    //MARK: - PRIVATE METHODS
    func setupInitialConfiguration() {
        userNameVw.dropShadow()
        passwordVw.dropShadow()
        emailVw.dropShadow()
        firstNameVw.dropShadow()
        lastNameVw.dropShadow()
        imgProfile.dropShadow()
        userNameVw.cornerRadius()
        passwordVw.cornerRadius()
        firstNameVw.cornerRadius()
        lastNameVw.cornerRadius()
        emailVw.cornerRadius()
        imgProfile.cornerRadius(radius: imgProfile.bounds.height/2)
        btnSignUp.dropShadow()
        btnSignUp.cornerRadius()
        imgProfile.addBorder(2)
        observeEvent()
        
    }
    
    //MARK: - @IBACTION

    @IBAction func tapSignUp(_ sender: UIButton) {
        view.endEditing(true)
        signUpRequest()
    }
    
    @IBAction func tapCamera(_ sender: UIButton) {
        MediaManager.shared.showMediaSheetOn(self)
        MediaManager.shared.delegate = self
        
    }
    
    func signUpRequest() {
        if let imageData = imgProfile.image?.jpegData(compressionQuality: 0.7) {
           viewModel.signUpRequest(userName: txtUserName.text, password: txtPassword.text, email: txtEmail.text, firstName: txtFirstName.text, lastName: txtLastName.text,imageData: imageData)
        } else {
            viewModel.signUpRequest(userName: txtUserName.text, password: txtPassword.text, email: txtEmail.text, firstName: txtFirstName.text, lastName: txtLastName.text)
        }
    }
    
    func redirectToLogin() {
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let nav: UINavigationController = UINavigationController(rootViewController: vc)
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = nav
            sd.window?.makeKeyAndVisible()
        }
     }
    


}

extension SignUpVC: MediaSelectedDelegate {
    func selectedMediaType(image: UIImage) {
        DispatchQueue.main.async {
            self.imgProfile.image = image
        }
        
    }
    
    func permissionDenied() {
        alertWithMessage("Permission denied!")
    }
    
}

extension SignUpVC {
    
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
                  self.redirectToLogin()
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.alertWithMessage(error?.localizedDescription ?? "")
                }
            
            }
        }
    }
    
}
