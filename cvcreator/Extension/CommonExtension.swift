import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    public func asDriverIgnoreError() -> RxCocoa.Driver<Self.Element> {
        return self.asDriver(onErrorRecover: { _ in return Driver<Self.Element>.empty() })
    }
}

extension UIStoryboard {
    public static func getViewController(name: String) -> UIViewController? {
        let viewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
        return viewController
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
}
