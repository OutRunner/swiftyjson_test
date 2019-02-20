//
//  ViewController.swift
//  swiftyjson_test
//
//  Created by Simon Wilmer on 18/02/2019.
//  Copyright © 2019 PSA Groupe. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var sectionTypes = [ "folderData", "imageData", "pdfData", "videoData" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let methodStart = Date()

        if let content = try? String( contentsOfFile: Bundle.main.path(forResource: "manifest", ofType: "json")!, encoding: String.Encoding.utf8 ) {
            let json = try! JSON( data: content.data( using: String.Encoding.utf8, allowLossyConversion: true )!)

            if json[ "folderData" ].exists() &&  json[ "folderData" ].count > 0 {
                print("OK!")

                for itemIndex: Int in 0...( json[ "folderData" ].count - 1 ) {

                    let json = json[ "folderData" ][ itemIndex ]
                    iterateSubItems(json: json)

                }

            } else {
                print("Not json")
            }
        } else {
            print("Can't even open it!")
        }

        let methodFinish = Date()
        let executionTime = methodFinish.timeIntervalSince(methodStart)
        print("Execution time: \(executionTime)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func iterateSubItems(json: JSON) {

        print("\(json[ "name" ].stringValue) \(json[ "fileType" ].stringValue) \(json[ "filename" ].stringValue) \(json[ "fullFileURL" ].stringValue) \(json[ "uniqueID" ].stringValue)")

        for sectionIndex: Int in 0...( self.sectionTypes.count - 1 ) {

            if json[ "subData" ][ self.sectionTypes[ sectionIndex ] ].count > 0 {

                for itemIndex: Int in 0...( json[ "subData" ][ self.sectionTypes[ sectionIndex ] ].count - 1 ) {

                    self.iterateSubItems( json: json[ "subData" ][ self.sectionTypes[ sectionIndex ] ][ itemIndex ] )

                }
            }
        }
    }

}

