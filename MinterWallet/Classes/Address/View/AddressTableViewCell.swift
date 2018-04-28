//
//  AddressTableViewCell.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 26/04/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import SVProgressHUD


class AddressTableViewCellItem : BaseCellItem {
	
	var address: String?
	
	var buttonTitle: String?
	
}


class AddressTableViewCell: BaseCell {
	
	//MARK: - IBOutlet/IBAction
	
	@IBOutlet weak var addressLabel: UILabel!
	
	@IBOutlet weak var actionButton: UIButton!
	
	@IBAction func didTapActionButton(_ sender: Any) {
		UIPasteboard.general.string = addressLabel.text
		
		SVProgressHUD.showSuccess(withStatus: "Copied")
	}
	
	//MARK: -

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	//MARK: - BaseCell
	
	override func configure(item: BaseCellItem) {
		if let addressItem = item as? AddressTableViewCellItem {
			addressLabel.text = addressItem.address
			
			actionButton.setTitle(addressItem.buttonTitle, for: .normal)
		}
	}
    
}
