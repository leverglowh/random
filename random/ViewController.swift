//
//  ViewController.swift
//  random
//
//  Created by Yingying Wu on 25/05/18.
//  Copyright © 2018 Everglow. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet weak var ok: NSTextField!
    @IBOutlet weak var wordToKnow: NSTextField!
    var dataArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func LoadFromFile(_ sender: Any) {
        let path = Bundle.main.path(forResource:"dict", ofType:"txt")
        let text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
        dataArray = text.components(separatedBy: "\n")
        ok.stringValue = "ok"
        }
        
    
    @IBAction func tryMe(_ sender: Any) {
        let i = Int(arc4random_uniform(_:UInt32(dataArray.count)))
        let randomVal = dataArray[i]
        dataArray.remove(at: i)
        if dataArray.count==0 {
            wordToKnow.stringValue = "Finitooo"
        }
        else{
            wordToKnow.stringValue = randomVal
    }
    }
    

}

