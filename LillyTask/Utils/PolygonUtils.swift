//
//  PolygonUtils.swift
//  LillyTask
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation

func crossProduct(p0: Point, p1: Point, p2 : Point) -> Double {
    return (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x)
}

func isPolygon(points: [Point]) -> Bool {
    print(points.count)
    for i in 0..<(points.count - 2) {
        if crossProduct(p0: points[i], p1: points[i + 1], p2: points[i + 2]) == 0 {
            print("Error: the shape intersects with itself.")
            return false
        }
    }
    return true
}

func isConvex(points: [Point]) -> Bool {
    let pointCount = points.count
    var previousCrossProduct = 0.0
    for i in 0..<pointCount {
        let pointCrossProduct = crossProduct(p0: points[i], p1: points[(i + 1) % pointCount], p2: points[(i + 2) % pointCount])
        if pointCrossProduct != 0 {
            if pointCrossProduct * previousCrossProduct < 0 {
                print("Error: polygon is not convex.")
                return false
            } else {
                previousCrossProduct = pointCrossProduct
            }
        }
    }
    return true
}
