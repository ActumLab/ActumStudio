//
//  UIImageView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView{
    func setImage(with url: String){
        print("URL STRING: \(url)")
        self.kf.indicatorType = .activity
        let tmp = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: tmp!) else {
            self.image = #imageLiteral(resourceName: "EmptyPhoto")
            return
        }
        print("URL: \(url)")
        self.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}
