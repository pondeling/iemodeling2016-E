//
//  map.swift
//  PondelingApp
//
//  Created by 上原優里奈 on 2017/01/05.
//  Copyright © 2017年 上原優里奈. All rights reserved.

//test comment
//test comment



import UIKit
//マップ
import MapKit
//加速度
import CoreMotion

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    //マップ
    @IBOutlet weak var testMapView: MKMapView!
    
    //加速度
//    @IBOutlet weak var XLabel: UILabel!
//    @IBOutlet weak var YLabel: UILabel!
//    @IBOutlet weak var ZLabel: UILabel!
//    @IBOutlet weak var GLabel: UILabel!
//    @IBOutlet weak var HLabel: UILabel!
    @IBOutlet weak var hyoukalabel: UILabel!


    //仮配列
    //加速度，躍度を入れる配列
    var lastG : Float = 0;
    var lastH : Float = 0;
    var YG : Float = 0;
    var YH : Float = 0;
    var G : [Float] = [];
    var H : [Float] = [];
    var yankG : [Float] = [];
    var yankH : [Float] = [];

    
    
    
    var myMotionManager: CMMotionManager!
    
    
    
    //マップ
    var testManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //テスト
        //変数宣言letは不変、varは可変
        var a = 1
        
        
        
        //デリゲート先を自分に設定する。
        testManager.delegate = self
        
        //位置情報の利用許可を変更する画面をポップアップ表示する。
        testManager.requestWhenInUseAuthorization()
        
        //位置情報の取得を要求する。
        testManager.requestLocation()
        
        
        
        //加速度
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
//            self.XLabel.text = "x=\(data.acceleration.x)"
//            self.YLabel.text = "y=\(data.acceleration.y)"
//            self.ZLabel.text = "z=\(data.acceleration.z)"
        
            //main.swift add
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
            
            //垂直方向の値を配列に入れる
            self.G.append(Float(findPresentGravitationalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ)))
            
            //水平方向の値を配列に入れる
            self.H.append(Float(findPresentHorizonalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ)))
            
            
            //垂直方向の躍度の躍度の計算
            self.YG = self.lastG - findPresentGravitationalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ);
            
            self.lastG = findPresentGravitationalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ);
            
            //垂直方向の躍度の値を配列に入れる
            self.yankG.append(self.YG)
            
            
            //水平方向の躍度の計算
            self.YH = self.lastH - findPresentHorizonalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ);
            
            self.lastH = findPresentHorizonalVector(presentX: presX,presentY: presY,presentZ: presZ,basisX: bX,basisY: bY,basisZ: bZ);
            
            //水平方向の躍度の値を配列に入れている
            self.yankH.append(self.YG)
            
            //良いか悪いかの判定
            if(data.acceleration.x<0.1){
                a=1
            }else{
                a=0
            }
            
            if(a == 1){
                self.hyoukalabel.text="もっと安全運転をしよう、、、"
            }else{
                self.hyoukalabel.text="いい感じ！"
            }
            
        })
        
        
    }
    
    
    //マップ
    //位置情報取得時の呼び出しメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        for location in locations {
            //現在位置をマップの中心にして登録する。
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake(center, span)
            testMapView.setRegion(region, animated:true)
        }
    }
    
    
    
    //位置情報取得失敗時の呼び出しメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    //ストップボタンを押した時の処理
    @IBAction func stopButton(_ sender: Any) {
        //userDefaults
        let userDefaults = UserDefaults.standard
        //配列保存
        userDefaults.set(yankH, forKey: "Key")
        userDefaults.synchronize()
        
        
        
        //画面遷移
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "graph" ) 
        self.present( targetViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
}




