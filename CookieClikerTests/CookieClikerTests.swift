////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import XCTest
@testable import CookieCliker

class CookieClikerTests: XCTestCase {
	var game = Game()
	override func setUp() {
		super.setUp()
		game = Game()
		game.score = 0
		game.initialize()
	}
	
	func testGivenCookieAre0_WhenClicking_ThenCookiesShouldBeOne() {
		game.cookieClick()

		XCTAssertEqual(game.score, 1)
	}

	func testGivenCookiePerSecondAreOneAndScoreIsZero_WhenOneSecondPass_ThenScoreShouldBeOne() {
		game.cookiesPerMiliSecond = 0.1

		for _ in 0..<10 {
			game.timePassed()
		}

		XCTAssertTrue(game.score > 0.95) //Because 0,1+0,2 does not equal to 0,3
	}

	func testGivenNotEnoughCookieToBuy_WhenBuying_ThenNotBuying() {
		let random = Int.random(in: 0...game.upgradeList.count - 1)

		game.buyOne(upgrade: random)

		XCTAssertEqual(game.numberOfUpgrade[random], 0)
	}

	func testGivenNothingHasBeenBuyed_WhenBuyingABuilding_ThenCPSIsEqualToCpsOfThisBuilding() {
		let random = Int.random(in: 0...game.upgradeList.count - 1)
		game.score = Double(game.upgradeList[random].baseCost)

		game.buyOne(upgrade: random)

		print("Random Upgrade for test : \(random)")
		XCTAssertEqual(game.cookiesPerMiliSecond, game.upgradeList[random].cookPerUnitPerSecond/10)
	}

	func testGivenBuildingWasBuyed_WhenBuying_ThenCostNotTheSame() {
		let random = Int.random(in: 0...game.upgradeList.count - 1)
		game.score = Double(game.upgradeList[random].baseCost)
		game.buyOne(upgrade: random)
		game.score = Double(game.upgradeList[random].baseCost)

		game.buyOne(upgrade: random) //Expected : unable to buy

		XCTAssertEqual(game.numberOfUpgrade[random], 1)
	}
}

//MARK : - Export And Import Tests
extension CookieClikerTests {
	var exportCode : String{
		get {
			return ExportService.shared.export()
		}
	}
	var impor : importService {
		get {
			return importService.shared
		}
	}

	func testGivenNameWasJohn_WhenExportingAndImporting_ThenNameIsJohn() {
		SaveServices.shared.renameGAme(index: 0, newName: "John")

		impor.importKey(exportCode)

		XCTAssertEqual(impor.gameName, "John")
	}
}
