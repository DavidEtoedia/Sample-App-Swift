//
//  network_manager.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation
import Combine

protocol NetworkService {
 func getPhotos(url: URL) -> AnyPublisher< Data, Error >
    }



struct NetworkManager : NetworkService {
     func getPhotos(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                    print("error")
                 throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        
    }
    
    
}
