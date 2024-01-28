//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation
import Foundation
import Combine

final class NetworkManager: NetworkManagerProtocol {
   
    func request<T>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> where T: Codable {
        guard var url = endpoint.url.asURL() else {return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.invalidUrl))}
        _ =  endpoint.method == .Get && endpoint.params.count > 0 ? url.append(queryItems: endpoint.params.asQueryItems) : ()
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.addValue(ApiInfo.content, forHTTPHeaderField: "Content-Type")
        request.httpBody = endpoint.method != .Get ? endpoint.params.asData : nil
        print(url.absoluteString)
        return call(request: request)
    }
    
    func call<T>(request: URLRequest) -> AnyPublisher<T, NetworkError> where T: Codable {
        return URLSession.shared
        .dataTaskPublisher(for: request)
        .tryMap{ output in
            let statusCode = (output.response as? HTTPURLResponse)?.statusCode
            guard statusCode == 200  else {throw NetworkError.convert(statusCode) ?? .errorOccured}
            return output.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError{NetworkError.convert($0)}
        .retry(3)
        .eraseToAnyPublisher()
    }
}
