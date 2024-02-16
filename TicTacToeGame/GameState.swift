import Foundation
import SwiftUI

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtsScore = 0
    @Published var crosesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    
    init()
    {
        resetBoard()
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func placeTile(_ row: Int,_ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if(checkForVictory())
        {
            if turn == Tile.Cross
            {
                crosesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses Win" : "Noughts Win"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if(checkForDraw())
        {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkForVictory() -> Bool
    {
        //vertical vic
        if isturnTile(0, 0) && isturnTile(1, 0) && isturnTile(2, 0)
        {
            return true
        }
        if isturnTile(0, 1) && isturnTile(1, 1) && isturnTile(2, 1)
        {
            return true
        }
        if isturnTile(0, 2) && isturnTile(1, 2) && isturnTile(2, 2)
        {
            return true
        }
        
        //horizonal vic
        if isturnTile(0, 0) && isturnTile(0, 1) && isturnTile(0, 2)
        {
            return true
        }
        if isturnTile(1, 0) && isturnTile(1, 1) && isturnTile(1, 2)
        {
            return true
        }
        if isturnTile(2, 0) && isturnTile(2, 1) && isturnTile(2, 2)
        {
            return true
        }
        
        //diagnoal vic
        
        if isturnTile(0, 0) && isturnTile(1, 1) && isturnTile(2, 2)
        {
            return true
        }
        if isturnTile(0, 2) && isturnTile(1, 1) && isturnTile(2, 0)
        {
            return true
        }
        
        return false
    }
    
    func isturnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
