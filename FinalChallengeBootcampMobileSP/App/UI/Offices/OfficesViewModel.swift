//
//  OfficesViewModel.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import Foundation

class OfficesViewModel {
  let client: Client
  
  init(client: Client = NetworkClient()) {
    self.client = client
  }
  
  var officesResponse: OfficesResponse?
  
  func offices(completion: @escaping (_ succeeded: Bool) -> ()) {
    client.fetch(api: OfficesAPI.office) { (result: Result<OfficesResponse, Error>) in
      switch result {
      case .success(let response):
        self.officesResponse = response
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
}
