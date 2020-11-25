////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation

class Game {
	var score: Double = 0
	var cookiesPerMiliSecond: Double = 0
	var upgradeList : Array<cookieClickerUpgrade> = [] //This is a list of every possible uppgrade
	var numberOfUpgrade : Array<Int> = [] //Contains a list of Int, each Int Corespond to the number of upgrade buyed of a specific upgrade
	var isDisponible : Array<Bool> = []
	var numberOfDisponible : Int = 2
	func cookieClick() {
		score += 1
	}

	func timePassed() {
		score += cookiesPerMiliSecond
	}

	func initialize() {
		defineUpgradeListe()
	}

	func defineUpgradeListe() {
		let cursor = Cursor()
		let grandma = GrandMa()
		let farm = Farm()
		let mine = Mine()
		let factory = Factory()
		let bank = Bank()
		let temple = Temple()
		let wizardTower = WizardTower()
		let shipment = Shipment()
		let alchemyLab = AlchemyLab()
		let portal = Portal()
		let timeMachine = TimeMachine()
		let antimatterCondenser = AntimatterCondenser()
		let prism = Prism()
		let chanceMaker = Chancemaker()

		upgradeList = [cursor, grandma, farm, mine, factory, bank, temple, wizardTower, shipment, alchemyLab, portal, timeMachine, antimatterCondenser, prism, chanceMaker]
		for _ in 0...upgradeList.count - 1 {
			numberOfUpgrade.append(0)
		}
	}
	
	func buyOne(upgrade : Int) {
		var price: Double = Double(upgradeList[upgrade].baseCost)
		if numberOfUpgrade[upgrade] > 0 {
			for _ in 0...numberOfUpgrade[upgrade]-1 {
				price = price * 1.15
			}
		}
		if canBeBuyed(upgrade: upgrade, price : price) {
			price = Double(price)
			score -= price
			numberOfUpgrade[upgrade] += 1
			recalculateCookiesPerMiliSecond()
			recalculateDisponible()
		}
	}

	private func recalculateData() {
		recalculateDisponible()
		recalculateCookiesPerMiliSecond()
	}

	private func recalculateDisponible() {
		numberOfDisponible = 2
		for i in 0...upgradeList.count - 1 {
			if numberOfUpgrade[i] > 0 {
				numberOfDisponible += 1
			}
		}
		if numberOfDisponible > upgradeList.count {
			numberOfDisponible = upgradeList.count
		}
	}

	private func canBeBuyed(upgrade : Int, price : Double) -> Bool {
		if score < Double(Int.max) {
			if price < Double(Int.max) {
				if Int(score) >= Int(price) {
					return true
				}
			} else {
				if score >= price {
					return true
				}
			}
		} else {
			if score >= Double(price) {
				return true
			}
		}
		return false

	}

	private func recalculateCookiesPerMiliSecond() {
		cookiesPerMiliSecond = 0
		for i in 0...upgradeList.count - 1 {
			cookiesPerMiliSecond += upgradeList[i].cookPerUnitPerSecond/10 * Double(numberOfUpgrade[i])
		}
	}

	func loadNew(data : Array<Any>) {
		score = data[0] as! Double
		numberOfUpgrade = data[1] as! Array<Int>
		recalculateData()
	}
}
