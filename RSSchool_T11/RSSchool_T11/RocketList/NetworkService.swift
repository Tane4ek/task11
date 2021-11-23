//
//  NetworkService.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 12.09.2021.
//

import UIKit

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<[SearchResponse], Error>) -> Void) {
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
                    var rockets = try JSONDecoder().decode([SearchResponse].self, from: data)
                    for i in 0..<rockets.count {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let theDate = dateFormatter.date(from: rockets[i].firstFlight)!
                        let newDateFormater = DateFormatter()
                        newDateFormater.dateFormat = "MMMM dd, yyyy"
                        rockets[i].firstFlight = newDateFormater.string(from: theDate)
                    }
                    
                    completion(.success(rockets))
                } catch let jsonError {
                    print("Failer to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}
