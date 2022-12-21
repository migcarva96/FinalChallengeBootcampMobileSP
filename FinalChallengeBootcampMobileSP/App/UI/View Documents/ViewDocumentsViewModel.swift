//
//  ViewDocumentsViewModel.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import Foundation

class ViewDocumentsViewModel {
  let client: Client
  
  init(client: Client = NetworkClient()) {
    self.client = client
  }
  
  var responseByEmail: ViewDocumentsByEmailResponse?
  var responseById: [DocumentById]?
  
  func viewDocumentByEmail(completion: @escaping (_ succeeded: Bool) -> ()) {
    guard let email = AuthenticationManager.shared.email else { return }
    client.fetch(api: ViewDocumentsAPI.viewDocumentByEmail(email: email)) { (result: Result<ViewDocumentsByEmailResponse, Error>) in
      switch result {
      case .success(let response):
        self.responseByEmail = response
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
  
  func viewDocumentById(id: String, completion: @escaping (_ succeeded: Bool) -> ()) {
    client.fetch(api: ViewDocumentsAPI.viewDocumentById(id: id)) { (result: Result<ViewDocumentsByIdResponse, Error>) in
      switch result {
      case .success(let response):
        self.responseById = response.documents
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
}
