//
//  dd.swift
//  Mikomax
//
//  Created by Rafał Sowa on 11/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

/*
 PassthroughView is a subclass of UIView and override the default hitTest behavior.
 This class allows a view to be a passthrough view.
**/
class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
