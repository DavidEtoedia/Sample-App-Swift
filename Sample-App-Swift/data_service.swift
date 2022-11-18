//
//  data_service.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 10/11/2022.
//

import SwiftUI
import Combine
import Foundation

//
//  data_service.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 10/11/2022.
//


struct PostModel : Identifiable, Codable {
    let id : Int
    let title : String
    let body : String
    
}

struct PhotoModel : Identifiable, Codable {
    let id : Int
    let title : String
    let body : String
    
}



class DataServiceViewModel : ObservableObject{
    @Published var post : [PostModel] = []
    @Published var photo : [PhotoStruct] = []
    @Published var loading : Bool = false
    private (set) var state: ResultState = .idle
    private let dataService = PhotoService(dataService: NetworkManager())
    var cancellables = Set<AnyCancellable>()
    
    init(){
     
          dIService()
        
    
//        wrappedFunction()
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnedValue in
//                if let data = returnedValue {
//                    guard let newPost = try? JSONDecoder().decode([PhotoStruct].self, from: data) else {return}
//                    DispatchQueue.main.async { [weak self] in
//                        self?.photo = newPost
//                        print(newPost)
//
//                    }
//                }
//
//            }
//            .store(in: &cancellables)
           
    }
    
    // FIRST METHOD TO FETCH DATA FROM THE INTERNET
    
    func getPost1(){
        loading = true
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard error == nil else{
                print("Error\(String(describing: error))")
                return
            }
            /// CHECKING FOR RESPONSE STATUS CODE
            guard let response = response as? HTTPURLResponse else{
                print("Invalid REsponse")
                return
            }
            
            if (response.statusCode == 200){
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data!) else {return}
                //                print("Success: \(String(describing: newPost))")
                DispatchQueue.main.async { [weak self] in
                    self?.post = newPost
                    self?.loading = false
                    }
            }
        }
        .resume()
    }
    
    
    
    // SECOND METHOD TO FETCH DATA FROM THE INTERNET
    
    func getPost2() {
        loading = true
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 else{
                print("An Error Occurred")
                return
            }
            guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
            //                print("Success: \(String(describing: newPost))")
            DispatchQueue.main.async { [weak self] in
                self?.post = newPost
                self?.loading = false
                
            }
        }
        .resume()
    }
    
    // THIRD METHOD USING ESCAPE
    
    func getPost3(completion: @escaping (_ data : [PostModel]) -> ()) {
        loading = true
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 else{
                print("An Error Occurred")
                /// IF THERE IS AN ERROR RETURN AN EMPTY LIST
                completion([])
                return
            }
            guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
            //
            DispatchQueue.main.async { [weak self] in
                completion(newPost)
                self?.loading = false
                
            }
        }
        .resume()
    }
    
    
    func fetchPost(){
        loading = true
        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo") else {return}
        genericHelper(url: url) { returnedValue in
            if let data = returnedValue {
                guard let newPost = try? JSONDecoder().decode([PhotoStruct].self, from: data) else {return}
                DispatchQueue.main.async { [weak self] in
                    self?.photo = newPost
                    self?.loading = false
                }
               }
        }
    }
    
    /// A GENERIC HELPER TO MAKE A REQUEST
    
    func genericHelper(url : URL, onCompletion: @escaping (_ data : Data?) -> ()) {
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 else{
                onCompletion(nil)
                return
            }
            print(response)
            onCompletion(data)
          }
        .resume()
        }
    
    
    // SECOND METHOD USING A FUTURE
    
    func fetchPost4(onCompletion: @escaping (_ data: Data?, _ error: Error?) -> ()){
        self.loading = true
        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 else{
                onCompletion(nil, error)
                self.loading = false
                return
            }
            DispatchQueue.main.async {[weak self] in
                onCompletion(data, nil)
                self?.loading = false
            }
          
          }
        .resume()
        
    }
    // WRAP THE FUNCTIONS IN A FUTURE
    
    func wrappedFunction() -> Future<Data?, Error>{
    
        Future { promise in
            self.fetchPost4 { data, error in
                if let error = error {
                    promise(.failure(error))
                } else{
                    promise(.success(data))
                }
                
            }
        }
    }
    
    
    
    func dIService(){
        self.loading = true
//        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo") else {return}
//
//        dataService.getPhotos(url: url)
//                    .sink { completion in
//                        switch completion {
//                        case .finished:
//                            print("fin")
//                        case .failure(let err):
//                            print("failed: \(err.localizedDescription)")
//
//                        }
//                    } receiveValue: { [weak self] returnedValue in
//                      print(returnedValue)
//                        self?.loading = false
//                    }
//                    .store(in: &cancellables)

        dataService.$photos
            .sink { completion in
                switch completion {
                case .finished:
                    print("fin")
                case .failure(let err):
                    print("failed: \(err.localizedDescription)")

                }
            } receiveValue: { [weak self] returnedValue in
                self?.photo = returnedValue
                self?.loading = false
            }
            .store(in: &cancellables)

        
        
    }
    
}

//struct data_service_Previews: PreviewProvider {
//    static var previews: some View {
//        data_service()
//    }
//}
