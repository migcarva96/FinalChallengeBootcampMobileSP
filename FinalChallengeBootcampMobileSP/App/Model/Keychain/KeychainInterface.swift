//
//  KeychainInterface.swift
//  Sophos
//
//  Created by Miguel Urrea on 13/12/22.
//

import Foundation

class KeychainInterface {
  static let kServerKey = "com.miguelUrrea.Sophos"
  
  enum KeychainError: Error {
    case itemNotFound
    case duplicateItem
    case invalidItemFormat
    case unexpectedStatus(OSStatus)
  }
  
  static func save(password: Data, account: String) throws {
    let query: [String: AnyObject] = [
      kSecAttrAccount as String: account as AnyObject,
      kSecClass as String: kSecClassInternetPassword,
      kSecAttrServer as String: KeychainInterface.kServerKey as AnyObject,
      kSecValueData as String: password as AnyObject
    ]
    
    let status = SecItemAdd(query as CFDictionary, nil)
    _ = SecCopyErrorMessageString(status, nil) as? String
    
    guard status == 0 else {
      throw KeychainError.unexpectedStatus(status)
    }
  }
  
  static func read(account: String) throws -> Data? {
    let query: [String: AnyObject] = [
      kSecAttrServer as String: KeychainInterface.kServerKey as AnyObject,
      kSecAttrAccount as String: account as AnyObject,
      kSecClass as String: kSecClassInternetPassword,
      kSecReturnData as String: kCFBooleanTrue,
      kSecReturnAttributes as String: kCFBooleanTrue
    ]
    
    var itemCopy: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)
    _ = SecCopyErrorMessageString(status, nil) as? String
    
    guard status == 0 else {
      throw KeychainError.unexpectedStatus(status)
    }
    
    guard let userInfo = itemCopy as? [String: AnyObject], let password = userInfo[kSecValueData as String] as? Data else {
      throw KeychainError.invalidItemFormat
    }
    
    return password
  }
  
  static func delete(account: String) throws {
    let query: [String: AnyObject] = [
      kSecAttrAccount as String: account as AnyObject,
      kSecClass as String: kSecClassInternetPassword,
      kSecAttrServer as String: KeychainInterface.kServerKey as AnyObject
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    _ = SecCopyErrorMessageString(status, nil) as? String
    
    guard status == 0 else {
      throw KeychainError.unexpectedStatus(status)
    }
  }
}
