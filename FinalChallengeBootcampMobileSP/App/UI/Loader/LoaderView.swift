//
//  LoaderView.swift
//  Sophos
//
//  Created by Miguel Urrea on 4/12/22.
//

import UIKit

class LoaderView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  var activityIndicator: UIActivityIndicatorView!
  var loadingText: UILabel!
  var contentStackView: UIStackView!
  var backgroundView: UIView!
  
  private func setup() {
    setupLabel()
    setupActivityIndicator()
    setupBackgroundView()
    setupContainer()
    setupLanguage()
  }
  
  func configureConstraints() {
    guard let superView = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.topAnchor, constant: 0),
      leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0),
    ])
  }
  
  private func setupBackgroundView() {
    backgroundView = UIView()
    backgroundView.backgroundColor = UIColor(named: "blackColor")
    backgroundView.alpha = 0.5
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(backgroundView)
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
      backgroundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
      backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    ])
  }
  
  private func setupContainer() {
    contentStackView = UIStackView()
    contentStackView.axis = .vertical
    contentStackView.spacing = 16
    contentStackView.addArrangedSubview(activityIndicator)
    contentStackView.addArrangedSubview(loadingText)
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentStackView)
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
      contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
      contentStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0)
    ])
  }
  
  private func setupLabel(){
    loadingText = UILabel()
    loadingText.font = UIFont(name: "Montserrat-Bold", size: 20)
    loadingText.textColor = .white
    loadingText.textAlignment = .center
    loadingText.numberOfLines = 0
  }
  
  private func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      loadingText.text = NSLocalizedString("loader-message", bundle: bundle!, comment: "")
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      loadingText.text = NSLocalizedString("loader-message", bundle: bundle!, comment: "")
    }
  }
  
  private func setupActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .white
    activityIndicator.startAnimating()
  }
}
