//
//  DownloadInteractor.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class DownloadInteractor: NSObject, DownloadInteractorInput {
    
    // MARK: - Public
    
    weak var output: DownloadInteractorOutput!
    
    // MARK: - Private
    
    private let provider: MoyaProvider<ProductsApi>
    private var model: ModelAR?
    
    var downloadService = DownloadService()
    
    lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "coma.actumlab.actumstudio")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    let fileManager = FileManager.default
    
    
    
    required init(provider: MoyaProvider<ProductsApi>) {
        self.provider = provider
        super.init()
        
        downloadService.downloadSession = downloadSession

    }
    
    func fetchModels(for id: Int) {
        guard NetworkReachabilityManager()!.isReachable else {
            output.modelsFetchedFailed(error: .netowrkIsUnreachable)
            return
        }
        
        provider.request(.models(productId: id)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    let models = try response.map([ModelAR].self)
                    
                    guard let model = models.first else {
                        self?.output.modelsFetchedFailed(error: .server)
                        return
                    }
                    self?.model = model
                    
                    self?.startDownloadFileFor(urlString: model.objFile)
                    self?.startDownloadFileFor(urlString: model.mtlFile)

                    for texture in model.textures {
                        self?.startDownloadFileFor(urlString: texture.ambientOcclusion)
                        self?.startDownloadFileFor(urlString: texture.normal)
                        self?.startDownloadFileFor(urlString: texture.metalness)
                        self?.startDownloadFileFor(urlString: texture.diffuse)
                        self?.startDownloadFileFor(urlString: texture.roughness)
                    }
                    
                    if self?.downloadService.activeDownloads.count == 0 {
                         self?.output.modelsFetched(model)
                    }
                    
                } catch {
                    print(error)
                    self?.output.modelsFetchedFailed(error: .server)
                }
                
                break
            case let .failure(error):
                print("Error: \(error)")
                self?.output.modelsFetchedFailed(error: .server)
                break
            }
        }
        
    }
    
    func cancelFetching() {
        downloadService.downloadSession.invalidateAndCancel()
    }
    
    private  func startDownloadFileFor(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        if !fileManager.fileExists(atPath: localFilePath(for: url).path) {
            downloadService.startDownload(File(name: urlString))
        }
    }
}

extension DownloadInteractor: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
        
        downloadService.activeDownloads[sourceURL] = nil
        let destinationURL = localFilePath(for: sourceURL)
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        
        do{
            try fileManager.copyItem(at: location, to: destinationURL)
            print("Des: \(destinationURL)")
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        
        
        DispatchQueue.main.async { [weak self] in
//            let progress = "\(self?.downloadService.activeDownloads.count) from \(self?.downloadService.allDownloads)"
            self?.output.progressMessage("Downloading...")
        }
        
        if downloadService.activeDownloads.count == 0 {
            DispatchQueue.main.async { [weak self] in
                guard let model = self?.model else {
                    self?.output.modelsFetchedFailed(error: .server)
                    return
                }
                
                self?.output.modelsFetched(model)
            }
        }
    }
}

extension DownloadInteractor: URLSessionDelegate {
    
    // Standard background session handler
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
    
}

