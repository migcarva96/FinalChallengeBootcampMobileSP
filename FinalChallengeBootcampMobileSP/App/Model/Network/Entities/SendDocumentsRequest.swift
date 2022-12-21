//
//  SendDocumentsRequest.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

struct SendDocumentsRequest: Encodable {
  let idType: String
  let idNumber: String
  let name: String
  let lastname: String
  let city: String
  let email: String
  let fileType: String
  let file: String
  
  enum CodingKeys: String, CodingKey {
    case idType = "TipoId"
    case idNumber = "Identificacion"
    case name = "Nombre"
    case lastname = "Apellido"
    case city = "Ciudad"
    case email = "Correo"
    case fileType = "TipoAdjunto"
    case file = "Adjunto"
  }
}
