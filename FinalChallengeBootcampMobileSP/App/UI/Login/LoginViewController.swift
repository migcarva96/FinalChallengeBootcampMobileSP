//
//  LoginViewController.swift
//  FinalChallengeBootcampMobileSP
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController, StoryboardInstantiable {
  
  @IBOutlet weak var sophosLogoImage: UIImageView!
  @IBOutlet weak var titleLoginLabel: UILabel!
  @IBOutlet weak var emailStackView: UIStackView!
  @IBOutlet weak var emailIconImage: UIImageView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var emailSeparatorView: UIView!
  @IBOutlet weak var passwordStackView: UIStackView!
  @IBOutlet weak var passwordIconImage: UIImageView!
  @IBOutlet weak var passwordSeparatorView: UIView!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var togglePasswordVisibilityButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var fingerprintLoginButton: UIButton!
  @IBOutlet weak var fingerprintIconImage: UIImageView!
  
  var centerViewController: UINavigationController!
  var coordinator: LoginCoordinator!
  var viewModel: LoginViewModel!
  var loader: LoaderView!
  
  var emptyFieldMessage: String = ""
  var wrongPasswordMessage: String = ""
  var wrongEmailMessage: String = ""
  var touchidUnavailableTitle: String = ""
  var touchidUnavailableMessage: String = ""
  var touchidFailedTitle: String = ""
  var touchidFailedMessage: String = ""
  var touchidEmptyTitle: String = ""
  var touchidEmptyMessage: String = ""
  var touchidReasonMessage: String = ""
  
  var isLoading: Bool! {
    didSet {
      loader.isHidden = !isLoading
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLogoImages()
    setupTitleLoginLabel()
    setupEmailTextField()
    setupPasswordTextField()
    setupLoginButton()
    setupFingerprintLoginButton()
    setupLanguage()
    setupLoader()
    
    let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
    self.view.addGestureRecognizer(tap)
  }
  
  // MARK: Configure UI
  func setupLogoImages() {
    sophosLogoImage.tintColor = UIColor(named: "primaryColor")
  }
  
  func setupTitleLoginLabel() {
    titleLoginLabel.textColor = UIColor(named: "primaryColor")
    titleLoginLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
  }
  
  func setupEmailTextField() {
    if AuthenticationManager.shared.email != nil {
      emailTextField.text = AuthenticationManager.shared.email
    }
    emailStackView.layer.borderWidth = 1
    emailStackView.backgroundColor = .white
    emailStackView.layer.cornerRadius = 10
    emailTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark  {
      emailStackView.layer.borderColor = UIColor(named: "backgroundColor")?.cgColor
      emailSeparatorView.backgroundColor = UIColor(named: "backgroundColor")
      emailIconImage.tintColor = UIColor(named: "backgroundColor")
      emailTextField.textColor = UIColor(named: "backgroundColor")
    } else {
      emailStackView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
      emailIconImage.tintColor = UIColor(named: "primaryColor")
      emailTextField.textColor = UIColor(named: "primaryColor")
    }
  }
  
  func setupPasswordTextField() {
    passwordStackView.layer.borderWidth = 1
    passwordStackView.backgroundColor = .white
    passwordStackView.layer.cornerRadius = 10
    passwordTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    
    if traitCollection.userInterfaceStyle == .dark {
      passwordStackView.layer.borderColor = UIColor(named: "backgroundColor")?.cgColor
      passwordSeparatorView.backgroundColor = UIColor(named: "backgroundColor")
      passwordIconImage.tintColor = UIColor(named: "backgroundColor")
      passwordTextField.textColor = UIColor(named: "backgroundColor")
      togglePasswordVisibilityButton.tintColor = UIColor(named: "backgroundColor")
    } else {
      passwordIconImage.tintColor = UIColor(named: "primaryColor")
      passwordTextField.textColor = UIColor(named: "primaryColor")
      passwordStackView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
      togglePasswordVisibilityButton.tintColor = UIColor(named: "primaryColor")
    }
  }
  
  func setupLoginButton() {
    loginButton.backgroundColor = UIColor(named: "primaryColor")
    loginButton.layer.cornerRadius = 10
    loginButton.tintColor = UIColor(named: "backgroundColor")
    loginButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
  }
  
  func setupFingerprintLoginButton() {
    fingerprintLoginButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
    fingerprintLoginButton.layer.borderWidth = 1
    fingerprintLoginButton.layer.cornerRadius = 10
    fingerprintLoginButton.tintColor = UIColor(named: "primaryColor")
    fingerprintLoginButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
    fingerprintIconImage.tintColor = UIColor(named: "primaryColor")
    if AuthenticationManager.shared.biometricType == "FaceID" {
      fingerprintIconImage.image = UIImage(systemName: "faceid")
    } else {
      fingerprintIconImage.image = UIImage(named: "fingerprintIcon")
    }
  }
  
  private func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLoginLabel.text = NSLocalizedString("title-login-label-key", bundle: bundle!, comment: "")
      emailTextField.placeholder = NSLocalizedString("email-text-key", bundle: bundle!, comment: "")
      passwordTextField.placeholder = NSLocalizedString("password-text-key", bundle: bundle!, comment: "")
      loginButton.setTitle(NSLocalizedString("login-button-key", bundle: bundle!, comment: ""), for: .normal)
      fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyFieldMessage = NSLocalizedString("empty-fields-message",bundle: bundle!, comment: "")
      wrongPasswordMessage = NSLocalizedString("wrong-password-message",bundle: bundle!, comment: "")
      wrongEmailMessage = NSLocalizedString("wrong-email-message",bundle: bundle!, comment: "")
      touchidUnavailableTitle = NSLocalizedString("touchid-unavailable-title",bundle: bundle!, comment: "")
      touchidUnavailableMessage = NSLocalizedString("touchid-unavailable-message",bundle: bundle!, comment: "")
      touchidFailedTitle = NSLocalizedString("touchid-failed-title",bundle: bundle!, comment: "")
      touchidFailedMessage = NSLocalizedString("touchid-failed-message",bundle: bundle!, comment: "")
      touchidEmptyTitle = NSLocalizedString("touchid-empty-title",bundle: bundle!, comment: "")
      touchidEmptyMessage = NSLocalizedString("touchid-empty-message",bundle: bundle!, comment: "")
      touchidReasonMessage = NSLocalizedString("touchid-reason-message",bundle: bundle!, comment: "")
      if AuthenticationManager.shared.biometricType == "FaceID" {
        fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-faceid-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      } else {
        fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      }
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLoginLabel.text = NSLocalizedString("title-login-label-key", bundle: bundle!, comment: "")
      emailTextField.placeholder = NSLocalizedString("email-text-key", bundle: bundle!, comment: "")
      passwordTextField.placeholder = NSLocalizedString("password-text-key", bundle: bundle!, comment: "")
      loginButton.setTitle(NSLocalizedString("login-button-key", bundle: bundle!, comment: ""), for: .normal)
      fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyFieldMessage = NSLocalizedString("empty-fields-message",bundle: bundle!, comment: "")
      wrongPasswordMessage = NSLocalizedString("wrong-password-message",bundle: bundle!, comment: "")
      wrongEmailMessage = NSLocalizedString("wrong-email-message",bundle: bundle!, comment: "")
      touchidUnavailableTitle = NSLocalizedString("touchid-unavailable-title",bundle: bundle!, comment: "")
      touchidUnavailableMessage = NSLocalizedString("touchid-unavailable-message",bundle: bundle!, comment: "")
      touchidFailedTitle = NSLocalizedString("touchid-failed-title",bundle: bundle!, comment: "")
      touchidFailedMessage = NSLocalizedString("touchid-failed-message",bundle: bundle!, comment: "")
      touchidEmptyTitle = NSLocalizedString("touchid-empty-title",bundle: bundle!, comment: "")
      touchidEmptyMessage = NSLocalizedString("touchid-empty-message",bundle: bundle!, comment: "")
      touchidReasonMessage = NSLocalizedString("touchid-reason-message",bundle: bundle!, comment: "")
      if AuthenticationManager.shared.biometricType == "FaceID" {
        fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-faceid-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      } else {
        fingerprintLoginButton.setTitle(NSLocalizedString("fingerprint-login-button-key", bundle: bundle!, comment: ""), for: .normal)
      }
    }
  }
  
  // MARK: Actions
  @IBAction func loginButtonAction(_ sender: Any) {
    self.view.endEditing(true)
    guard let email = emailTextField.text, let password = passwordTextField.text else {
      return
    }
    
    guard !email.isEmpty, !password.isEmpty else {
      self.alert(title: nil, message: emptyFieldMessage)
      return
    }
    
    guard isValidEmail(email) else {
      self.alert(title: nil, message: wrongEmailMessage)
      return
    }
    
    isLoading = true
    
    viewModel.login(email: email, password: password) { succeeded in
      guard succeeded else {
        self.isLoading = false
        self.alert(title: nil, message: self.wrongPasswordMessage)
        return
      }
      self.isLoading = false
      self.passwordTextField.text = ""
      self.coordinator.navigateToHome()
    }
  }
  
  @IBAction func fingerprintLoginButtonAction(_ sender: Any) {
    let context = LAContext()
    var error: NSError? = nil
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: touchidReasonMessage) { [weak self] success, error in
        DispatchQueue.main.async {
          guard success, error == nil else {
            self?.alert(title: self?.touchidFailedTitle, message: self!.touchidFailedMessage)
            return
          }
          self?.isLoading = true
          self?.viewModel.biometricLogin { succeeded in
            guard succeeded else {
              self?.isLoading = false
              self?.alert(title: self?.touchidEmptyTitle, message: self!.touchidEmptyMessage)
              return
            }
            self?.isLoading = false
            self?.coordinator.navigateToHome()
          }
        }
      }
    } else {
      self.alert(title: touchidUnavailableTitle, message: touchidUnavailableMessage)
    }
  }
  
  @IBAction func togglePasswordVisibilityButtonAction(_ sender: Any) {
    if passwordTextField.isSecureTextEntry == true {
      passwordTextField.isSecureTextEntry = false
    } else {
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  @objc func dissmissKeyboard() {
    self.view.endEditing(true)
  }
  
  func alert(title:String?, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }
  
  private func setupLoader() {
    loader = LoaderView()
    self.view.addSubview(loader)
    loader.configureConstraints()
    loader.isHidden = true
  }
  
  func isValidEmail(_ email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
  }
}
