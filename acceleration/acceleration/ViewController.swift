//
//  ViewController.swift
//  acceleration
//
//  Created by 秋田海人 on 2016/12/13.
//  Copyright © 2016年 秋田海人. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation


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
        self.view.addSubview(myXLabel)
        
        let myYLabel: UILabel = UILabel()
        myYLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myYLabel.backgroundColor = UIColor.orange
        myYLabel.layer.masksToBounds = true
        myYLabel.layer.cornerRadius = 10.0
        myYLabel.textColor = UIColor.white
        myYLabel.shadowColor = UIColor.gray
        myYLabel.textAlignment = NSTextAlignment.center
        myYLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 280)
        self.view.addSubview(myYLabel)
        
        let myZLabel: UILabel = UILabel()
        myZLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myZLabel.backgroundColor = UIColor.red
        myZLabel.layer.masksToBounds = true
        myZLabel.layer.cornerRadius = 10.0
        myZLabel.textColor = UIColor.white
        myZLabel.shadowColor = UIColor.gray
        myZLabel.textAlignment = NSTextAlignment.center
        myZLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 360)
        self.view.addSubview(myZLabel)
        
        let XLabel: UILabel = UILabel()
        XLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        XLabel.backgroundColor = UIColor.red
        XLabel.layer.masksToBounds = true
        XLabel.layer.cornerRadius = 10.0
        XLabel.textColor = UIColor.white
        XLabel.shadowColor = UIColor.gray
        XLabel.textAlignment = NSTextAlignment.center
        XLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 440)
        self.view.addSubview(XLabel)
        
        
        
        //タイマー停止ボタンを作る.
        //let myButton = UIButton(frame: CGRect(x:0, y:0, width:200, height:50))
        //myButton.layer.masksToBounds = true
        //myButton.layer.cornerRadius = 20.0
        //myButton.backgroundColor = UIColor.blue
        //myButton.setTitle("Stop Timer", for: UIControlState.normal)
        //myButton.layer.position = CGPoint(x:self.view.center.x, y:self.view.center.y + 100)
        //myButton.addTarget(self, action: #selector(ViewController.onMyButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        //self.view.addSubview(myButton)
        
        
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyan
        
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
            
            var presX : Float = Float(data.acceleration.x);//get from accel code
            var presY : Float = Float(data.acceleration.y);//get from accel code
            var presZ : Float = Float(data.acceleration.z);//get from accel code
            var bX    : Float = 1;//get from accel code
            var bY    : Float = 0;//get from accel code
            var bZ    : Float = 0;//get from accel code
            
            var basisAbs : Float = 1;//must be calculated by "BasisAbsXYZ"
            
            
            func findPresentGravitationalVector(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) ->(Float){
                let presAbs = PresentAbsXYZ(presentX: presX, presentY: presY, presentZ: presZ)//present accel abs
                let presSubToBasis = presentSubToBasis(presentX: presentX, presentY: presentY, presentZ: presentZ, basisX: basisX, basisY: basisY, basisZ: basisZ)//present substruction to basis
                let gravitationalVector = (presAbs*presAbs-presSubToBasis*presSubToBasis+basisAbs*basisAbs)/(2*basisAbs)//ここに関しては計算した
                return gravitationalVector
            }
            
            func findPresentHorizonalVector(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) ->(Float){
                let presAbs = PresentAbsXYZ(presentX: presX, presentY: presY, presentZ: presZ)
                let gravVec = findPresentGravitationalVector(presentX: presX, presentY: presY, presentZ: presZ, basisX: bX, basisY: bY, basisZ: bZ)
                let horizonalVector = sqrtf(presAbs*presAbs-gravVec*gravVec)
                return horizonalVector
            }
            
            func PresentAbsXYZ(presentX:Float,presentY:Float,presentZ:Float) -> (Float){
                var abs : Float = 0
                abs = presentX*presentX+presentY*presentY+presentZ*presentZ
                abs = sqrtf(abs)
                return abs
            }
            
            func BasisAbsXYZ(basisX:Float,basisY:Float,basisZ:Float) -> (Float){
                var abs : Float = 0
                abs = basisX*basisX+basisY*basisY+basisZ*basisZ
                abs = sqrtf(abs)
                return abs
            }
            
            func presentSubToBasis(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) -> (Float){
                var abs : Float = 0;
                let subX = presentX-basisX;
                let subY = presentY-basisY;
                let subZ = presentZ-basisZ;
                abs = (subX*subX)+(subY*subY)+(subZ*subZ)
                abs = sqrtf(abs)
                return abs
            }
            
            XLabel.text = "X=\(findPresentGravitationalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ))"
            
        })
    }
    
    //func onMyButtonClick(sender : UIButton){
    
    //timerが動いてるなら.
    //  if  myMotionManager.isAccelerometerActive == true {
    
    //timerを破棄する.
    //    myMotionManager.stopAccelerometerUpdates()
    
    //ボタンのタイトル変更.
    //  sender.setTitle("Start Timer", for: UIControlState.normal)
    //}
    //else{
    
    //   myMotionManager = CMMotionManager()
    
    //ボタンのタイトル変更.
    // sender.setTitle("Stop Timer", for: UIControlState.normal)
    //}
    //}
}
