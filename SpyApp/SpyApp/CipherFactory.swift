import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "AlphanumericCesar": AlphanumericCesarCipher(),
        "LetterToNumberCesar": letterToNumberCesarCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
