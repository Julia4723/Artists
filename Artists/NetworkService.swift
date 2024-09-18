//
//  NetworkService.swift
//  Artists
//
//  Created by user on 16.09.2024.
//


import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchAF(completion: @escaping(Result<[Artist]?, AFError>) -> Void)
}



class NetworkService: NetworkServiceProtocol {
    func fetchAF(completion: @escaping (Result<[Artist]?, AFError>) -> Void) {
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
                            // Decode the response data into the Artists model
                            let artistsResponse = try decoder.decode(Artists.self, from: responseData)
                            // Extract the array of Artist objects
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
    }
