import Foundation

class UserDefaultService {
    static func getCVList() -> [CVModel] {
        guard let list = UserDefaults.standard.value(forKey: "CVList") as? [CVModel] else {
            return []
        }
        return list
    }
    
    private static func saveList(list: [CVModel]) {
        UserDefaults.standard.setValue(list, forKey: "CVList")
    }
    
    static func addOrUpdateCV(newModel: CVModel) {
        var list = getCVList()
        guard let existingIndex = list.firstIndex(where: { model in
            return model.id == newModel.id
        }) else {
            list.append(newModel)
            return
        }
        list[existingIndex] = newModel
        saveList(list: list)
    }
}
