//
//  ConvertTransactionTableViewCell.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 11/07/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import AlamofireImage


class ConvertTransactionTableViewCellItem : BaseCellItem {
	var txHash: String?
	var title: String?
	var image: UIImage?
	var date: Date?
	var from: String?
	var to: String?
	var coin: String?
	var amount: Double?
	var expandable: Bool?
}
	
protocol ConvertTransactionTableViewCellDelegate : class {
	func didTapExpandedButton(cell: ConvertTransactionTableViewCell)
}
	
class ConvertTransactionTableViewCell: ExpandableCell {
		
		//MARK: -
		
		let formatter = CurrencyNumberFormatter.transactionFormatter
		let dateFormatter = TransactionDateFormatter.transactionDateFormatter
		let timeFormatter = TransactionDateFormatter.transactionTimeFormatter
		
		weak var delegate: ConvertTransactionTableViewCellDelegate?
		
		//MARK: - IBOutlets
		
		@IBOutlet weak var title: UILabel!
		
		@IBOutlet weak var coinImageWrapper: UIView! {
			didSet {
				coinImageWrapper.layer.applySketchShadow(color: UIColor(hex: 0x000000, alpha: 0.2)!, alpha: 1, x: 0, y: 2, blur: 18, spread: 0)
			}
		}
		@IBOutlet weak var coinImage: UIImageView! {
			didSet {
				coinImage.makeBorderWithCornerRadius(radius: 17.0, borderColor: .white, borderWidth: 2.0)
			}
		}
		
		@IBOutlet weak var amount: UILabel!
		
		@IBOutlet weak var coin: UILabel!
		
		@IBOutlet weak var fromAddressLabel: UILabel!
		
		@IBOutlet weak var toAddressLabel: UILabel!
		
		@IBOutlet weak var expandedAmountLabel: UILabel!
		
		@IBOutlet weak var coinLabel: UILabel!
		
		@IBOutlet weak var dateLabel: UILabel!
		
		@IBOutlet weak var timeLabel: UILabel!
		
		//MARK: -
		
		required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
		}
		
		override func awakeFromNib() {
			super.awakeFromNib()
		}
		
		override func setSelected(_ selected: Bool, animated: Bool) {
			super.setSelected(selected, animated: animated)
		}
		
		//MARK: -
		
		override func configure(item: BaseCellItem) {
			if let transaction = item as? ConvertTransactionTableViewCellItem {
				title.text = transaction.title
				coinImage.image = UIImage(named: "convertImage")
				if let image = transaction.image {
					coinImage.image = image
				}
				amount.text = amountText(amount: transaction.amount ?? 0)
				amount.textColor = ((transaction.amount ?? 0) > 0) ? UIColor(hex: 0x35B65C) : .black
				
				fromAddressLabel.text = transaction.from
				toAddressLabel.text = transaction.to
				expandedAmountLabel.text = amountText(amount: transaction.amount ?? 0)
				coinLabel.text = transaction.coin
				dateLabel.text = dateFormatter.string(from: transaction.date ?? Date())
				timeLabel.text = timeFormatter.string(from: transaction.date ?? Date())
				
				coin.text = transaction.coin
				expandable = transaction.expandable ?? false
			}
		}
		
		private func amountText(amount: Double) -> String {
			return formatter.string(from: amount as NSNumber) ?? ""
		}
		
		//MARK: -
		
		@IBAction func didTapExpandedButton(_ sender: Any) {
			delegate?.didTapExpandedButton(cell: self)
		}
		
		//MARK: -
		
		override func layoutSubviews() {
			super.layoutSubviews()
		}
		
		override func prepareForReuse() {
			super.prepareForReuse()
			
			if expanded {
				
			}
			
		}
		
}