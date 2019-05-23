//
//  ViewController.swift
//  random
//
//  Created by Yingying Wu on 25/05/18.
//  Copyright © 2018 Everglow. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    @IBOutlet weak var wordToKnow: NSTextField!
    @IBOutlet weak var solution: NSTextField!
    
    @IBOutlet weak var ok: NSButton!
    @IBOutlet weak var loaded: NSButton!
    @IBOutlet weak var reverseStatus: NSButton!
    
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
                ok.title = "Click load"
                loaded.title = "load"
            }
        } else {
            path = nil
            ok.title = "not ok"
        }
        
    }
        
    
    @IBAction func loadFile(_ sender: NSButton) {
        if (path != nil) {
            let text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            dataArray = text.components(separatedBy: "\n")
            let splitArray = dataArray.split()
            left_array = splitArray.left
            right_array = splitArray.right
            print(left_array.count)
            print(right_array.count)
            loaded.title = "ok"
        } else {
            loaded.title = "errore"
        }
    }
    
    @IBAction func tryMe(_ sender: Any) {
        
        ok.title = "Load file"
        loaded.title = "Load!"
        
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
        
        reverseStatus.title = "Reverse (S)"
        solution.stringValue = ""
    }
    
    
    @IBAction func reverseRemove(_ sender: NSButton) {
        left_array.append(leftVal)
        right_array.append(rightVal)
        reverseStatus.title = "ok"
    }
    
    @IBAction func giveUp(_ sender: NSButton) {
            solution.stringValue = rightVal
            reverseStatus.stringValue = "Reverse (S)"
        
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

