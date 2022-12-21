//
//  ViewDocumentsViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit

class ViewDocumentsViewController: UIViewController, StoryboardInstantiable, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  
  var centerViewController: UINavigationController!
  var coordinator: ViewDocumentsCoordinator!
  var viewModel: ViewDocumentsViewModel!
  var delegate: MenuDelegate?
  var menu: MenuView!
  var tableViewContainer: UIView!
  var documentsTableView: UITableView!
  var document: Array<DocumentByEmail>? = nil
  var activityIndicator: UIActivityIndicatorView!
  var emptyMessageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    
    setupContainer()
    setupDocumentsTableView()
    setupTopBar()
    setupMenu()
    setupLoader()
    setupEmptyMessage()
    setupLanguage()
  }
  
  // MARK: Configure UI
  func setupTopBar() {
    titleLabel.font = UIFont(name: "Montserrat-Bold", size: 22)
    backButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
    
    if traitCollection.userInterfaceStyle == .dark {
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
  
  private func setupMenu() {
    menu = MenuView()
    self.view.addSubview(menu)
    menu.delegate = delegate.self
    menu.configureConstraints()
    menu.isHidden = true
  }
  
  func setupContainer() {
    tableViewContainer = UIView()
    tableViewContainer.backgroundColor = .clear
    tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableViewContainer)
    
    NSLayoutConstraint.activate([
      tableViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      tableViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      tableViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    ])
  }
  
  func setupDocumentsTableView() {
    
    viewModel.viewDocumentByEmail { succeeded in
      guard succeeded else { return }
      self.document = self.viewModel.responseByEmail?.documents
      
      self.documentsTableView = UITableView()
      self.documentsTableView.translatesAutoresizingMaskIntoConstraints = false
      self.documentsTableView.separatorColor = UIColor(named: "secondaryColor")
      self.documentsTableView.separatorInset = .zero
      self.documentsTableView.separatorStyle = .none
      self.documentsTableView.backgroundColor = .clear
      self.documentsTableView.delegate = self
      self.documentsTableView.dataSource = self
      self.documentsTableView.register(ViewDocumentTableViewCell.self, forCellReuseIdentifier: "ViewDocumentTableViewCell")
      self.tableViewContainer.addSubview(self.documentsTableView)
      
      let containerHeight = Int(self.tableViewContainer.frame.height)
      let tableViewHeight = (self.document?.count ?? 0) * 44
      let headerHeight = ((containerHeight)/2 - (tableViewHeight)) - 44
      if headerHeight > 0 {
        self.documentsTableView.isScrollEnabled = false
        NSLayoutConstraint.activate([
          self.documentsTableView.leadingAnchor.constraint(equalTo: self.tableViewContainer.leadingAnchor, constant: 0),
          self.documentsTableView.trailingAnchor.constraint(equalTo: self.tableViewContainer.trailingAnchor, constant: 0),
          self.documentsTableView.topAnchor.constraint(equalTo: self.tableViewContainer.topAnchor, constant: CGFloat(headerHeight)),
          self.documentsTableView.bottomAnchor.constraint(equalTo: self.tableViewContainer.bottomAnchor, constant: 0)
        ])
      } else{
        NSLayoutConstraint.activate([
          self.documentsTableView.leadingAnchor.constraint(equalTo: self.tableViewContainer.leadingAnchor, constant: 0),
          self.documentsTableView.trailingAnchor.constraint(equalTo: self.tableViewContainer.trailingAnchor, constant: 0),
          self.documentsTableView.topAnchor.constraint(equalTo: self.tableViewContainer.topAnchor, constant: 0),
          self.documentsTableView.bottomAnchor.constraint(equalTo: self.tableViewContainer.bottomAnchor, constant: 0)
        ])
      }
      self.activityIndicator.isHidden = true
      self.activityIndicator.stopAnimating()
      let rowCount = self.document?.count ?? 0
      if rowCount == 0 {
        self.emptyMessageLabel.isHidden = false
      }
    }
  }
  
  func setupLoader() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = UIColor(named: "secondaryColor")
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }
  
  func setupEmptyMessage() {
    emptyMessageLabel = UILabel()
    emptyMessageLabel.textColor = UIColor(named: "secondaryColor")
    emptyMessageLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
    emptyMessageLabel.textAlignment = .center
    emptyMessageLabel.numberOfLines = 0
    emptyMessageLabel.isHidden = true
    emptyMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(emptyMessageLabel)
    NSLayoutConstraint.activate([
      emptyMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      emptyMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
      emptyMessageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
    ])
  }
  
  private func setupLanguage() {
    if ProfileManager.shared.localizableLanguage == "en" {
      let path = Bundle.main.path(forResource: "en", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLabel.text = NSLocalizedString("view-documents-title-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyMessageLabel.text = NSLocalizedString("empty-view-documents-label-key",bundle: bundle!, comment: "")
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLabel.text = NSLocalizedString("view-documents-title-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
      emptyMessageLabel.text = NSLocalizedString("empty-view-documents-label-key",bundle: bundle!, comment: "")
    }
  }
  
  @objc func uiModeNotificationRecieved() {
    menu.isHidden = true
    setupTopBar()
    menu.setup()
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    document?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ViewDocumentTableViewCell", for: indexPath) as! ViewDocumentTableViewCell
    let model = document?[indexPath.row]
    cell.configurate(model: model)
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = document?[indexPath.row]
    guard let id = model?.idDocument else { return }
    viewModel.viewDocumentById(id: id) { succeeded in
      guard let imageBase64 = self.viewModel.responseById?[0].file else { return }
      let imageData = Data(base64Encoded: imageBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
      let image = UIImage(data: imageData)
      self.coordinator.imageViewer(image: image)
      
    }
  }
}
