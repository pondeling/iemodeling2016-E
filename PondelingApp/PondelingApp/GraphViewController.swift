//
//  GraphViewController.swift
//  Graph
//
//  Created by Yuta Miyagi on 2017/01/05.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//


import UIKit

class GraphViewController: UIViewController {
    
   
    var i: [Float] = []
   
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.setupPoints(points: i)
    }
}
