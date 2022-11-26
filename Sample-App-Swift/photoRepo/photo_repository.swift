//
//  photo_repository.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 24/11/2022.
//

import Foundation
import Combine

protocol PhotoRepository {
    func getPhotos(pages : Int) -> AnyPublisher< Data, Error >
    func getDetails(_ id : String) -> AnyPublisher< Data, Error >
}


struct PhotoRepositoryImpl : PhotoRepository{
    var dataSource: PhotoDataSource
    func getDetails(_ id : String) -> AnyPublisher<Data, Error> {
        return dataSource.getDetails(id: id)
    }
    
  
    func getPhotos(pages : Int) -> AnyPublisher<Data, Error> {
        return dataSource.getPhotos(pages : pages)
    }
  
}

struct GetUseCase{
    var repo : PhotoRepository
    
    func getAllPhoto (pages : Int) ->  AnyPublisher<Data, Error>{
        return repo.getPhotos(pages : pages)
    }
    func getDetails (id: String ) ->  AnyPublisher<Data, Error>{
        return repo.getDetails(id)
    }
}

