//
//  GameRules.swift
//  GameOfLife
//
//  Created by wojtek on 27/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import Foundation

protocol GameRules {
    func apply(to cell: Cell)
}

public class MyGameRules: GameRules {
    func apply(to cell: Cell) {
        if cell.neighbors!.count() == 2 {
            cell.isAlive = true
        } else {
            cell.isAlive = false
        }
    }
}
