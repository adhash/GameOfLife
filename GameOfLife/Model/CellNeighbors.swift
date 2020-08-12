//
//  CellNeighbors.swift
//  GameOfLife
//
//  Created by wojtek on 27/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import Foundation

class CellNeighbors {
    var leftNeighbor: Cell?
    var rightNeighbor: Cell?
    var topNeighbor: Cell?
    var bottomNeighbor: Cell?
    
    func count() -> Int {
        var counter = 0
        
        if leftNeighbor != nil && leftNeighbor!.isAlive {
            counter += 1
        }
        if rightNeighbor != nil && rightNeighbor!.isAlive {
            counter += 1
        }
        if topNeighbor != nil && topNeighbor!.isAlive {
            counter += 1
        }
        if bottomNeighbor != nil && bottomNeighbor!.isAlive {
            counter += 1
        }
        
        return counter
    }
}
