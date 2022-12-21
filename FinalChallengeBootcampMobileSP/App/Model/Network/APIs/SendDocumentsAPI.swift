//
//  SendDocumentsAPI.swift
//  Sophos
//
//  Created by Miguel Urrea on 14/12/22.
//

import Foundation

enum SendDocumentsAPI: API {
  case sendDocument(request: SendDocumentsRequest)
  
  var body: SendDocumentsRequest? {
    switch self {
    case .sendDocument(let request):
      return request
    }
  }
  
  var requestMethod: String {
    "POST"
  }

  var requestPath: String? {
    "/RS_Documentos"
  }

  var requestPathParam: String? {
    nil
  }

  var queryItems: [URLQueryItem]? {
    nil
  }
}
