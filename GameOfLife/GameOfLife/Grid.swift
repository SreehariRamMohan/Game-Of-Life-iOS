import SpriteKit

class Grid: SKSpriteNode {
    var gridArray = [[Creature]]()

    /* Grid array dimensions */
    let rows = 8
    let columns = 10
    
    /* Individual cell dimension, calculated in setup*/
    var cellWidth = 0
    var cellHeight = 0
    
    var population: Int = 0
    var generation: Int = 0
    
       
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        /* There will only be one touch as multi touch is not enabled by default */
        let touch = touches.first!
        let location = touch.location(in: self)
        let x = location.x
        let y = location.y
        
        var column = Int(Float(x)/Float(cellWidth))
        var row = Int(Float(y)/Float(cellHeight))
        
        if(row > 7) {
            row = 7        }
        if(column > 9) {
            column = 9
        }
        
        let creature = gridArray[column][row]
        creature.isAlive = !creature.isAlive
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
                
        /* Enable own touch implementation for this node */
        isUserInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        /* Populate grid with creatures */
        populateGrid()
    }
    
    
    func addCreatureAtGrid(gridX: Int, gridY: Int) {
        let creature: Creature = Creature()
        let xPos = gridX * cellWidth
        let yPos = gridY * cellHeight
        
        let gridPosition = CGPoint(x: xPos, y: yPos)
        
        creature.position = gridPosition
        creature.isAlive = false
        addChild(creature)
        gridArray[gridX].append(creature)
        
    }
    
    func populateGrid() {
        /* Populate the grid with creatures */
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Initialize empty column */
            gridArray.append([])
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Create a new creature at row / column position */
                addCreatureAtGrid(gridX:gridX, gridY:gridY)
            }
        }
    }
    
    func countNeighbors() {
        /* Process array and update creature neighbor count */
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Grab creature at grid position */
                let currentCreature = gridArray[gridX][gridY]
                
                /* Reset neighbor count */
                currentCreature.neighborCount = 0
                
                /* Loop through all adjacent creatures to current creature */
                for innerGridX in (gridX - 1)...(gridX + 1) {
                    
                    /* Ensure inner grid column is inside array */
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1) {
                        
                        /* Ensure inner grid row is inside array */
                        if innerGridY<0 || innerGridY >= rows { continue }
                        
                        /* Creature can't count itself as a neighbor */
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        /* Grab adjacent creature reference */
                        let adjacentCreature:Creature = gridArray[innerGridX][innerGridY]
                        
                        /* Only interested in living creatures */
                        if adjacentCreature.isAlive {
                            currentCreature.neighborCount += 1
                        }  
                    }
                }    
            }
        }
    }
    
    func updateCreatures() {
        population = 0
        for gridX in 0..<columns{
            for gridY in 0..<rows {
                let creature = gridArray[gridX][gridY]
                var nums: Int = creature.neighborCount
                
                if(nums < 2) {
                    creature.isAlive = false
                } else if( nums > 3) {
                    creature.isAlive = false
                } else if( nums == 3) {
                    creature.isAlive = true
                } else if(nums == 2 || nums == 3) {
                    //it stays alive
                }
                
                
                
                if(creature.isAlive) {
                    population += 1
                    creature.neighborCount = nums
                }
                
                
            }
        }
    }
    
    func evolve() {
        /* Updated the grid to the next state in the game of life */
        
        /* Update all creature neighbor counts */
        countNeighbors()
        
        /* Calculate all creatures alive or dead */
        updateCreatures()
        
        /* Increment generation counter */
        generation += 1
    }
    
    
 
    
        
        
        
        
    
    
}
