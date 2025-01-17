//
//  CoinsCoinsViewController.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 02/04/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture
import RxDataSources
import SafariServices
import AlamofireImage
import NotificationBannerSwift

class CoinsViewController: BaseTableViewController,
ScreenHeaderProtocol,
ControllerType {

	private var disposeBag = DisposeBag()

	lazy var readerVC: QRCodeReaderViewController = {
		let builder = QRCodeReaderViewControllerBuilder {
			$0.reader = QRCodeReader(metadataObjectTypes: [.qr],
															 captureDevicePosition: .back)
			$0.showSwitchCameraButton = false
		}
		return QRCodeReaderViewController(builder: builder)
	}()

	// MARK: - ControllerType

	typealias ViewModelType = CoinsViewModel

	func configure(with viewModel: CoinsViewModel) {

		// Input
		refreshControl.rx.controlEvent([.valueChanged])
			.subscribe(viewModel.input.didRefresh).disposed(by: disposeBag)

		txScanButton.rx.tap.asDriver()
			.drive(viewModel.input.txScanButtonDidTap).disposed(by: disposeBag)

		txScanButton.rx.tap.subscribe({ [weak self] (_) in
//			self?.readerVC.delegate = self
			self?.present(self!.readerVC, animated: true, completion: nil)
			}).disposed(by: disposeBag)

		readerVC.delegate = self
		readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
			self?.readerVC.stopScanning()
			self?.readerVC.dismiss(animated: true) {
				if let res = result?.value {
					self?.viewModel.input.didScanQR.onNext(res)
				}
			}
		}

		// Output
		viewModel.output
			.totalDelegatedBalance
			.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] (val) in
				let defaultTopConstraint = CGFloat(63.0)

				var shouldLayout = false
				if val == nil {
					if self?.delegatedHeaderTopConstraint.constant == -defaultTopConstraint {
						shouldLayout = false
					} else {
						self?.delegatedHeaderTopConstraint.constant = -defaultTopConstraint
						shouldLayout = true
					}
					self?.delegatedBalanceLabel.text = "0.0"
				} else {
					if self?.delegatedHeaderTopConstraint.constant == 0.0 {
						shouldLayout = false
					} else {
						self?.delegatedHeaderTopConstraint.constant = 0.0
						shouldLayout = true
					}
					self?.delegatedBalanceLabel.text = val
				}

				let additionalTop = (self?.shouldShowTestnetToolbar ?? false) ? CGFloat(56) : CGFloat(0)
				if val == nil {
					let top = 60 + additionalTop
					if self?.tableView.contentInset.top != top {
						self?.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
						shouldLayout = true
					}
				} else {
					let top = 100 + additionalTop
					if self?.tableView.contentInset.top != top {
						self?.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
						shouldLayout = true
					}
				}

				UIView.animate(withDuration: 0.5, animations: {
					if shouldLayout {
						self?.view.layoutIfNeeded()
					}
				})
		}).disposed(by: disposeBag)

		viewModel.output.balanceText.subscribe(onNext: { [weak self] (balanceItem) in
			if balanceItem.animated {
				self?.headerViewTitleLabel.pushTransition(0.55)
			}
			self?.headerViewTitleLabel.text = balanceItem.title
			self?.headerViewBalanceLabel.attributedText = balanceItem.text
		}).disposed(by: disposeBag)

		viewModel
			.output
			.showViewController
			.asDriver(onErrorJustReturn: nil)
			.drive(onNext: { [weak self] (viewController) in
				guard let viewController = viewController else { return }
				self?.tabBarController?.present(viewController, animated: true, completion: nil)
			}).disposed(by: disposeBag)

		viewModel
			.output
			.showSendTab
			.asDriver(onErrorJustReturn: ())
			.drive(onNext: { [weak self] (_) in
				self?.tabBarController?.selectedIndex = 1
			}).disposed(by: disposeBag)

		viewModel
			.output
			.error
			.asDriver(onErrorJustReturn: nil)
			.filter({ (notification) -> Bool in
				return nil != notification
			}).drive(onNext: { (notification) in
				let banner = NotificationBanner(title: notification?.title ?? "",
																				subtitle: notification?.text,
																				style: .danger)
				banner.show()
			}).disposed(by: disposeBag)

		self.headerViewBalanceLabel.rx.tapGesture().map({ (_) -> () in
			return ()
		}).subscribe(viewModel.input.didTapBalance).disposed(by: disposeBag)
	}

	// MARK: -

	var refreshControl: UIRefreshControl! {
		didSet {
			refreshControl.translatesAutoresizingMaskIntoConstraints = false
			refreshControl.addTarget(self, action:
				#selector(CoinsViewController.handleRefresh(_:)),
															 for: UIControlEvents.valueChanged)
		}
	}
	@objc func handleRefresh(_ refreshControl: UIRefreshControl) {
		SoundHelper.playSoundIfAllowed(type: .refresh)
		refreshControl.endRefreshing()
	}
	@IBOutlet weak var balanceBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var balanceTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet var usernameView: UsernameView!
	@IBOutlet var headerView: ScreenHeader? {
		didSet {
			headerView?.delegate = self
		}
	}
	//BalanceHeader
	@IBOutlet weak var headerViewBalanceLabel: UILabel!
	@IBOutlet weak var headerViewTitleLabel: UILabel!
	@IBOutlet override weak var tableView: UITableView! {
		didSet {
			tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
			tableView.estimatedRowHeight = 50.0
		}
	}
	@IBOutlet weak var dotCircle1ImageView: UIImageView!
	@IBOutlet weak var dotCircle2ImageView: UIImageView!
	@IBOutlet weak var robotImageView: UIImageView!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var delegatedHeaderTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var delegatedBalanceLabel: UILabel!
	@IBOutlet var tableHeaderTopConstraint: NSLayoutConstraint?
	@IBOutlet weak var txScanButton: UIBarButtonItem!

	var qrCodeReader: QRCodeReaderViewController?
	func processQR(result: String) {}

	// MARK: -

	var rxDataSource: RxTableViewSectionedAnimatedDataSource<BaseTableSectionItem>?

	var tableHeaderTopPadding: Double {
		if shouldShowTestnetToolbar {
			return -105
		}
		return -72
	}

	// MARK: -

	var viewModel = CoinsViewModel()

	// MARK: Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		refreshControl = UIRefreshControl()

		configure(with: viewModel)

		registerCells()

		self.tableView.addSubview(self.refreshControl)

		self.tableView.addConstraints(NSLayoutConstraint
			.constraints(withVisualFormat: "V:|-(-10)-[refreshControl(30)]",
									 options: [],
									 metrics: nil,
									 views: ["refreshControl": refreshControl]))

		self.tableView.addConstraint(NSLayoutConstraint(item: refreshControl,
																										attribute: .centerX,
																										relatedBy: .equal,
																										toItem: tableView,
																										attribute: .centerX,
																										multiplier: 1.0,
																										constant: 0.0))

		rxDataSource = RxTableViewSectionedAnimatedDataSource<BaseTableSectionItem>(
			configureCell: { [weak self] dataSource, tableView, indexPath, sm in

				guard let item = self?.viewModel.cellItem(section: indexPath.section,
																									row: indexPath.row),
					let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier) as? ConfigurableCell else {
					return UITableViewCell()
				}

				cell.configure(item: item)

				if let buttonCell = cell as? ButtonTableViewCell {
					buttonCell.delegate = self
				}
				if let transactionCell = cell as? ExpandableCell {
					transactionCell.delegate = self
				}

				if let accordionCell = cell as? AccordionTableViewCell {
					let isExpanded = self?.expandedIdentifiers
						.contains(accordionCell.identifier) ?? false
					(cell as? ExpandableCell)?.toggle(isExpanded, animated: false)
				}
				return cell
		})

		rxDataSource?.animationConfiguration = AnimationConfiguration(insertAnimation: .top,
																																	reloadAnimation: .automatic,
																																	deleteAnimation: .automatic)

		tableView.rx.setDelegate(self).disposed(by: disposeBag)

		viewModel.sectionsObservable
			.bind(to: tableView.rx.items(dataSource: rxDataSource!)).disposed(by: disposeBag)

		hidesBottomBarWhenPushed = false

		viewModel.errorObservable.distinctUntilChanged()
			.subscribe(onNext: { [weak self] (val) in
				UIView.animate(withDuration: 0.25,animations: {
					if val {
						self?.showPlaceholderView()
					} else {
						self?.hidePlaceholderView()
					}
				})
		}).disposed(by: disposeBag)

		if self.shouldShowTestnetToolbar {
			headerViewHeightConstraint.constant = 73.0 + 56.0
			tableHeaderTopConstraint?.constant = 73.0 + 56.0
			self.view?.addSubview(self.testnetToolbarView)
			self.balanceTopConstraint.constant = 80
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		AnalyticsHelper.defaultAnalytics.track(event: .CoinsScreen)
	}

	// MARK: -

	func updateUsernameView() {
		usernameView.set(username: viewModel.rightButtonTitle,
										 imageURL: viewModel.rightButtonImage)
	}

	func hidePlaceholderView() {
		self.tableView.backgroundColor = .white
		self.dotCircle1ImageView.isHidden = true
		self.dotCircle2ImageView.isHidden = true
		self.robotImageView.isHidden = true
		self.errorLabel.isHidden = true
	}

	func showPlaceholderView() {
		self.tableView.backgroundColor = UIColor(hex: 0x4225A4)
		self.dotCircle1ImageView.isHidden = false
		self.dotCircle2ImageView.isHidden = false
		self.robotImageView.isHidden = false
		self.errorLabel.isHidden = false
	}

	// MARK: -

	@objc func didTapUsernameView() {
		self.tabBarController?.selectedIndex = 3
		AnalyticsHelper.defaultAnalytics.track(event: .CoinsUsernameButton)
	}

	// MARK: -

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let section = viewModel.section(index: section) else {
			return UIView()
		}

		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CoinsTableViewHeaderView")
		if let defaultHeader = header as? CoinsTableViewHeaderView {
			defaultHeader.titleLabel.text = section.header
		}
		return header
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 52
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		super.tableView(tableView, didSelectRowAt: indexPath)

		guard let item = viewModel.cellItem(section: indexPath.section, row: indexPath.row) else {
			return
		}
		performSegue(for: item.identifier)
	}

	func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		if let item = viewModel.cellItem(section: indexPath.section, row: indexPath.row),
			item.reuseIdentifier == "BlankTableViewCell" {
				return false
		}
		return true
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let item = viewModel.cellItem(section: indexPath.section,
																				row: indexPath.row) else {
			return 0.1
		}

		if item.reuseIdentifier == "BlankTableViewCell" {
			return 8.0
		} else if item.reuseIdentifier == "SeparatorTableViewCell" {
			return 1.0
		} else if item.reuseIdentifier == "ButtonTableViewCell" {
			return 70.0
		} else if !expandedIdentifiers.contains(item.identifier) {
			return 55.0
		}
		return UITableViewAutomaticDimension
	}

	// MARK: - ScreenHeaderProtocol

	func additionalUpdateHeaderViewFromScrollEvent(_ scrollView: UIScrollView) {}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		headerView?.updateHeaderViewFromScrollEvent(scrollView)
	}

	// MARK: - Segues

	func performSegue(for cellIdentifier: String) {
		let vm = type(of: self.viewModel)

		//Move to router?
		switch cellIdentifier {
		case vm.cellIdentifierPrefix.convert.rawValue:
			perform(segue: CoinsViewController.Segue.showConvert)
			break

		case vm.cellIdentifierPrefix.transactions.rawValue:
			perform(segue: CoinsViewController.Segue.showTransactions)
			break

		default:
			break
		}
	}

	func presentExplorerController(with url: URL) {
		self.present(CoinsRouter.explorerViewController(url: url), animated: true) {}
	}
}

extension CoinsViewController: ButtonTableViewCellDelegate {

	func ButtonTableViewCellDidTap(_ cell: ButtonTableViewCell) {
		guard let indexPath = tableView.indexPath(for: cell),
			let item = viewModel.cellItem(section: indexPath.section,
																		row: indexPath.row) else { return }

		self.performSegue(for: item.identifier)
	}
}

extension CoinsViewController: ExpandedTransactionTableViewCellDelegate {

	func didTapExplorerButton(cell: ExpandableCell) {
		performLightImpact()

		AnalyticsHelper.defaultAnalytics.track(event: .TransactionExplorerButton)

		if let indexPath = tableView.indexPath(for: cell),
			let url = viewModel.explorerURL(section: indexPath.section,
																			row: indexPath.row) {
			presentExplorerController(with: url)
		}
	}

	func didTapFromButton(cell: ExpandableCell) {
		SoundHelper.playSoundIfAllowed(type: .click)

		if let indexPath = tableView.indexPath(for: cell),
			let cellItem = viewModel.cellItem(section: indexPath.section,
																				row: indexPath.row) as? TransactionCellItem,
			let from = cellItem.from {
				UIPasteboard.general.string = from
				BannerHelper.performCopiedNotification()
		}
	}

	func didTapToButton(cell: ExpandableCell) {
		SoundHelper.playSoundIfAllowed(type: .click)

		if let indexPath = tableView.indexPath(for: cell),
			let cellItem = viewModel.cellItem(section: indexPath.section,
																				row: indexPath.row) as? TransactionCellItem,
			let to = cellItem.to {
				UIPasteboard.general.string = to
				BannerHelper.performCopiedNotification()
		}
	}
}

extension CoinsViewController {

	func registerCells() {
		tableView.register(UINib(nibName: "CoinsTableViewHeaderView", bundle: nil),
											 forHeaderFooterViewReuseIdentifier: "CoinsTableViewHeaderView")
		tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "TransactionTableViewCell")
		tableView.register(UINib(nibName: "ConvertTransactionTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "ConvertTransactionTableViewCell")
		tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "ButtonTableViewCell")
		tableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "CoinTableViewCell")
		tableView.register(UINib(nibName: "SeparatorTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "SeparatorTableViewCell")
		tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "LoadingTableViewCell")
		tableView.register(UINib(nibName: "DelegateTransactionTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "DelegateTransactionTableViewCell")
		tableView.register(UINib(nibName: "MultisendTransactionTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "MultisendTransactionTableViewCell")
		tableView.register(UINib(nibName: "RedeemCheckTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "RedeemCheckTableViewCell")
		tableView.register(UINib(nibName: "SystemTransactionTableViewCell", bundle: nil),
											 forCellReuseIdentifier: "SystemTransactionTableViewCell")
	}
}

extension CoinsViewController: QRCodeReaderViewControllerDelegate {

	func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
		
	}

	func readerDidCancel(_ reader: QRCodeReaderViewController) {
		
	}
}
