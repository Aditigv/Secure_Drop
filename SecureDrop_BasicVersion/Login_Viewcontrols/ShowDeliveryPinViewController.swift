//
//  ShowDeliveryPinViewController.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 10/14/22.
//

import Foundation
import UIKit

class ShowDeliveryPinViewController: UIViewController {
    
    @IBOutlet weak var deliveryPinTextField: UITextField!
    @IBOutlet weak var orderIDTextField: UITextField!
    @IBOutlet weak var orderDetailsTextView: UITextView!
    @IBOutlet weak var vendorDetailsTextField: UITextField!
    @IBOutlet weak var saveOrderBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.isUserInteractionEnabled = false
        self.addLoadingIndicator()
        autoGeneratePin { hasSuccess in
            DispatchQueue.main.async {
                self.deliveryPinTextField.text = self.generateDeliveryPin()
                self.removeLoadingIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    func autoGeneratePin(completion: @escaping (_ hasSuccess: Bool?) -> Void) {
        //fake example api call
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
    }
    func callFirebaseToSaveOrder(completion: @escaping(Bool?) -> Void) {
            //fake example api call
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 2.0) {
                completion(true)
            }
            
        }
    @objc func didTapSaveOrderBtn() {
        self.addLoadingIndicator()
        callFirebaseToSaveOrder { didSaveOrder in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
            }
            guard let _ = didSaveOrder else {
                //TODO: Did not save order, handle error flow.
                return
            }
            //TODO: Did save order, send back to Home Screen
            DispatchQueue.main.async {
                if let deliveryVC = self.navigationController?.viewControllers.first(where: { $0 is DeliveryPinViewController }) {
                                self.navigationController?.popToViewController(deliveryVC, animated: true)
                            } else {
                                print("ERROR: cannot navigation to \(String(describing: DeliveryPinViewController.self))")
                            }
            }
            
        }
    }
    func setupDeliveryPinTextField() {
        deliveryPinTextField.isEnabled = false
        deliveryPinTextField.isUserInteractionEnabled = false
        deliveryPinTextField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        deliveryPinTextField.layer.opacity = 1
        deliveryPinTextField.textAlignment = .center
        deliveryPinTextField.font = UIFont(name: "Courier New", size: 20)
        deliveryPinTextField.text = ""
    }
    func generateDeliveryPin() -> String {
        let result = Array(repeating: "", count: 4)
        return result.map { _ in "\(Int.random(in: 0...9))" }.joined()
    }
    func setupOrderDetailsTextView() {
        // Round the corners.
           orderDetailsTextView.layer.masksToBounds = true

           // Set the size of the roundness.
           orderDetailsTextView.layer.cornerRadius = 10

           // Set the thickness of the border.
        orderDetailsTextView.layer.borderWidth = 0.7

           // Set the border color to black.
        orderDetailsTextView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor

           // Set the font.
           orderDetailsTextView.font = UIFont.systemFont(ofSize: 16.0)

           // Set font color.
           orderDetailsTextView.textColor = UIColor.black

           // Set left justified.
           orderDetailsTextView.textAlignment = NSTextAlignment.center

           // Automatically detect links, dates, etc. and convert them to links.
           orderDetailsTextView.dataDetectorTypes = UIDataDetectorTypes.all

           // Set shadow darkness.
           orderDetailsTextView.layer.shadowOpacity = 0.5

           // Make text uneditable.
           orderDetailsTextView.isEditable = true
    }
    func setupVendorDetailsTextField() {
//        orderIDTextField.numberOfLines = 1
    }
    func setupOrderDescriptionTextField() {
//        orderIDTextField.numberOfLines = 0
    }
    func setupOrderIDTextField() {
//        orderIDTextField.numberOfLines = 1
    }
    func setupSaveOrderBtn() {
        self.saveOrderBtn.addTarget(self, action: #selector(didTapSaveOrderBtn), for: .touchUpInside)
    }
    func setup() {
        setupDeliveryPinTextField()
        setupOrderIDTextField()
        setupVendorDetailsTextField()
        setupOrderDescriptionTextField()
        setupOrderDetailsTextView()
        setupSaveOrderBtn()
    }
}
