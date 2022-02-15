import Foundation

typealias Codable = Encodable & Decodable
struct CVModel: Codable {
    var id: Int
    var photo: String
    var mobileNo: String
    var email: String
    var address: String
    var careerObjective: String
    var workExperience: WorkExperience
    var skill: [String]
    var education: Education
    var project: Project
}

struct WorkExperience: Codable {
    var companyName: String
    var duration: WorkDuration
}

struct WorkDuration: Codable {
    var year: Int
    var month: Int
}

struct Education: Codable {
    var eduClass: String
    var passingYear: String
    var gpa: String
}

struct Project: Codable {
    var name: String
    var size: Int
    var summary: String
    var techStack: String
    var role: String
}
