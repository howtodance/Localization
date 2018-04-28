//
//  ViewController.swift
//  Localization
//
//  Created by Yauheni Baranouski on 4/28/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lowToHighLabel: UILocalizedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func englsihPressed(_ sender: UILocalizedButton) {
                Language.language = .english

    }
    @IBAction func spanishPressed(_ sender: UILocalizedButton) {
        Language.language = .spanish
        
    }

    @IBAction func changeLangPressed(_ sender: UILocalizedButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Lang")
       // controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

