//
//  HomeContainerViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

protocol MenuDelegate {
  func menu(with option: MenuOption?)
}

class HomeContainerViewController: UIViewController {
  
  var statusBarContent: UIStatusBarStyle = .default
  
  var centerViewController: UINavigationController!
  var homeCoordinator: HomeCoordinator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureHomeController()
    userSetup()
  }
  
  func configureHomeController() {
    homeCoordinator = HomeCoordinator(menuDelegate: self)
    homeCoordinator.navigate()
    centerViewController = homeCoordinator.presenter
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
  
  func changeUIMode() {
    if ProfileManager.shared.uiMode == "darkMode" {
      statusBarContent = .darkContent
      overrideUserInterfaceStyle = .light
      ProfileManager.shared.uiMode = "lightMode"
    } else {
      statusBarContent = .lightContent
      overrideUserInterfaceStyle = .dark
      ProfileManager.shared.uiMode = "darkMode"
    }
    setNeedsStatusBarAppearanceUpdate()
    NotificationCenter.default.post(name: NSNotification.Name.ChangeUIMode, object: nil)
  }
  
  func changeLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      ProfileManager.shared.localizableLanguage = "es"
    } else {
      ProfileManager.shared.localizableLanguage = "en"
    }
    NotificationCenter.default.post(name: NSNotification.Name.ChangeLocalizable, object: nil)
  }
}

extension HomeContainerViewController: MenuDelegate {
  func menu(with option: MenuOption?) {
    switch option {
    case .sendDocuments:
      homeCoordinator.navigate()
      homeCoordinator.navigateToSendDocuments()
    case .viewDocuments:
      homeCoordinator.navigate()
      homeCoordinator.navigateToViewDocuments()
    case .offices:
      homeCoordinator.navigate()
      homeCoordinator.navigateToOffices()
    case .uiMode:
      changeUIMode()
    case .localizable:
      changeLanguage()
    case .logout:
      dismiss(animated: true)
    default:
      break
    }
  }
}
