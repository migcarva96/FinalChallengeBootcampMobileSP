//
//  HomeViewModel.swift
//  Sophos
//
//  Created by Miguel Urrea on 30/11/22.
//

import Foundation

class HomeViewModel {
  let client: Client
  
  init(client: Client = NetworkClient()) {
    self.client = client
  }
}
