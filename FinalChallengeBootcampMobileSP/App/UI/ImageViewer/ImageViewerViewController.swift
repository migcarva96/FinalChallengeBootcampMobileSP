//
//  ImageViewerViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 18/12/22.
//

import UIKit

class ImageViewerViewController: UIViewController {
  
  var exitButton: UIButton!
  var documentImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setupExitButton()
    setupImage()
  }
  
  func setupExitButton() {
    exitButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.dismiss(animated: true)
    }))
    exitButton.setImage(UIImage(named: "exitIcon"), for: .normal)
    exitButton.tintColor = .white
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(exitButton)
    NSLayoutConstraint.activate([
      exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      exitButton.heightAnchor.constraint(equalToConstant: 20),
      exitButton.widthAnchor.constraint(equalToConstant: 20),
    ])
  }
  
  func setupImage() {
    documentImage = UIImageView()
    documentImage.contentMode = .scaleAspectFit
    documentImage.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(documentImage)
    NSLayoutConstraint.activate([
      documentImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      documentImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      documentImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      documentImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
    ])
  }
}
