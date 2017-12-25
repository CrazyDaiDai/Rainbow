//
//  ViewController.swift
//  Rainbow
//
//  Created by 呆仔～林枫 on 2017/12/25.
//  Copyright © 2017年 最怕追求不凡,最后依然碌碌无为 - Crazy_Lin. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds.size

class ViewController: UIViewController {
    
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Crazy_Lin"
        creatProgress()
    }
    
    func creatProgress() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.updateProgress()
        }
    }
    
    lazy var progressLayer : CAGradientLayer = {
        
        let progressLayer = CAGradientLayer()
        progressLayer.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        progressLayer.startPoint = CGPoint(x: 0, y: 0)
        progressLayer.endPoint = CGPoint(x: 1, y: 1)
        /// colors
        var colors = [CGColor]()
        var hue = 0.0
        while hue <= 360 {
            let color = UIColor(hue: CGFloat(1.0 * hue / 360),
                                saturation: 1.0,
                                brightness: 1.0,
                                alpha: 1.0)
            colors.append(color.cgColor)
            hue += 5
        }
        progressLayer.colors = colors
        view.layer.addSublayer(progressLayer)
        return progressLayer
    }()
    
    func updateProgress() {
        
        var colorArr = progressLayer.colors
        let lastColor = colorArr?.last
        colorArr?.removeLast()
        colorArr?.insert(lastColor as Any, at: 0)
        progressLayer.colors = colorArr
        let  animation = CABasicAnimation(keyPath: "colors")
        animation.toValue = colorArr
        animation.duration = 0.1
        animation.fillMode = kCAFillModeForwards
        progressLayer.add(animation, forKey: "animation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
        print(timer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

