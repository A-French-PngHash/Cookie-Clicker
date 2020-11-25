////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	let cookie = SKSpriteNode(imageNamed: "Cookie")
	let numberOfCookiesLabel = SKLabelNode(text: "0")
	let cookiesPerSecondsLabel = SKLabelNode(text : "0")
	let particles = SKEmitterNode(fileNamed: "MyParticle.sks")!
	var particleNode = SKEmitterNode(fileNamed: "MyParticle")!

	override func didMove(to view: SKView) {
		cookie.size = CGSize(width: 200, height: 200)
		cookie.position = CGPoint(x: 110, y: size.height/2 - 60)
		cookie.zPosition = 0
		addChild(cookie)

		cookiesPerSecondsLabel.position = CGPoint(x: 110, y: cookie.position.y + cookie.size.height/2 + 10)
		cookiesPerSecondsLabel.fontName = "Marker Felt"
		cookiesPerSecondsLabel.fontColor = .darkGray
		addChild(cookiesPerSecondsLabel)


		let cookiesPerSecondsIndication = SKLabelNode(text: "Cookies Per Second : ")
		cookiesPerSecondsIndication.position = CGPoint(x: 130, y: cookie.position.y + cookie.size.height/2 + 40)
		cookiesPerSecondsIndication.fontName = "Marker Felt"
		cookiesPerSecondsIndication.fontColor = .darkGray
		addChild(cookiesPerSecondsIndication)
	}

	func cookieClick(touchLocation : CGPoint) {
		createParticle(touchLocation: touchLocation)
		run(SKAction.sequence([SKAction.run(decreaseCookieSize), SKAction.wait(forDuration: 0.1), SKAction.run(increaseCookieSize)]))
		// SKAction.playSoundFileNamed("clickOnCookie.mp3", waitForCompletion: false),
	}

	func decreaseCookieSize() {
		cookie.size = CGSize(width: 185, height: 185)
	}
	func increaseCookieSize() {
		cookie.size = CGSize(width: 200, height: 200)
	}

	func createParticle(touchLocation : CGPoint) {
		let particles = self.particleNode.copy() as! SKEmitterNode
		let touch = CGPoint(x: touchLocation.x, y: self.view!.frame.height - touchLocation.y)
		particles.position = touch
		particles.zPosition = 1
		addChild(particles)
		particles.run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.removeFromParent()]))
	}

	func playUpgradeSound() {
		//SKAction.playSoundFileNamed("upgradeBuyed.mp3", waitForCompletion: false)
	}

	func particleAlpha(particle : SKSpriteNode) {
	}
}
