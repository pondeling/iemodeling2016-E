//
//  GraphViewController.swift
//  Graph
//
//  Created by Yuta Miyagi on 2017/01/05.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//


import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UserDefaults
        let userDefaults = UserDefaults.standard
        let array = userDefaults.object(forKey: "Key")
        print(array)
        
        
        graphView.setupPoints(points: [10,10,1,10,30,50])
        

    }
}
