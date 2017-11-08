//
//  ViewController.swift
//  testMiner
//
//  Created by Gleb Karpushkin on 05/11/2017.
//  Copyright © 2017 Gleb Karpushkin. All rights reserved.
//

import UIKit
import Xminer

class ViewController: UIViewController {

    @IBOutlet weak var hashrateLabel: UILabel!
    @IBOutlet weak var submittedHashesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MinerDelegate {
    func miner(updatedStats stats: MinerStats) {
        print("\(stats.hashes) hashes")
        print("\(stats.hashRate) H/s")
        print("\(stats.submittedHashes) submited")
    }
}
