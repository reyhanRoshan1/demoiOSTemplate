//
//  CampersClosetPageControl.swift
//  CampersCloset
//
//  Created by Surinder Kumar on 11/05/22.
//

import Foundation
import UIKit


class CampersClosetPageControl: UIPageControl {

@IBInspectable var currentPageImage: UIImage?

@IBInspectable var otherPagesImage: UIImage?

override var numberOfPages: Int {
    didSet {
        updateDots()
    }
}

override var currentPage: Int {
    didSet {
        updateDots()
    }
}

override func awakeFromNib() {
    super.awakeFromNib()
    pageIndicatorTintColor = .clear
    currentPageIndicatorTintColor = .clear
    clipsToBounds = false
}

private func updateDots() {

    for (index, subview) in subviews.enumerated() {
        let imageView: UIImageView
        if let existingImageview = getImageView(forSubview: subview) {
            imageView = existingImageview
        } else {
            imageView = UIImageView(image: otherPagesImage)

            imageView.center = subview.center
            subview.addSubview(imageView)
            subview.clipsToBounds = false
        }
        imageView.image = currentPage == index ? currentPageImage : otherPagesImage
    }
}

private func getImageView(forSubview view: UIView) -> UIImageView? {
    if let imageView = view as? UIImageView {
        return imageView
    } else {
        let view = view.subviews.first { (view) -> Bool in
            return view is UIImageView
        } as? UIImageView

        return view
    }
}
}

class DefaultPageControl: UIPageControl {

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
        updateDots()
    }

    private func updateDots() {
        let currentDot = subviews[currentPage]
        let largeScaling = CGAffineTransform(scaleX: 3.0, y: 3.0)
        let smallScaling = CGAffineTransform(scaleX: 1.0, y: 1.0)

        subviews.forEach {
            // Apply the large scale of newly selected dot.
            // Restore the small scale of previously selected dot.
            $0.transform = $0 == currentDot ? largeScaling : smallScaling
        }
    }

    override func updateConstraints() {
        super.updateConstraints()
        // We rewrite all the constraints
        rewriteConstraints()
    }

    private func rewriteConstraints() {
        let systemDotSize: CGFloat = 7.0
        let systemDotDistance: CGFloat = 16.0

        let halfCount = CGFloat(subviews.count) / 2
        subviews.enumerated().forEach {
            let dot = $0.element
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(dot.constraints)
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: systemDotSize),
                dot.heightAnchor.constraint(equalToConstant: systemDotSize),
                dot.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
                dot.centerXAnchor.constraint(equalTo: centerXAnchor, constant: systemDotDistance * (CGFloat($0.offset) - halfCount))
            ])
        }
    }
}
class CustomPageControl: UIPageControl {

@IBInspectable var currentPageImage: UIImage?

@IBInspectable var otherPagesImage: UIImage?

override var numberOfPages: Int {
    didSet {
        updateDots()
    }
}

override var currentPage: Int {
    didSet {
        updateDots()
    }
}

override func awakeFromNib() {
    super.awakeFromNib()
    if #available(iOS 14.0, *) {
        defaultConfigurationForiOS14AndAbove()
    } else {
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        clipsToBounds = false
    }
}

private func defaultConfigurationForiOS14AndAbove() {
    if #available(iOS 14.0, *) {
        for index in 0..<numberOfPages {
            let image = index == currentPage ? currentPageImage : otherPagesImage
            setIndicatorImage(image, forPage: index)
        }

        // give the same color as "otherPagesImage" color.
        pageIndicatorTintColor = .gray
        
        // give the same color as "currentPageImage" color.
        currentPageIndicatorTintColor = .red
        /*
         Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
        */
    }
}

private func updateDots() {
    if #available(iOS 14.0, *) {
        defaultConfigurationForiOS14AndAbove()
    } else {
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageview = getImageView(forSubview: subview) {
                imageView = existingImageview
            } else {
                imageView = UIImageView(image: otherPagesImage)
                
                imageView.center = subview.center
                subview.addSubview(imageView)
                subview.clipsToBounds = false
            }
            imageView.image = currentPage == index ? currentPageImage : otherPagesImage
        }
    }
}

private func getImageView(forSubview view: UIView) -> UIImageView? {
    if let imageView = view as? UIImageView {
        return imageView
    } else {
        let view = view.subviews.first { (view) -> Bool in
            return view is UIImageView
        } as? UIImageView

        return view
    }
}
}
