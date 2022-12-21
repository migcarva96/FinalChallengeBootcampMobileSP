//
//  StoryboardInstantiable.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

protocol StoryboardInstantiable {
  static func fromStoryboard() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {
  
  static func fromStoryboard() -> Self {
    guard let name = description().components(separatedBy: ".").last?
      .replacingOccurrences(of: "ViewController", with: "") else {
      return Self.init(nibName: nil, bundle: nil)
    }
    
    let storyboard = UIStoryboard(name: name, bundle: nil)
    
    return storyboard.instantiateInitialViewController() as! Self
  }
}
