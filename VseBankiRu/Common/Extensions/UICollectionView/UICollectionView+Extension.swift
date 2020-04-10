//
//  UICollectionView+Extension.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    // MARK: Detect center visible cell
    var visibleIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
}
