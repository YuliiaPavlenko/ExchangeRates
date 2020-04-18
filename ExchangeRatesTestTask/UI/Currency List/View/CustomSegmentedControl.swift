//
//  CustomSegmentedControl.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 18/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

protocol CustomSegmentedControlDelegate: class {
    
    func changeToIndex(index: Int)
}

class CustomSegmentedControl: UIView {
    private var segments: [Segment]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex: Int = 0
    
    convenience init(frame: CGRect, segments: [Segment]) {
        self.init(frame: frame)
        self.segments = segments
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setIndex(index: Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(segments.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            
            if button == sender {
                let selectorPosition = frame.width/CGFloat(segments.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.changeToIndex(index: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

// MARK: Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButtons()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leftAnchor, bottom: nil, trailing: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.segments.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButtons() {
        buttons = [UIButton]()
        buttons.removeAll()
        
        subviews.forEach({$0.removeFromSuperview()})
        for segment in segments {
            let button = UIButton(type: .system)
            button.setTitle(segment.title, for: .normal)
            button.backgroundColor = segment.backgroundColor
            button.setTitleColor(textColor, for: .normal)
            
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
