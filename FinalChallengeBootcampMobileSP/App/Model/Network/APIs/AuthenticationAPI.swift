//
//  AuthenticationAPI.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

enum AuthenticationAPI: API {
  case authentication(email: String, password: String)
  
  var body: EmptyBody? {
    nil
  }
  
  var requestMethod: String {
    "GET"
  }

  var requestPath: String? {
    "/RS_Usuarios"
  }

  var requestPathParam: String? {
    nil
  }

  var queryItems: [URLQueryItem]? {
    switch self {
    case .authentication(let email, let password):
      return [URLQueryItem(name: "idUsuario", value: email),
              URLQueryItem(name: "clave", value: password)]
    }
  }
}
