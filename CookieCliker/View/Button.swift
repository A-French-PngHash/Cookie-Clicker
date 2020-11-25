////This file was created on 27/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class CircleButton: UIButton {
	override func awakeFromNib() {
		super.awakeFromNib()
		addCornerRadius()
	}

	private func addCornerRadius() {
		layer.cornerRadius = 100
	}
}
