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
    for i in 0..<(points.count - 2) {
        if crossProduct(p0: points[i], p1: points[i + 1], p2: points[i + 2]) == 0 {
            print("Error: the shape intersects with itself. Points do not form a polyon.")
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

func checkDirection(_ p0: Point, _ p1: Point, _ p2 : Point) -> Direction {
    let directionAngle = crossProduct(p0: p0, p1: p1, p2: p2)
    if directionAngle == 0 {
        return Direction.collinear
    } else if directionAngle < 0 {
        return Direction.counterclockwise
    } else {
        return Direction.clockwise
    }
}

func checkPointOnLine(point: Point, line: Line) -> Bool {
    if point.x <= max(line.start.x, line.end.x) && point.x >= min(line.start.x, line.end.x) &&
        point.y <= max(line.start.y, line.end.y) && point.y >= min(line.start.y, line.end.y) {
        return true
    }
    return false
}

func checkLineIntersection(_ line1: Line, _ line2: Line) -> Bool {
    let dir1 = checkDirection(line1.start, line1.end, line2.start)
    let dir2 = checkDirection(line1.start, line1.end, line2.end)
    let dir3 = checkDirection(line2.start, line2.end, line1.start)
    let dir4 = checkDirection(line2.start, line2.end, line1.end)
    
    let condition1 = dir1 == Direction.collinear && checkPointOnLine(point: line2.start, line: line1)
    let condition2 = dir2 == Direction.collinear && checkPointOnLine(point: line2.end, line: line1)
    let condition3 = dir3 == Direction.collinear && checkPointOnLine(point: line1.start, line: line2)
    let condition4 = dir4 == Direction.collinear && checkPointOnLine(point: line1.end, line: line2)
    
    if dir1 != dir2 && dir3 != dir3 {
        return true
    } else if condition1 || condition2 || condition3 || condition4 {
        return true
    } else {
        return false
    }
}

func isPointInside(point: Point, polygon: [Point]) -> Bool {
    let pointCount = polygon.count
    let castLine = Line(start: point, end: Point(999999999, point.y))
    var crossCount = 0
    var i = 0
    while true {
        let side = Line(start: polygon[i], end: polygon[(i + 1) % pointCount])
        if checkLineIntersection(side, castLine) {
            if checkDirection(side.start, point, side.end) == Direction.collinear {
                return checkPointOnLine(point: point, line: side)
            }
            crossCount += 1
        }
        i = (i + 1) % pointCount;
        if i == 0 {
            break
        }
    }
    return (crossCount % 2) == 1
}
