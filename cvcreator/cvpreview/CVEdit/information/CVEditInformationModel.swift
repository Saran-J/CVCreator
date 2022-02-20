enum InformationType {
    case address
    case careerObjective
    
    func getTitle() -> String {
        switch self {
        case .address:
            return "Address"
        case .careerObjective:
            return "Career Objective"
        }
    }
}
