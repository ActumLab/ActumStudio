//
//  ApiError.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
enum ApiError: AppError {
    case netowrkIsUnreachable
    case server
    case message(String)
    
    var title: String {
        switch self {
        case .netowrkIsUnreachable:
            return "Network is unreachable"
        case .server:
            return "Something went wrong."
        case .message(_):
            return "Error"
        }
    }
    
    var description: String {
        switch self {
        case let .message(msg):
            return msg
        default:
            return ""
        }
    }
}
