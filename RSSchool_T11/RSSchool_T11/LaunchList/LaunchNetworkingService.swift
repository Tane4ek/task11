//
//  LaunchNetworkingService.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 13.09.2021.
//

import Foundation

class LaunchNetworkingService {
    
    func request(urlString: String, completion: @escaping (Result<[LaunchSearchResponse], Error>) -> Void) {
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
                    var launch = try JSONDecoder().decode([LaunchSearchResponse].self, from: data)
                    for i in 0..<launch.count {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        let theDate = dateFormatter.date(from: launch[i].dateUtc)!
                        let newDateFormater = DateFormatter()
                        newDateFormater.dateFormat = "MMMM dd, yyyy"
                        launch[i].dateUtc = newDateFormater.string(from: theDate)
                    }
                    for i in 0..<launch.count {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        if launch[i].staticFireDateUtc != nil {
                            let theDate = dateFormatter.date(from: launch[i].staticFireDateUtc!)!
                        let newDateFormater = DateFormatter()
                        newDateFormater.dateFormat = "MMMM dd, yyyy"
                        launch[i].staticFireDateUtc = newDateFormater.string(from: theDate)
                        }
                    }
                    completion(.success(launch))
                    
                } catch let jsonError {
                    print("Failer to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
