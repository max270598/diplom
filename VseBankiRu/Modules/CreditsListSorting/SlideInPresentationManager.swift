//
//  SlideInPresentationManager.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/6/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {

    var direction: PresentationDirection = .bottom
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(
      forPresented presented: UIViewController,
      presenting: UIViewController?,
      source: UIViewController
    ) -> UIPresentationController? {
      let presentationController = CreditsListSortingViewController(
        presentedViewController: presented,
        presenting: presenting,
        direction: direction
      )
      return presentationController
    }

}
