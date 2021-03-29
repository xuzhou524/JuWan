//
//  WatermelonModel.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

struct CommandMove {
    let direction : DirectionMove
    let completion : (Bool) -> ()
}

enum OrderMove {
    case SingleOrderMove(source: Int, destination: Int, value: Int, wasMerge: Bool)
    case DoubleOrderMove(firstSource: Int, secondSource: Int, destination: Int, value: Int)
}

enum DirectionMove {
    case Up, Down, Left, Right
}

enum TileNotes {
    case Empty
    case Tile(Int)
}

enum ActionToken {
    case NoAction(source: Int, value: Int)
    case Move(source: Int, value: Int)
    case SingleCombine(source: Int, value: Int)
    case DoubleCombine(source: Int, second: Int, value: Int)

    func getValue() -> Int {
        switch self {
        case let .NoAction(_, v): return v
        case let .Move(_, v): return v
        case let .SingleCombine(_, v): return v
        case let .DoubleCombine(_, _, v): return v
        }
    }

    func getSource() -> Int {
        switch self {
        case let .NoAction(s, _): return s
        case let .Move(s, _): return s
        case let .SingleCombine(s, _): return s
        case let .DoubleCombine(s, _, _): return s
        }
    }
}

struct SquareGameboard<T> {
    let dimension : Int
    var boardArray : [T]
    
    init(dimension d: Int, initialValue: T) {
        dimension = d
        
        boardArray = [T].init(repeating: initialValue, count: d*d)
        
    }
    
    subscript(row: Int, col: Int) -> T {
        get {
            assert(row >= 0 && row < dimension)
            assert(col >= 0 && col < dimension)
            return boardArray[row*dimension + col]
        }
        set {
            assert(row >= 0 && row < dimension)
            assert(col >= 0 && col < dimension)
            boardArray[row*dimension + col] = newValue
        }
    }

    mutating func setAll(item: T) {
        for i in 0..<dimension {
            for j in 0..<dimension {
                self[i, j] = item
            }
        }
    }
}

protocol GameModelProtocol : class {
    func scoreChanged(score: Int)
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int)
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int)
    func insertTile(location: (Int, Int), value: Int)
}

class GameModel : NSObject {
    let dimension : Int
    let threshold : Int
    
    var score : Int = 0 {
        didSet {
            delegate.scoreChanged(score: score)
        }
    }
    var gameboard: SquareGameboard<TileNotes>
    
    unowned let delegate : GameModelProtocol
    
    var queue: [CommandMove]
    var timer: Timer
    
    let maxCommands = 100
    let queueDelay = 0.3
    
    init(dimension d: Int, threshold t: Int, delegate: GameModelProtocol) {
        dimension = d
        threshold = t
        self.delegate = delegate
        queue = [CommandMove]()
        timer = Timer()
        gameboard = SquareGameboard(dimension: d, initialValue: .Empty)
        super.init()
    }
    
    func reset() {
        score = 0
        gameboard.setAll(item: .Empty)
        queue.removeAll(keepingCapacity: true)
        timer.invalidate()
    }
    
    func queueMove(direction: DirectionMove, completion: @escaping (Bool) -> ()) {
        guard queue.count <= maxCommands else {
            // Queue is wedged. This should actually never happen in practice.
            return
        }
        queue.append(CommandMove(direction: direction, completion: completion))
        if !timer.isValid {
            timerFired(timer)
        }
    }

    @objc func timerFired(_: Timer) {
        if queue.count == 0 {
            return
        }

        var changed = false
        while queue.count > 0 {
            let command = queue[0]
            queue.remove(at: 0)
            changed = performMove(direction: command.direction)
            command.completion(changed)
            if changed {

                break
            }
        }
        if changed {
            timer = Timer.scheduledTimer(timeInterval: queueDelay, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: false)
        }
    }

    func insertTile(position: (Int, Int), value: Int) {
        let (x, y) = position
        if case .Empty = gameboard[x, y] {
            gameboard[x, y] = TileNotes.Tile(value)
            delegate.insertTile(location: position, value: value)
        }
    }
    
    func insertTileAtRandomLocation(value: Int) {
        let openSpots = gameboardEmptySpots()
        if openSpots.isEmpty {
            return
        }
        let idx = Int(arc4random_uniform(UInt32(openSpots.count-1)))
        let (x, y) = openSpots[idx]
        insertTile(position: (x, y), value: value)
    }
    
    func gameboardEmptySpots() -> [(Int, Int)] {
        var buffer : [(Int, Int)] = []
        for i in 0..<dimension {
            for j in 0..<dimension {
                if case .Empty = gameboard[i, j] {
                    buffer += [(i, j)]
                }
            }
        }
        return buffer
    }

    func tileBelowHasSameValue(location: (Int, Int), _ value: Int) -> Bool {
        let (x, y) = location
        guard y != dimension - 1 else {
            return false
        }
        if case let .Tile(v) = gameboard[x, y+1] {
            return v == value
        }
        return false
    }
    
    func tileToRightHasSameValue(location: (Int, Int), _ value: Int) -> Bool {
        let (x, y) = location
        guard x != dimension - 1 else {
            return false
        }
        if case let .Tile(v) = gameboard[x+1, y] {
            return v == value
        }
        return false
    }
    
    func userHasLost() -> Bool {
        guard gameboardEmptySpots().isEmpty else {
            return false
        }
        
        for i in 0..<dimension {
            for j in 0..<dimension {
                switch gameboard[i, j] {
                case .Empty:
                    assert(false, "Gameboard reported itself as full, but we still found an empty tile. This is a logic error.")
                case let .Tile(v):
                    if tileBelowHasSameValue(location: (i, j), v) || tileToRightHasSameValue(location: (i, j), v) {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func userHasWon() -> (Bool, (Int, Int)?) {
        for i in 0..<dimension {
            for j in 0..<dimension {
                if case let .Tile(v) = gameboard[i, j], v >= threshold {
                    return (true, (i, j))
                }
            }
        }
        return (false, nil)
    }
    
    func performMove(direction: DirectionMove) -> Bool {

        let coordinateGenerator: (Int) -> [(Int, Int)] = { (iteration: Int) -> [(Int, Int)] in
            
            var buffer = Array<(Int, Int)>.init(repeating: (0, 0), count: self.dimension)
            
            for i in 0..<self.dimension {
                switch direction {
                case .Up: buffer[i] = (i, iteration)
                case .Down: buffer[i] = (self.dimension - i - 1, iteration)
                case .Left: buffer[i] = (iteration, i)
                case .Right: buffer[i] = (iteration, self.dimension - i - 1)
                }
            }
            return buffer
        }
        
        var atLeastOneMove = false
        for i in 0..<dimension {
            let coords = coordinateGenerator(i)

            let tiles = coords.map() { (c: (Int, Int)) -> TileNotes in
                let (x, y) = c
                return self.gameboard[x, y]
            }

            let orders = merge(group: tiles)
            atLeastOneMove = orders.count > 0 ? true : atLeastOneMove

            for object in orders {
                switch object {
                case let OrderMove.SingleOrderMove(s, d, v, wasMerge):
                    let (sx, sy) = coords[s]
                    let (dx, dy) = coords[d]
                    if wasMerge {
                        score += v
                    }
                    gameboard[sx, sy] = TileNotes.Empty
                    gameboard[dx, dy] = TileNotes.Tile(v)
                    delegate.moveOneTile(from: coords[s], to: coords[d], value: v)
                case let OrderMove.DoubleOrderMove(s1, s2, d, v):
                    let (s1x, s1y) = coords[s1]
                    let (s2x, s2y) = coords[s2]
                    let (dx, dy) = coords[d]
                    score += v
                    gameboard[s1x, s1y] = TileNotes.Empty
                    gameboard[s2x, s2y] = TileNotes.Empty
                    gameboard[dx, dy] = TileNotes.Tile(v)
                    delegate.moveTwoTiles(from: (coords[s1], coords[s2]), to: coords[d], value: v)
                }
            }
        }
        return atLeastOneMove
    }

    func condense(group: [TileNotes]) -> [ActionToken] {
        var tokenBuffer = [ActionToken]()
        for (idx, tile) in group.enumerated() {
            switch tile {
            case let .Tile(value) where tokenBuffer.count == idx:
                tokenBuffer.append(ActionToken.NoAction(source: idx, value: value))
            case let .Tile(value):
                tokenBuffer.append(ActionToken.Move(source: idx, value: value))
            default:
                break
            }
        }
        return tokenBuffer;
    }
    
    class func quiescentTileStillQuiescent(inputPosition: Int, outputLength: Int, originalPosition: Int) -> Bool {
        return (inputPosition == outputLength) && (originalPosition == inputPosition)
    }

    func collapse(group: [ActionToken]) -> [ActionToken] {
        
        var tokenBuffer = [ActionToken]()
        var skipNext = false
        for (idx, token) in group.enumerated(){
            if skipNext {
                skipNext = false
                continue
            }
            switch token {
            case .SingleCombine:
                assert(false, "Cannot have single combine token in input")
            case .DoubleCombine:
                assert(false, "Cannot have double combine token in input")
            case let .NoAction(s, v)
                    where (idx < group.count-1
                            && v == group[idx+1].getValue()
                            && GameModel.quiescentTileStillQuiescent(inputPosition: idx, outputLength: tokenBuffer.count, originalPosition: s)):
                let next = group[idx+1]
                let nv = v + group[idx+1].getValue()
                skipNext = true
                tokenBuffer.append(ActionToken.SingleCombine(source: next.getSource(), value: nv))
            case let t where (idx < group.count-1 && t.getValue() == group[idx+1].getValue()):
                let next = group[idx+1]
                let nv = t.getValue() + group[idx+1].getValue()
                skipNext = true
                tokenBuffer.append(ActionToken.DoubleCombine(source: t.getSource(), second: next.getSource(), value: nv))
            case let .NoAction(s, v) where !GameModel.quiescentTileStillQuiescent(inputPosition: idx, outputLength: tokenBuffer.count, originalPosition: s):
                tokenBuffer.append(ActionToken.Move(source: s, value: v))
            case let .NoAction(s, v):
                tokenBuffer.append(ActionToken.NoAction(source: s, value: v))
            case let .Move(s, v):
                tokenBuffer.append(ActionToken.Move(source: s, value: v))
            default:
                break
            }
        }
        return tokenBuffer
    }

    func convert(group: [ActionToken]) -> [OrderMove] {
        var moveBuffer = [OrderMove]()
        for (idx, t) in group.enumerated() {
            switch t {
            case let .Move(s, v):
                moveBuffer.append(OrderMove.SingleOrderMove(source: s, destination: idx, value: v, wasMerge: false))
            case let .SingleCombine(s, v):
                moveBuffer.append(OrderMove.SingleOrderMove(source: s, destination: idx, value: v, wasMerge: true))
            case let .DoubleCombine(s1, s2, v):
                moveBuffer.append(OrderMove.DoubleOrderMove(firstSource: s1, secondSource: s2, destination: idx, value: v))
            default:
                break
            }
        }
        return moveBuffer
    }
    
    func merge(group: [TileNotes]) -> [OrderMove] {
        return convert(group: collapse(group: condense(group: group)))
    }
}
