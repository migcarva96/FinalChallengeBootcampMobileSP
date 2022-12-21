//
//  ViewDocumentsCoordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit

class ViewDocumentsCoordinator: Coordinator {
  var presenter: UINavigationController
  let menuDelegate: MenuDelegate
  
  init(presenter: UINavigationController = UINavigationController(), menuDelegate: MenuDelegate) {
    self.presenter = presenter
    self.menuDelegate = menuDelegate
  }
  
  func navigate() {
    let viewDocumentsViewController = ViewDocumentsViewController.fromStoryboard()
    viewDocumentsViewController.viewModel = ViewDocumentsViewModel()
    viewDocumentsViewController.coordinator = self
    viewDocumentsViewController.delegate = menuDelegate
    presenter.pushViewController(viewDocumentsViewController, animated: true)
  }
  
  func back() {
    presenter.popToRootViewController(animated: true)
  }
  
  func imageViewer(image: UIImage?) {
    let imageViewController = ImageViewerViewController()
    imageViewController.dismiss(animated: true)
    imageViewController.modalTransitionStyle = .coverVertical
    self.presenter.present(imageViewController, animated: true)
    imageViewController.documentImage.image = image
  }
}
