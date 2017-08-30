//
//  ViewController.swift
//  TTStackViewSample
//
//  Created by Mateusz Chojnacki on 29/08/2017.
//  Copyright © 2017 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TTStackViewDelegate {
    
    @IBOutlet var stackView: TTStackView?
    var buttonsVar = [UIButton]()
    func buttonsData(data: [UIButton]) {
        buttonsVar = data
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        stackView?.delegate = self
    }
    
    func printInfo(){
        for i in 0..<buttonsVar.count{
            print("button number \(i) is \(buttonsVar[i].isSelected)")
        }
    }

    @IBAction func printButtons(_ sender: Any) {
        printInfo()
    }
    
}

