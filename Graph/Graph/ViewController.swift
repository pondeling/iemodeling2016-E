//
//  ViewController.swift
//  Graph
//
//  Created by Yuta Miyagi on 2017/01/05.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.setupPoints(points: [10,10,1,10,2,4,5,2,7,8,6,5,1])
    }
}
