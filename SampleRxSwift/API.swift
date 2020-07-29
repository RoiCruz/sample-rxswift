//
//  API.swift
//  SampleRxSwift
//
//  Created by Roy Cruz on 7/29/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import Foundation
import RxSwift

class UniversityRequest: APIRequest {
    var method = RequestType.GET
    var path = "regions"
    var parameters = [String: String]()

    init() {
        
    }
}


protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

public enum RequestType: String {
    case GET, POST
}
