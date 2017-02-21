//
//  ViewController.swift
//  Graph
//
//  Created by Yuta Miyagi on 2017/01/05.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//


import UIKit

class ViewController2: UIViewController {
    
    var i: [Int] = []
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        graphView.setupPoints(points: i)
    }
}
