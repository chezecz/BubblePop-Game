//
//  BeforeStartViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 1/5/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class BeforeStartViewController: UIViewController {

    var settings: Settings?
    var player: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.player?.name = playerName.text!
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var playerName: UITextField!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if playerName.text == "" {
            playerName.backgroundColor = UIColor.cyan
            return false
        }
        playerName.backgroundColor = UIColor.clear
        self.player?.name = playerName.text!
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passSettings = segue.destination as? GameViewController {
            passSettings.settings = self.settings
            passSettings.player = self.player
        }
    }
}
