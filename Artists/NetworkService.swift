//
//  NetworkService.swift
//  Artists
//
//  Created by user on 16.09.2024.
//


import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchArtist(completion: @escaping(Result<[Artist]?, AFError>) -> Void)
    func fetchWork(completion: @escaping(Result<[Work]?, AFError>) -> Void)
    //func fetchAF<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(T) -> Void)
    
}



class NetworkService: NetworkServiceProtocol {
    func fetchWork(completion: @escaping (Result<[Work]?, AFError>) -> Void) {
        
        let URLString = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
        guard let url = URL(string: URLString) else {
            completion(.failure(AFError.invalidURL(url: URLString)))
            return
        }
        
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let responseData):
                    do {
                        let decoder = JSONDecoder()
                        
                        let artistsResponse = try decoder.decode(Artists.self, from: responseData)
                        
                        let allWorks = artistsResponse.artists.flatMap { $0.works}
                        completion(.success(allWorks))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func fetchArtist(completion: @escaping (Result<[Artist]?, AFError>) -> Void) {
        let URLString = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
        guard let url = URL(string: URLString) else {
            completion(.failure(AFError.invalidURL(url: URLString)))
            return
        }
        
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let responseData):
                    do {
                        let decoder = JSONDecoder()
                        
                        let artistsResponse = try decoder.decode(Artists.self, from: responseData)
                        
                        completion(.success(artistsResponse.artists))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    //    func fetchAF<T>(dataType: T.Type, url: String, completion: @escaping (T) -> Void) where T : Decodable {
    //        guard let url = URL(string: url) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { data, _, error in
    //            guard let data = data else {
    //                return
    //            }
    //            do {
    //                let decoder = JSONDecoder()
    //                let type = try decoder.decode(T.self, from: data)
    //                DispatchQueue.main.async {
    //                    completion(type)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }.resume()
    //    }
}




