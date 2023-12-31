//
//  Point.swift
//  PointInPolygon
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation

struct Point {
    let x : Double
    let y : Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    func toString() -> String {
        return "(\(x),\(y))"
    }
}
