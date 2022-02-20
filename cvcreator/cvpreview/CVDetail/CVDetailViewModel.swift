import Foundation
import UIKit
import RxSwift
import RxCocoa

class CVDetailViewModel {
    let onSave = PublishSubject<Void>()
    let onError = PublishSubject<CVDetailModel.CVDetailError>()
    func calculcateWorkExpTotalDuration(workExp: [WorkExperience]) -> WorkDuration {
        var totalYear = 0
        var totalMonth = 0
        workExp.forEach { exp in
            let year = exp.duration.year
            let month = exp.duration.month
            totalYear += year
            totalMonth += month
        }
        let yearFromMonth = totalMonth / 12
        let leftMont = totalMonth % 12
        totalYear += yearFromMonth
        return WorkDuration(year: totalYear, month: leftMont)
    }
    
    func convertUIImageToNSData(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        return data.base64EncodedString()
    }
    
    func saveCV(model: CVModel) {
        UserDefaultService.addOrUpdateCV(newModel: model)
        onSave.onNext(())
    }
}
