//
//  File.swift
//  Spatial Measure Kit
//
//  Created by Rafał Sowa on 23/04/2018.
//  Copyright © 2018 ActumLab. All rights reserved.
//

import Foundation
import ARKit

extension ARCamera.TrackingState {
    var presentationString: String {
        switch self {
        case .notAvailable:
            return "TRACKING UNAVAILABLE"
        case .normal:
            return "normal"
        case .limited(let state):
            switch state {
            case .initializing:
                return "initializing"
            default:
                return "default"
            }
        }
    }
}


enum Message {
    case error(ARCamera.TrackingState)
    case arFail
    
    var description: String {
        switch self {
        case .error(let state):
            return state.presentationString
        case .arFail:
            return "Oops! Something went wrong. Click here now to start again: "
        }
    }
    
    
    var buttonIsNeeded: Bool {
        switch self {
        case let .error(state):
            switch state {
            case .limited(.excessiveMotion):
                return true
            case .limited(.insufficientFeatures):
                return true
            case .limited(.relocalizing):
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}
