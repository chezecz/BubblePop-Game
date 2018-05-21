//
//  GameOverViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 1/5/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    var player: User?
    var settings: Settings?
    
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBAction func playAgainAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "fromGameToGame", sender: self)
    }
    @IBAction func leaderboardButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "fromGameToLeaderboard", sender: self)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "fromGameToSettings", sender: self)
    }
    @IBAction func mainMenuAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "fromGameToMenu", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        finalScore.text = String(player!.points)
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passSettings = segue.destination as? BeforeStartViewController{
            passSettings.player = self.player
            passSettings.settings = self.settings
        }
        if let passSettings = segue.destination as? LeaderboardTableViewController{
            passSettings.players = self.player
        }
        if let passSettings = segue.destination as? SettingsViewController{
            passSettings.settings = self.settings
        }
        if let passSettings = segue.destination as? MainViewController{
            passSettings.currentPlayer = self.player!
            passSettings.currentSettings = self.settings!
        }

    }
}
