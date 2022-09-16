//
//  BaseUseCase.swift
//  Catpedia (iOS)
//
//  Created by Celia on 10/9/22.
//

import Foundation

protocol BaseUseCase {
    associatedtype Input
    associatedtype Output
    
    func getData(requestModel: Input?, completion: @escaping (Result<Output, Error>) -> Void)
}

extension BaseUseCase {
    func getData(requestModel: Input? = nil, completion: @escaping (Result<Output, Error>) -> Void) {}
}
