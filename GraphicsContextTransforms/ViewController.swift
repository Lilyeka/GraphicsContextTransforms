//
//  ViewController.swift
//  GraphicsContextTransforms
//
//  Created by Лилия Левина on 29/05/2019.
//  Copyright © 2019 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initObjects()
    }
    
    func initObjects() {
        let myArrows = MyArrows()
        myArrows.frame = CGRect(x: 100, y: 100, width: 140, height: 140)
        view.addSubview(myArrows)
    }

}

