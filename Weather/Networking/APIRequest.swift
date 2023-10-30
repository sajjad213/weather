//
//  APIRequest.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import Foundation

class APIRequest {
    let urlString: String
    let params: [String: Any]?
    
    init(url: String, params: [String: Any]?) {
        self.urlString = url
        self.params = params
    }
    
    func perform<T: Decodable>() async throws -> T {
        var components = URLComponents(string: urlString)!
        components.queryItems = params?.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIError.invalidReponse
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        guard let result = try? decoder.decode(T.self, from: data) else {
            throw APIError.invalidData
        }
        return result
    }
}

class RequestParamsModel: Codable {
    
    //MARK: - Properties
    public let appId: String = "774a8badc9bb561943d6ef6affd95ec4"
    
    public enum CodingKeys: String, CodingKey {
        case appId = "appid"
    }
    
}

enum APIError: Error {
    case invalidReponse
    case invalidData
    case invalidURL
}
