//
//  NetworkManagerProtocol.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

import Foundation
import Combine

public typealias JSON = [String : Any]

protocol  NetworkManagerProtocol {
    func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
    func call<T: Codable>(request: URLRequest) -> AnyPublisher<T, NetworkError>
}
