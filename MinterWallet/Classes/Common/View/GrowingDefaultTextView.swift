//
//  GrowingDefaultTextView.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 27/04/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
//import GrowingTextView
import SwiftValidator


class GrowingDefaultTextView: AutoGrowingTextView, Validatable {
	
	//MARK: - IBOutlets
	
//	var activityIndicator: UIActivityIndicatorView?
	
	//MARK: -
	
	public var validationText: String {
		return self.text ?? ""
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		
		setDefault()
		
//		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//		activityIndicator?.backgroundColor = .red
//		activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
//
//		self.superview?.addSubview(activityIndicator!)
		
	}
	
	func setValid() {
		setDefault()
	}
	
	func setInvalid() {
		self.layer.cornerRadius = 8.0
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor(hex: 0xEC373C)?.cgColor
	}
	
	//MARK: -
	
	func setDefault() {
		self.layer.cornerRadius = 8.0
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor(hex: 0x929292, alpha: 0.4)?.cgColor
	}
	
	//MARK: -
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}

}
