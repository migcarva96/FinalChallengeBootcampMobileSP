//
//  AuthenticationResponse.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

struct AuthenticationResponse: Codable {
  let id: String
  let name: String
  let lastname: String
  let access: Bool
  let admin: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case name = "nombre"
    case lastname = "apellido"
    case access = "acceso"
    case admin
  }
}
