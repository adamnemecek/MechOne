//
//  MainMenu.swift
//  MechOne
//
//  Created by James Dyer on 5/25/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import SpriteKit

class MainMenu: SKTScene {
    
    //Screen
    var fullScreen = true
    
    //Sounds
    let sndTitleSlide = SKAction.playSoundFileNamed("title.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        addChild(background)
        
        let playButton = SKLabelNode(fontNamed: "Roboto-Bold")
        playButton.posByScreen(0.5, y: 0.3)
        playButton.fontSize = 56
        playButton.text = lt("PLAY")
        playButton.fontColor = SKColor.whiteColor()
        playButton.zPosition = 10
        playButton.name = "playGame"
        addChild(playButton)
        
        //Build
        /*
        let buildButton = SKLabelNode(fontNamed: "Roboto-Bold")
        buildButton.posByScreen(0.5, y: 0.2)
        buildButton.fontSize = 56
        buildButton.text = lt("BUILD")
        buildButton.fontColor = SKColor.whiteColor()
        buildButton.zPosition = 10
        buildButton.name = "buildGame"
        addChild(buildButton)
        */
        
        let title = SKSpriteNode(imageNamed: "MECHONE01")
        title.posByCanvas(-1.5, y: 0.7)
        title.xScale = 0.7
        title.yScale = 0.7
        title.zPosition = 15
        addChild(title)
        title.runAction(SKAction.group([ SKAction.moveTo(CGPoint(screenX: 0.5, screenY: 0.7), duration: 1.0), sndTitleSlide]))
        
        #if os(OSX)
            let exitButton = SKLabelNode(fontNamed: "Roboto-Bold")
            exitButton.posByScreen(0.5, y: 0.2)
            exitButton.fontSize = 56
            exitButton.text = lt("EXIT")
            exitButton.fontColor = SKColor.whiteColor()
            exitButton.zPosition = 10
            exitButton.name = "exitGame"
            addChild(exitButton)
        #endif
        
    }
    
    //MARK: Responders
    
    override func screenInteractionStarted(location: CGPoint) {
        
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                
                if node.name == "playGame" {
                    buttonEvent("buttonA", velocity: 1.0, pushedOn: true)
                }
                
                /*
                if node.name == "buildGame" {
                    buttonEvent("buttonB", velocity: 1.0, pushedOn: true)
                }
                */
 
                #if os(OSX)
                    if node.name == "exitGame" {
                        SKTAudio.sharedInstance().playSoundEffect("button_click.wav")
                        NSApplication.sharedApplication().terminate(self)
                    }
                #endif
                
            }
        }
        
    }
    
    override func buttonEvent(event:String,velocity:Float,pushedOn:Bool) {
        if event == "buttonA" {
            
            SKTAudio.sharedInstance().playSoundEffect("button_click.wav")
            
            let nextScene = GameIntro(size: self.scene!.size)
            nextScene.scaleMode = self.scaleMode
            self.view?.presentScene(nextScene)
            
        }
        /*
        if event == "buttonB" {
            
            self.runAction(sndButtonClick)
            
            let nextScene = GameBuildMode(size: self.scene!.size)
            nextScene.scaleMode = self.scaleMode
            self.view?.presentScene(nextScene)
            
        }
        */
    }
    
    override func stickEvent(event:String,point:CGPoint) {
        
    }
    
    #if os(OSX)
    override func handleKeyEvent(event: NSEvent, keyDown: Bool) {
        if let characters = event.characters {
            for character in characters.characters {
                switch character {
                case " " where keyDown:
                    SKTAudio.sharedInstance().playSoundEffect("button_click.wav")
                    
                    let nextScene = GameIntro(size: self.scene!.size)
                    nextScene.scaleMode = self.scaleMode
                    self.view?.presentScene(nextScene)
                    break
                default:
                    break
                }
            }
        }
    }

    #endif
    
    #if !os(OSX)
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
            case .Select:
                SKTAudio.sharedInstance().playSoundEffect("button_click.wav")
                let nextScene = GameIntro(size: self.scene!.size)
                nextScene.scaleMode = self.scaleMode
                self.view?.presentScene(nextScene)
                break
            default:
                break
            }
        }
    }
    #endif
}

