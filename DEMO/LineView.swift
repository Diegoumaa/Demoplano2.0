//  LineView.swift
//  DEMO
//
//  Created by gd on 25/4/23.
//

import UIKit

class LineView: UIView {
    var start: CGPoint = .zero
    var end: CGPoint = .zero
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        UIColor.black.setStroke() // Puedes cambiar el color de la línea aquí
        path.lineWidth = 2 // Puedes cambiar el grosor de la línea aquí
        path.stroke()
    }
}
