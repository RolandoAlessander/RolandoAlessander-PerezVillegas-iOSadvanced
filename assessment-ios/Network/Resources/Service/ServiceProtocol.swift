//
//  Service.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

protocol Service {
  var httpMethod: HTTPMethod { get }
  var baseURl: String { get }
  var endPoint: String { get }
  var parameterEncoding: ParametersEncodingProtocol { get }
  var parameters: QueryParamsProtocol? { get }
  var timeInterval: TimeInterval { get }
}

extension Service {

  var httpMethod: HTTPMethod {
    return .get
  }

  var timeInterval: TimeInterval {
    return 10.0
  }
}
