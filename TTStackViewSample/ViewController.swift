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
    var buttonsVar = [Bool](){
        didSet{
            printInfo()
        }
        
    }
    func buttonsData(data: [Bool]) {
        buttonsVar = data
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        stackView?.delegate = self
    }
    
    func printInfo(){
        for i in 0..<buttonsVar.count{
            print("button number \(i) is \(buttonsVar[i])")
        }
    }
}

