//
//  ViewDocumentsAPI.swift
//  Sophos
//
//  Created by Miguel Urrea on 14/12/22.
//

import Foundation

enum ViewDocumentsAPI: API {
  case viewDocumentByEmail(email: String)
  case viewDocumentById(id: String)
  
  var body: EmptyBody? {
    nil
  }
  
  var requestMethod: String {
    "GET"
  }
  
  var requestPath: String? {
    "/RS_Documentos"
  }
  
  var requestPathParam: String? {
    nil
  }
  
  var queryItems: [URLQueryItem]? {
    switch self {
    case .viewDocumentByEmail(let email):
      return [URLQueryItem(name: "correo", value: email)]
    case .viewDocumentById(let id):
      return [URLQueryItem(name: "idRegistro", value: id)]
    }
  }
}

