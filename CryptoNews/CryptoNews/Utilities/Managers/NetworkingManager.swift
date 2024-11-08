//
//  NetworkingManager.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 24/10/2024.
//

import Foundation
import Combine

class NetworkingManager {

    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL)
        case unauthorized
        case badUrl
        case unknown

        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url): return "Bad response from URL: \(url)"
            case .unauthorized: return "Unauthorized user"
            case .badUrl: return "Bad URL"
            case .unknown: return "Unknown error occured"
            }
        }
    }

    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
}
