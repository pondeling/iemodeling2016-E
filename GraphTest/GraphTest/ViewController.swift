//
//  ViewController.swift
//  GraphTest
//
//  Created by Yuta Miyagi on 2017/02/21.
//  Copyright © 2017年 Ryukyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func Go(_ sender: Any) {
        performSegue(withIdentifier: "graph",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "graph") {

            var r: [Int] = []
            for _ in 0..<100 {
                r.append(Int(arc4random() % 4 + 1))
            }

            let vc2: ViewController2 = (segue.destination as? ViewController2)!
            // 値の転送
            vc2.i = r
        }
    }
}

