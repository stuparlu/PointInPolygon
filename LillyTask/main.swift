//
//  main.swift
//  LillyTask
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation


let (pointToCheck, polygonPoints) = getUserInput()
isPolygon(points: polygonPoints)
isConvex(points: polygonPoints)
