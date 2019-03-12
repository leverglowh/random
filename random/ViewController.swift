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
    @IBOutlet weak var loaded: NSTextField!
    
    
    var dataArray:[String] = []
    var path: String?

    
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
        
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["txt"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
        
            if (result != nil) {
                path = result!.path
                ok.stringValue = "Click load"
            }
        } else {
            path = nil
            ok.stringValue = "not ok"
        }
        
        }
        
    
    @IBAction func loadFile(_ sender: NSButton) {
        if (path != nil) {
            let text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            dataArray = text.components(separatedBy: "\n")
            loaded.stringValue = "ok."
        } else {
            loaded.stringValue = "errore."
        }
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

