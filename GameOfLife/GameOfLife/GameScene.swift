import SpriteKit

class GameScene: SKScene {
    
    var generationLabel: SKLabelNode!
    var populationLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    var gridNode: Grid!
    
    
    
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        generationLabel = self.childNode(withName: "//generationLabel") as! SKLabelNode
        populationLabel = self.childNode(withName: "//populationLabel") as! SKLabelNode
        playButton = self.childNode(withName: "//playButton") as! MSButtonNode
        stepButton = self.childNode(withName: "//stepButton") as! MSButtonNode
        gridNode = self.childNode(withName: "//gridNode") as! Grid
        pauseButton = self.childNode(withName: "//pauseButton") as! MSButtonNode
        
        
        //DETECTING BUTTON CLICKS ON STEP BUTTON
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        
        playButton.selectedHandler = {
            self.isPaused = false
        }
        
        
        pauseButton.selectedHandler = {
            self.isPaused = true
        }
        
        
        
        
        
        /* Create an SKAction based timer, 0.5 second delay */
        let delay = SKAction.wait(forDuration: 0.5)
        
        /* Call the stepSimulation() method to advance the simulation */
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        
        /* Create the delay,step cycle */
        let stepSequence = SKAction.sequence([delay,callMethod])
        
        /* Create an infinite simulation loop */
        // let simulation = SKAction.repeatActionForever(stepSequence)
        let simulation = SKAction.repeatForever(stepSequence)
        
        /* Run simulation action */
        self.run(simulation)
        
        /* Default simulation to pause state */
        self.isPaused = true
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
    func stepSimulation() {
        /* Step Simulation */
        
        /* Run next step in simulation */
        gridNode.evolve()
        
        /* Update UI label objects */
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
}
