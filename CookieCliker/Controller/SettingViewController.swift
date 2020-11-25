////This file was created on 27/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class SettingViewController: UIViewController {
	var tableView : UITableView?
	//var isEditing : Bool = false
	var canEdit : Bool = false
	var game : Game{
		get {
			return SaveServices.shared.game
		}
	}

	var save = SaveServices.shared
	@IBOutlet weak var codeLabel: UITextField!
	@IBOutlet weak var saveGameButton: UIButton!
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var newGameButton: UIButton!

	@IBOutlet weak var copyButton: UIButton!
	@IBAction func newGameButtonPressed() {
		let alert = UIAlertController(title: "Create New Game", message: "Write the name of your game (you will be able to change it later)", preferredStyle: .alert)
		alert.addTextField {(textField : UITextField) in
			textField.placeholder = "My Games"
			textField.autocapitalizationType = .words
			textField.layer.cornerRadius = 6
			textField.font = UIFont(name: "Marker Felt", size: 17)
		}
		alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action : UIAlertAction) in
			if let textFields = alert.textFields {
				if let text = textFields[0].text {
					if textFields[0].text == "" {
					} else {
						self.save.createNewGame(name: text)
					}
					self.tableView!.reloadData()
				}
			}
		}))
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(cancel)
		self.present(alert, animated: true, completion: nil)
	}
	@IBAction func backButtonPressed() {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func editButtonPressed(_ sender: Any) {
		if canEdit {
			editButton.setImage(UIImage(named: "editButton"), for: .normal)
		} else {
			editButton.setImage(UIImage(named: "greenCheck"), for: .normal)
		}
		canEdit = !canEdit
		tableView!.reloadData()
	}

	@IBAction func saveGamePressed() {
		save.saveData()
	}

	@IBAction func copyeButtonPressed(_ sender: Any) {
		UIPasteboard.general.string = codeLabel.text
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		saveGameButton.layer.cornerRadius = 6
		newGameButton.layer.cornerRadius = newGameButton.frame.width / 2
		editButton.layer.cornerRadius = editButton.frame.width / 2
		export()
	}

	func export() {
		save.saveData()
		let exportKey = ExportService.shared.export()
		codeLabel.text = exportKey
	}

	func deleteGame(_ game : Int) {
		save.deleteGame(index: game)
		tableView!.reloadData()
	}

	func isNameValid(name : String) -> Bool {
		for i in 0...save.names.count - 1 {
			if save.names[i] ==  name {
				return false
			}
		}
		return true
	}
}


extension SettingViewController : UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.tableView = tableView
		return save.names.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! GameTableViewCell
		print(canEdit)

		cell.configure(index: indexPath.row, editing : canEdit)
		
		cell.backgroundColor = .white
		if !canEdit {
			if indexPath.row == save.actualGame {
				cell.backgroundColor = .gray
			}
		}
		cell.nameLabel.delegate = self
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			if save.names.count == 1 {
				let alert = UIAlertController(title: "Restricted Action", message: "You can't delete this game without creating a new one before. If you delete it like that there will be no other game", preferredStyle: UIAlertController.Style.alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
				self.present(alert, animated: true, completion: nil)

			} else {

				let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete your game ? All that you've done will be lost.", preferredStyle: .actionSheet)
				alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
				alert.addAction(UIAlertAction(title:" Delete", style: .destructive, handler: {(action:UIAlertAction!) in
					SaveServices.shared.deleteGame(index : indexPath.row)
					tableView.reloadData()
				}))
				self.present(alert, animated: true, completion: nil)
			}
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		save.saveData()
		let cell = tableView.cellForRow(at: indexPath)! as! GameTableViewCell
		let name = cell.name.text
		save.loadGame(withName: name!)
		tableView.reloadData()
		export()
	}
}

extension SettingViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		print("return")
		return true
	}

}
