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
    let mapping: [Character:Character] = Soundex.buildMapping(codes:en_alphabet,alphabet:en_mapping_string)
    
    static func buildMapping(codes: Array<Character>, alphabet: Array<Character>) -> [Character:Character] {
        var retval: [Character:Character] = [:]
        for (index,code) in codes.enumerated() {
            retval[code] = alphabet[index]
        }
        return retval
    }
    
    var soundexMapping: Array<Character> = Array(repeating:" ",count:4)
    
    func getMappingCode(s: String, index:Int) -> Character {
//        let i = s.characters.startIndex.advanced(by:index) // get index in string, Unicode safe
        let i = s.index(s.startIndex, offsetBy: index)

        
        let mappedChar = mapChar(c:s[i])
        
        if (index>1 && !(mappedChar=="0"))
        {
            //let j = s.characters.startIndex.advanced(by:index-1)
	let j = s.index(s.startIndex,offsetBy:index-1)
            
            let hwChar = s[j]
            
            if (hwChar=="H" || hwChar=="W")
            {
//                let k = s.characters.startIndex.advanced(by:index-2)
		let k = s.index(s.startIndex,offsetBy:index-2)
                let prehwChar = s[k]
                let firstCode = mapChar(c:prehwChar)
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
    
    func soundex(of: String) -> String {
        
        guard (of.characters.count>0) else {
            return ""
        }
        
        let str=of.uppercased()
        
        var out: Array<Character> = Array("    ".characters)
        var last: Character = " "
        var mapped: Character = " "
        var incount=1
        var count = 1

        out[0]=str[str.startIndex]
        last = getMappingCode(s:str, index: 0)
        while (incount < str.characters.count && count < out.count) {
            mapped = getMappingCode(s:str, index: incount)
            incount += 1
            if (mapped != "0") {
                if (mapped != "0" && mapped != last) {
                    out[count]=mapped
                    count += 1
                }
            }
        }
        return String(out)
    }
}
