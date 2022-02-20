import RxSwift
import RxCocoa

enum CVDetailModel {
    struct Output {
        let onSaveComplete: Driver<Void>
        let onSaveError: Driver<CVDetailError>
    }
    
    enum CVDetailError: Error {
        case failToSave
    }
}
