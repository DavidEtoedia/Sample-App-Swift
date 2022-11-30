////
////  network_manager.swift
////  Sample-App-Swift
////
////  Created by Inyene Etoedia on 18/11/2022.
////
//
//import Foundation
//import Combine
//
//
//
//
//class PhotoService {
//    
//    
//    @Published var photos : [PhotoStruct] = []
//    @Published var photosDetails : PhotoDetails?
//    private let dataService : NetworkService
//    var photoSubscription : AnyCancellable?
//    
//    init(dataService: NetworkService) {
//        self.dataService = dataService
////        fetchPhotos()
//      }
//
//    private func fetchPhotos(){
//        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo") else {return}
//        photoSubscription =  dataService.getPhotos(url: url)
//            .decode(type: [PhotoStruct].self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion {
//                case .finished:
//                 print("COMPLETED")
//                case .failure(let error):
//                 print("Failed: \(error.localizedDescription)")
//                }
//  
//            } receiveValue: { [weak self] returnedValue in
//                self?.photos = returnedValue
//                self?.photoSubscription?.cancel()
//            }
//
//    }
//    
//    private func photoDetails(id: String = ""){
//        guard let url = URL(string: "https://api.unsplash.com/photos/\(id)?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo") else {return}
//        photoSubscription =  dataService.getPhotos(url: url)
//            .decode(type: PhotoDetails.self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion {
//                case .finished:
//                 print("COMPLETED IN Details")
//                case .failure(let error):
//                 print("Failed: \(error.localizedDescription)")
//                }
//                
//                
//            } receiveValue: { [weak self] returnedValue in
//                self?.photosDetails = returnedValue
//                self?.photoSubscription?.cancel()
//            }
//
//    }
//    
//    
//    
//}
