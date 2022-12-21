//
//  ViewDocumentsByEmailResponse.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

struct ViewDocumentsByEmailResponse: Decodable {
  let documents: [DocumentByEmail]
  let count: Int
  let scannedCount: Int
  
  enum CodingKeys: String, CodingKey {
    case documents = "Items"
    case count = "Count"
    case scannedCount = "ScannedCount"
  }
}

struct DocumentByEmail: Decodable {
  let idDocument: String
  let date: String
  let fileTitle: String
  let name: String
  let lastname: String
  
  enum CodingKeys: String, CodingKey {
    case idDocument = "IdRegistro"
    case date = "Fecha"
    case fileTitle = "TipoAdjunto"
    case name = "Nombre"
    case lastname = "Apellido"
  }
}
