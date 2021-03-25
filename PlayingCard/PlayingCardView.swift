//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by bogdanov on 25.03.21.
//

import UIKit

class PlayingCardView: UIView {
    override func draw(_ rect: CGRect) {
//        if let context  = UIGraphicsGetCurrentContext() {
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            context.setLineWidth(5.0)
//            UIColor.red.setStroke()
//            UIColor.green.setFill()
//            context.strokePath()
//            context.fillPath()
//        }
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        path.lineWidth = 5.0 
        UIColor.red.setStroke()
        UIColor.green.setFill()
        path.stroke()
        path.fill()
    }
}
