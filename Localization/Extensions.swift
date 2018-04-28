//
//  Extensions.swift
//  Localization
//
//  Created by Yauheni Baranouski on 4/28/18.
//

import Foundation
import UIKit

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

enum DataLoaderStrings: String, Localizable {
    case accept = "accept"
    case cancel = "cancel"

    case bus = "bus"
    case capacity = "capacity"

    case lowToHigh = "low_to_high"
    case highToLow = "high_to_low"


    var tableName: String {
        return "Localizable"
    }
}

let string = DataLoaderStrings.accept.localized

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

// 1
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}


//https://marcosantadev.com/app-localization-tips-swift/

final class UILocalizedLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized
    }
}

final class UILocalizedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        let title = self.title(for: .normal)?.localized
        setTitle(title, for: .normal)
    }
}

final class UILocalizedTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized()
    }
}
private let appleLanguagesKey = "AppleLanguages"

//https://github.com/romansorochak/Localizable/blob/master/Localizable/Localizable.swift

enum Language: String {

    case english = "en"
    case spanish = "es"

    var semantic: UISemanticContentAttribute {
        switch self {
        case .english, .spanish:
            return .forceLeftToRight
    }
    }
      static  var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                guard let localization = Language(
                    rawValue: preferredLanguage.substring(to: index)
                    //rawValue: String(preferredLanguage[..<index])

                    ) else {
                        return Language.english
                }

                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }

            //change language in the app
            //the language will be changed after restart
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
//            if UserDefaults.standard.synchronize() {
//                UIView.appearance().semanticContentAttribute = newValue.semantic
//                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(
//                    name: "Main",
//                    bundle: nil
//                    ).instantiateInitialViewController()
//            }

            //Changes semantic to all views
            //this hack needs in case of languages with different semantics: leftToRight(en/uk) & rightToLeft(ar)
            //UIView.appearance().semanticContentAttribute = newValue.semantic

            //initialize the app from scratch
            //show initial view controller
            //so it seems like the is restarted
            //NOTE: do not localize storboards
            //After the app restart all labels/images will be set
            //see extension String below


//            let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController")
//            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//            rootviewcontroller.rootViewController = firstVC

//            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: {
//                let delegate = UIApplication.shared.delegate as! AppDelegate
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                delegate.window?.rootViewController = storyboard.instantiateInitialViewController()


            //https://www.youtube.com/watch?v=-HIVRe10puU
            //https://drive.google.com/drive/folders/0B2JesNvFjyTbbnljOGNZakNBR3c
            exit(EXIT_SUCCESS)
//                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(
//                    name: "Main",
//                    bundle: nil
//                    ).instantiateInitialViewController()

        }
    }
}




extension String {

    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }

    var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(type: ".png")
            ?? localizedImage(type: ".jpg")
            ?? localizedImage(type: ".jpeg")
            ?? UIImage(named: self)
    }

    private func localizedImage(type: String = "") -> UIImage? {
        guard let imagePath = Bundle.localizedBundle.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}

extension Bundle {
    //Here magic happens
    //when you localize resources: for instance Localizable.strings, images
    //it creates different bundles
    //we take appropriate bundle according to language
    static var localizedBundle: Bundle {
        let languageCode = Language.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}

