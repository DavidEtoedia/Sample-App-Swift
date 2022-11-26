//
//  network_manager.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation
import Combine

///
///
//extension URLL {
//
// static var forAllProducts: URL {
//        URL(string: "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo")!
//    }
//    static func url(_ path: String) -> URL? {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "fakestoreapi.com"
//        components.path = path
//        return components.url
//    }
//}

// GENERIC API ENDPOINTS WITH REQUEST
extension URL {
    
    static func url(_ path : String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/\(path)/"
        components.query = "client_id=\(ApiKey.apiKey.description)"
        return components.url
    }
    static func paginated(_ path : String, pageNum : Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/\(path)/"
        components.query = "page=\(pageNum)&client_id=\(ApiKey.apiKey.description)"
        return components.url
    }
    
    static func request(_ url : URL, _ method : String) -> URL? {
        var request = URLRequest(url: url)
               request.httpMethod = method
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        return request.url
    }

}




protocol NetworkService {
 func getPhotos(url: URL) -> AnyPublisher< Data, Error >
    
    }

protocol PhotoDataSource {
 func getPhotos(pages : Int) -> AnyPublisher< Data, Error >
 func getDetails(id : String) -> AnyPublisher< Data, Error >
    
    }


struct PhotoDataSourceImpl : PhotoDataSource {
    func getDetails(id : String) -> AnyPublisher<Data, Error> {
      return URLSession.shared.dataTaskPublisher(for: .request(.url("photos/\(id)")!, "GET")!)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                    print("Details Error")
                    print(output.response)
                 throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func getPhotos(pages : Int) -> AnyPublisher<Data, Error> {
//        var request = URLRequest(url: .url("photos")!)
//               request.httpMethod = "GET"
//               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
//        print(request.httpMethod!)
        return URLSession.shared.dataTaskPublisher(for: .request(.paginated("photos", pageNum: pages)!, "GET")!)
           .subscribe(on: DispatchQueue.global(qos: .default))
           .tryMap { output -> Data in
               guard let response = output.response as? HTTPURLResponse,
               response.statusCode >= 200 && response.statusCode < 300 else {
                   print("error from list of photos")
                   print(output.response)
                throw URLError(.badServerResponse)
               }
               return output.data
           }
           .receive(on: DispatchQueue.main)
           .eraseToAnyPublisher()
   }

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
