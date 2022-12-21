//
//  OfficesAPI.swift
//  Sophos
//
//  Created by Miguel Urrea on 14/12/22.
//

import Foundation

enum OfficesAPI: API {
  case office
  
  var body: EmptyBody? {
    nil
  }
  
  var requestMethod: String {
    "GET"
  }

  var requestPath: String? {
    "/RS_Oficinas"
  }

  var requestPathParam: String? {
    nil
  }

  var queryItems: [URLQueryItem]? {
    nil
  }
}
