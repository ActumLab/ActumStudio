//
//  AlamoifreManagerWithSSL.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 14/05/2018.
//  Copyright © 2018 ActumLab. All rights reserved.
//

import Foundation
import Alamofire
import Moya

struct AlamoifreManagerWithSSL {
    static func getAlamofireManager() -> Manager {
        let pathToCert = Bundle.main.path(forResource: "actumstudio", ofType: "cer")
        let localCertificate:NSData = NSData(contentsOfFile: pathToCert!)!
        
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: [SecCertificateCreateWithData(nil, localCertificate)!],
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            "actumstudio.com": serverTrustPolicy
        ]
        
        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
    }
    
}
