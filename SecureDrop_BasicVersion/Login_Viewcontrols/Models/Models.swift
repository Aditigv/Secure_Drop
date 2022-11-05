//
//  Models.swift
//  SecureDrop_BasicVersion
//
//  Created by Suman Chatla on 9/27/22.
//

import Foundation
protocol Failable {
    var errorMsg: String? { get }
}
enum UserPropType {
    
    case fullName(String?)
    case emailAddress(String?)
    case password(String?)
    
    var validate: String? {
        switch self {
        case .fullName(let name): return validate(name)
        case .emailAddress(let emailAddress): return validate(emailAddress)
        case .password(let password): return validate(password)
        }
    }
    private func validate(_ field: String?) -> String? {
        switch self {
            case .fullName:
            return field
            case .emailAddress:
            return Utilities.isEmailValid(field ?? "") ? field : nil
            case .password:
            return Utilities.isPasswordValid(field ?? "") ? field : nil
        }
    }
    
    var validationError: String {
        switch self {
            case .emailAddress(_): return "Please enter a valid email address"
            case .password(_): return "Please enter a valid password"
            case .fullName(_): return "Please enter your full name"
        }
    }
    
    
    
    
}

struct User: Failable, Codable {
    var errorMsg: String?
    
    var fullName: String?
    var emailAddress: String?
    var password: String?
    
    enum CodingKeys: CodingKey {
        case fullName
        case emailAddress
        case password
    }
    
    private func isFullNameValid() -> String? {
        return ""
    }
    private func isEmailAddressValid() -> String? {
        return ""
    }
    private func isPasswordValid() -> String? {
        
        return ""
    }
    init(fullName: UserPropType? = nil, emailAddress: UserPropType?, password: UserPropType?) {
        if let fullName = fullName?.validate {
            self.fullName = fullName
        } else {
            self.errorMsg = fullName?.validationError
        }
        
        if let emailAddress = emailAddress?.validate {
            self.emailAddress = emailAddress
        } else {
            self.errorMsg = emailAddress?.validationError
        }
        if let password = password?.validate {
            self.password = password
        } else {
            self.errorMsg = password?.validationError
        }
    }
}
