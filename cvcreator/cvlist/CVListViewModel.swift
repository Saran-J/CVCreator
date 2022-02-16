import Foundation
import RxSwift
import RxCocoa

class CVListViewModel {
    let cvListSubject = PublishSubject<[CVModel]>()
    let errorSubject = PublishSubject<CVListError>()
    var output: CVListModel.Output
    
    init() {
        output = CVListModel.Output(
            onGetCVList: cvListSubject.asDriverIgnoreError(),
            onError: errorSubject.asDriverIgnoreError()
        )
    }
    
    func getCVList() {
        let list = UserDefaultService.getCVList()
        if list.isEmpty {
            errorSubject.onNext(.empty)
            return
        }
        cvListSubject.onNext(list)
    }
}
