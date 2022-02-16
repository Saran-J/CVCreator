import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    public func asDriverIgnoreError() -> RxCocoa.Driver<Self.Element> {
        return self.asDriver(onErrorRecover: { _ in return Driver<Self.Element>.empty() })
    }
}
