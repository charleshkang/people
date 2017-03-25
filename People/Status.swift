//
//  Status.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(RequestError)
    
}

enum SuccessStatusCode: Int {
    case OK = 200
    case Created = 201
    
}

enum RequestError: Error {
    case InvalidQuery
    case NoContent
    case NotFound
    case MethodNotAllowed
    case UnexpectedError
    
    init(code: Int) {
        switch code {
        case 204: self = .NoContent
        case 404: self = .NotFound
        case 405: self = .MethodNotAllowed
        default: self = .UnexpectedError
        }
    }
    
}
