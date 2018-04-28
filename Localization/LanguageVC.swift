//
//  LanguageVC.swift
//  Localization
//
//  Created by Yauheni Baranouski on 4/28/18.
//

import UIKit

class LanguageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func englsihPressed(_ sender: UILocalizedButton) {
        Language.language = Language.english
        dismiss(animated: true, completion: nil)
    }
    @IBAction func spanishPressed(_ sender: UILocalizedButton) {
        Language.language = Language.spanish
        dismiss(animated: true, completion: nil)


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
