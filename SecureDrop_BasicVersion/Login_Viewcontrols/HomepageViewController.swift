//
//  HomepageViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 9/22/22.
//

import UIKit

class MPinViewController: UIViewController {

    @IBOutlet var pinTextField: UITextField!
    @IBOutlet var pinValidationTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var setMasterPinBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        addGestureRecognizer()
        setupSetMasterPinBtn()
        setupPinTextField()
    }
    func callFirebaseToSetMasterPin(completion: @escaping (_ hasSuccess: Bool?) -> Void) {
        //fake example api call
        guard let masterKey = self.pinTextField.text else {
            completion(nil)
            return
        }
        UserDefaults.standard.setValue(masterKey, forKey: MPIN.masterKeyID.description)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
        
    }
    func isValidPasscode() -> Bool {
        let error: String =             """
                                        Error: Invalid Passcode.
                                        Please enter a 4 Digit Passcode.
                                        Be sure to enter an exact match in both text fields.
                                        Thank you! :)
                                        """
        guard let pin = self.pinTextField.text,
                let validationPin = self.pinValidationTextField.text else {
            print("Error: \(error)")
            return false
        }
        let isNotEmpty = !(pin.isEmpty && validationPin.isEmpty)
        let isSame = pin == validationPin
        if isNotEmpty && isSame {
            return true
        } else {
            print("Error: \(error)")
            return false
        }
    }
    @objc func didTapSetMasterPinBtn() {
        print("didTap: \(#function)")
        guard self.isValidPasscode() else {
            //TODO: present error for mismatch pin / validation pin
            return
        }
        //TODO: make API call to firebase to set master pin
        self.addLoadingIndicator()
        callFirebaseToSetMasterPin { hasSuccess in
            print(hasSuccess)
        }
        callFirebaseToSetMasterPin { hasSuccess in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
            }
            guard let _ = hasSuccess else {
                //TODO: Handle error case on failed to send master pin to firebase
                print("failed to set master pin...please handle error case here")
                
                return
            }
            DispatchQueue.main.async {
                //TODO: Push to auto-generate short-term pin screen
                guard let deliveryPinVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DeliveryPinViewController.self)) as? DeliveryPinViewController else {
                    print("ERROR:  error pushing view controller: \(String(describing: DeliveryPinViewController.self))")
                    return
                }
                self.navigationController?.pushViewController(deliveryPinVC, animated: true)
            }
        }
    }
    @objc func didTapScreen(_ sender: UITapGestureRecognizer) {
        print("didTap: \(#function)")
        self.pinTextField.resignFirstResponder()
        self.pinValidationTextField.resignFirstResponder()
    }
    func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(didTapScreen))
        self.view.addGestureRecognizer(tapGesture)
    }
    func setupSetMasterPinBtn() {
//        setMasterPinBtn.layer.borderWidth = setMasterPinBtn.bounds.height / 2
        setMasterPinBtn.addTarget(self, action: #selector(didTapSetMasterPinBtn), for: .touchUpInside)
    }
    func setupPinTextField() {
        self.pinTextField.delegate = self
        self.pinValidationTextField.delegate = self
        self.pinTextField.keyboardType = .numberPad
        self.pinValidationTextField.keyboardType = .numberPad
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MPinViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //check if string can cast to Int
        guard let _ = Int(string) else { return false }
        //If so, generate full text
        let replacementText = (textField.text ?? "") + string
        //check if text length is less than 4
        guard replacementText.count <= 4 else { return false }
        //If so, allow text to printed in field
        print("wholeText: \(replacementText)")
        print("replacement: \(string)")
        return true
    }
}


enum MPIN {
    case masterKeyID
    var description: String {
        switch self {
        case .masterKeyID: return "masterKey"
        }
    }
}
