//
//  URLExtension.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

extension String {
  func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw NSError()
    }
    return url
  }
}
