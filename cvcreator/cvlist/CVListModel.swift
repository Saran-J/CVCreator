import Foundation
import RxSwift
import RxCocoa



enum CVListModel {
    struct Output {
        let onGetCVList: Driver<[CVModel]>
        let onError: Driver<CVListError>
    }
}

enum CVListError: Error {
    case empty
}
