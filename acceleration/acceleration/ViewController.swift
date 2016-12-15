//
//  ViewController.swift
//  acceleration
//
//  Created by 秋田海人 on 2016/12/13.
//  Copyright © 2016年 秋田海人. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var myMotionManager: CMMotionManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Labelを作成.
        let myXLabel: UILabel = UILabel()
        myXLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myXLabel.backgroundColor = UIColor.blue
        myXLabel.layer.masksToBounds = true
        myXLabel.layer.cornerRadius = 10.0
        myXLabel.textColor = UIColor.white
        myXLabel.shadowColor = UIColor.gray
        myXLabel.textAlignment = NSTextAlignment.center
        myXLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        let myYLabel: UILabel = UILabel()
        myYLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myYLabel.backgroundColor = UIColor.orange
        myYLabel.layer.masksToBounds = true
        myYLabel.layer.cornerRadius = 10.0
        myYLabel.textColor = UIColor.white
        myYLabel.shadowColor = UIColor.gray
        myYLabel.textAlignment = NSTextAlignment.center
        myYLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 280)
        
        let myZLabel: UILabel = UILabel()
        myZLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myZLabel.backgroundColor = UIColor.red
        myZLabel.layer.masksToBounds = true
        myZLabel.layer.cornerRadius = 10.0
        myZLabel.textColor = UIColor.white
        myZLabel.shadowColor = UIColor.gray
        myZLabel.textAlignment = NSTextAlignment.center
        myZLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 360)
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyan
        
        // ViewにLabelを追加.
        self.view.addSubview(myXLabel)
        self.view.addSubview(myYLabel)
        self.view.addSubview(myZLabel)
        
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = 0.1
        
        // 加速度の取得を開始.
        myMotionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {(accelerometerData, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            guard let data = accelerometerData else {
                return
            }
            myXLabel.text = "x=\(data.acceleration.x)"
            myYLabel.text = "y=\(data.acceleration.y)"
            myZLabel.text = "z=\(data.acceleration.z)"
        })
    }
    
}
