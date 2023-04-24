//
//  APIError.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

public enum APIError: Error {
  case noNetwork
  case timeout
  case communication
  case generic(Int)
  case invalidRequest
  case resourceNotFound
  case serverUnavailable
  case serviceUnavailable
  case unknown

  init?(code: Int) {
    var error: APIError
    switch code {
    case NSURLErrorTimedOut:
      error = .timeout
    case NSURLErrorNotConnectedToInternet, NSURLErrorCannotFindHost, NSURLErrorDataNotAllowed:
      error = .noNetwork
    case NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost:
      error = .communication
    case NSURLErrorCancelled:
          error = .communication
    default:
      return nil
    }
    self = error
  }
}
