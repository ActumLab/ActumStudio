//
//  AppError.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
/// The protocol that helps to show the error in the alert
protocol AppError: Error {
    var title: String { get }
    var description: String { get }
}
