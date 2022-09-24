//
//  AnimateButton2.swift
//  TwitterAnimation
//
//  Created by Mitya Kim on 9/23/22.
//

import Foundation
import UIKit

class AnimatedButton2: UIButton {
    
    fileprivate var wAnchor: NSLayoutConstraint?
    fileprivate var hAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(title: "Button")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        wAnchor = widthAnchor.constraint(equalToConstant: 150)
        wAnchor?.isActive = true
        
        hAnchor = heightAnchor.constraint(equalToConstant: 50)
        hAnchor?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(title: String) {
        layer.cornerRadius = 8
        backgroundColor = .brown
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        addTarget(self, action: #selector(downButton), for: .touchDown)
        addTarget(self, action: #selector(upButton), for: .touchUpInside)
    }
    
    @objc fileprivate func downButton() {
        
        wAnchor?.isActive = false
        hAnchor?.isActive = false
        
        wAnchor?.constant = 200
        hAnchor?.constant = 200
        
        wAnchor?.isActive = true
        hAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func upButton() {
        
        wAnchor?.isActive = false
        hAnchor?.isActive = false
        
        wAnchor?.constant = 150
        hAnchor?.constant = 50
        
        wAnchor?.isActive = true
        hAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.superview?.layoutIfNeeded()
        }
    }
}
