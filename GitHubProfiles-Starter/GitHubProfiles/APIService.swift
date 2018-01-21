
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

enum APIError: Error {

    case missingData

}

enum Result<T> {

    case success(T)
    case failure(Error)

}

final class APIService {

    static let shared = APIService()

    let defaultSession = URLSession(configuration: .default)

    typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> Result<T>

    @discardableResult
    private func request<T>(_ url: URL, serializationFunction: @escaping SerializationFunction<T>,
                            completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        fatalError("Code not filled in")
    }

    @discardableResult
    func request<T: Decodable>(_ url: URL, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        fatalError("Code not filled in")
    }

    private func serializeJSON<T: Decodable>(with data: Data?, response: URLResponse?, error: Error?) -> Result<T> {
        fatalError("Code not filled in")
    }

    @discardableResult
    func requestImage(withURL url: URL, completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask {
        fatalError("Code not filled in")
    }

    private func serializeImage(with data: Data?, response: URLResponse?, error: Error?) -> Result<UIImage> {
        fatalError("Code not filled in")
    }

}
