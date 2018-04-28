//
//  ViewController.swift
//  Choose language
//
//  Created by Yauheni Baranouski on 4/28/18.
//  Copyright © 2018 Yauheni Baranouski. All rights reserved.
//

//1. Choose language
//2. Add string files
//3. Configure string file for localization
//4. Add keys to get the value


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func englishPressed(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bndl = Bundle.init(path: path!)! as Bundle

        countryLabel.text = bndl.localizedString(forKey: "CountryName", value: nil, table: nil)
    }



    @IBAction func spanishPressed(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "es", ofType: "lproj")
        let bndl = Bundle.init(path: path!)! as Bundle

        countryLabel.text = bndl.localizedString(forKey: "CountryName", value: nil, table: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

