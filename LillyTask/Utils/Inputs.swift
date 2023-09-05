//
//  Inputs.swift
//  LillyTask
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation

func getInputCoordinates(with message: String) -> Point {
    repeat {
        print(message)
        guard let userInput = readLine() else {
            print("Input is invalid, please try again.")
            continue
        }
        
        let coordinates = userInput.replacingOccurrences(of: " ", with: "").split(separator: ",")
        
        if coordinates.count != 2 {
            print("Invalid input, please enter exactly 2 coordinates and make sure they are numerical values.")
            continue

        }
        
        guard let x = Double(coordinates[0]), let y = Double(coordinates[1]) else {
            print("Invalid input, please enter numerical values for coordinates.")
            continue
        }
        
        return Point(x, y)
    } while true
}

func getUserInput() -> (Point, [Point]) {
    repeat {
        print("Please enter the number of points of polygon: ")
        guard let pointNumber = Int(readLine() ?? "0") else {
            print("Input is invalid, you have to input integer.")
            continue
        }
        
        if pointNumber < 3 {
            print("Polygon must contain at least 3 points. Please try again.")
            continue
        }
        
        var points : [Point] = []
        for i in 0..<pointNumber {
            let point = getInputCoordinates(with: "Please enter the coordinates of No.\(i + 1) separated by single comma:")
            points.append(point)
        }
        points.append(points[0])
        
        let pointToCheck = getInputCoordinates(with: "Please enter the coordinates of the point to check separated by single comma:")
        
        return (pointToCheck, points)
    } while true
}
