//
//  LiveXibView.swift
//  Xcode Live Rendering
//
//  Created by Morten Bøgh on 22/07/14.
//  Copyright (c) 2014 Morten Bøgh. All rights reserved.
//

import UIKit

@IBDesignable
class LiveXibView: UIView {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    private var view: LiveXibView?
    
    @IBInspectable public var title: String = "" {
        didSet {
            if let optionalView = view {
                optionalView.titleLabel.text = title
            }
            else {
                self.titleLabel.text = title
            }
        }
    }
    
    @IBInspectable public var avatarImage: UIImage = UIImage() {
        didSet {
            let size = self.avatarImage.size
            let rect = CGRectMake(0, 0, size.width, size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
            var path = UIBezierPath(ovalInRect: rect)
            path.addClip()
            avatarImage.drawInRect(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            if let optionalView = view {
                optionalView.avatarImageView.image = image
            }
            else {
                self.avatarImageView.image = image
            }
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        var view = self.loadNib()
        view.frame = self.bounds
        view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.view = view
        self.addSubview(self.view)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func awakeAfterUsingCoder(aDecoder: NSCoder!) -> AnyObject! {
        if self.subviews.count == 0 {
            var view = self.loadNib()
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
            let contraints = self.constraints()
            self.removeConstraints(contraints)
            view.addConstraints(contraints)
            return view
        }
        return self
    }
    
    private func loadNib() -> LiveXibView {
        var bundle = NSBundle(forClass: self.dynamicType)
        var view = bundle.loadNibNamed("LiveXibView", owner: nil, options: nil)[0] as LiveXibView
        return view
    }
}