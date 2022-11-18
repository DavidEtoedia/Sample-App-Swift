//
//  result_state.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation

enum ResultState{
    case isLoading
    case idle
    case success
    case error(error: Error?)
}
