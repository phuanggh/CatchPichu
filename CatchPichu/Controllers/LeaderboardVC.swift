//
//  LeaderboardVC.swift
//  CatchPichu
//
//  Created by Penny Huang on 2020/3/22.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet var lastResultLabel: [UILabel]!
    
    
    @IBOutlet var rankLabel: [UILabel]!
    
    @IBAction func returnButtonPressed(_ sender: Any) {

    }
    
    
    func displayLastResult(){
        let latestResultArray = defaults.array(forKey: "ResultArray") as! [Int]
        
        lastResultLabel[0].text = "PICHU: \(latestResultArray[0])"
        lastResultLabel[1].text = "PIKACHU: \(latestResultArray[1])"
        lastResultLabel[2].text = "RAICHU: \(latestResultArray[2])"
        lastResultLabel[3].text = "SCORE: \(latestResultArray[3])"
        
    }
    
    func displayRank(){
        let scoreArray = defaults.array(forKey: "ScoreArray") as! [Int]
        rankLabel[0].text = "1st \(scoreArray[0])"
        rankLabel[1].text = "1st \(scoreArray[1])"
        rankLabel[2].text = "1st \(scoreArray[2])"
        rankLabel[3].text = "1st \(scoreArray[3])"
        rankLabel[4].text = "1st \(scoreArray[4])"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLastResult()
        displayRank()
        
//        print(latestResultArray ?? "cannot find the latest result in UserDefault")
//        print(scoreArray ?? "cannot find score array in UserDefault")

    }
    
}
