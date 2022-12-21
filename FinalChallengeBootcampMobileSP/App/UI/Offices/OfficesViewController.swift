//
//  OfficesViewController.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import UIKit
import CoreLocation
import MapKit

class OfficesViewController: UIViewController, StoryboardInstantiable {
  
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mapContainer: UIView!
  
  var centerViewController: UINavigationController!
  var coordinator: OfficesCoordinator!
  var viewModel: OfficesViewModel!
  var delegate: MenuDelegate?
  var menu: MenuView!
  
  private var locationManager: CLLocationManager?
  private var userLocation: CLLocation?
  private var map: MKMapView?
  private var isLocationEnable: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(uiModeNotificationRecieved), name: NSNotification.Name.ChangeUIMode, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(localizableNotificationRecieved), name: NSNotification.Name.ChangeLocalizable, object: nil)
    
    requestLocation()
    
    setupTopBar()
    setupMenu()
    setupLanguage()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupMap()
    setupMapLocation()
  }
  
  private func requestLocation() {
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestAlwaysAuthorization()
    locationManager?.startUpdatingLocation()
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
  
  func setupMap() {
    map = MKMapView(frame: mapContainer.bounds)
    mapContainer.addSubview(map ?? UIView())
    
    setupOfficesMarkers()
  }
  
  func setupMapLocation() {
    guard let location = userLocation else {
      return
    }
    
    guard let heading = CLLocationDirection(exactly: 12) else {
      return
    }
    
    map?.camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), fromDistance: 50000, pitch: .zero, heading: heading)
    
    map?.showsUserLocation = true
  }
  
  func setupOfficesMarkers() {
    viewModel.offices { succeeded in
      self.viewModel.officesResponse?.offices.forEach { item in
        let marker = MKPointAnnotation()
        guard let latitude = Double(item.latitude) else { return }
        guard let longitude = Double(item.longitude) else { return }
        marker.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = item.name
        marker.subtitle = item.city
        self.map?.addAnnotation(marker)
      }
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
      titleLabel.text = NSLocalizedString("offices-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
    } else {
      let path = Bundle.main.path(forResource: "es", ofType: "lproj")
      let bundle = Bundle(path: path!)
      titleLabel.text = NSLocalizedString("offices-label-key", bundle: bundle!, comment: "")
      backButton.setTitle("   " + NSLocalizedString("back-button-key", bundle: bundle!, comment: ""), for: .normal)
    }
  }
  
  @objc func uiModeNotificationRecieved() {
    menu.isHidden = true
    setupTopBar()
    setupMap()
    setupMapLocation()
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
}

extension OfficesViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let bestLocation = locations.last else {
      return
    }
    userLocation = bestLocation
    if !isLocationEnable {
      setupMapLocation()
      isLocationEnable = true
    }
  }
}
