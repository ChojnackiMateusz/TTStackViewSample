//
//  TTStackView.swift
//  TTStackViewSample
//
//  Created by Mateusz Chojnacki on 29/08/2017.
//  Copyright © 2017 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class TTStackView: UIStackView {
    
    private var TTButtons = [UIButton]()


    var title = ["a","b","c","d","e"]
    
    @IBInspectable var buttonsSize: CGSize = CGSize(width: 100.0, height: 30.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var buttonCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons(){
        
        for button in TTButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        TTButtons.removeAll()
        
        
        for i in 0..<buttonCount {
            
            let button = UIButton()
            button.setBackgroundImage(UIImage(color: .red), for: UIControlState.normal)
            button.setBackgroundImage(UIImage(color: .blue), for: UIControlState.selected)
            
            button.heightAnchor.constraint(equalToConstant: buttonsSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonsSize.width).isActive = true
            button.layer.cornerRadius = 16
            button.setTitle(title[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            
            button.addTarget(self, action: #selector(TTStackView.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            
            TTButtons.append(button)
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        print(button.titleLabel?.text)
    }
    
    
}


public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

