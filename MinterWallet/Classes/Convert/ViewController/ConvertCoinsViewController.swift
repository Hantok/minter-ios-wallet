//
//  ConvertCoinsViewController.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 17/07/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import RxSwift
import NotificationBannerSwift


class ConvertCoinsViewController: BaseViewController {
	
	var viewModel: ConvertCoinsViewModel? {
		didSet {
			viewModel?.feeObservable.asDriver(onErrorJustReturn: "").drive(feeLabel.rx.text).disposed(by: self.disposableBag)
//			viewModel?.feeObservable.subscribe(onNext: { (val) in
//				self.feeLabel.text = val
//			}).disposed(by: self.disposableBag)
		}
	}
	
	let coinFormatter = CurrencyNumberFormatter.coinFormatter
	
	//MARK: - 
	
	@IBOutlet weak var feeLabel: UILabel! {
		didSet {
			feeLabel.layer.zPosition = -1
		}
	}
	
	@IBOutlet weak var approximately: UILabel!
	
	@IBOutlet weak var buttonActivityIndicator: UIActivityIndicatorView!
	
	@IBOutlet weak var getActivityIndicator: UIActivityIndicatorView!
	
	@IBOutlet weak var exchangeButton: DefaultButton!
	
	@IBOutlet weak var autocompleteViewWrapper: UIView!
	
	@IBOutlet weak var autocompleteView: LUAutocompleteView! {
		didSet {
			autocompleteView.autocompleteCellNibName = "CoinAutocompleteCell"
		}
	}
	
	@IBOutlet weak var getCoinTextField: ValidatableTextField! {
		didSet {
			setAppearance(for: getCoinTextField)
		}
	}
	
	//MARK: -
	
	var disposableBag = DisposeBag()
	
	//MARK: -

	override func viewDidLoad() {
		super.viewDidLoad()

		autocompleteView.textField = getCoinTextField
		
		autocompleteView.dataSource = self
		autocompleteView.delegate = self
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
	
	//MARK: -
	
	func toggleTextFieldBorder(textField: UITextField?) {
		if textField?.isEditing == true {
			textField?.layer.borderColor = UIColor(hex: 0x502EC2)?.cgColor
		}
		else {
			textField?.layer.borderColor = UIColor(hex: 0x929292, alpha: 0.4)?.cgColor
		}
	}
	
	func setAppearance(for textField: UITextField) {
		textField.layer.cornerRadius = 8.0
		textField.layer.borderWidth = 2
		textField.layer.borderColor = UIColor(hex: 0x929292, alpha: 0.4)?.cgColor
		textField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
			.asObservable()
			.subscribe(onNext: { [weak self] state in
				self?.toggleTextFieldBorder(textField: textField)
			}).disposed(by: disposableBag)
	}

}

// MARK: - LUAutocompleteViewDataSource

extension ConvertCoinsViewController: LUAutocompleteViewDataSource {
	func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
		
		viewModel?.coinNames(by: text) { (coins) in
			if coins.count == 1 && (coins.first ?? "") == text {
				completion([])
			}
			else {
				completion(coins)
			}
		}
	}
}

// MARK: - LUAutocompleteViewDelegate

extension ConvertCoinsViewController: LUAutocompleteViewDelegate {
	
	func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
		//HACK: Remove after GetCoinsViewModel refactoring
		if let vm = viewModel as? GetCoinsViewModel {
			vm.getCoin.onNext(text)
		}
//		viewModel?.getCoin.value = text
		//		print(text + " was selected from autocomplete view")
	}
}
