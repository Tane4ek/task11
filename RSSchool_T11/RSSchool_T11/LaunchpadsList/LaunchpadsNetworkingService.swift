//
//  LaunchpadsNetworkingService.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 29.09.2021.
//

import Foundation

class LaunchpadsNetworkingService {
    
    func request(urlString: String, completion: @escaping (Result<[LaunchpadsSearchResponse], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    var launch = try JSONDecoder().decode([LaunchpadsSearchResponse].self, from: data)
                    completion(.success(launch))
                    
                } catch let jsonError {
                    print("Failer to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

