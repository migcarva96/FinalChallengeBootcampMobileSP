//
//  SendDocumentsViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit
import UniformTypeIdentifiers
import PhotosUI

class SendDocumentsViewController: UIViewController, StoryboardInstantiable, UIDocumentPickerDelegate, PHPickerViewControllerDelegate {
  
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var openCameraButton: UIButton!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var idTypeTextField: UITextField!
  @IBOutlet weak var idImage: UIImageView!
  @IBOutlet weak var idNumberTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var lastnameTextField: UITextField!
  @IBOutlet weak var documentTitleTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var uploadDocumentButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var idTypeDropDownButton: UIButton!
  @IBOutlet weak var cityDropDownButton: UIButton!
  
  var centerViewController: UINavigationController!
  var coordinator: SendDocumentsCoordinator!
  var viewModel: SendDocumentsViewModel!
  var delegate: MenuDelegate?
  var menu: MenuView!
  
  var dropDown: UIStackView!
  var optionButton: UIButton!
  var idTypeDropDown: UIStackView!
  var cityDropDown: UIStackView!
  var loader: LoaderView!
  var imageBase64: String?
  var emptyFieldMessage: String = ""
  var emptyImageMessage: String = ""
  var openCameraTitle: String = ""
  var openCameraMessage: String = ""
  var loadPhotoMessage: String = ""
  var takePhoto: String = ""
  var cancelTitle: String = ""
  var sendDocumentMessage: String = ""
  private var cameraImage: UIImagePickerController?
  private var imagePicker: PHPickerViewController?
  private var documentPicker: UIDocumentPickerViewController?
  
  var isLoading: Bool! {
    didSet {
      loader.isHidden = !isLoading
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.cities { succeeded in
      self.setupCityDropDown()
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    
    setupTopBar()
    setupForm()
    setupPhotoButton()
    setupUploadDocumentButton()
    setupSendButton()
    setupMenu()
    setupLanguage()
    setupLoader()
    
    let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
    self.view.addGestureRecognizer(tap)
  }
  
  // MARK: Configure UI
  func setupTopBar() {
    titleLabel.font = UIFont(name: "Montserrat-Bold", size: 22)
    backButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
    
    if traitCollection.userInterfaceStyle == .dark || overrideUserInterfaceStyle == .dark {
      titleLabel.textColor = .white
      menuButton.tintColor = .white
      backButton.tintColor = .white
      backButton.setImage(UIImage(named: "arrowLeftIconDark"), for: .normal)
    } else {
      titleLabel.textColor = UIColor(named: "secondaryColor")
      menuButton.tintColor = UIColor(named: "primaryColor")
      backButton.tintColor = UIColor(named: "primaryColor")
      backButton.setImage(UIImage(named: "arrowLeftIconLight"), for: .normal)
    }
  }
  
  func setupForm() {
    setupIdTypeDropDown()
    setupCityDropDown()
    idImage.tintColor = UIColor(named: "secondaryColor")
    
    idTypeTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    idTypeTextField.textColor = UIColor(named: "secondaryColor")
    
    idNumberTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    idNumberTextField.textColor = UIColor(named: "secondaryColor")
    
    nameTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    nameTextField.textColor = UIColor(named: "secondaryColor")
    
    lastnameTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    lastnameTextField.textColor = UIColor(named: "secondaryColor")
    
    documentTitleTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    documentTitleTextField.textColor = UIColor(named: "secondaryColor")
    
    cityTextField.font = UIFont(name: "Montserrat-Medium", size: 14)
    cityTextField.textColor = UIColor(named: "secondaryColor")
  }
  
  func setupPhotoButton() {
    photoImageView.contentMode = .center
    photoImageView.image = UIImage(named: "camera")
    photoImageView.tintColor = UIColor(named: "tertiaryColor")
  }
  
  func setupUploadDocumentButton() {
    uploadDocumentButton.backgroundColor = UIColor(named: "pinkColor")
    uploadDocumentButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 14)
    uploadDocumentButton.layer.cornerRadius = 10
    uploadDocumentButton.tintColor = .white
  }
  
  func setupSendButton() {
    sendButton.backgroundColor = UIColor(named: "pinkColor")
    sendButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 14)
    sendButton.layer.cornerRadius = 10
    sendButton.tintColor = .white
  }
  
  func setupIdTypeDropDown() {
    idTypeDropDownButton.tintColor = UIColor(named: "secondaryColor")
    let options: Array<String> = ["CC", "TI", "PA", "CE"]
    idTypeDropDown = UIStackView()
    idTypeDropDown.axis = .vertical
    idTypeDropDown.distribution = .fillEqually
    idTypeDropDown.spacing = -1
    idTypeDropDown.backgroundColor = UIColor(named: "backgroundColor")
    options.forEach { option in
      optionButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.idTypeTextField.text = option
        self.idTypeDropDown.isHidden = true
      }))
      idTypeDropDown.addArrangedSubview(optionButton)
      optionButton.tintColor = UIColor(named: "secondaryColor")
      optionButton.setTitle(option, for: .normal)
      optionButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
      optionButton.layer.borderWidth = 1
      if traitCollection.userInterfaceStyle == .dark {
        optionButton.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
      } else {
        optionButton.layer.borderColor = UIColor(named: "blackColor")?.cgColor
      }
      if option == options[options.count - 1]{
        optionButton.layer.cornerRadius = 10
        optionButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
      }
    }
    idTypeDropDown.isHidden = true
    idTypeDropDown.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(idTypeDropDown)
    NSLayoutConstraint.activate([
      idTypeDropDown.leadingAnchor.constraint(equalTo: idTypeTextField.leadingAnchor, constant: 0),
      idTypeDropDown.trailingAnchor.constraint(equalTo: idTypeDropDownButton.trailingAnchor, constant: 0),
      idTypeDropDown.topAnchor.constraint(equalTo: idTypeTextField.bottomAnchor, constant: 0),
      idTypeDropDown.heightAnchor.constraint(equalToConstant: CGFloat(30 * options.count))
    ])
  }
  
  func setupCityDropDown() {
    let options = self.viewModel.cities.sorted()
    cityDropDownButton.tintColor = UIColor(named: "secondaryColor")
    cityDropDown = UIStackView()
    cityDropDown.axis = .vertical
    cityDropDown.distribution = .fillEqually
    cityDropDown.spacing = -1
    cityDropDown.backgroundColor = UIColor(named: "backgroundColor")
    options.forEach { option in
      optionButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.cityTextField.text = option
        self.cityDropDown.isHidden = true
      }))
      cityDropDown.addArrangedSubview(optionButton)
      optionButton.tintColor = UIColor(named: "secondaryColor")
      optionButton.setTitle(option, for: .normal)
      optionButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
      optionButton.layer.borderWidth = 1
      if traitCollection.userInterfaceStyle == .dark {
        optionButton.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
      } else {
        optionButton.layer.borderColor = UIColor(named: "blackColor")?.cgColor
      }
      if option == options[options.count - 1]{
        optionButton.layer.cornerRadius = 10
        optionButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
      }
    }
    cityDropDown.isHidden = true
    cityDropDown.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(cityDropDown)
    NSLayoutConstraint.activate([
      cityDropDown.leadingAnchor.constraint(equalTo: cityTextField.leadingAnchor, constant: 0),
      cityDropDown.trailingAnchor.constraint(equalTo: cityDropDownButton.trailingAnchor, constant: 0),
      cityDropDown.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 0),
      cityDropDown.heightAnchor.constraint(equalToConstant: CGFloat(30 * options.count))
    ])
  }
  
  func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLabel.text = NSLocalizedString("send-documents-title-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
      idTypeTextField.placeholder = NSLocalizedString("id-type-text-key", bundle: bundle!, comment: "")
      idNumberTextField.placeholder = NSLocalizedString("id-number-text-key", bundle: bundle!, comment: "")
      nameTextField.placeholder = NSLocalizedString("names-text-key", bundle: bundle!, comment: "")
      lastnameTextField.placeholder = NSLocalizedString("lastnames-text-key", bundle: bundle!, comment: "")
      documentTitleTextField.placeholder = NSLocalizedString("document-title-key", bundle: bundle!, comment: "")
      cityTextField.placeholder = NSLocalizedString("city-text-key", bundle: bundle!, comment: "")
      uploadDocumentButton.setTitle("   " + NSLocalizedString("document-button-key", bundle: bundle!, comment: ""), for: .normal)
      sendButton.setTitle("   " + NSLocalizedString("send-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyFieldMessage = NSLocalizedString("empty-fields-message", bundle: bundle!, comment: "")
      emptyImageMessage = NSLocalizedString("empty-image-message", bundle: bundle!, comment: "")
      openCameraTitle = NSLocalizedString("open-camera-title", bundle: bundle!, comment: "")
      openCameraMessage = NSLocalizedString("open-camera-message", bundle: bundle!, comment: "")
      loadPhotoMessage = NSLocalizedString("load-photo-message", bundle: bundle!, comment: "")
      takePhoto = NSLocalizedString("take-photo", bundle: bundle!, comment: "")
      cancelTitle = NSLocalizedString("cancel-title", bundle: bundle!, comment: "")
      sendDocumentMessage = NSLocalizedString("send-document-message", bundle: bundle!, comment: "")
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLabel.text = NSLocalizedString("send-documents-title-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
      idTypeTextField.placeholder = NSLocalizedString("id-type-text-key", bundle: bundle!, comment: "")
      idNumberTextField.placeholder = NSLocalizedString("id-number-text-key", bundle: bundle!, comment: "")
      nameTextField.placeholder = NSLocalizedString("names-text-key", bundle: bundle!, comment: "")
      lastnameTextField.placeholder = NSLocalizedString("lastnames-text-key", bundle: bundle!, comment: "")
      documentTitleTextField.placeholder = NSLocalizedString("document-title-key", bundle: bundle!, comment: "")
      cityTextField.placeholder = NSLocalizedString("city-text-key", bundle: bundle!, comment: "")
      uploadDocumentButton.setTitle("   " + NSLocalizedString("document-button-key", bundle: bundle!, comment: ""), for: .normal)
      sendButton.setTitle("   " + NSLocalizedString("send-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyFieldMessage = NSLocalizedString("empty-fields-message", bundle: bundle!, comment: "")
      emptyImageMessage = NSLocalizedString("empty-image-message", bundle: bundle!, comment: "")
      openCameraTitle = NSLocalizedString("open-camera-title", bundle: bundle!, comment: "")
      openCameraMessage = NSLocalizedString("open-camera-message", bundle: bundle!, comment: "")
      loadPhotoMessage = NSLocalizedString("load-photo-message", bundle: bundle!, comment: "")
      takePhoto = NSLocalizedString("take-photo", bundle: bundle!, comment: "")
      cancelTitle = NSLocalizedString("cancel-title", bundle: bundle!, comment: "")
      sendDocumentMessage = NSLocalizedString("send-document-message", bundle: bundle!, comment: "")
    }
  }
  
  private func setupMenu() {
    menu = MenuView()
    self.view.addSubview(menu)
    menu.delegate = delegate.self
    menu.configureConstraints()
    menu.isHidden = true
  }
  
  // MARK: Functions
  
  private func openCamera() {
    cameraImage = UIImagePickerController()
    cameraImage?.sourceType = .camera
    cameraImage?.cameraFlashMode = .off
    cameraImage?.cameraCaptureMode = .photo
    cameraImage?.allowsEditing = true
    cameraImage?.delegate = self
    
    guard let cameraImage = cameraImage else {
      return
    }
    present(cameraImage, animated: true)
  }
  
  private func openImagePicker() {
    var configuration: PHPickerConfiguration = PHPickerConfiguration()
    configuration.filter = PHPickerFilter.images
    configuration.selectionLimit = 1
    imagePicker = PHPickerViewController(configuration: configuration)
    imagePicker?.delegate = self
    guard let imagePicker = imagePicker else {
      return
    }
    present(imagePicker, animated: true)
  }
  
  private func openDocument() {
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.image])
    documentPicker.delegate = self
    documentPicker.allowsMultipleSelection = false
    documentPicker.shouldShowFileExtensions = true
    documentPicker.modalPresentationStyle = .overFullScreen
    present(documentPicker, animated: true)
  }
  
  public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    guard url.startAccessingSecurityScopedResource() else {
      return
    }
    
    defer {
      url.stopAccessingSecurityScopedResource()
    }
    
    do {
      let imageData = try Data(contentsOf: url)
      let image = UIImage(data: imageData)
      photoImageView.image = image
      photoImageView.contentMode = .scaleAspectFit
      imageBase64 = image?.toBase64()
    } catch {
      print ("loading image file error")
    }
  }
  
  public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true, completion: nil)
    for result in results {
      result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
        if let image = object as? UIImage {
          DispatchQueue.main.async {
            self.photoImageView.image = image
            self.photoImageView.contentMode = .scaleAspectFit
            self.imageBase64 = image.toBase64()
          }
        }
      })
    }
  }
  
  private func setupLoader() {
    loader = LoaderView()
    self.view.addSubview(loader)
    loader.configureConstraints()
    loader.isHidden = true
  }
  
  @objc func uiModeNotificationRecieved() {
    menu.isHidden = true
    idTypeDropDown.isHidden = true
    cityDropDown.isHidden = true
    setupTopBar()
    setupForm()
    setupUploadDocumentButton()
    setupSendButton()
    menu.setup()
    if photoImageView.image != UIImage(named: "cameraDark") && photoImageView.image != UIImage(named: "cameraLight") {
      return
    }
    setupPhotoButton()
  }
  
  @objc func localizableNotificationRecieved() {
    menu.isHidden = true
    setupTopBar()
    setupLanguage()
    menu.setup()
  }
  
  // MARK: Actions
  @IBAction func backButtonAction(_ sender: Any) {
    coordinator.back()
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
  
  @IBAction func openCameraAction(_ sender: Any) {
    
    let alert = UIAlertController(title: openCameraTitle, message: openCameraMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: loadPhotoMessage, style: .default, handler: { _ in
      self.openImagePicker()
    }))
    alert.addAction(UIAlertAction(title: takePhoto, style: .default, handler: { _ in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
    self.present(alert, animated: true)
  }
  
  @IBAction func uploadDocumentButtonAction(_ sender: Any) {
    openDocument()
  }
  
  @IBAction func sendButtonAction(_ sender: Any) {
    view.endEditing(true)
    self.isLoading = true
    guard let idType = idTypeTextField.text,
          let idNumber = idNumberTextField.text,
          let name = nameTextField.text,
          let lastName = lastnameTextField.text,
          let documentTitle = documentTitleTextField.text,
          let city = cityTextField.text
    else {
      return
    }
    
    guard !idType.isEmpty,
          !idNumber.isEmpty,
          !name.isEmpty,
          !lastName.isEmpty,
          !documentTitle.isEmpty,
          !city.isEmpty
    else {
      self.isLoading = false
      self.alert(title: nil, message: emptyFieldMessage)
      return
    }
    
    guard let image = imageBase64 else {
      self.isLoading = false
      self.alert(title: nil, message: emptyImageMessage)
      return
    }
    
    guard let email = AuthenticationManager.shared.email else {
      return
    }
        
    viewModel.sendDocument(idType: idType, idNumber: idNumber, name: name, lastname: lastName, city: city, email: email, fileType: documentTitle, file: image) { succeeded in
      let alert = UIAlertController(title: nil, message: self.sendDocumentMessage, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        self.coordinator.back()
        self.isLoading = false
      }))
      self.present(alert, animated: true)
    }
    
    self.isLoading = false
  }
  
  @IBAction func idTypeDropDownButtonAction(_ sender: Any) {
    if idTypeDropDown.isHidden == false {
      idTypeDropDown.isHidden = true
    } else {
      idTypeDropDown.isHidden = false
    }
  }
  
  @IBAction func cityDropDownButtonAction(_ sender: Any) {
    guard let _ = cityDropDown else {
      return
    }
    if cityDropDown.isHidden == false {
      cityDropDown.isHidden = true
    } else {
      cityDropDown.isHidden = false
    }
  }
  
  @objc func dissmissKeyboard() {
    self.view.endEditing(true)
    idTypeDropDown.isHidden = true
    cityDropDown.isHidden = true
    menu.isHidden = true
    setupTopBar()
  }
  
  func alert(title:String?, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }
}

extension SendDocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    cameraImage?.dismiss(animated: true)
    if info.keys.contains(.originalImage) {
      let image = info[.originalImage] as? UIImage
      photoImageView.image = image
      imageBase64 = image?.toBase64()
      photoImageView.contentMode = .scaleAspectFit
    }
  }
}

extension UIImage {
  func toBase64() -> String {
    let imageData: NSData = self.jpegData(compressionQuality: 0.2)! as NSData
    return imageData.base64EncodedString(options: .init(rawValue: 0))
  }
}
