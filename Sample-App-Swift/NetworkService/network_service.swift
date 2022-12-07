//
//  network_manager.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation
import Combine

///
/// https://api.unsplash.com/search/photos?page=2&query=office&client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo
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
    
    static func getPhotos(_ path : String) -> URL? {
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
    
    static func search (_ path : String, query : String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/\(path)/photos/"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "client_id", value: ApiKey.apiKey.description),
        
        ]
        return components.url
    }
    
    static func request(_ url : URL, _ method : String) -> URL? {
        var request = URLRequest(url: url)
               request.httpMethod = method
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        return request.url
    }
    
   
}

// THIS IS FOR URLREQUEST PROTOCOL

extension URLRequest{
    static func urlRequest(_ url : URL, _ method : String) -> URLRequest? {
        var request = URLRequest(url: url)
               request.httpMethod = method
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        return request
    }

    
}




protocol NetworkService {
 func getPhotos(url: URL) -> AnyPublisher< Data, Error >
    
    }

protocol PhotoDataSource {
 func getPhotos(pages : Int) -> AnyPublisher< Data, Error >
 func getDetails(id : String) -> AnyPublisher< Data, Error >
 func search(search : String) -> AnyPublisher< Data, Error >
    
    }


struct PhotoDataSourceImpl : PhotoDataSource {
    func search(search: String) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: .request(.search("search", query: search)!, "GET")!)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getDetails(id : String) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: .request(.getPhotos("photos/\(id)")!, "GET")!)
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
    
    /// Using a Publisher
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



protocol NetworkHelperProtocol {
    func photoReq<T: Codable> (path : String, type : T.Type ) async throws -> T
    
    }

final class NetworkHelper : NetworkHelperProtocol{
    static let shared = NetworkHelper()

    private init(){}
    
    
    
    func photoReq<T: Codable> (path : String, type : T.Type ) async throws -> T{
        
        let (data, response) = try await URLSession.shared.data(for: .urlRequest(.paginated(path, pageNum: 3)!, "GET")! )
         guard let response  =  response as? HTTPURLResponse,
               (200...300) ~= response.statusCode else {
             let statusCode = (response as? HTTPURLResponse)?.statusCode
             throw ApiError.errorCode(statusCode ?? 0)
             
         }
        
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decode.decode(T.self, from: data)
        return res
        
        
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
