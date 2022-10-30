//
//  Extensions.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 10/14/22.
//

import Foundation
import UIKit
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: padding.right).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        if size != .zero {
            if size.height != .zero {
                self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            }
            if size.width != .zero {
                self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            }
        }
        
    }
}


extension UIViewController {
    func addLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = .black
        loadingIndicator.frame = self.view.bounds
        self.view.addSubview(loadingIndicator)
        loadingIndicator.anchor(top: self.view.topAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor)
        loadingIndicator.isHidden = false
    }
    func removeLoadingIndicator() {
        let activityIndicatorView = self.view.subviews.first { $0 is UIActivityIndicatorView }
        activityIndicatorView?.isHidden = true
        activityIndicatorView?.removeFromSuperview()
    }
}
