//
//  NetworkClient.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

class NetworkClient: Client {
  var session: URLSession = URLSession(configuration: .default)

  func fetch<Request, Response>(api: Request, completion: @escaping (Result<Response, Error>) -> Void) where Request : API, Response : Decodable {
    do {
      let request = try api.asURLRequest()
      let dataTask = session.dataTask(with: request) { (data, response, error) in
        guard let validData = data, error == nil else {
          DispatchQueue.main.async {
            completion(.failure(error!))
          }
          return
        }

        do{
          let json = try JSONDecoder().decode(Response.self, from: validData)
          DispatchQueue.main.async {
            completion(.success(json))
          }
        }catch let error {
          DispatchQueue.main.async {
            completion(.failure(error))
          }
        }
      }

      dataTask.resume()
    } catch let error {
      DispatchQueue.main.async {
        completion(.failure(error))
      }
    }
  }
}
