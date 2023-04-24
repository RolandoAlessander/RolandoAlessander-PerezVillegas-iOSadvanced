//
//  Parameters.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

protocol ParametersEncodingProtocol {
  func encode(_ urlRequest: URLRequestConvertible, with parameters: QueryParamsProtocol?) throws -> URLRequest
}

protocol QueryParamsProtocol {
func getQueryParams() -> [URLQueryItem]
}

struct ParametersEncoding: ParametersEncodingProtocol {
  enum ParameterType {
    case queryItem
  }

  let parameterType: ParameterType

  init(parameterType: ParameterType) {
    self.parameterType = parameterType
  }

  func encode(_ urlRequest: URLRequestConvertible, with parameters: QueryParamsProtocol?) throws -> URLRequest {
    var urlRequest: URLRequest = try urlRequest.asURLRequest()
    guard let parametersNotNil = parameters else { return urlRequest }
    let parametersQueryItems: [URLQueryItem] = parametersNotNil.getQueryParams()

    switch parameterType {
    case .queryItem:
      guard let url = urlRequest.url else {
        throw NSError()
      }
      if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
         !parametersQueryItems.isEmpty {
        let urlQueryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = urlQueryItems + parametersQueryItems
        urlRequest.url = urlComponents.url
      }
    }
    return urlRequest
  }
}
