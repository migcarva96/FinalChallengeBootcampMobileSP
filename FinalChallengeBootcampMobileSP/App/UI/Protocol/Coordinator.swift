//
//  Coordinator.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import UIKit

protocol Coordinator {
    var presenter: UINavigationController { get }
    
    func navigate()
}
