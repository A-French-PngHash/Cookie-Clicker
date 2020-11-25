////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class UpgradeTableViewCell: UITableViewCell {
	@IBOutlet weak var upgradeLogo: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var numberOfUpgradeLabel: UILabel!
	var delegate: InfoButtonDelegate?
	
	@IBOutlet weak var blackMask: UIView!
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	func configure(name : String, price : Double, logo : UIImage, numberOfUpgrade : Int, canBeBuyed : Bool) {

		blackMask.isUserInteractionEnabled = false
		upgradeLogo.image = logo
		priceLabel.text = "\(floor(price))"
		nameLabel.text = name
		numberOfUpgradeLabel.text = "\(numberOfUpgrade)"
		blackMask.isHidden = canBeBuyed
	}

	@IBAction func InfoButtonPressed(_ sender: Any) {
        delegate?.infoButtonPressed(for: nameLabel.text!, self)
	}
}

protocol InfoButtonDelegate {
	func infoButtonPressed(for upgrade : String, _ tableViewCell : UpgradeTableViewCell)
}
