//
//  ViewController.swift
//  xMinerClient
//
//  Created by Gleb Karpushkin on 08/11/2017.
//  Copyright © 2017 Gleb Karpushkin. All rights reserved.
//

import UIKit
import iOS_XMiner

class ViewController: UIViewController {
    
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var workerIDLabel: UILabel!
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var walletAddress: UITextView!
    @IBOutlet weak var poolUrl: UITextField!
    @IBOutlet weak var poolPort: UITextField!
    @IBOutlet weak var workerID: UITextField!
    @IBOutlet weak var threadsSlider: UISlider!
    @IBOutlet weak var threadsInUse: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var submitionLabel: UILabel!
    @IBOutlet weak var hashRateLabel: UILabel!
    
    var miner: iOS_XMiner.XMiner?
    var isMining: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        let maxThreadsCount = Float(ProcessInfo.processInfo.activeProcessorCount)
        threadsSlider.maximumValue = maxThreadsCount
        threadsSlider.value = maxThreadsCount
        threadsInUse.text = String(Int(maxThreadsCount))
        poolUrl.delegate = self
        poolPort.delegate = self
        workerID.delegate = self
    }
    
    func startMining(address: String, url: String?, port: String?, worker: String?) {
        if !isMining! {
            if !(url?.isEmpty)! && !(port?.isEmpty)! {
                miner = iOS_XMiner.XMiner(host: url!, port: Int(port!)!, destinationAddress: address, clientIdentifier: worker!)
            }else{
                miner = iOS_XMiner.XMiner(destinationAddress: address)
            }
            miner?.delegate = self
            do {
                try miner?.start(threadLimit: Int(threadsSlider.value))
                isMining = true
            }catch {
                print(error)
            }
            interraction(false)
        }else{
            isMining = false
            miner?.stop()
            interraction(true)
        }
    }
    
    func interraction(_ enabled: Bool) {
        if !enabled {
            startStopButton.setTitle("Stop", for: .normal)
        }else{
            startStopButton.setTitle("Start", for: .normal)
        }
        poolUrl.isEnabled = enabled
        poolPort.isEnabled = enabled
        workerID.isEnabled = enabled
        threadsSlider.isEnabled = enabled
        walletAddress.isEditable = enabled
    }
    
}

extension ViewController: UITextViewDelegate, iOS_XMiner.XMinerDelegate, UITextFieldDelegate {
    
    func miner(updatedStats stats: MinerStats) {
        submitionLabel.text = "subm: \(stats.submittedHashes)"
        hashRateLabel.text = "\(Int(stats.hashRate)) H/s"
    }
    
    @IBAction func changeThreads(_ sender: Any) {
        threadsInUse.text = String(Int((sender as! UISlider).value))
    }
    
    @IBAction func startMining(_ sender: Any) {
        startMining(address: walletAddress.text, url: poolUrl.text, port: poolPort.text, worker: workerID.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        walletAddress.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
