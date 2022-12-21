//
//  HomeViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInstantiable {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var homeLabel: UILabel!
  @IBOutlet weak var sendDocumentsView: UIView!
  @IBOutlet weak var sendDocumentsIcon: UIImageView!
  @IBOutlet weak var sendDocumentsLabel: UILabel!
  @IBOutlet weak var sendDocumentsButton: UIButton!
  @IBOutlet weak var sendDocumentsButtonIcon: UIImageView!
  @IBOutlet weak var viewDocumentsView: UIView!
  @IBOutlet weak var viewDocumentsIcon: UIImageView!
  @IBOutlet weak var viewDocumentsLabel: UILabel!
  @IBOutlet weak var viewDocumentsButton: UIButton!
  @IBOutlet weak var viewDocumentsButtonIcon: UIImageView!
  @IBOutlet weak var officesView: UIView!
  @IBOutlet weak var officesIcon: UIImageView!
  @IBOutlet weak var officesLabel: UILabel!
  @IBOutlet weak var officesButton: UIButton!
  @IBOutlet weak var officesButtonIcon: UIImageView!
  
  var centerViewController: UINavigationController!
  var coordinator: HomeCoordinator!
  var viewModel: HomeViewModel!
  var delegate: MenuDelegate?
  var menu: MenuView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    
    setupTopBar()
    setupHomeHeader()
    setupSendDocuments()
    setupViewDocuments()
    setupOffices()
    setupMenu()
    setupLanguage()
  }
  
  // MARK: Configure UI
  
  func setupTopBar() {
    nameLabel.font = UIFont(name: "Montserrat-Bold", size: 22)
    nameLabel.text = ProfileManager.shared.userProfile?.name
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark  {
      nameLabel.textColor = .white
      menuButton.tintColor = .white
    } else {
      nameLabel.textColor = UIColor(named: "primaryColor")
      menuButton.tintColor = UIColor(named: "primaryColor")
    }
  }
  
  func setupHomeHeader() {
    welcomeLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
    homeLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
  }
  
  func setupSendDocuments() {
    sendDocumentsView.layer.borderColor = UIColor(named: "pinkColor")?.cgColor
    sendDocumentsView.layer.borderWidth = 1
    sendDocumentsView.layer.cornerRadius = 10
    sendDocumentsLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
    sendDocumentsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    sendDocumentsButton.layer.cornerRadius = 10
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark  {
      sendDocumentsView.backgroundColor = UIColor(named: "pinkColor")?.withAlphaComponent(0.7)
      sendDocumentsIcon.tintColor = .white
      sendDocumentsLabel.textColor = .white
      sendDocumentsButton.tintColor = .white
      sendDocumentsButtonIcon.tintColor = .white
      sendDocumentsButton.backgroundColor = UIColor(named: "pinkColor")
    } else {
      sendDocumentsView.backgroundColor = .white
      sendDocumentsIcon.tintColor = UIColor(named: "pinkColor")
      sendDocumentsLabel.textColor = UIColor(named: "pinkColor")
      sendDocumentsButton.tintColor = UIColor(named: "pinkColor")
      sendDocumentsButtonIcon.tintColor = UIColor(named: "pinkColor")
      sendDocumentsButton.layer.borderColor = UIColor(named: "pinkColor")?.cgColor
      sendDocumentsButton.layer.borderWidth = 1
      sendDocumentsButton.backgroundColor = .white
    }
  }
  
  func setupViewDocuments() {
    viewDocumentsView.layer.borderColor = UIColor(named: "violetColor")?.cgColor
    viewDocumentsView.layer.borderWidth = 1
    viewDocumentsView.layer.cornerRadius = 10
    viewDocumentsLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
    viewDocumentsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    viewDocumentsButton.layer.cornerRadius = 10
    
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark  {
      viewDocumentsView.backgroundColor = UIColor(named: "violetColor")?.withAlphaComponent(0.7)
      viewDocumentsIcon.tintColor = .white
      viewDocumentsLabel.textColor = .white
      viewDocumentsButton.tintColor = .white
      viewDocumentsButtonIcon.tintColor = .white
      viewDocumentsButton.backgroundColor = UIColor(named: "violetColor")
      
    } else {
      viewDocumentsView.backgroundColor = .white
      viewDocumentsIcon.tintColor = UIColor(named: "violetColor")
      viewDocumentsLabel.textColor = UIColor(named: "violetColor")
      viewDocumentsButton.tintColor = UIColor(named: "violetColor")
      viewDocumentsButtonIcon.tintColor = UIColor(named: "violetColor")
      viewDocumentsButton.layer.borderColor = UIColor(named: "violetColor")?.cgColor
      viewDocumentsButton.layer.borderWidth = 1
      viewDocumentsButton.backgroundColor = .white
    }
  }
  
  func setupOffices() {
    officesView.layer.borderColor = UIColor(named: "greenColor")?.cgColor
    officesView.layer.borderWidth = 1
    officesView.layer.cornerRadius = 10
    officesLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
    officesButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
    officesButton.layer.cornerRadius = 10
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark  {
      officesView.backgroundColor = UIColor(named: "greenColor")?.withAlphaComponent(0.7)
      officesIcon.tintColor = .white
      officesLabel.textColor = .white
      officesButton.tintColor = .white
      officesButtonIcon.tintColor = .white
      officesButton.backgroundColor = UIColor(named: "greenColor")
      
    } else {
      officesView.backgroundColor = .white
      officesIcon.tintColor = UIColor(named: "greenColor")
      officesLabel.textColor = UIColor(named: "greenColor")
      officesButton.tintColor = UIColor(named: "greenColor")
      officesButtonIcon.tintColor = UIColor(named: "greenColor")
      officesButton.layer.borderColor = UIColor(named: "greenColor")?.cgColor
      officesButton.layer.borderWidth = 1
      officesButton.backgroundColor = .white
    }
  }
  
  private func setupMenu() {
    menu = MenuView()
    self.view.addSubview(menu)
    menu.delegate = delegate.self
    menu.configureConstraints()
    menu.isHidden = true
  }
  
  private func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      welcomeLabel.text = NSLocalizedString("welcome-label-key", bundle: bundle!, comment: "")
      homeLabel.text = NSLocalizedString("home-label-key", bundle: bundle!, comment: "")
      sendDocumentsLabel.text = NSLocalizedString("send-documents-label-key", bundle: bundle!, comment: "")
      sendDocumentsButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
      viewDocumentsLabel.text = NSLocalizedString("view-documents-label-key", bundle: bundle!, comment: "")
      viewDocumentsButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
      officesLabel.text = NSLocalizedString("offices-label-key", bundle: bundle!, comment: "")
      officesButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      welcomeLabel.text = NSLocalizedString("welcome-label-key", bundle: bundle!, comment: "")
      homeLabel.text = NSLocalizedString("home-label-key", bundle: bundle!, comment: "")
      sendDocumentsLabel.text = NSLocalizedString("send-documents-label-key", bundle: bundle!, comment: "")
      sendDocumentsButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
      viewDocumentsLabel.text = NSLocalizedString("view-documents-label-key", bundle: bundle!, comment: "")
      viewDocumentsButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
      officesLabel.text = NSLocalizedString("offices-label-key", bundle: bundle!, comment: "")
      officesButton.setTitle(NSLocalizedString("go-button-title-key", bundle: bundle!, comment: ""), for: .normal)
    }
  }
  
  @objc func uiModeNotificationRecieved() {
    menu.isHidden = true
    setupTopBar()
    setupHomeHeader()
    setupSendDocuments()
    setupViewDocuments()
    setupOffices()
    menu.setup()
  }
  
  @objc func localizableNotificationRecieved() {
    menu.isHidden = true
    setupTopBar()
    setupLanguage()
    menu.setup()
  }
  
  // MARK: Actions
  
  @IBAction func sendDocumentsButtonAction(_ sender: Any) {
    coordinator.navigateToSendDocuments()
  }
  
  @IBAction func viewDocumentsButtonAction(_ sender: Any) {
    coordinator.navigateToViewDocuments()
  }
  
  @IBAction func officesButtonAction(_ sender: Any) {
    coordinator.navigateToOffices()
  }
  
  @IBAction func menuButtonAction(_ sender: Any) {
    if menu.isHidden == false {
      menu.isHidden = true
      setupTopBar()
    } else {
      menu.isHidden = false
      menuButton.tintColor = UIColor(named: "pinkColor")
    }
  }
}
