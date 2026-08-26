import Foundation

struct BibleReference {

    let book: BibleBook
    let chapter: Int
    let startVerse: Int
    let endVerse: Int?


    var displayText: String {

        if let endVerse {
            return "\(book.displayName) \(chapter):\(startVerse)-\(endVerse)"
        }
//        
//        if let secndChapter {
//            return "\((book.displayName), \(firstChapter):\(startVerse):(endVerse)-\(secndChapter):\(startVerse):(endVerse))"
//        }

        return "\(book.displayName) \(chapter):\(startVerse)"
    }
}
