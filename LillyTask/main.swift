//
//  main.swift
//  LillyTask
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation


let (pointToCheck, polygonPoints) = getUserInput()
if isPolygon(points: polygonPoints) {
    if isConvex(points: polygonPoints) {
        if isPointInside(point: pointToCheck, polygon: polygonPoints) {
            print("The point is inside the polygon.")
        } else {
            print("The point is not inside the polygon.")
        }
    }
}
