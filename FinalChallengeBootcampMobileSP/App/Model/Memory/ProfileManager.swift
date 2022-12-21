//
//  ProfileManager.swift
//  Sophos
//
//  Created by Miguel Urrea on 8/12/22.
//

import Foundation

class ProfileManager {
  static var kUserKey = "user_profile"
  static var kLanguageKey = "language"
  static var kUIModeKey = "ui_mode"
  static let shared: ProfileManager = ProfileManager()
  
  var image: String?
  
  var localizableLanguage: String? {
    set {
      saveLanguage(newValue)
    }
    get {
      getLanguage()
    }
  }

  var uiMode: String? {
    set {
      saveUIMode(newValue)
    }
    get {
      getUIMode()
    }
  }
  
  var userProfile: AuthenticationResponse? {
    set {
      saveToDefaults(newValue)
    }
    get {
      getFromDefaults()
    }
  }
  
  private func saveToDefaults(_ user: AuthenticationResponse?) {
    let user = try? JSONEncoder().encode(user)
    UserDefaults.standard.set(user, forKey: ProfileManager.kUserKey)
    UserDefaults.standard.synchronize()
  }

  private func getFromDefaults() -> AuthenticationResponse? {
    guard let data = UserDefaults.standard.value(forKey: ProfileManager.kUserKey) as? Data else { return nil }
    let user = try? JSONDecoder().decode(AuthenticationResponse.self, from: data)
    return user
  }
  
  private func saveLanguage(_ localizableLanguages: String?) {
    UserDefaults.standard.set(localizableLanguages, forKey: ProfileManager.kLanguageKey)
    UserDefaults.standard.synchronize()
  }
  
  private func getLanguage() -> String? {
    guard let localizableLanguage = UserDefaults.standard.value(forKey: ProfileManager.kLanguageKey) as? String else { return nil }
    return localizableLanguage
  }
  
  private func saveUIMode(_ uiMode: String?) {
    UserDefaults.standard.set(uiMode, forKey: ProfileManager.kUIModeKey)
    UserDefaults.standard.synchronize()
  }
  
  private func getUIMode() -> String? {
    guard let uiMode = UserDefaults.standard.value(forKey: ProfileManager.kUIModeKey) as? String else { return nil }
    return uiMode
  }
}
