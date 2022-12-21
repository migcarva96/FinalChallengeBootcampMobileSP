//
//  OfficesResponse.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

struct OfficesResponse: Decodable {
  let offices: [Office]
  let count: Int
  let scannedCount: Int
  
  enum CodingKeys: String, CodingKey {
    case offices = "Items"
    case count = "Count"
    case scannedCount = "ScannedCount"
  }
}

struct Office: Decodable {
  let city: String
  let longitude: String
  let latitude: String
  let idOffice: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case city = "Ciudad"
    case longitude = "Longitud"
    case latitude = "Latitud"
    case idOffice = "IdOficina"
    case name = "Nombre"
  }
}
