//
//  OfficesCoordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit

class OfficesCoordinator: Coordinator {
  var presenter: UINavigationController
  let menuDelegate: MenuDelegate
  
  init(presenter: UINavigationController = UINavigationController(), menuDelegate: MenuDelegate) {
    self.presenter = presenter
    self.menuDelegate = menuDelegate
  }
  
  func navigate() {
    let officesViewController = OfficesViewController.fromStoryboard()
    officesViewController.viewModel = OfficesViewModel()
    officesViewController.coordinator = self
    officesViewController.delegate = menuDelegate
    presenter.pushViewController(officesViewController, animated: true)
  }
  
  func back() {
    presenter.popToRootViewController(animated: true)
  }
}

