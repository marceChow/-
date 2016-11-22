//
//  MenuVC.swift
//  Transition
//
//  Created by yunneng on 2016/11/17.
//  Copyright © 2016年 zyh. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet var img_businessCar: UIImageView!
    @IBOutlet var l_businessCar: UILabel!
    
    @IBOutlet var img_taxi: UIImageView!
    @IBOutlet var l_taxi: UILabel!
    
    @IBOutlet var img_bus: UIImageView!
    @IBOutlet var l_bus: UILabel!
    
    @IBOutlet var img_selfDrive: UIImageView!
    @IBOutlet var l_selfDrive: UILabel!
    
    @IBOutlet var img_gasStation: UIImageView!
    @IBOutlet var l_gasStation: UILabel!
    
    @IBOutlet var img_service: UIImageView!
    @IBOutlet var l_service: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //返回
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }

}
