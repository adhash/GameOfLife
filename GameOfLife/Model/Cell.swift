
//
//  Cel.swift
//  GameOfLife
//
//  Created by wojtek on 25/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import Foundation

class Cell {
    var isAlive: Bool = false
    var neighbors: CellNeighbors?
    var position: Position
    
    static var width = 10
    static var height = 10
    
    init (position: Position) {
        self.position = position
    }
    
}
