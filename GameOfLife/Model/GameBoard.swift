//
//  GameBoard.swift
//  GameOfLife
//
//  Created by wojtek on 27/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import Foundation

public class GameBoard {
    private var board = [[Cell]]()
    private var newBoard = [[Cell]]()
    var width: Int
    var height: Int
    private var rules: GameRules
    
    init(width: Int, height: Int, rules: GameRules) {
        self.width = width
        self.height = height
        self.rules = rules
        self.initBoard()
    }
    
    func getCell(at position: Position, from board: [[Cell]]) -> Cell? {
        if position.x >= 0 && position.x < self.width && position.y >= 0 && position.y < self.height {
            return board[position.y][position.x]
        } else {
            return nil
        }
    }
    
    func applyRule(at position: Position, in board: [[Cell]]) {
        let cell = getCell(at: position, from: board)
        self.rules.apply(to: cell!)
    }
    
    func start() {
        for i in 0..<self.height {
            for j in 0..<self.width {
                let position = Position(x: j, y: i)
                self.applyRule(at: position, in: newBoard)
            }
        }
        self.board = self.newBoard
    }
    
    func getBoardState() -> [[Cell]] {
        return self.newBoard
    }
    
    private func initBoard() {
        for i in 0..<self.height {
            var arr = [Cell]()
            
            for j in 0..<self.width {
                arr.append(Cell(position: Position(x: j * Cell.width, y: i * Cell.height)))
            }
            self.board.append(arr)
        }
        self.newBoard = self.board
        
        for i in 0..<self.height {
            for j in 0..<self.width {
                let position = Position(x: j, y: i)
                let cell = self.getCell(at: position, from: self.board)
                
                self.randomizeCellLife(cell: cell!)
                self.setNeighbors(for: cell!, at: position)
            }
        }
    }
    
    private func randomizeCellLife(cell: Cell) {
        cell.isAlive = Bool.random()
    }
    
    private func setNeighbors(for cell: Cell, at position: Position) {
        let topNeighborPosition = Position(x: position.x, y: position.y - 1)
        let bottomNeighborPosition = Position(x: position.x, y: position.y + 1)
        let leftNeighborPosition = Position(x: position.x - 1, y: position.y)
        let rightNeighborPosition = Position(x: position.x + 1, y: position.y)
        let cellNeighbors = CellNeighbors()
        
        cellNeighbors.topNeighbor = self.getCell(at: topNeighborPosition, from: self.board)
        cellNeighbors.bottomNeighbor = self.getCell(at: bottomNeighborPosition, from: self.board)
        cellNeighbors.leftNeighbor = self.getCell(at: leftNeighborPosition, from: self.board)
        cellNeighbors.rightNeighbor = self.getCell(at: rightNeighborPosition, from: self.board)
        
        cell.neighbors = cellNeighbors
    }
}
