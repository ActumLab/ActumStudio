//
//  String.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

extension String {
    func url() -> URL? {
        return URL(string: self)
    }
}
