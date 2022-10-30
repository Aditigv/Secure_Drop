//
//  launchViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 9/22/22.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet var launchSignUpButton: UIButton!
    
    @IBOutlet var launchLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        //addd comment

        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(launchSignUpButton)
        //Utilities.styleFilledButton(LoginButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpTapped(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        signUpVC?.definesPresentationContext = true
        if let signUpVC = signUpVC {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        loginVC?.definesPresentationContext = true
        if let loginVC = loginVC {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
