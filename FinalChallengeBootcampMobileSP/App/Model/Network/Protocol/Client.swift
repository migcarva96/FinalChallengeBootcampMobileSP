//
//  Client.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

protocol Client {
  func fetch<Request: API, Response: Decodable>(api: Request, completion: @escaping (Result<Response, Error>) -> Void)
}
