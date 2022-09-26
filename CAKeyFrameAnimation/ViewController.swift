//
//  ViewController.swift
//  CAKeyFrameAnimation
//
//  Created by Mitya Kim on 9/26/22.
//

import UIKit

class ViewController: UIViewController {

    let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    let image: UIImageView = UIImageView(image: UIImage(named: "1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = view.frame
        image.contentMode = .scaleAspectFit
        
        view.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = view.frame
        blurView.alpha = 0.5
        blurView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        setupCAKeyFrame()
        
        
        perform(#selector(shake), with: nil, afterDelay: 3)
    }
    
    @objc fileprivate func shake() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: -20, y: -20),
            CGPoint(x: 20, y: 20),
            CGPoint(x: 0, y: 0),
        ]
        animation.isAdditive = true
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 2
        animation.repeatCount = 20
        blurView.layer.add(animation, forKey: "shakeAnimation")
    }
    
    fileprivate func setupCAKeyFrame() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [0.5, 1, 0.5, 0.75]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 2
        blurView.layer.add(animation, forKey: "scale")
        
        
        let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorAnimation.values = [UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.systemPink.cgColor]
        colorAnimation.keyTimes = [0, 0.5, 1]
        colorAnimation.duration = 2
        blurView.layer.add(colorAnimation, forKey: "colorAnimation")
        
    }
}

