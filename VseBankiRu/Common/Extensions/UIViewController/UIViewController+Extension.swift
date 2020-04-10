//
//  UIViewController+DrawerShadow.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Foundation


// MARK: Add Shadow for Drawer
extension UIViewController {
    
    // MARK: Set Notifications
    func registerShadowNotifications(notificationName: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(addShadow), name: Notification.Name(notificationName + "addShadow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeShadow), name: Notification.Name(notificationName + "removeShadow"), object: nil)
    }
    // FIXME: Убрать sender, после замены Pulley
    @objc func addShadow() { //_ sender: Any? = nil, view: UIView? = nil) {
        let shadowBlurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        shadowBlurVisualEffectView.alpha = 0.2
        shadowBlurVisualEffectView.frame = view.bounds
        self.view.addSubview(shadowBlurVisualEffectView)
    }
    // FIXME: Убрать sender, после замены Pulley
    @objc func removeShadow() { // _ sender: Any? = nil, view: UIView? = nil) {
        for childView in self.view.subviews {
            guard let effectView = childView as? UIVisualEffectView else { continue }
            effectView.removeFromSuperview()
        }
    }
}


// Hide Keyboard Gesture
extension UIViewController {
    
    func hideKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Get Status Bar Height
extension UIViewController {
    
    var statusBarHeight: CGFloat {
        
        var height: CGFloat = 0.0
        
        if #available(iOS 13, *) {
            height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }
        
        return height
    }
}

// MARK: Share Links
extension UIViewController {
    
    func shareLinkController(urlString: String, sourceView: UIView) -> UIActivityViewController? {
        
        guard let shareLink = URL(string: urlString) else { return nil }
        
        let objectsToShare = [shareLink] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        // Excluded Activities
        activityVC.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.addToReadingList
        ]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.popoverPresentationController?.permittedArrowDirections = [
                UIPopoverArrowDirection.down,
                UIPopoverArrowDirection.up
            ]
        }
        
        activityVC.popoverPresentationController?.sourceView = sourceView
        
        return activityVC
    }
}
