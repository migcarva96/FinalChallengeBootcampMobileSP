//
//  ViewDocumentsByIdResponse.swift
//  Sophos
//
//  Created by Miguel Urrea on 15/12/22.
//

import Foundation

struct ViewDocumentsByIdResponse: Decodable {
  let documents: [DocumentById]
  let count: Int
  let scannedCount: Int
  
  enum CodingKeys: String, CodingKey {
    case documents = "Items"
    case count = "Count"
    case scannedCount = "ScannedCount"
  }
}

struct DocumentById: Decodable {
  let city: String
  let date: String
  let fileTitle: String
  let name: String
  let lastname: String
  let idNumber: String
  let idDocument: String
  let idType: String
  let email: String
  let file: String
  
  enum CodingKeys: String, CodingKey {
    case city = "Ciudad"
    case date = "Fecha"
    case fileTitle = "TipoAdjunto"
    case name = "Nombre"
    case lastname = "Apellido"
    case idNumber = "Identificacion"
    case idDocument = "IdRegistro"
    case idType = "TipoId"
    case email = "Correo"
    case file = "Adjunto"
  }
}
