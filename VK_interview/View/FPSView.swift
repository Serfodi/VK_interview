//
//  FPSView.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 04.12.2024.
//

import UIKit

class FPSView: UIView {
    
    var label = UILabel(title: "foo", alignment: .center)
    
    private var lastTimestamp: TimeInterval = 0
    private var frameCount: Int = 0
    private var fps: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        backgroundColor = ColorAppearance.lightGray.withAlphaComponent(0.8)
        
        addSubview(label)
        label.edgesToSuperView(value: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startFPS() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateFPS), userInfo: nil, repeats: true)
        let displayLink = CADisplayLink(target: self, selector: #selector(trackFrame))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc private func trackFrame() {
        frameCount += 1
    }
    
    @objc private func updateFPS() {
        let currentTime = CACurrentMediaTime()
        
        if lastTimestamp > 0 {
            let elapsedTime = currentTime - lastTimestamp
            fps = Double(frameCount) / elapsedTime
            label.text = String(format: "FPS: %.2f", fps)
            frameCount = 0
        }
        
        lastTimestamp = currentTime
    }
    
    
}
