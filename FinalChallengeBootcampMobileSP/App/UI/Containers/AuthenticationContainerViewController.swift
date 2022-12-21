//
//  AuthenticationContainerViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

class AuthenticationContainerViewController: UIViewController {
  
  var statusBarContent: UIStatusBarStyle = .default
  var centerViewController: UINavigationController!
  var loginCoordinator: LoginCoordinator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLoginController()
    userSetup()
  }
  
  func configureLoginController() {
    loginCoordinator = LoginCoordinator()
    loginCoordinator.navigate()
    centerViewController = loginCoordinator.presenter
    view.addSubview(centerViewController.view)
    addChild(centerViewController)
  }
  
  func userSetup() {
    if ProfileManager.shared.localizableLanguage == nil {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      let localizableLanguages: String = NSLocalizedString("localizable-Languages", bundle: bundle!, comment: "")
      if NSLocalizedString("localizable-Languages", comment: "") == localizableLanguages{
        ProfileManager.shared.localizableLanguage = "en"
      } else {
        ProfileManager.shared.localizableLanguage = "es"
      }
    }
    if ProfileManager.shared.uiMode == nil {
      if traitCollection.userInterfaceStyle == .dark {
        ProfileManager.shared.uiMode = "darkMode"
      } else {
        ProfileManager.shared.uiMode = "lightMode"
      }
    } else {
      if ProfileManager.shared.uiMode == "darkMode" {
        statusBarContent = .lightContent
        overrideUserInterfaceStyle = .dark
      } else {
        statusBarContent = .darkContent
        overrideUserInterfaceStyle = .light
      }
    }
  }
  
}
