//
//  Response.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

struct Response<T> {
  let value: T
  let response: URLResponse

  init(value: T, response: URLResponse) {
    self.value = value
    self.response = response
  }
}
