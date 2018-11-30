//
//  OpeningViewController.swift
//  targeting
//
//  Created by Jim Lambert on 11/28/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {
    
    @IBOutlet weak var demoButton: UIButton!
    @IBOutlet weak var liveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoButton.layer.borderColor = UIColor.white.cgColor
        demoButton.layer.cornerRadius = 20
        demoButton.layer.borderWidth = 2
        liveButton.layer.borderColor = UIColor.white.cgColor
        liveButton.layer.cornerRadius = 20
        liveButton.layer.borderWidth = 2
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "two-planes")?.draw(in: view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }
    
}
