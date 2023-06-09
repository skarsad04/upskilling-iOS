//
//  CustomLoader.swift
//  VinmoApp
//
//  Created by asif hussain on 3/20/23.
//

//import Foundation
//import UIKit
//class MRActivityIndicator: UIView {
//    static var shared = MRActivityIndicator()
//    private convenience init() {
//        self.init(frame: UIScreen.main.bounds)
//    }
//    
//    private var spinnerBehavior: UIDynamicItemBehavior?
//    private var animator: UIDynamicAnimator?
//    private var imageView: UIImageView?
//    private var loaderImageName = ""
//        
//    func show(with image: String = "activityLoader") {
//        loaderImageName = image
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
//            if self?.imageView == nil {
//                self?.setupView()
//                DispatchQueue.main.async {[weak self] in
//                    self?.showLoadingActivity()
//                }
//            }
//        }
//    }
//    
//    func hide() {
//        DispatchQueue.main.async {[weak self] in
//            self?.stopAnimation()
//        }
//    }
//    
//    private func setupView() {
//        center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
//        autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
//        
//        let theImage = UIImage(named: loaderImageName)
//        imageView = UIImageView(image: theImage)
//        imageView?.frame = CGRect(x: self.center.x - 20, y: self.center.y - 20, width: 40, height: 40)
//        
//        if let imageView = imageView {
//            self.spinnerBehavior = UIDynamicItemBehavior(items: [imageView])
//        }
//        animator = UIDynamicAnimator(referenceView: self)
//    }
//    
//    private func showLoadingActivity() {
//        if let imageView = imageView {
//            addSubview(imageView)
//            startAnimation()
//            let scene = UIApplication.shared.connectedScenes.first
//            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
//                sd.window?.addSubview(self)
//                self.isUserInteractionEnabled = false
//            }
//        }
//    }
//    
//    private func startAnimation() {
//        guard let imageView = imageView,
//              let spinnerBehavior = spinnerBehavior,
//              let animator = animator else { return }
//        if !animator.behaviors.contains(spinnerBehavior) {
//            spinnerBehavior.addAngularVelocity(5.0, for: imageView)
//            animator.addBehavior(spinnerBehavior)
//        }
//    }
//    
//    private func stopAnimation() {
//        animator?.removeAllBehaviors()
//        imageView?.removeFromSuperview()
//        imageView = nil
//        self.removeFromSuperview()
//        self.isUserInteractionEnabled = true
//    }
//}
