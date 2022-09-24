//
//  ViewController.swift
//  TwitterAnimation
//
//  Created by Mitya Kim on 9/21/22.
//

import UIKit

class ViewController: UIViewController {
    
    // twitter animation
    let image: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "tile00")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var spriteImages = [UIImage]()
    
    // basic animation
    let basicView = UIView()
    var yAnchor:NSLayoutConstraint!
    var xAnchor:NSLayoutConstraint!
    var widthAnchor:NSLayoutConstraint!
    var heightAnchor:NSLayoutConstraint!
    
    // animatedButton
    let animatedButton = AnimatedButton(title: "Animations")
    
    let animatedButton2 = AnimatedButton2(title: "Animations2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterAnimation()
        
        layoutButton()
        
        basicView.backgroundColor = .blue
        basicView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(basicView)
        
        yAnchor = basicView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        yAnchor.isActive = true
        
        xAnchor = basicView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        xAnchor.isActive = true
        basicView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        heightAnchor = basicView.heightAnchor.constraint(equalToConstant: 200)
        heightAnchor.isActive = true
        
        widthAnchor = basicView.widthAnchor.constraint(equalToConstant: 200)
        widthAnchor.isActive = true
        
        
        perform(#selector(animateBox), with: nil, afterDelay: 1)
        
        basicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOnTap)))
        
    }
    
    // twitter animation
    func twitterAnimation() {
        view.addSubview(image)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        for i in 0..<29 {
            spriteImages.append(UIImage(named: "tile0\(i)")!)
        }
    }
    
    @objc func animate() {
        image.animationImages = spriteImages
        image.animationDuration = 5
        image.animationRepeatCount = 1
        image.startAnimating()
    }
    
    // uiview animation
    @objc fileprivate func animateBox() {
        
        yAnchor.isActive = false
        yAnchor = basicView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        yAnchor.isActive = true
        
        widthAnchor.isActive = false
        widthAnchor = basicView.widthAnchor.constraint(equalToConstant: 300)
        widthAnchor.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    var tapped:Bool = false
    
    @objc func animateOnTap() {
        if tapped {
            widthAnchor.isActive = false
            widthAnchor = basicView.widthAnchor.constraint(equalToConstant: view.frame.width/2)
            widthAnchor.isActive = true
        } else {
            yAnchor.isActive = false
            yAnchor = basicView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200)
            yAnchor.isActive = true
            
            widthAnchor.isActive = false
            widthAnchor = basicView.widthAnchor.constraint(equalToConstant: view.frame.width - 20)
            widthAnchor.isActive = true
            
            heightAnchor.isActive = false
            heightAnchor = basicView.heightAnchor.constraint(equalToConstant: 200)
            heightAnchor.isActive = true
        }
        
        tapped = !tapped
        
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ViewController {
    // animated button
    func layoutButton() {
        view.addSubview(animatedButton)
        animatedButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animatedButton2)
        
        NSLayoutConstraint.activate([
            animatedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            animatedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animatedButton.widthAnchor.constraint(equalToConstant: 150),
            animatedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            animatedButton2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: animatedButton2.trailingAnchor, constant: 20)
        ])
    }
}
