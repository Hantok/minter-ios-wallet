//
//  TransactionDateFormatter.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 23/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation

class TransactionDateFormatter : DateFormatter {
	
	class var transactionDateFormatter : DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		formatter.timeZone = TimeZone.current//TimeZone(identifier: "GMT")
		formatter.locale = Locale.current
		return formatter
	}
	
	class var transactionTimeFormatter : DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		formatter.timeZone = TimeZone(identifier: "GMT")
		formatter.locale = Locale.current
		return formatter
	}
	
	
}

