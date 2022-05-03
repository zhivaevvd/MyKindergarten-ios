//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public extension String {
    func replace(_ with: String, at index: Int) -> String {
        var modifiedString = String()
        for (i, char) in enumerated() {
            modifiedString += String((i == index) ? with : String(char))
        }
        return modifiedString
    }

    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    var uppers: String {
        components(separatedBy: CharacterSet.uppercaseLetters.inverted)
            .joined()
    }

    var lowers: String {
        components(separatedBy: CharacterSet.lowercaseLetters.inverted)
            .joined()
    }

    var specials: Int {
        length - lowers.length - uppers.length - digits.length
    }

    var length: Int {
        count
    }

    var adaptedPhone: String {
        replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+7", with: "7")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "#", with: "")
    }

    var maskedPhoneNumber: String {
        let pattern = "+# ### ### ## ##"
        let replacementCharacter: Character = "#"
        var pureNumber = purePhoneNumber
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                return pureNumber
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else {
                continue
            }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }

    var purePhoneNumber: String {
        var pureNumber = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if pureNumber.count > 2 || pureNumber.count == 1, pureNumber.first == "8" {
            pureNumber = "7" + String(pureNumber.dropFirst())
        }
        return pureNumber
    }

    func applyingMask(
        _ mask: String,
        replacingCharacter replacementCharacter: Character = "#"
    ) -> String {
        var result = ""
        var currentCharacterIndex = startIndex
        for character in mask {
            if character == replacementCharacter, indices.contains(currentCharacterIndex) {
                let currentCharacter = self[currentCharacterIndex]
                result.append(currentCharacter)
                currentCharacterIndex = index(after: currentCharacterIndex)
            } else {
                result.append(character)
            }
        }
        return result
    }
}
