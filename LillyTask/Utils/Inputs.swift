//
//  Inputs.swift
//  LillyTask
//
//  Created by Luka Stupar on 5.9.23..
//

import Foundation

func makePoint(from coordinates: String) -> Point? {
    let coordinates = coordinates.replacingOccurrences(of: " ", with: "").split(separator: ",")
    if coordinates.count != 2 {
        return nil
    }
    guard let x = Double(coordinates[0]), let y = Double(coordinates[1]) else {
        return nil
    }
    return Point(x, y)
}

func getCommandLineInput() -> (Point, [Point])? {
    let invalidMessage = "Command line input is invalid, reverting to user input."
    let arguments = CommandLine.arguments
    if arguments.count <= 1 {
        print(invalidMessage)
        return nil
    }
    guard let pointNumber = Int(arguments[1]) else {
        print(invalidMessage)
        return nil
    }
    if arguments.count != pointNumber + 3 {
        print(invalidMessage)
        return nil
    }
    var points : [Point] = []
    for (index, argument) in arguments.enumerated() {
        if index > 1 {
            if let point: Point = makePoint(from: argument) {
                points.append(point)
            } else {
                print(invalidMessage)
                return nil
            }
        }
    }
    points.append(points[0])
    guard let pointCoordinates : Point = makePoint(from: arguments[pointNumber + 2]) else {
        print(invalidMessage)
        return nil
    }
    print("Data taken from the command line:")
    print("Number of points in polygon: \(pointNumber), Points: \(points.map{point in point.toString()})")
    print("Point to check: \(pointCoordinates.toString())")
    return (pointCoordinates, points)
}

func readInput() -> String? {
    let userInput = readLine()
    if let input = userInput {
        if input == "exit" {
            exit(0)
        }
    }
    return userInput
}

func getInputCoordinates(with message: String) -> Point {
    repeat {
        print(message)
        guard let userInput = readInput() else {
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
        guard let pointNumber = Int(readInput() ?? "0") else {
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
