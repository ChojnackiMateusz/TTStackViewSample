//
//  TTStackView.swift
//  TTStackViewSample
//
//  Created by Mateusz Chojnacki on 29/08/2017.
//  Copyright © 2017 Mateusz Chojnacki. All rights reserved.
//

import UIKit


protocol TTStackViewDelegate {
    func buttonsData(data: [UIButton])
}


class TTStackView: UIStackView {
    var delegate: TTStackViewDelegate? = nil
    
    private var TTButtons = [UIButton]()
    
    
    var title = [String]()
    
    @IBInspectable var buttonsSize: CGSize = CGSize(width: 100.0, height: 30.0) {
        didSet {
            setupButtons()
        }
    }
    
    
    var customSelectedButton = Bool()
    @IBInspectable var CustomSelected: Bool = false{
        didSet {
            customSelectedButton = CustomSelected
            setupButtons()
        }
    }
    
    
    private var internalTextArray: [String]?
    
    @IBInspectable var segments: String = "" {
        didSet {
            internalTextArray = segments.components(separatedBy: "\n")
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
        
        let buttonCount = internalTextArray?.count
        if(buttonCount == nil){
            return
        }
        for i in 0..<internalTextArray!.count {
            
            let button = UIButton()
            button.setBackgroundImage(UIImage(color: .red), for: UIControlState.normal)
            button.setBackgroundImage(UIImage(color: .blue), for: UIControlState.selected)
            
            button.heightAnchor.constraint(equalToConstant: buttonsSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonsSize.width).isActive = true
            button.layer.cornerRadius = 16
            button.setTitle(internalTextArray![i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            
            button.addTarget(self, action: #selector(TTStackView.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            TTButtons.append(button)
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        if customSelectedButton == false{
            guard let index = TTButtons.index(of: button) else {
                fatalError("error")
            }
            for i in 0..<TTButtons.count{
                TTButtons[i].isSelected = false
            }
            TTButtons[index].isSelected = !TTButtons[index].isSelected
        
        }else if customSelectedButton == true{
            guard let index = TTButtons.index(of: button) else {
                fatalError("error")
            }
            if(index == 0){
                TTButtons[0].isSelected = !TTButtons[1].isSelected
                TTButtons[1].isSelected = false
                TTButtons[2].isSelected = false
            }else if(index == 1){
                TTButtons[0].isSelected = false
                TTButtons[1].isSelected = !TTButtons[index].isSelected
            }else if(index == 2){
                TTButtons[0].isSelected = false
                TTButtons[2].isSelected = !TTButtons[index].isSelected
            }else if(TTButtons[0].isSelected == false && TTButtons[1].isSelected == false && TTButtons[2].isSelected == false ){
                TTButtons[0].isSelected = true
            }
        }
        
        delegate?.buttonsData(data: TTButtons)
        
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


