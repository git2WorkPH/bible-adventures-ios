import Foundation

enum BibleBook:String {
    case genesis = "Genesis"
    case exodus = "Exodus"
    case leviticus = "Leviticus"
    case numbers = "Numbers"
    case deuteronomy = "Deuteronomy"
    
}


extension BibleBook {
    var displayName:String {
        rawValue
    }
}
