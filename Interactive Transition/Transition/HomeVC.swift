//
//  HomeVC.swift
//  Transition
//
//  Created by yunneng on 2016/11/17.
//  Copyright © 2016年 zyh. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    //step.5
    //初始化自定义转场动画协议对象
    let transitionHelper = MenuTransitionHepler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //step.6
        //设置转场动画的fromVC
        self.transitionHelper.sourceViewController=self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //step.7
        //设置转场动画的toVC
        let menu = segue.destination as! MenuVC

        //step.8
        //设置transitioningDelegate为【自定义转场协议】
        menu.transitioningDelegate = self.transitionHelper
        
        self.transitionHelper.menuViewController = menu

    }
    
}
