//
//  Soundex.swift
//  speller
//
//  Created by Clifford Helsel on 4/28/16.
//
//  Based on standard Soundex algorithm and loosely ported from Apache Commons
//  https://commons.apache.org/proper/commons-codec/apidocs/src-html/org/apache/commons/codec/language/Soundex.html


public class Soundex {
    
    private static let en_mapping_string = Array("01230120022455012623010202".characters)
    private static let en_alphabet =       Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
    private let mapping: [Character:Character] = Soundex.buildMapping(en_alphabet,alphabet:en_mapping_string)
    
    private static func buildMapping(codes: Array<Character>, alphabet: Array<Character>) -> [Character:Character] {
        var retval: [Character:Character] = [:]
        for (index,code) in codes.enumerate() {
            retval[code] = alphabet[index]
        }
        return retval
    }
    
    private var soundexMapping: Array<Character> = Array(count: 4, repeatedValue: " ")
    
    private func getMappingCode(s: String, index:Int) -> Character {
        
        let char = s[s.startIndex.advancedBy(index)]
        let mappedChar = mapChar(char)
        guard mappedChar != "0" else { return mappedChar }
        
        if (index>0)
        {
            let prevChar = s[s.startIndex.advancedBy(index-1)]
            if mapChar(prevChar) == mappedChar {
                return "0"
            }
            
            if (index>1) {
                let preprevChar = s[s.startIndex.advancedBy(index-2)]
                if (mappedChar == mapChar(preprevChar)) && (prevChar=="H" || prevChar=="W") {
                    return "0"
                }
            }
        }
        
        return mappedChar
    }
    
    private func mapChar(c: Character) -> Character {
        if let val = mapping[c] {
            return val
        }
        return "0" // not specified in original Soundex specification, if character is not found, code is 0
    }
    
    public func soundex(of: String) -> String {
        
        guard (of.characters.count>0) else {
            return ""
        }
        
        let str=of.uppercaseString
        
        var out: Array<Character> = Array("0000".characters)
        var mapped: Character = "0"
        var incount=1
        var count = 1

        out[0]=str[str.startIndex]
        while (incount < str.characters.count && count < out.count) {
            mapped = getMappingCode(str, index: incount)
            incount += 1
            if (mapped != "0") {
                out[count]=mapped
                count += 1
            }
        }
        return String(out)
    }
}
