//
//  LoginViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 9/22/22.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        setUpElements()
        setupPasswordTextField()
    }
    func setupPasswordTextField() {
        self.passwordTextField.isSecureTextEntry = true
    }
    func setUpElements() {
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
     
    @IBAction func didTapCreateAccount(_ sender: UIButton) {
        if self.definesPresentationContext {
            let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
                    if let signUpVC = signUpVC {
                        self.navigationController?.present(signUpVC, animated: true)
                    }
        } else {
            self.dismiss(animated: true)
        }
        
    }
    
    @IBAction func diTapLoginButton(_ sender: UIButton) {
        
        self.errorLabel.isHidden = true
        guard let emailAddress = self.emailTextField.text,
              let password = self.passwordTextField.text else {
            print("Please enter email and password")
            return
        }
        self.addLoadingIndicator()
        Auth.auth().signIn(withEmail: emailAddress, password: password) { result, err in
            self.removeLoadingIndicator()
            if let err = err {
                self.errorLabel.text = err.localizedDescription
                self.errorLabel.isHidden = false
                print(err.localizedDescription)
            }
            if let _ = result?.user {
                //proceed with home screen navigation
                let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
                if let homepageVC = homePageVC {
                    self.navigationController?.pushViewController(homepageVC, animated: true)
                }
            }
            
        }
        
    }
        
    //@IBAction func LoginButton(_ sender: Any) {
    //}
    
}
        
    
