////This file was created on 31/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class GameTableViewCell: UITableViewCell {
	var save = SaveServices.shared
	var index = 0

	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var name: UILabel!
	var previousValue = ""
	@IBOutlet weak var nameLabel: UITextField!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func okButtonPressed(_ sender: Any) {
			if let text = nameLabel.text {

				for i in 0...save.names.count - 1 {
					if text == save.names[i] {
						nameLabel.text = previousValue
						nameLabel.resignFirstResponder()
						return
					}
				}
				save.renameGAme(index: index, newName: text)
				nameLabel.resignFirstResponder()
			}
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	func configure(index : Int, editing : Bool) {
		if editing {
			name.text = ""
			nameLabel.isHidden = false
			nameLabel.text = save.names[index]
			self.index = index
			previousValue = save.names[index]
			name.isHidden = true
			okButton.isHidden = false
		} else {
			nameLabel.isHidden = true
			name.isHidden = false
			okButton.isHidden = true
		}
		name.text = save.names[index]
	}
	
}
