import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String?
    
    func decrypt(_ plaintext: String, secret: String) -> String?
}

struct CeaserCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decrypted = ""
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decrypted = decrypted + shiftedCharacter
        }
        return decrypted
    }
}

struct AlphanumericCesarCipher: Cipher {
    
    let outputTable: [String] = [
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
        "0","1","2","3","4","5","6","7","8","9"]
    
    func encode(_ plaintext: String, secret: String) -> String? {
        if plaintext.isAlphanumeric {
        } else {
            print("not alphanumeric")
            return nil
        }
        
        guard let shiftBy = Int(secret) else {
            return nil
        }
        
        var encoded = ""
        
        for character in plaintext {
            let upperCharacter = String(character).uppercased()
            let index = outputTable.firstIndex(of: upperCharacter)
            var shiftedIndex = index! + shiftBy
            if shiftedIndex >= outputTable.count {
                shiftedIndex = shiftedIndex % outputTable.count
            }
            let shiftedCharacter = outputTable[shiftedIndex]
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String? {
        if plaintext.isAlphanumeric {
        } else {
            print("not alphanumeric")
            return nil
        }
        
        guard let shiftBy = Int(secret) else {
            return nil
        }
        var decrypted = ""
        
        for character in plaintext {
            let upperCharacter = String(character).uppercased()
            let index = outputTable.firstIndex(of: upperCharacter)
            var shiftedIndex = index! - shiftBy
            if shiftedIndex < 0 {
                while shiftedIndex < 0 {
                    shiftedIndex = outputTable.count + shiftedIndex
                }
            }
            let shiftedCharacter = outputTable[shiftedIndex]
            decrypted = decrypted + shiftedCharacter
        }
        return decrypted
    }
}

struct letterToNumberCesarCipher: Cipher {
    
    let outputTable: [String] = [
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
        "1","2","3","4","5","6","7","8","9","0"]
    
    func encode(_ plaintext: String, secret: String) -> String? {
        if plaintext.isAlphabet {
        } else {
            print("not alphabet")
            return nil
        }
        
        guard let shiftBy = Int(secret) else {
            return nil
        }
        
        var encoded = ""
        
        for character in plaintext {
            let upperCharacter = String(character).uppercased()
            let index = outputTable.firstIndex(of: upperCharacter)
            var shiftedIndex = index! + shiftBy
            if shiftedIndex >= (outputTable.count-10) {
                shiftedIndex = shiftedIndex % (outputTable.count-10)
            }
            let result = String(shiftedIndex + 1)
            encoded = encoded + result
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String? {
        if plaintext.isNumeric {
        } else {
            print("not numeric")
            return nil
        }
        
        guard let shiftBy = Int(secret) else {
            return nil
        }
        var decrypted = ""
        
        for character in plaintext {
            var index = outputTable.firstIndex(of: String(character))
            index = index! - 26
            var shiftedIndex = index! - shiftBy
            if shiftedIndex < 0 {
                while shiftedIndex < 0 {
                    shiftedIndex = outputTable.count - 26 + shiftedIndex
                }
            }
            let result = outputTable[(shiftedIndex)]
            decrypted = decrypted + result
        }
        return decrypted
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

extension String {
    var isAlphabet: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}

extension String {
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
}
