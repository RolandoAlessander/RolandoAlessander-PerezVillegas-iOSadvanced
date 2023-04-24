//
//  URLSessionNetworking.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol NetworkingProtocol {

  @available(iOS 13, *)
  func perform<T: Decodable>(service: Service) -> AnyPublisher<Response<T>, APIError>
}

final class UrlSessionNetworking: NetworkingProtocol {

  @available(iOS 13, *)
  func perform<T: Decodable>(service: Service) -> AnyPublisher<Response<T>, APIError> {
    guard let urlRequest = try? RequestConvertible(service: service).asURLRequest() else {
      return Fail(error: APIError.invalidRequest).eraseToAnyPublisher()
    }

    let cancellable: AnyPublisher<Response<T>, APIError>
    cancellable = URLSession.shared
      .dataTaskPublisher(for: urlRequest)
      .tryMap { result -> Response<T> in
        print(result.data.description)
        let value = try JSONDecoder().decode(T.self, from: result.data)
        return Response(value: value, response: result.response)
      }
      .mapError({ error in
        if let apiServiceError = error as? APIError {
          return apiServiceError
        } else if let urlError = error as? URLError, let apiError = APIError(code: urlError.errorCode) {
          return apiError
        } else {
          return APIError.unknown
        }
      })
      .receive(on: DispatchQueue.main).eraseToAnyPublisher()

    return cancellable
  }
}

final class RequestConvertible: URLRequestConvertible {

  private let service: Service
  private var url: URL {
    do {
      return try service.baseURl.asURL()
    } catch {}
    return URL(fileURLWithPath: "")
  }

  init(service: Service) {
    self.service = service
  }

  func asURLRequest() throws -> URLRequest {
    let serviceURL = url.appendingPathComponent(service.endPoint)
    var urlRequest = URLRequest(
      url: serviceURL,
      cachePolicy: .reloadIgnoringLocalCacheData,
      timeoutInterval: service.timeInterval
    )
    urlRequest.httpMethod = service.httpMethod.rawValue
    let parameterEncoding = service.parameterEncoding
    urlRequest = try parameterEncoding.encode(urlRequest, with: service.parameters)
    return urlRequest
  }
}

protocol URLRequestConvertible {
  func asURLRequest() throws -> URLRequest
}

extension URLRequest: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    self
  }
}
