import Foundation

class UserDefaultService {
    static func getCVList() -> [CVModel] {
        if let data = UserDefaults.standard.value(forKey: "CVList") as? Data {
            let array = try! PropertyListDecoder().decode([CVModel].self, from: data)
            return array
        }
        return []
    }
    
    private static func saveList(list: [CVModel]) {
        if let data = try? PropertyListEncoder().encode(list) {
            UserDefaults.standard.set(data, forKey: "CVList")
        }
    }
    
    static func addOrUpdateCV(newModel: CVModel) {
        var list = getCVList()
        guard let id = newModel.id, let existingIndex = list.firstIndex(where: { model in
            return model.id == id
        }) else {
            var model = newModel
            model.id = (list.last?.id ?? 0) + 1
            list.append(model)
            saveList(list: list)
            return
        }
        list[existingIndex] = newModel
        saveList(list: list)
    }
}
