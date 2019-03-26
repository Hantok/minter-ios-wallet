//
//  RootRootViewModel.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 04/04/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import RxSwift
import SwiftCentrifuge
import MinterCore
import MinterExplorer
import RxAppState

class RootViewModel: BaseViewModel {

	private let session = Session.shared

	var title: String {
		get {
			return "Root".localized()
		}
	}

	var channel: String?

	var client: CentrifugeClient?

	var isConnected: Bool = false {
		didSet {
			if self.isConnected == true && !oldValue {
				self.subscribeAccountBalanceChange()
			}
		}
	}

	var addressManager = ExplorerAddressManager.default

	override init() {
		super.init()

		Session.shared.isLoggedIn.asObservable().filter({ (isLoggedIn) -> Bool in
			return isLoggedIn
		}).subscribe(onNext: { (isLoggedIn) in
			//show wallet
			SessionHelper.reloadAccounts()
			Session.shared.loadUser()
		}).disposed(by: disposeBag)

		Session.shared.updateGas()

		Observable.combineLatest(UIApplication.shared.rx.applicationDidBecomeActive, Session.shared.accounts.asObservable(), Session.shared.isLoggedIn.asObservable()).distinctUntilChanged({ (val1, val2) -> Bool in
			return val1.1 == val2.1 && val1.2 == val2.2
		}).filter({ (val) -> Bool in
			let accounts = val.1
			let loggedIn = val.2
			return loggedIn || accounts.count > 0
		}).subscribe(onNext: { [weak self] (state, accounts, loggedIn) in
			let addresses = accounts.map({ (account) -> String in
				return "Mx" + account.address
			})

			guard addresses.count > 0 else {
				if self?.isConnected == true {
					try? self?.client?.disconnect()
				}
				self?.unsubscribeAccountBalanceChange(completed: {

				})
				return
			}

			self?.channel = addresses.first

			self?.connect(completion: {

			})
		}).disposed(by: disposeBag)
	}

	func didLoad() {
		SessionHelper.reloadAccounts()
	}

	func connect(completion: (() -> ())?) {
		if nil == client {
			var config = CentrifugeClientConfig()
			client = CentrifugeClient(url: MinterExplorerWebSocketURL!.absoluteURL.absoluteString + "?format=protobuf", config: config, delegate: self)
		}

		self.client?.connect()
	}

	var sub: CentrifugeSubscription?

	private func subscribeAccountBalanceChange() {
		guard self.isConnected == true, let cnl = self.channel else {
			return
		}
		do {
			let sub = try client?.newSubscription(channel: cnl, delegate: self)
			sub?.subscribe()
		} catch {
			print("Can not create subscription: \(error)")
		}
	}

	private func unsubscribeAccountBalanceChange(completed: (() -> ())?) {

		guard let cnl = self.channel else {
			completed?()
			return
		}
	}

	// MARK: -

	func reloadData() {
		Session.shared.loadBalances()
		Session.shared.loadTransactions()
	}

}

extension RootViewModel : CentrifugeClientDelegate, CentrifugeSubscriptionDelegate {

	// MARK: -

	func onConnect(_ client: CentrifugeClient, _ e: CentrifugeConnectEvent) {
		self.isConnected = true
	}

	func onDisconnect(_ client: CentrifugeClient, _ e: CentrifugeDisconnectEvent) {
		self.isConnected = false
	}

	func onPublish(_ s: CentrifugeSubscription, _ e: CentrifugePublishEvent) {
		self.reloadData()
	}
}
