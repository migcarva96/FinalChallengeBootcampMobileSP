//
//  AuthenticationManager.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

class AuthenticationManager {
  static var kEmailKey = "email"
  static let shared: AuthenticationManager = AuthenticationManager()
  
  var biometricType: String?
  
  var email: String? {
    set {
      saveEmail(newValue)
    }
    get {
      getEmail()
    }
  }
  
  private func saveEmail(_ email: String?) {
    UserDefaults.standard.set(email, forKey: AuthenticationManager.kEmailKey)
    UserDefaults.standard.synchronize()
  }
  
  private func getEmail() -> String? {
    guard let email = UserDefaults.standard.value(forKey: AuthenticationManager.kEmailKey) as? String else { return nil }
    return email
  }
}
