//
//  SendDocumentsViewModel.swift
//  Sophos
//
//  Created by Miguel Urrea on 2/12/22.
//

import Foundation

class SendDocumentsViewModel {
  var cities: Array<String> = []
  let client: Client
  
  init(client: Client = NetworkClient()) {
    self.client = client
  }
  
  func sendDocument(idType: String,
                    idNumber: String,
                    name: String,
                    lastname: String,
                    city: String,
                    email: String,
                    fileType: String,
                    file: String,
                    completion: @escaping (_ succeeded: Bool) -> ()) {
    let request = SendDocumentsRequest(idType: idType, idNumber: idNumber, name: name, lastname: lastname, city: city, email: email, fileType: fileType, file: file)
    client.fetch(api: SendDocumentsAPI.sendDocument(request: request)) { (result: Result<SendDocumentsResponse, Error>) in
      switch result {
      case .success(let response):
        response.put ? completion(true) : completion(false)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
  
  func cities(completion: @escaping (_ succeeded: Bool) -> ()) {
    client.fetch(api: OfficesAPI.office) { (result: Result<OfficesResponse, Error>) in
      switch result {
      case .success(let response):
        response.offices.forEach { office in
          if !self.cities.contains(office.city){
            self.cities.append(office.city)
          }
        }
        completion(true)
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
}
