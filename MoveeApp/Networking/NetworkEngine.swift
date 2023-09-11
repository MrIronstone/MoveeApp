//
//  File.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation


final class NetworkEngine {
    // 1
    /// Executes the web call and will decode the JSON response into the Codable object provided
    /// - Parameters:
    ///   - endpoint: the endpoint to make HTTP request against
    ///   - completion: the JSON response converted to provided Codable object, if successful, or failure otherwise
    
    class func request<T: Decodable>(endpoint: Endpoint, requestParameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        // 2
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        // 3
        guard let url = components.url else { return }
        
        // print("URL is (\(url)")
        
        
        // 4
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        if requestParameters != nil, endpoint.method != "GET" {
            do {
                guard let requestParameters else { return }
                let requestData = try JSONSerialization.data(withJSONObject: requestParameters)
                urlRequest.httpBody = requestData as Data
                urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            } catch {
                print("Error occured while serilize the json: \(error.localizedDescription)")
            }
        }
        
        // 5
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            // 6
            guard error == nil else {
                guard let safeError = error else { return }
                completion(.failure(safeError))
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            // run in main thread
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(jsonData)
                } catch {
                    let error = NSError(domain: "", code: -1002, userInfo: [NSLocalizedDescriptionKey: "Failed to decode json"])
                    completion(.failure(error))
                }
                
                if let responseObject = try? decoder.decode(T.self, from: data) {
                    // 7
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        })
        dataTask.resume()
    }
}
