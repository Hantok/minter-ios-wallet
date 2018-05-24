//
// Autogenerated by Natalie - Storyboard Generator
// by Marcin Krzyzanowski http://krzyzanowskim.com
//
import UIKit

// MARK: - Storyboards

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
        let instance = type.init()
        if let identifier = instance.storyboardIdentifier {
            return self.instantiateViewController(withIdentifier: identifier) as? T
        }
        return nil
    }

}

protocol Storyboard {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

struct Storyboards {

    struct Settings: Storyboard {

        static let identifier = "Settings"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Popup: Storyboard {

        static let identifier = "Popup"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> SendPopupViewController {
            return self.storyboard.instantiateInitialViewController() as! SendPopupViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }

        static func instantiateCountdownPopupViewController() -> CountdownPopupViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "CountdownPopupViewController") as! CountdownPopupViewController
        }
    }

    struct CreateWallet: Storyboard {

        static let identifier = "CreateWallet"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> CreateWalletViewController {
            return self.storyboard.instantiateInitialViewController() as! CreateWalletViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Coins: Storyboard {

        static let identifier = "Coins"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }

        static func instantiateCoinsViewController() -> CoinsViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "CoinsViewController") as! CoinsViewController
        }
    }

    struct Receive: Storyboard {

        static let identifier = "Receive"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UIViewController {
            return self.storyboard.instantiateInitialViewController()!
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Transactions: Storyboard {

        static let identifier = "Transactions"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> TransactionsViewController {
            return self.storyboard.instantiateInitialViewController() as! TransactionsViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Address: Storyboard {

        static let identifier = "Address"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> AddressViewController {
            return self.storyboard.instantiateInitialViewController() as! AddressViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct AdvancedMode: Storyboard {

        static let identifier = "AdvancedMode"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> AdvancedModeViewController {
            return self.storyboard.instantiateInitialViewController() as! AdvancedModeViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Root: Storyboard {

        static let identifier = "Root"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> RootViewController {
            return self.storyboard.instantiateInitialViewController() as! RootViewController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Send: Storyboard {

        static let identifier = "Send"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Login: Storyboard {

        static let identifier = "Login"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }

        static func instantiateLoginViewController() -> HomeViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! HomeViewController
        }
    }

    struct LaunchScreen: Storyboard {

        static let identifier = "LaunchScreen"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UIViewController {
            return self.storyboard.instantiateInitialViewController()!
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }

    struct Main: Storyboard {

        static let identifier = "Main"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> TabBarController {
            return self.storyboard.instantiateInitialViewController() as! TabBarController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }
}

// MARK: - ReusableKind
enum ReusableKind: String, CustomStringConvertible {
    case tableViewCell = "tableViewCell"
    case collectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

// MARK: - SegueKind
enum SegueKind: String, CustomStringConvertible {
    case relationship = "relationship"
    case show = "show"
    case presentation = "presentation"
    case embed = "embed"
    case unwind = "unwind"
    case push = "push"
    case modal = "modal"
    case popover = "popover"
    case replace = "replace"
    case custom = "custom"

    var description: String { return self.rawValue }
}

// MARK: - IdentifiableProtocol

public protocol IdentifiableProtocol: Equatable {
    var storyboardIdentifier: String? { get }
}

// MARK: - SegueProtocol

public protocol SegueProtocol {
    var identifier: String? { get }
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ==<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

public func ~=<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

// MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? { get }
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.storyboardIdentifier == rhs.storyboardIdentifier
}

// MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

// MARK: - UIViewController extension
extension UIViewController {
    func perform<T: SegueProtocol>(segue: T, sender: Any?) {
        if let identifier = segue.identifier {
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func perform<T: SegueProtocol>(segue: T) {
        perform(segue: segue, sender: nil)
    }
}
// MARK: - UICollectionView

extension UICollectionView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UICollectionViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, for: IndexPath) -> UICollectionReusableView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
// MARK: - UITableView

extension UITableView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UITableViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
             register(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

// MARK: - SettingsViewController
extension UIStoryboardSegue {
    func selection() -> SettingsViewController.Segue? {
        if let identifier = self.identifier {
            return SettingsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
extension SettingsViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case showAddress = "showAddress"
        case showUsername = "showUsername"
        case showMobile = "showMobile"
        case showEmail = "showEmail"
        case showPassword = "showPassword"

        var kind: SegueKind? {
            switch self {
            case .showAddress:
                return SegueKind(rawValue: "show")
            case .showUsername:
                return SegueKind(rawValue: "show")
            case .showMobile:
                return SegueKind(rawValue: "show")
            case .showEmail:
                return SegueKind(rawValue: "show")
            case .showPassword:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            case .showUsername:
                return UsernameEditViewController.self
            case .showMobile:
                return MobileEditViewController.self
            case .showEmail:
                return EmailEditViewController.self
            case .showPassword:
                return PasswordEditViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}
extension SettingsViewController {

    enum Reusable: String, CustomStringConvertible, ReusableViewProtocol {
        case SettingsAvatarTableViewCell_ = "SettingsAvatarTableViewCell"

        var kind: ReusableKind? {
            switch self {
            case .SettingsAvatarTableViewCell_:
                return ReusableKind(rawValue: "tableViewCell")
            }
        }

        var viewType: UIView.Type? {
            switch self {
            case .SettingsAvatarTableViewCell_:
                return SettingsAvatarTableViewCell.self
            }
        }

        var storyboardIdentifier: String? { return self.description }
        var description: String { return self.rawValue }
    }

}

// MARK: - UsernameEditViewController

// MARK: - MobileEditViewController

// MARK: - EmailEditViewController

// MARK: - PasswordEditViewController

// MARK: - SendPopupViewController

// MARK: - CountdownPopupViewController
protocol CountdownPopupViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension CountdownPopupViewController: CountdownPopupViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: CountdownPopupViewController {
    var storyboardIdentifier: String? { return "CountdownPopupViewController" }
    static var storyboardIdentifier: String? { return "CountdownPopupViewController" }
}

// MARK: - SendPopupViewController

// MARK: - CreateWalletViewController

// MARK: - CoinsViewController
extension UIStoryboardSegue {
    func selection() -> CoinsViewController.Segue? {
        if let identifier = self.identifier {
            return CoinsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
protocol CoinsViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension CoinsViewController: CoinsViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: CoinsViewController {
    var storyboardIdentifier: String? { return "CoinsViewController" }
    static var storyboardIdentifier: String? { return "CoinsViewController" }
}
extension CoinsViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case showTransactions = "showTransactions"

        var kind: SegueKind? {
            switch self {
            case .showTransactions:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - TransactionsViewController

// MARK: - AddressViewController
extension UIStoryboardSegue {
    func selection() -> AddressViewController.Segue? {
        if let identifier = self.identifier {
            return AddressViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
extension AddressViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case showBalance = "showBalance"

        var kind: SegueKind? {
            switch self {
            case .showBalance:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - AdvancedModeViewController
extension UIStoryboardSegue {
    func selection() -> AdvancedModeViewController.Segue? {
        if let identifier = self.identifier {
            return AdvancedModeViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
extension AdvancedModeViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case showGenerate = "showGenerate"

        var kind: SegueKind? {
            switch self {
            case .showGenerate:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            case .showGenerate:
                return GenerateAddressViewController.self
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - GenerateAddressViewController

// MARK: - RootViewController

// MARK: - SendViewController

// MARK: - HomeViewController
extension UIStoryboardSegue {
    func selection() -> HomeViewController.Segue? {
        if let identifier = self.identifier {
            return HomeViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
protocol HomeViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension HomeViewController: HomeViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: HomeViewController {
    var storyboardIdentifier: String? { return "LoginViewController" }
    static var storyboardIdentifier: String? { return "LoginViewController" }
}
extension HomeViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case showAdvanced = "showAdvanced"

        var kind: SegueKind? {
            switch self {
            case .showAdvanced:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - LoginViewController

// MARK: - TabBarController
