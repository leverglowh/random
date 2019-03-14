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
    @IBOutlet weak var reverseStatus: NSTextField!
    
    
    var dataArray:[String] = []
    var path: String?
    var leftVal: String = ""
    var rightVal: String = ""
    var left_array:[String] = []
    var right_array:[String] = []
    
    
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
            let splitArray = dataArray.split()
            left_array = splitArray.left
            right_array = splitArray.right
            loaded.stringValue = "ok"
        } else {
            loaded.stringValue = "errore"
        }
    }
    
    @IBAction func tryMe(_ sender: Any) {
        
        if left_array.count==0 {
            wordToKnow.stringValue = "Finitooo"
        } else{
            
            let i = Int(arc4random_uniform(_:UInt32(left_array.count)))
            leftVal = left_array[i]
            rightVal = right_array[i]
        
            wordToKnow.stringValue = leftVal
            left_array.remove(at: i)
            right_array.remove(at: i)
            
        }
        
        reverseStatus.stringValue = ""
        
    }
    
    
    @IBAction func reverseRemove(_ sender: NSButton) {
        left_array.append(leftVal)
        right_array.append(rightVal)
        reverseStatus.stringValue = "ok"
    }
    
    @IBAction func giveUp(_ sender: NSButton) {
        wordToKnow.stringValue = wordToKnow.stringValue + " " + rightVal
        reverseStatus.stringValue = ""
    }
    
}

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half+1 ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}

