//
//  DeliveryPinViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 10/14/22.
//

import Foundation
import UIKit
import Firebase
class DeliveryPinViewController: UIViewController {
    @IBOutlet weak var generateDeliveryPinBtn: UIButton!
    @IBOutlet weak var mpinLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        setupGenerateDeliveryPinBtn()
        setupUsernameLabel()
        setupMPINLable()
    }
    func setupMPINLable() {
        if let masterPin = UserDefaults.standard.value(forKey: MPIN.masterKeyID.description) as? String {
            self.mpinLabel.text = "MPIN: \(masterPin)"
        } else {
            self.mpinLabel.text = "????"
        }
        
    }
    func setupUsernameLabel() {
        if let userEmail = try? Auth.auth().getStoredUser(forAccessGroup: nil)?.email {
            self.usernameLabel.text = "Welcome \(userEmail)!"
        } else {
            self.usernameLabel.text = "Welcome!"
        }
    }
    @objc func setupGenerateDeliveryPinBtn() {
        self.generateDeliveryPinBtn.addTarget(self, action: #selector(didTapGenerateDeliveryPin), for: .touchUpInside)
    }
    @objc func didTapGenerateDeliveryPin(sender: UIButton) {
        guard let showDeliveryPinViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ShowDeliveryPinViewController.self)) else {
            print("cannot present: \(String(describing: ShowDeliveryPinViewController.self))")
            return
        }
        self.navigationController?.pushViewController(showDeliveryPinViewController, animated: true)
    }
}
