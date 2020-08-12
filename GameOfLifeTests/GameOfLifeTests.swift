//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by wojtek on 27/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func  test_cell_has_neighbors() {
        /*
          x
         xXx
          x
         */
        let topCell = Cell(position: Position(x: 10, y: 0))
        let bottomCell = Cell(position: Position(x: 10, y: 20))
        let rightCell = Cell(position: Position(x: 0, y: 10))
        let leftCell = Cell(position: Position(x: 10, y: 10))
        leftCell.isAlive = true
        let actualCell = Cell(position: Position(x: 10, y: 10))
        actualCell.isAlive = true
        
        let topCellNeighbors = CellNeighbors()
        topCellNeighbors.bottomNeighbor = actualCell
        topCell.neighbors = topCellNeighbors
        
        let leftCellNeighbors = CellNeighbors()
        leftCellNeighbors.rightNeighbor = actualCell
        leftCell.neighbors = leftCellNeighbors
        
        let bottomCellNeighbors = CellNeighbors()
        bottomCellNeighbors.topNeighbor = actualCell
        bottomCell.neighbors = bottomCellNeighbors
        
        let rightCellNeighbors = CellNeighbors()
        rightCellNeighbors.leftNeighbor = actualCell
        rightCell.neighbors = rightCellNeighbors
        
        let actualCellNeighbors = CellNeighbors()
        actualCellNeighbors.topNeighbor = topCell
        actualCellNeighbors.bottomNeighbor = bottomCell
        actualCellNeighbors.leftNeighbor = leftCell
        actualCellNeighbors.rightNeighbor = rightCell
        actualCell.neighbors = actualCellNeighbors
        
        XCTAssert(actualCell.neighbors!.count() > 0)
        XCTAssert(topCell.neighbors!.count() > 0)
        XCTAssert(bottomCell.neighbors!.count() > 0)
        XCTAssert(leftCell.neighbors!.count() > 0)
        XCTAssert(rightCell.neighbors!.count() > 0)
        
    }
    
    func test_cell_state_change() {
        let width = 4
        let height = 4
        
        let gameRules = MyGameRules()
        let gameBoard = GameBoard(width: width, height: height, rules: gameRules)
        
        
        let testCellPosition = Position(x: 0, y: 0)
        let board = gameBoard.getBoardState()
        
        let testNeighbor1 = gameBoard.getCell(at: Position(x: 0, y: 1), from: board)
        testNeighbor1!.isAlive = true
        
        let testNeighbor2 = gameBoard.getCell(at: Position(x: 1, y: 0), from: board)
        testNeighbor2!.isAlive = true
        
        let testCell = gameBoard.getCell(at: testCellPosition, from: board)
        testCell!.isAlive = false
        
        gameBoard.applyRule(at: testCellPosition, in: board)
        
        XCTAssert(testCell!.isAlive == true)
    }
    
    func test_board_size_match_cell_size() {
        Cell.height = 2
        Cell.width = 2
        
        let width = 4
        let height = 4
        let gameRules = MyGameRules()
        let gameBoard = GameBoard(width: width / Cell.width, height: height / Cell.height, rules: gameRules)
        let board = gameBoard.getBoardState()
        
        XCTAssert(board.count == 2) //exect 2 cells in width
        XCTAssert(board[0].count == 2) //exect 2 cells in height
    }

}
