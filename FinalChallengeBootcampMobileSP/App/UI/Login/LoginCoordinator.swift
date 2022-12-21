//
//  LoginCoordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//
import UIKit

class LoginCoordinator: Coordinator {
  var presenter: UINavigationController
  
  init(presenter: UINavigationController = UINavigationController()) {
    self.presenter = presenter
  }
  
  func navigate() {
    let loginViewController = LoginViewController.fromStoryboard()
    loginViewController.viewModel = LoginViewModel()
    loginViewController.coordinator = self
    presenter.setViewControllers([loginViewController], animated: false)
    presenter.navigationBar.isHidden = true
  }
  
  func navigateToHome() {
    let containerViewController = HomeContainerViewController()
    containerViewController.modalPresentationStyle = .fullScreen
    containerViewController.modalTransitionStyle = .crossDissolve
    self.presenter.present(containerViewController, animated: true)
  }
}
