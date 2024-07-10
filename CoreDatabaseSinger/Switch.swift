//
//  Switch.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit

class CustomSwitch: UIControl {

    private var isOn = false
    private let backgroundView = UIView()
    private let circleView = UIView()
    private let leftIconImageView = UIImageView()
    private let rightIconImageView = UIImageView()
    
    private let switchWidth: CGFloat = 110
    private let switchHeight: CGFloat = 50
    private let circleSize: CGFloat = 40
    private let circleImageSize: CGFloat = 30

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.frame = CGRect(x: 0, y: 0, width: switchWidth, height: switchHeight)
        self.layer.cornerRadius = switchHeight / 2
        self.clipsToBounds = true
        
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = .orange
        addSubview(backgroundView)
        
        circleView.frame = CGRect(x: 5, y: 5, width: circleSize, height: circleSize)
        circleView.layer.cornerRadius = circleSize / 2
        circleView.backgroundColor = .white
        addSubview(circleView)
        
        leftIconImageView.frame = CGRect(x: 10, y: 10, width: circleImageSize, height: circleImageSize)
        leftIconImageView.image = UIImage(named: "instagramIcon")
        leftIconImageView.contentMode = .scaleAspectFit
        addSubview(leftIconImageView)
        
        rightIconImageView.frame = CGRect(x: switchWidth - circleImageSize - 10, y: 10, width: circleImageSize, height: circleImageSize)
        rightIconImageView.image = UIImage(named: "snapchatIcon")
        rightIconImageView.contentMode = .scaleAspectFit
        addSubview(rightIconImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSwitch))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleSwitch() {
        isOn.toggle()
        let newCirclePosition = isOn ? switchWidth - circleSize - 5 : 5
        UIView.animate(withDuration: 0.3) {
            self.circleView.frame.origin.x = newCirclePosition
            self.backgroundView.backgroundColor = self.isOn ? .orange : .orange
        }
        sendActions(for: .valueChanged)
    }
    
    func setOn(_ on: Bool, animated: Bool) {
        isOn = on
        let newCirclePosition = isOn ? switchWidth - circleSize - 5 : 5
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.x = newCirclePosition
                self.backgroundView.backgroundColor = self.isOn ? .yellow : .orange
            }
        } else {
            circleView.frame.origin.x = newCirclePosition
            backgroundView.backgroundColor = isOn ? .yellow : .orange
        }
    }
    
    var isSwitchOn: Bool {
        return isOn
    }
}

