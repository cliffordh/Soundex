//
//  Soundex.swift
//  speller
//
//  Created by Clifford Helsel on 4/28/16.
//
//  Based on standard Soundex algorithm and loosely ported from Apache Commons
//  https://commons.apache.org/proper/commons-codec/apidocs/src-html/org/apache/commons/codec/language/Soundex.html


class Soundex {
    
    static let en_mapping_string = Array("01230120022455012623010202".characters)
    static let en_alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
    let mapping: [Character:Character] = Soundex.buildMapping(en_alphabet,alphabet:en_mapping_string)
    
    static func buildMapping(codes: Array<Character>, alphabet: Array<Character>) -> [Character:Character] {
        var retval: [Character:Character] = [:]
        for (index,code) in codes.enumerate() {
            retval[code] = alphabet[index]
        }
        return retval
    }
    
    var soundexMapping: Array<Character> = Array(count:4,repeatedValue:" ")
    
    func getMappingCode(s: String, index:Int) -> Character {
        let i = s.startIndex.advancedBy(index) // get index in string, Unicode safe
        
        let mappedChar = mapChar(s[i])
        
        if (index>1 && !(mappedChar=="0"))
        {
            let j = s.startIndex.advancedBy(index-1)
            
            let hwChar = s[j]
            
            if (hwChar=="H" || hwChar=="W")
            {
                let k = s.startIndex.advancedBy(index-2)
                let prehwChar = s[k]
                let firstCode = mapChar(prehwChar)
                if (firstCode==mappedChar || "H"==prehwChar || "W"==prehwChar) {
                    return "0"
                }
            }
        }
        
        return mappedChar
    }
    
    func mapChar(c: Character) -> Character {
        if let val = mapping[c] {
            return val
        }
        return "0" // not specified in original Soundex specification, if character is not found, code is 0
    }
}
