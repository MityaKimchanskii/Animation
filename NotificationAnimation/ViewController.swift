//
//  ViewController.swift
//  NotificationAnimation
//
//  Created by Mitya Kim on 9/26/22.
//

import UIKit

extension UIView {
    func fetchCenter(animating: Bool) -> CGPoint {
        if animating, let presentation = layer.presentation() {
            return presentation.position
        }
        return center
    }
}

class ViewController: UIViewController {
    
    fileprivate let startingHeight: CGFloat = 150
    fileprivate let maxDragHeight: CGFloat = 150
    fileprivate let shapeLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate let leftThree = UIView()
    fileprivate let leftTwo = UIView()
    fileprivate let leftOne = UIView()
    fileprivate let centerZero = UIView()
    fileprivate let rightOne = UIView()
    fileprivate let rightTwo = UIView()
    fileprivate let rightThree = UIView()
    
    fileprivate lazy var views: [UIView] = [
        leftThree,
        leftTwo,
        leftOne,
        centerZero,
        rightOne,
        rightTwo,
        rightThree
    ]
    
    fileprivate var displayLink:CADisplayLink!
    fileprivate var animating = false {
        didSet {
            view.isUserInteractionEnabled = !animating
            displayLink.isPaused = !animating
        }
    }
    
    
    let button = ReusableButton(title: "Add To Cart")
    let notification = UIView()
    
    var notificationBottomAnchor:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupButton()
        setupNotification()
        
        
        shapeLayer.fillColor = UIColor.darkGray.cgColor
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.userIsDragging)))
        
        setupViewPoints()
        setupCADisplayLink()
    }
    
    fileprivate func setupButton() {
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        button.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
    }
    
    @objc fileprivate func handleAddToCart() {
        notificationBottomAnchor.constant = -15
//        notificationBottomAnchor.isActive = false
//        notificationBottomAnchor = notification.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
//        notificationBottomAnchor.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (complete) in
            if complete {
                self.notificationBottomAnchor.constant = 40
//                self.notificationBottomAnchor.isActive = false
//                self.notificationBottomAnchor = self.notification.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40)
//                self.notificationBottomAnchor.isActive = true
                UIView.animate(withDuration: 0.5, delay: 1.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    fileprivate func setupNotification() {
        let notiLabel = UILabel()
        notiLabel.translatesAutoresizingMaskIntoConstraints = false
        notiLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        notiLabel.textColor = .white
        notiLabel.text = "Added In App Purchase To Cart."
        
        view.addSubview(notification)
        notification.backgroundColor = .lightGray
        notification.translatesAutoresizingMaskIntoConstraints = false
        notification.heightAnchor.constraint(equalToConstant: 40).isActive = true
        notification.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        notificationBottomAnchor = notification.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40)
        notificationBottomAnchor.isActive = true
        
        notification.addSubview(notiLabel)
        notiLabel.leftAnchor.constraint(equalTo: notification.leftAnchor, constant: 20).isActive = true
        notiLabel.centerYAnchor.constraint(equalTo: notification.centerYAnchor).isActive = true
    }
    
    fileprivate func setupCADisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(generatePath))
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    }
    
    fileprivate func setupViewPoints() {
        views.forEach { (layoutViewPoint) in
            layoutViewPoint.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
//            layoutViewPoint.backgroundColor = .cyan
            view.addSubview(layoutViewPoint)
        }
        
        layoutViewPoints(minHeight: startingHeight, dragY: 0, dragX: view.frame.width/2)
        generatePath()
    }
    
    
    @objc fileprivate func generatePath() {
        let screenWidth = view.frame.width
        
        let leftThreeCenter = leftThree.fetchCenter(animating: animating)
        let leftTwoCenter = leftTwo.fetchCenter(animating: animating)
        let leftOneCenter = leftOne.fetchCenter(animating: animating)
        let centerZeroCenter = centerZero.fetchCenter(animating: animating)
        let rightOneCenter = rightOne.fetchCenter(animating: animating)
        let rightTwoCenter = rightTwo.fetchCenter(animating: animating)
        let rightThreeCenter = rightThree.fetchCenter(animating: animating)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: leftThreeCenter.y))
        bezierPath.addCurve(to: leftOneCenter, controlPoint1: leftThreeCenter, controlPoint2: leftTwoCenter)
        bezierPath.addCurve(to: rightOneCenter, controlPoint1: centerZeroCenter, controlPoint2: rightOneCenter)
        bezierPath.addCurve(to: rightThreeCenter, controlPoint1: rightOneCenter, controlPoint2: rightTwoCenter)
        bezierPath.addLine(to: CGPoint(x: screenWidth, y: 0))
        
        shapeLayer.path = bezierPath.cgPath
    }
    
    fileprivate func layoutViewPoints(minHeight: CGFloat, dragY: CGFloat, dragX: CGFloat) {
        let minX: CGFloat = 0
        let maxX: CGFloat = view.frame.width
        
        let leftPart = dragX - minX
        let rightPart = maxX - dragX
        
        leftThree.center = CGPoint(x: minX, y: minHeight)
        leftTwo.center = CGPoint(x: minX + (leftPart * 0.44), y: minHeight)
        leftOne.center = CGPoint(x: minX + (leftPart * 0.71), y: minHeight + (dragY * 0.64))
        centerZero.center = CGPoint(x: dragX, y: minHeight + (dragY * 1.36))
        rightOne.center = CGPoint(x: maxX - (rightPart * 0.71), y: minHeight + (dragY * 0.64))
        rightTwo.center = CGPoint(x: maxX - (rightPart * 0.44), y: minHeight)
        rightThree.center = CGPoint(x: maxX, y: minHeight)
    }
    
  
    @objc fileprivate func userIsDragging(gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended
            || gesture.state == .failed
            || gesture.state == .cancelled {
            animating = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.views.forEach({ (view) in
                    view.center.y = self.startingHeight
                })
            }) { (complete) in
                if complete {
                    self.animating = false
                }
            }
        } else {
            //            shapeLayer.frame.size.height = startingHeight + gesture.translation(in: self.view).y
            let dragHeight = gesture.translation(in: view).y
            
            let dragY = min(dragHeight * 0.5, maxDragHeight)
            let minimumHeight = startingHeight + dragHeight - dragY
            
            let dragX = gesture.location(in: view).x
            
            layoutViewPoints(minHeight: minimumHeight, dragY: dragY, dragX: dragX)
            generatePath()
        }
    }
}


