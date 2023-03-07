//
//  UIViewController+Add.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import UIKit

extension UIViewController {

    func add(_ child: UIViewController?,
             to container: UIView,
             frame: CGRect? = nil) {
        guard let child = child else {
            return
        }

        addChild(child)
        
        container.addSubview(child.view)

        child.view.clipsToBounds = true
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.frame = frame ?? safeAreaBounds()
        
        child.didMove(toParent: self)
    }

    func safeAreaBounds() -> CGRect {
        let safeAreaHeight = view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        return CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: safeAreaHeight)
    }
}
