//
//  ViewController.swift
//  TwitterAnimation
//
//  Created by Mitya Kim on 9/21/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    // view property animator
    let animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: nil)
    
    let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    
    let slider = UISlider()
    
    // twitter animation
    let image: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "tile00")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var spriteImages = [UIImage]()
    
    // bluer image animation
    let image2: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // basic animation
    let basicView = UIView()
    var yAnchor:NSLayoutConstraint!
    var xAnchor:NSLayoutConstraint!
    var widthAnchor:NSLayoutConstraint!
    var heightAnchor:NSLayoutConstraint!
    
    // animatedButton
    let animatedButton = AnimatedButton(title: "Animations")
    
    let animatedButton2 = AnimatedButton2(title: "Animations2")
    
    let box = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view property animator
        view.backgroundColor = .yellow
        imageBluerAnimation2()
        
        setupCABasic()
        setupCAGradientLayer()
        layoutSlider()
        
        animator.addAnimations {
            self.view.backgroundColor = .white
        }
        
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .allEvents)
        // twitter animation
        twitterAnimation()
        
        // animated button
        layoutButton()
        
        basicView.backgroundColor = .blue
        basicView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(basicView)
        
        yAnchor = basicView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        yAnchor.isActive = true
        
        xAnchor = basicView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        xAnchor.isActive = true
        basicView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        heightAnchor = basicView.heightAnchor.constraint(equalToConstant: 100)
        heightAnchor.isActive = true
        
        widthAnchor = basicView.widthAnchor.constraint(equalToConstant: 100)
        widthAnchor.isActive = true
        
        
        perform(#selector(animateBox), with: nil, afterDelay: 1)
        
        basicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOnTap)))
        
        view.addSubview(box)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.backgroundColor = .red
        NSLayoutConstraint.activate([
            box.topAnchor.constraint(equalToSystemSpacingBelow: slider.bottomAnchor, multiplier: 1),
            box.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            box.heightAnchor.constraint(equalToConstant: 100),
            box.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        perform(#selector(self.animateBox2), with: nil, afterDelay: 1)
    }
    
    
    fileprivate func setupCAGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = blurView.frame
        gradient.colors = [UIColor.cyan.cgColor, UIColor.orange.cgColor]
        
        blurView.layer.addSublayer(gradient)
    }
    
    // twitter animation
    fileprivate func twitterAnimation() {
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
    
    fileprivate func imageBluerAnimation2() {
        view.addSubview(image2)
        view.addSubview(blurView)
        
        blurView.frame = view.frame
        
        self.blurView.alpha = 0.1
        
        image.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            image2.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            image2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image2.heightAnchor.constraint(equalToConstant: 300),
            image2.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        animator.addAnimations {
            self.blurView.alpha = 1
            self.image2.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    @objc fileprivate func animate() {
        image.animationImages = spriteImages
        image.animationDuration = 1
        image.animationRepeatCount = 1
        image.startAnimating()
    }
    
    // uiview animation
    @objc fileprivate func animateBox() {
        
        yAnchor.isActive = false
        yAnchor = basicView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        yAnchor.isActive = true
        
        widthAnchor.isActive = false
        widthAnchor = basicView.widthAnchor.constraint(equalToConstant: 150)
        widthAnchor.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    @objc fileprivate func animateBox2() {
        UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: 1.6, y: 1.6)
            transform = transform.translatedBy(x: 10, y: 20)
            transform = transform.rotated(by: 90)
            
            self.box.transform = transform
        }
    }
    
    fileprivate func setupCABasic() {
        let basic0 = CABasicAnimation(keyPath: "transform.scale")
        basic0.toValue = 2
        basic0.duration = 2
        
        basic0.fillMode = CAMediaTimingFillMode.forwards
        basic0.isRemovedOnCompletion = false
        
        image2.layer.add(basic0, forKey: nil)
        
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        
        springAnimation.fromValue = 0
        springAnimation.toValue = 1
        springAnimation.damping = 5
        springAnimation.mass = 5
        springAnimation.duration = 10
        
        image2.layer.add(springAnimation, forKey: nil)
    }
    
    fileprivate var tapped:Bool = false
    
    @objc fileprivate func animateOnTap() {
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
    fileprivate func layoutButton() {
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

extension ViewController {
    fileprivate func layoutSlider() {
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 8)
        ])
    }
    
    @objc fileprivate func handleSliderChanged(slide: UISlider) {
        animator.fractionComplete = CGFloat(slide.value)
    }
}
