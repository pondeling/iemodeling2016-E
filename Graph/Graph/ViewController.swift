//
//  ViewController.swift
//  Graph
//
//  Created by Yuta Miyagi on 2017/01/05.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//

//test comment


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //配列で値を入れられたらいいな・・・・
//        var array = ["10","10","1","10","2","4","5","2","7","8","6","5","1"]
        
        graphView.setupPoints(points: [10,10,1,10,2,4,5,2,7,8,6,5,1])
//        graphView.setupPoints(points: [array])
    }
}
