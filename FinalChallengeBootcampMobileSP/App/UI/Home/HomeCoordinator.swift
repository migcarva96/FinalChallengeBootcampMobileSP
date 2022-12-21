//
//  HomeCoordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

class HomeCoordinator: Coordinator {
  var presenter: UINavigationController
  let menuDelegate: MenuDelegate
  
  init(presenter: UINavigationController = UINavigationController(), menuDelegate: MenuDelegate) {
    self.presenter = presenter
    self.menuDelegate = menuDelegate
  }
  
  func navigate() {
    let homeViewController = HomeViewController.fromStoryboard()
    homeViewController.viewModel = HomeViewModel()
    homeViewController.coordinator = self
    homeViewController.delegate = menuDelegate
    presenter.setViewControllers([homeViewController], animated: false)
    presenter.navigationBar.isHidden = true
  }
  
  func navigateToSendDocuments() {
    let coordinator = SendDocumentsCoordinator(presenter: presenter, menuDelegate: menuDelegate)
    coordinator.navigate()
  }
  
  func navigateToViewDocuments() {
    let coordinator = ViewDocumentsCoordinator(presenter: presenter, menuDelegate: menuDelegate)
    coordinator.navigate()
  }
  
  func navigateToOffices() {
    let coordinator = OfficesCoordinator(presenter: presenter, menuDelegate: menuDelegate)
    coordinator.navigate()
  }
  
}
