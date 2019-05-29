//
//  MyArrows.swift
//  GraphicsContextTransforms
//
//  Created by Лилия Левина on 29/05/2019.
//  Copyright © 2019 Лилия Левина. All rights reserved.
//

import UIKit

class MyArrows: UIView {
    
    lazy var arrow: UIImage = {
        let r = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 100))
        return r.image(actions: { (_) in
            self.drawGradientArrowWithPatternUIKit()
        })
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        //drawWithoutShadow()
        drawWithShadow()
    }
    
    func  drawWithoutShadow() {
        let con = UIGraphicsGetCurrentContext()!
        self.arrow.draw(at: CGPoint(x: 0, y: 0))
        for _ in 0..<3 {
            con.translateBy(x: 20, y: 100)
            con.rotate(by: 30 * .pi/180.0)
            con.translateBy(x: -20, y: -100)
            self.arrow.draw(at: CGPoint(x: 0, y: 0))
        }
    }
    
    func drawWithShadow() {
        let con = UIGraphicsGetCurrentContext()!
        con.setShadow(offset: CGSize(width: 7, height: 7), blur: 12.0)
        //con.beginTransparencyLayer(auxiliaryInfo: nil)
        self.arrow.draw(at: CGPoint(x: 0, y: 0))
        for _ in 0..<3 {
            con.translateBy(x: 20, y: 100)
            con.rotate(by: 30 * .pi/180.0)
            con.translateBy(x: -20, y: -100)
            self.arrow.draw(at: CGPoint(x: 0, y: 0))
        }
        //con.endTransparencyLayer()
    }
    
    func drawGradientArrowWithPatternUIKit() {
        // obtain the current graphics context
        let con = UIGraphicsGetCurrentContext()!
        //punch triangular hole in context clipping region
        con.move(to: CGPoint(x: 10, y: 100))
        con.addLine(to: CGPoint(x: 20, y: 90))
        con.addLine(to: CGPoint(x: 30, y: 100))
        con.closePath()
        con.addRect(con.boundingBoxOfClipPath)
        con.clip(using: .evenOdd)
        // draw the vertical line, add its shape to the clipping region
        con.move(to: CGPoint(x: 20, y: 100))
        con.addLine(to: CGPoint(x: 20, y: 19))
        con.setLineWidth(20)
        con.replacePathWithStrokedPath()
        con.clip()
        // draw the gradient
        let locs: [CGFloat] = [0.0, 0.5, 1.0]
        let colors: [CGFloat] = [
            0.8, 0.4,//starting color, transparent light gray
            0.1, 0.5,// intermediate color, darker less transparent gray
            0.8, 0.4,// ending color, transperent light gray
        ]
        let sp = CGColorSpaceCreateDeviceGray()
        let grad = CGGradient(colorSpace: sp, colorComponents: colors, locations: locs, count: 3)!
        con.drawLinearGradient(grad, start: CGPoint(x: 10, y: 0), end: CGPoint(x: 30, y: 0), options: [])
        con.resetClip()//done clipping
        
        //create the pattern image tile
        let r = UIGraphicsImageRenderer(size: CGSize(width: 4, height: 4))
        let stripes = r.image { ctx in
            let imcon = ctx.cgContext
            imcon.setFillColor(UIColor.red.cgColor)
            imcon.fill(CGRect(x: 0, y: 0, width: 4, height: 4))
            imcon.setFillColor(UIColor.blue.cgColor)
            imcon.fill(CGRect(x: 0, y: 0, width: 4, height: 2))
        }
        //paint the point of the arrow with it
        let stripesPattern = UIColor(patternImage: stripes)
        stripesPattern.setFill()
        let p = UIBezierPath()
        p.move(to: CGPoint(x: 0, y: 25))
        p.addLine(to: CGPoint(x: 20, y: 0))
        p.addLine(to: CGPoint(x: 40, y: 25))
        p.fill()
    }
}
