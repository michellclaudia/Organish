//
//  Brief1ViewController.swift
//  Organish
//
//  Created by Michelle Pricilla on 27/04/22.
//

import UIKit

class Brief1ViewController: UIViewController {
    @IBAction func nextBtn(_ sender: Any) {
        let controller =
        storyboard?.instantiateViewController(withIdentifier: "Brief2View") as! Brief2ViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
