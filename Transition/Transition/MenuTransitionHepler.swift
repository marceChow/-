//
//  MenuTransitionHepler.swift
//  Transition
//
//  Created by yunneng on 2016/11/17.
//  Copyright © 2016年 zyh. All rights reserved.
//

import UIKit

class MenuTransitionHepler: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    private var isPresenting = false
    
    //实现UIViewControllerAnimatedTransitioning代理方法
    
    //过场动画持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //过场动画实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView

        let toVC=transitionContext.viewController(forKey: !self.isPresenting ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to)!
        
//        let fromVC=transitionContext.viewController(forKey: !self.isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from)!
        
//        let fromView    = fromVC.view
        let toView      = toVC.view
        
        //设置动画初始位置
        if self.isPresenting {
            self.setOffAnimation(menuVC: toVC as! MenuVC)
        }
        
        container.addSubview(toView!)
        
        let duration = self.transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveLinear, animations: {
            
            if self.isPresenting{
                self.setOnAnimation(menuVC: toVC as! MenuVC)

            }else{
                self.setOffAnimation(menuVC: toVC as! MenuVC)
            }
            
        }, completion: {(finish:Bool) in
            
            transitionContext.completeTransition(true)
            
        })
        

        
        

    }
    
    func offCGAffineTransform(amount:CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func setOffAnimation(menuVC:MenuVC){
        menuVC.view.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let topRowOffset  :CGFloat = 300
        let middleRowOffset :CGFloat = 150
        let bottomRowOffset  :CGFloat = 50
        
        menuVC.img_businessCar.transform = self.offCGAffineTransform(amount: -topRowOffset)
        menuVC.l_businessCar.transform = self.offCGAffineTransform(amount: -topRowOffset)
        
        menuVC.img_taxi.transform = self.offCGAffineTransform(amount: topRowOffset)
        menuVC.l_taxi.transform = self.offCGAffineTransform(amount: topRowOffset)
        
        menuVC.img_bus.transform = self.offCGAffineTransform(amount: -middleRowOffset)
        menuVC.l_bus.transform = self.offCGAffineTransform(amount: -middleRowOffset)
        
        menuVC.img_selfDrive.transform = self.offCGAffineTransform(amount: middleRowOffset)
        menuVC.l_selfDrive.transform = self.offCGAffineTransform(amount: middleRowOffset)
        
        menuVC.img_gasStation.transform = self.offCGAffineTransform(amount: -bottomRowOffset)
        menuVC.l_gasStation.transform = self.offCGAffineTransform(amount: -bottomRowOffset)
        
        menuVC.img_service.transform = self.offCGAffineTransform(amount: bottomRowOffset)
        menuVC.l_service.transform = self.offCGAffineTransform(amount: bottomRowOffset)
    }
    
    func setOnAnimation(menuVC:MenuVC){
        menuVC.view.alpha = 1
        
        menuVC.img_businessCar.transform = CGAffineTransform.identity
        menuVC.l_businessCar.transform = CGAffineTransform.identity
        
        menuVC.img_taxi.transform = CGAffineTransform.identity
        menuVC.l_taxi.transform = CGAffineTransform.identity
        
        menuVC.img_bus.transform = CGAffineTransform.identity
        menuVC.l_bus.transform = CGAffineTransform.identity
        
        menuVC.img_selfDrive.transform = CGAffineTransform.identity
        menuVC.l_selfDrive.transform = CGAffineTransform.identity
        
        menuVC.img_gasStation.transform = CGAffineTransform.identity
        menuVC.l_gasStation.transform = CGAffineTransform.identity
        
        menuVC.img_service.transform = CGAffineTransform.identity
        menuVC.l_service.transform = CGAffineTransform.identity
    }
    
    
    //UIViewControllerTransitioningDelegate代理方法
    //presented
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting=true
        return self
    }
    
    //dismissed
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting=false
        return self
    }
    
    
    
}
