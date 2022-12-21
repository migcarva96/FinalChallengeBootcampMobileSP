//
//  MenuView.swift
//  Sophos
//
//  Created by Miguel Urrea on 4/12/22.
//

import UIKit

enum MenuOption {
  case sendDocuments
  case viewDocuments
  case offices
  case uiMode
  case localizable
  case logout
}

class MenuView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    setup()
  }
  
  var contentStackView: UIStackView!
  var sendDocumentsButton: UIButton!
  var viewDocumentsButton: UIButton!
  var officesButton: UIButton!
  var uiModeButton: UIButton!
  var localizableButton: UIButton!
  var logoutButton: UIButton!
  
  var delegate: MenuDelegate?
  
  func setup() {
    setupSendDocumentsItem()
    setupViewDocumentsItem()
    setupOfficesItem()
    setupUIModeItem()
    setupLocalizableItem()
    setupLogOutItem()
    setupContainer()
    setupLanguage()
  }
  
  func configureConstraints() {
    guard let superView = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: 50),
      trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      widthAnchor.constraint(equalToConstant: 180),
      heightAnchor.constraint(equalToConstant: 210),
    ])
  }
  
  func setupContainer() {
    contentStackView  = UIStackView()
    contentStackView.axis = .vertical
    contentStackView.distribution = .fillEqually
    contentStackView.addArrangedSubview(sendDocumentsButton)
    contentStackView.addArrangedSubview(viewDocumentsButton)
    contentStackView.addArrangedSubview(officesButton)
    contentStackView.addArrangedSubview(uiModeButton)
    contentStackView.addArrangedSubview(localizableButton)
    contentStackView.addArrangedSubview(logoutButton)
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentStackView)
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
      contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
      contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
      contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    ])
  }
  
  func setupSendDocumentsItem() {
    sendDocumentsButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .sendDocuments)
    }))
    sendDocumentsButton.layer.borderColor = UIColor(named: "pinkColor")?.cgColor
    sendDocumentsButton.layer.borderWidth = 1
    sendDocumentsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark{
      sendDocumentsButton.backgroundColor = UIColor(named: "pinkColor")
      sendDocumentsButton.backgroundColor?.withAlphaComponent(0.7)
      sendDocumentsButton.setTitleColor(.white, for: .normal )
    } else {
      sendDocumentsButton.backgroundColor = .white
      sendDocumentsButton.backgroundColor?.withAlphaComponent(1)
      sendDocumentsButton.setTitleColor(UIColor(named: "pinkColor"), for: .normal )
    }
  }
  
  func setupViewDocumentsItem() {
    viewDocumentsButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .viewDocuments)
    }))
    viewDocumentsButton.layer.borderColor = UIColor(named: "violetColor")?.cgColor
    viewDocumentsButton.layer.borderWidth = 1
    viewDocumentsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark{
      viewDocumentsButton.backgroundColor = UIColor(named: "violetColor")
      viewDocumentsButton.backgroundColor?.withAlphaComponent(0.7)
      viewDocumentsButton.setTitleColor(.white, for: .normal )
    } else {
      viewDocumentsButton.backgroundColor = .white
      viewDocumentsButton.backgroundColor?.withAlphaComponent(1)
      viewDocumentsButton.setTitleColor(UIColor(named: "violetColor"), for: .normal )
    }
  }
  
  func setupOfficesItem() {
    officesButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .offices)
    }))
    officesButton.layer.borderColor = UIColor(named: "greenColor")?.cgColor
    officesButton.layer.borderWidth = 1
    officesButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark{
      officesButton.backgroundColor = UIColor(named: "greenColor")
      officesButton.backgroundColor?.withAlphaComponent(0.7)
      officesButton.setTitleColor(.white, for: .normal )
    } else {
      officesButton.backgroundColor = .white
      officesButton.backgroundColor?.withAlphaComponent(1)
      officesButton.setTitleColor(UIColor(named: "greenColor"), for: .normal )
    }
  }
  
  func setupUIModeItem() {
    uiModeButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .uiMode)
    }))
    uiModeButton.layer.borderColor = UIColor(named: "darkVioletColor")?.cgColor
    uiModeButton.layer.borderWidth = 1
    uiModeButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark{
      uiModeButton.backgroundColor = UIColor(named: "darkVioletColor")
      uiModeButton.backgroundColor?.withAlphaComponent(0.7)
      uiModeButton.setTitleColor(.white, for: .normal )
    } else {
      uiModeButton.backgroundColor = .white
      uiModeButton.backgroundColor?.withAlphaComponent(1)
      uiModeButton.setTitleColor(UIColor(named: "darkVioletColor"), for: .normal )
    }
  }
  
  func setupLocalizableItem() {
    localizableButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .localizable)
    }))
    localizableButton.layer.borderColor = UIColor(named: "blueColor")?.cgColor
    localizableButton.layer.borderWidth = 1
    localizableButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark {
      localizableButton.backgroundColor = UIColor(named: "blueColor")
      localizableButton.backgroundColor?.withAlphaComponent(0.7)
      localizableButton.setTitleColor(.white, for: .normal )
    } else {
      localizableButton.backgroundColor = .white
      localizableButton.backgroundColor?.withAlphaComponent(1)
      localizableButton.setTitleColor(UIColor(named: "blueColor"), for: .normal )
    }
  }
  
  func setupLogOutItem() {
    logoutButton = UIButton(primaryAction: UIAction(handler: { _ in
      self.delegate?.menu(with: .logout)
    }))
    logoutButton.layer.borderColor = UIColor(named: "violetColor")?.cgColor
    logoutButton.layer.borderWidth = 1
    logoutButton.layer.cornerRadius = 10
    logoutButton.layer.maskedCorners = .layerMinXMaxYCorner
    logoutButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    
    if traitCollection.userInterfaceStyle == .dark {
      logoutButton.backgroundColor = UIColor(named: "violetColor")
      logoutButton.backgroundColor?.withAlphaComponent(0.7)
      logoutButton.setTitleColor(.white, for: .normal )
    } else {
      logoutButton.backgroundColor = .white
      logoutButton.backgroundColor?.withAlphaComponent(1)
      logoutButton.setTitleColor(UIColor(named: "violetColor"), for: .normal )
    }
  }
  
  func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      sendDocumentsButton.setTitle(NSLocalizedString("send-documents-label-key", bundle: bundle!, comment: ""), for: .normal)
      viewDocumentsButton.setTitle(NSLocalizedString("view-documents-label-key", bundle: bundle!, comment: ""), for: .normal)
      officesButton.setTitle(NSLocalizedString("offices-label-key", bundle: bundle!, comment: ""), for: .normal)
      localizableButton.setTitle(NSLocalizedString("language-button-key", bundle: bundle!, comment: ""), for: .normal)
      logoutButton.setTitle(NSLocalizedString("log-out-button-key", bundle: bundle!, comment: ""), for: .normal)
      if traitCollection.userInterfaceStyle == .dark{
        uiModeButton.setTitle(NSLocalizedString("light-mode-button-key", bundle: bundle!, comment: ""), for: .normal)
      } else {
        uiModeButton.setTitle(NSLocalizedString("dark-mode-button-key", bundle: bundle!, comment: ""), for: .normal)
      }

    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      sendDocumentsButton.setTitle(NSLocalizedString("send-documents-label-key", bundle: bundle!, comment: ""), for: .normal)
      viewDocumentsButton.setTitle(NSLocalizedString("view-documents-label-key", bundle: bundle!, comment: ""), for: .normal)
      officesButton.setTitle(NSLocalizedString("offices-label-key", bundle: bundle!, comment: ""), for: .normal)
      localizableButton.setTitle(NSLocalizedString("language-button-key", bundle: bundle!, comment: ""), for: .normal)
      logoutButton.setTitle(NSLocalizedString("log-out-button-key", bundle: bundle!, comment: ""), for: .normal)
      if traitCollection.userInterfaceStyle == .dark{
        uiModeButton.setTitle(NSLocalizedString("light-mode-button-key", bundle: bundle!, comment: ""), for: .normal)
      } else {
        uiModeButton.setTitle(NSLocalizedString("dark-mode-button-key", bundle: bundle!, comment: ""), for: .normal)
      }
    }
  }
  
  @objc func uiModeNotificationRecieved() {
    setup()
  }
  
  @objc func localizableNotificationRecieved() {
    setup()
  }
}
