//
//  MCAnimateButton.swift
//  TwitterAnimation
//
//  Created by Mitya Kim on 9/23/22.
//

import Foundation
import UIKit

class AnimatedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(title: "Button")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(title: String) {
        layer.cornerRadius = 12
        backgroundColor = .green
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationForButton)))
        addTarget(self, action: #selector(downButton), for: .touchDown)
        addTarget(self, action: #selector(upButton), for: .touchUpInside)
    }
    
    @objc fileprivate func downButton() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc fileprivate func upButton() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.transform = .identity
        }
    }
}
