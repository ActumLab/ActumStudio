////
////  Blurabble.swift
////  Mikomax
////
////  Created by Rafał Sowa on 17/05/2018.
////  Copyright © 2018 Actum Lab. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//protocol Blurable
//{
//    var layer: CALayer { get }
//    var subviews: [UIView] { get }
//    var frame: CGRect { get }
//    var superview: UIView? { get }
//
//    func addSubview(view: UIView)
//    func removeFromSuperview()
//
//    func blur(blurRadius: CGFloat)
//    func unBlur()
//
//    var isBlurred: Bool { get }
//}
//
//extension Blurable
//{
//    func blur(blurRadius: CGFloat)
//    {
//        if self.superview == nil
//        {
//            return
//        }
//
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.width, height: frame.height), false, 1)
//
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext();
//
//        guard let blur = CIFilter(name: "CIGaussianBlur"),
//            let this = self as? UIView else
//        {
//            return
//        }
//
//        blur.setValue(CIImage(image: image!), forKey: kCIInputImageKey)
//        blur.setValue(blurRadius, forKey: kCIInputRadiusKey)
//
//        let ciContext  = CIContext(options: nil)
//
//        let result = blur.value(forKey: kCIOutputImageKey) as! CIImage?
//
//        let boundingRect = CGRect(x:0,
//                                  y: 0,
//                                  width: frame.width,
//                                  height: frame.height)
//
//        let cgImage = ciContext.createCGImage(result!, fromRect: boundingRect)
//
//        let filteredImage = UIImage(CGImage: cgImage)
//
//        let blurOverlay = BlurOverlay()
//        blurOverlay.frame = boundingRect
//
//        blurOverlay.image = filteredImage
//        blurOverlay.contentMode = UIViewContentMode.left
//
//        if let superview = superview as? UIStackView,
//            let index = (superview as UIStackView).arrangedSubviews.indexOf(this)
//        {
//            removeFromSuperview()
//            superview.insertArrangedSubview(blurOverlay, atIndex: index)
//        }
//        else
//        {
//            blurOverlay.frame.origin = frame.origin
//
//            UIView.transition(from: this,
//                              to: blurOverlay,
//                                      duration: 0.2,
//                                      options: UIViewAnimationOptions.curveEaseIn,
//                                      completion: nil)
//        }
//
//        objc_setAssociatedObject(this,
//                                 &BlurableKey.blurable,
//                                 blurOverlay,
//                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//    }
//
//    func unBlur()
//    {
//        guard let this = self as? UIView,
//            let blurOverlay = objc_getAssociatedObject(self as? UIView, &BlurableKey.blurable) as? BlurOverlay else
//        {
//            return
//        }
//
//        if let superview = blurOverlay.superview as? UIStackView,
//            let index = (blurOverlay.superview as! UIStackView).arrangedSubviews.indexOf(blurOverlay)
//        {
//            blurOverlay.removeFromSuperview()
//            superview.insertArrangedSubview(this, atIndex: index)
//        }
//        else
//        {
//            this.frame.origin = blurOverlay.frame.origin
//
//            UIView.transition(from: blurOverlay,
//                              to: this,
//                                      duration: 0.2,
//                                      options: UIViewAnimationOptions.curveEaseIn,
//                                      completion: nil)
//        }
//
//        objc_setAssociatedObject(this,
//                                 &BlurableKey.blurable,
//                                 nil,
//                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//    }
//
//    var isBlurred: Bool
//    {
//        return objc_getAssociatedObject(self as? UIView, &BlurableKey.blurable) is BlurOverlay
//    }
//}
//
//extension UIView: Blurable
//{
//}
//
//class BlurOverlay: UIImageView
//{
//}
//
//struct BlurableKey
//{
//    static var blurable = "blurable"
//}
