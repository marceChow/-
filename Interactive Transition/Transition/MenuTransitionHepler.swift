//
//  MenuTransitionHepler.swift
//  Transition
//
//  Created by yunneng on 2016/11/17.
//  Copyright © 2016年 zyh. All rights reserved.
//

import UIKit

//判断是presented还是dismiss
private var isInteractive = false
private var isPresenting  = false

class MenuTransitionHepler: UIPercentDrivenInteractiveTransition,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    //step.4
    //实现UIPercentDrivenInteractiveTransition交互切换协议
    //present切换启动手势
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    
    //present交互动画控制器
    var sourceViewController : UIViewController! {
        didSet{
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action: #selector(MenuTransitionHepler.handelOnStagePan(pan:)))
            self.enterPanGesture.edges=UIRectEdge.left
            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
            
        }
    }
    
    //present手势长度比率，控制动画进度
    func handelOnStagePan(pan:UIPanGestureRecognizer){
        
        let view_transition = pan.translation(in: pan.view!.superview)
        
        let d = view_transition.x / (pan.view?.bounds.width)! * 0.5
        
        
        print(d)
        
        switch pan.state {
        case UIGestureRecognizerState.began:
            isInteractive=true
            self.sourceViewController.performSegue(withIdentifier: "presentMenu", sender: self)
            
            break
        case UIGestureRecognizerState.changed:
            self.update(d)
            
            break
        default:
            isInteractive = false
            if(d > 0.2){
                self.finish()
            }
            else {
                self.cancel()
            }
            break
        }
        
    }
    
    //dismiss切换启动手势
    private var exitPanGesture: UIPanGestureRecognizer!
    
    //dismiss交互动画控制器
    var menuViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action:#selector(MenuTransitionHepler.handleOffstagePan(pan:)))
            self.menuViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    //dismiss手势长度比率，控制动画进度
    func handleOffstagePan(pan: UIPanGestureRecognizer){
        let view_transition = pan.translation(in: pan.view!)
        
        let d = view_transition.x / (pan.view?.bounds.width)! * -0.5
        
        switch pan.state {
        case UIGestureRecognizerState.began:
            isInteractive=true
            self.menuViewController.dismiss(animated: true, completion: nil)
            
            break
        case UIGestureRecognizerState.changed:
            self.update(d)
            
            break
        default:
            isInteractive = false
            if(d > 0.1){
                self.finish()
            }
            else {
                self.cancel()
            }
            break
        }
    }
    
}

//step.1
//UIViewControllerTransitioningDelegate代理方法
extension MenuTransitionHepler{
    //presented
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting=true
        return self
    }
    
    //dismissed
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting=false
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ? self : nil
    }
}

//step.2
//动画实现
extension MenuTransitionHepler{
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
    
    func setOffAnimationInteractive(menuVC: MenuVC){
        
        menuVC.view.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let offstageOffset  :CGFloat = -300
        
        menuVC.img_businessCar.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_businessCar.transform = self.offCGAffineTransform(amount: offstageOffset)
        
        menuVC.img_taxi.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_taxi.transform = self.offCGAffineTransform(amount: offstageOffset)
        
        menuVC.img_bus.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_bus.transform = self.offCGAffineTransform(amount: offstageOffset)
        
        menuVC.img_selfDrive.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_selfDrive.transform = self.offCGAffineTransform(amount: offstageOffset)
        
        menuVC.img_gasStation.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_gasStation.transform = self.offCGAffineTransform(amount: offstageOffset)
        
        menuVC.img_service.transform = self.offCGAffineTransform(amount: offstageOffset)
        menuVC.l_service.transform = self.offCGAffineTransform(amount: offstageOffset)
        
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

}

//step.3
//实现UIViewControllerAnimatedTransitioning代理方法
extension MenuTransitionHepler{
    
    //过场动画持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //过场动画实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        //需要presented到的vc对象
        let toVC=transitionContext.viewController(forKey: !isPresenting ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to)!
        
        let toView      = toVC.view
        
        //设置动画初始位置
        if isPresenting {
            if isInteractive {
                self.setOffAnimationInteractive(menuVC: toVC as! MenuVC)
                //                self.setOffAnimation(menuVC: toVC as! MenuVC)
            }else{
                self.setOffAnimation(menuVC: toVC as! MenuVC)
            }
        }
        
        container.addSubview(toView!)
        
        //动画时间
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveLinear, animations: {
            
            if isPresenting{
                //进行presented动画
                self.setOnAnimation(menuVC: toVC as! MenuVC)
                
            }else{
                //进行dismissed动画
                if isInteractive{
                    self.setOffAnimationInteractive(menuVC: toVC as! MenuVC)
                    //                    self.setOffAnimation(menuVC: toVC as! MenuVC)
                }else{
                    self.setOffAnimation(menuVC: toVC as! MenuVC)
                }
            }
            
        }, completion: {(finish:Bool) in
            
            if transitionContext.transitionWasCancelled{
                transitionContext.completeTransition(false)
            }else{
                //转场动画结束后需要调用此方法
                transitionContext.completeTransition(true)
            }
            
        })
        
    }

}



