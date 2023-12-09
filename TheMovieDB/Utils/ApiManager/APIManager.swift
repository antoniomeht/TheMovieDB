//
//  APIManager.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    // https://developer.themoviedb.org/reference/intro/authentication
    private let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMTRlZjNkMWMzOTAwMGY0YjcwMmM4YzRkNWIyYTdhNCIsInN1YiI6IjYyZTE1ZTA2NzcwNzAwMDA1MDBkN2E2ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SgIwcIl2L5TqiCuIKbIckmsVwpJQ1QVRdsRg2tNFH0k"
    
    func request<T: Codable>(endpoint: String, method: APIMethod, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string : Constants.Endpoint.baseUrl + endpoint) else {
            return
        }
        
        let headers = [
          "accept": "application/json",
          "Authorization": apiKey
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = parameters?.percentEncoded()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
