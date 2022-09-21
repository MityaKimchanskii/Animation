//
//  ViewController.swift
//  TwitterAnimation
//
//  Created by Mitya Kim on 9/21/22.
//

import UIKit

class ViewController: UIViewController {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "tile00")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    var spriteImages = [UIImage]()
    
    @objc func animate() {
        image.animationImages = spriteImages
        image.animationDuration = 0.6
        image.animationRepeatCount = 1
        image.startAnimating()
    }
}

