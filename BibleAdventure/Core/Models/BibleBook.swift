import Foundation

enum BibleBook:String, Codable {
    case genesis = "Genesis"
    case exodus = "Exodus"
    case leviticus = "Leviticus"
    case numbers = "Numbers"
    case deuteronomy = "Deuteronomy"
    case firstSamuel = "1 Samuel"
    
}


extension BibleBook {
    var displayName:String {
        rawValue
    }
}
