//
//  SignupViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 9/22/22.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var fullNameTextField: UITextField!
    
    @IBOutlet var emailTextField:UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        setupSignUpBtn()
    }
    
    
    func setUpElements() {
        errorLabel.isHidden = true
        
        Utilities.styleTextField(fullNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
    func setupSignUpBtn() {
        self.signUpButton.setTitleColor(.white, for: .normal)
    }
    
     /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    

    @IBAction func signUpTapped(_ sender: Any) {
        //proceed to signUp flow
        self.errorLabel.isHidden = true
        self.addLoadingIndicator()
        guard self.passwordTextField.text == self.confirmPasswordTextField.text else {
            self.errorLabel.text = "Please make sure your password matches the confirm password field"
            print("Please make sure your password matches the confirm password field")
            self.errorLabel.isHidden = false
            return
        }
        
        let user = User(fullName: .fullName(fullNameTextField.text),
                        emailAddress: .emailAddress(emailTextField.text),
                        password: .password(passwordTextField.text))
        
        if let fullName = user.fullName,
           let emailAddress = user.emailAddress,
           let password = user.password {
            self.addLoadingIndicator()
            Auth.auth().createUser(withEmail: emailAddress,
                                   password: password) { authResult, err in
                DispatchQueue.main.async {
                    self.removeLoadingIndicator()
                    
                    if let err = err {
                        print("Firebase Auth Err: \(err)")
                    } else {
                        print("Created User \(String(describing: authResult?.user))")
                        let alertVC = UIAlertController(title: "Confim Dialog", message: "User Created", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default) { okAction in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertVC.addAction(okAction)
                        self.present(alertVC, animated: true)
                    }
                }
            }
        } else if let err = user.errorMsg {
            print("Error Creating Local User: \(err)")
        } else {
            
        }
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        if self.definesPresentationContext {
            let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            loginVC?.definesPresentationContext = false
            if let loginVC = loginVC {
                self.navigationController?.present(loginVC, animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
        
    }
}


