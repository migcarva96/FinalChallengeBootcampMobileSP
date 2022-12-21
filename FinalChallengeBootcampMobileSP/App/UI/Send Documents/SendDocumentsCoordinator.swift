//
//  SendDocumentsCoordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit

class SendDocumentsCoordinator: Coordinator {
  var presenter: UINavigationController
  let menuDelegate: MenuDelegate
  
  init(presenter: UINavigationController = UINavigationController(), menuDelegate: MenuDelegate) {
    self.presenter = presenter
    self.menuDelegate = menuDelegate
  }
  
  func navigate() {
    let sendDocumentsViewController = SendDocumentsViewController.fromStoryboard()
    sendDocumentsViewController.viewModel = SendDocumentsViewModel()
    sendDocumentsViewController.coordinator = self
    sendDocumentsViewController.delegate = menuDelegate
    presenter.pushViewController(sendDocumentsViewController, animated: true)
  }
  
  func back() {
    presenter.popToRootViewController(animated: true)
  }
}
