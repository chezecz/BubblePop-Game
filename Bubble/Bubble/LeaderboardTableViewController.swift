//
//  LeaderboardTableViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 30/4/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    var playersLeader = [User]()
    var players: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        loadFromFile()
        loadPlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playersLeader.count
    }

    func loadPlayers() {
        for _ in 0...playersLeader.count {
            if players?.name != "" {
                playersLeader.append(players!)
            }
        }
        playersLeader.sort{$0.points > $1.points}
        //saveToFile(playersLeader: playersLeader)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerScoreLeaderboardTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerScoreLeaderboardTableViewCell
        let player = playersLeader[indexPath.row]
        // Configure the cell...
        cell?.playerName.text = player.name
        cell?.playerScore.text = String(player.points)
        return cell!
    }
    
    var leaderboardURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("leaderboard")
    }
    
    func saveToFile(playersLeader: Array<User>) {
        if playersLeader != [] {
            NSKeyedArchiver.archiveRootObject(playersLeader, toFile: leaderboardURL.path)
        }
    }
    
    func loadFromFile() {
        let leaderboard = NSKeyedUnarchiver.unarchiveObject(withFile: leaderboardURL.path) as? [User]
        if leaderboard != nil {
            self.playersLeader = leaderboard!
        }
    }
}
