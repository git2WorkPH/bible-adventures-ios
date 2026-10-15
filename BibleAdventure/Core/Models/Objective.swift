import Foundation

struct Objective: Codable {

    let id: String

    let title: String

    let instruction: String

    let hint: String?

    let type: ObjectiveType

    let reference: BibleReference

    let scripture: String

    let questionId: String
    
    let storyId: StoryID

}
