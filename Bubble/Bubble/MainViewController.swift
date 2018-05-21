//
//  MainViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 1/5/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var currentPlayer = User()
    var currentSettings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passSettings = segue.destination as? SettingsViewController {
            passSettings.settings = self.currentSettings
        }
        if let passSettings = segue.destination as? BeforeStartViewController {
            passSettings.settings = self.currentSettings
            passSettings.player = self.currentPlayer
        }
        if let passSettings = segue.destination as? LeaderboardTableViewController {
            passSettings.players = self.currentPlayer
        }
    }
}
