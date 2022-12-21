//
//  LoginViewModel.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import Foundation

class LoginViewModel {
  let client: Client
  
  init(client: Client = NetworkClient()) {
    self.client = client
  }
  
  func login(email: String, password: String, completion: @escaping (_ succeeded: Bool) -> ()) {
    
    client.fetch(api: AuthenticationAPI.authentication(email: email, password: password)) { (result: Result<AuthenticationResponse, Error>) in
      switch result {
      case .success(let response):
        guard response.access else {
          completion(false)
          return
        }
        ProfileManager.shared.userProfile = response
        AuthenticationManager.shared.email = email
        guard let passwordData = password.data(using: .utf8) else {
          completion(true)
          return
        }
        do {
          try KeychainInterface.save(password: passwordData, account: email)
        } catch let error {
          print(error.localizedDescription)
        }
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
  
  func biometricLogin(completion: @escaping (_ succeeded: Bool) -> ()) {
    guard let email = AuthenticationManager.shared.email else {
      completion(false)
      return
    }
    var API: AuthenticationAPI = AuthenticationAPI.authentication(email: "", password: "")
    do {
      guard let passwordData = try KeychainInterface.read(account: email) else {
        throw KeychainInterface.KeychainError.invalidItemFormat
      }
      guard let password = String(data: passwordData, encoding: .utf8) else { return }
      API = AuthenticationAPI.authentication(email: email, password: password)
    } catch let error {
      print(error.localizedDescription)
      API = AuthenticationAPI.authentication(email: "", password: "")
    }
    
    client.fetch(api: API) { (result: Result<AuthenticationResponse, Error>) in
      switch result {
      case .success(let response):
        guard response.access else {
          completion(false)
          return
        }
        ProfileManager.shared.userProfile = response
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
}
