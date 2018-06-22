//
//  DownloadService.swift
//  House360
//
//  Created by Rafał Sowa on 11.10.2017.
//  Copyright © 2017 ActumLab. All rights reserved.
//

import Foundation

class DownloadService {
    
    
    
    var downloadSession: URLSession!
    var activeDownloads: [URL: Download] = [:]
    var allDownloads = 0
//    init(session: URLSession) {
//        self.downloadSession = session
//    }
    
    func startDownload(_ file: File) {
        print("Start download file: \(file.name)")
        let download = Download(file: file)
        download.task = downloadSession.downloadTask(with: file.downloadURL)
        download.task!.resume()
        download.isDownloading = true
        
        allDownloads+=1
        activeDownloads[download.file.downloadURL] = download
        print("All downloads: \(allDownloads)")
        print("Active downloads \(activeDownloads.count)")
    }
    
    
}
