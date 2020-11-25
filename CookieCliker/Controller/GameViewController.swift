////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {


	let save = SaveServices.shared
	var cookieSize : CGSize?
	var cookiePosition : CGPoint?
	var scene = GameScene()
	var game : Game {
		get {
			return SaveServices.shared.game
		}
	}
	var loadedGame : Int {
		get {
			return SaveServices.shared.actualGame
		}
	}

	var score : Double {
		get {
			return floor(game.score)
		}
	}
	var cellWhoRequireInfo : UpgradeTableViewCell? = nil
	var upgradeOfCellWhoRequireInfo : cookieClickerUpgrade? = nil
	var tableVue : UITableView? = nil
	var timeBeforeSave = 100

	@IBOutlet weak var settingButton: UIButton!
	@IBOutlet weak var infoView: UIView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var cookiePerSecondWithOneUpgradeLabel: UILabel!
	@IBOutlet weak var cookieperSecondWithAllUpgradeLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var numberOfCookiesLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		scene = GameScene(size: view.bounds.size)
		let skView = view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		skView.ignoresSiblingOrder = true
		scene.scaleMode = .resizeFill
		scene.backgroundColor = .white
		skView.presentScene(scene)
		infoView.isHidden = true

		infoView.layer.zPosition = 10
		numberOfCookiesLabel.frame = CGRect(x: 14, y: 30, width: numberOfCookiesLabel.frame.width, height: numberOfCookiesLabel.frame.height)

		cookieSize = scene.cookie.size
		cookiePosition = scene.cookie.position
		game.initialize()
		loadBackup()

		startTimer()
		refreshCookiesPerSecond()
    }

	override func viewWillAppear(_ animated: Bool) {
		//loadBackup()
		super.viewWillAppear(true)
		refreshCookiesPerSecond()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		hideInfoView()
		let touchLocation = touches.first!.location(in: self.view)
		let x = cookiePosition!.x
		let y = cookiePosition!.y
		let height = cookieSize!.height
		let width = cookieSize!.width
		let posY = self.view.frame.maxY - touchLocation.y

		if touchLocation.x <= x + width/2 {
			if touchLocation.x >= x - width/2 {
				if posY <= y + height/2 {
					if posY >= y - height/2{
						game.cookieClick()
						scene.cookieClick(touchLocation: touchLocation)
						refreshScore()
						reloadData()
					}
				}
			}
		}
	}

	func refreshScore() {
		var score = game.score
		score = floor(score)
		numberOfCookiesLabel.text = "Cookies : \(score)"
	}

	func startTimer() {
		let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timePassed), userInfo: nil, repeats: true)
	}
	@objc func timePassed() {
		if timeBeforeSave <= 0 {
			save.saveData()
			timeBeforeSave = 1000
		} else {
			timeBeforeSave -= 1
		}
		game.timePassed()
		refreshScore()
		if let _ = cellWhoRequireInfo {
			refreshInfoViewData()
		}
		tableVue!.reloadData()
	}

	func refreshCookiesPerSecond() {
		let cookiePerSecond = game.cookiesPerMiliSecond * 10
		var trueCookie = (cookiePerSecond * 10).rounded()
		trueCookie = trueCookie/10
		scene.cookiesPerSecondsLabel.text = "\(trueCookie)"
	}

	func loadBackup() {
		save.loadGame(withName: save.names[save.actualGame])
		refreshScore()
		refreshCookiesPerSecond()
	}
}

extension GameViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		tableVue = tableView
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return game.numberOfDisponible //Nombre de cellules
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "upgradeCell", for : indexPath) as? UpgradeTableViewCell else {
			return UITableViewCell()
		}
		if indexPath.row > game.upgradeList.count{
			return UITableViewCell()
		}
		let upgrade = game.upgradeList[indexPath.row]
		var price: Float = Float(upgrade.baseCost)
		if game.numberOfUpgrade[indexPath.row] != 0 {
			for _ in 0...game.numberOfUpgrade[indexPath.row] - 1{
				price = price * 1.15
			}
		}
		var canBeBuyed = false
		if Double(game.score) < Double(Int.max) {
			if Int(game.score) >= Int(price) {
				canBeBuyed = true
			}
		} else {
			if game.score >= Double(price) {
				canBeBuyed = true
			}
		}
		cell.configure(name: upgrade.name, price: Double(price), logo: upgrade.logo, numberOfUpgrade: game.numberOfUpgrade[indexPath.row], canBeBuyed : canBeBuyed)
		//CHANGER LE FALSE AVEC UN CALCUL
		cell.delegate = self
		cell.selectionStyle = UITableViewCell.SelectionStyle.none
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		scene.playUpgradeSound()
		game.buyOne(upgrade: indexPath.row)
		refreshCookiesPerSecond()
		reloadData()
	}

	func reloadData() {
		tableVue!.reloadData()
	}
}

extension GameViewController : InfoButtonDelegate {
	func infoButtonPressed(for upgrade: String, _ tableViewCell: UpgradeTableViewCell) {
		for i in 0...game.upgradeList.count - 1 {
			if game.upgradeList[i].name == upgrade {
				cellWhoRequireInfo = tableViewCell
				upgradeOfCellWhoRequireInfo = game.upgradeList[i]
				showInfoView()
				refreshInfoViewData()
			}
		}
	}
}

extension GameViewController {
	func showInfoView() {
		infoView.isHidden = false
		descriptionLabel.text = cellWhoRequireInfo!.description
	}
	func hideInfoView() {
		infoView.isHidden = true
		cellWhoRequireInfo = nil
		upgradeOfCellWhoRequireInfo = nil
	}

	func refreshInfoViewData() {
		//Nombre de cookie créer par seconde avec un upgrade de ce type
		guard let upgrade = upgradeOfCellWhoRequireInfo else {
			return
		}
		nameLabel.text = upgrade.name
		descriptionLabel.text = upgrade.description
		cookiePerSecondWithOneUpgradeLabel.text = "A \( cellWhoRequireInfo!.nameLabel.text!) cook \(upgrade.cookPerUnitPerSecond) cookies per second."
		var index = 0
		for i in 0...game.upgradeList.count-1 {
			if game.upgradeList[i].name == cellWhoRequireInfo!.nameLabel.text {
				index = i
			}
		}
		let withOneUpgrade = upgrade.cookPerUnitPerSecond * Double(game.numberOfUpgrade[index]) //Cookies par secondes avec cette upgrade

		var pourcentage = game.cookiesPerMiliSecond * 10 //Cookies par secondes
		pourcentage = withOneUpgrade / Double(pourcentage)
		pourcentage = pourcentage * 100
		pourcentage = round(100 * pourcentage) / 100
		let totalCook = round(upgrade.cookPerUnitPerSecond * Double(game.numberOfUpgrade[index]) * 10) / 10
		
		cookieperSecondWithAllUpgradeLabel.text = "All your \( cellWhoRequireInfo!.nameLabel.text!) cook \(totalCook) cookies per second.(\(pourcentage) % of the production)"
	}
}
