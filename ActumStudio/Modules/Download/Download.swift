//
//  Download.swift
//  House360
//
//  Created by Rafał Sowa on 11.10.2017.
//  Copyright © 2017 ActumLab. All rights reserved.
//

import Foundation

class Download {
    var file: File
    
    init(file: File) {
        self.file = file
    }
    //Download service
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    //Download delegate
    var progress: Float = 0
}
