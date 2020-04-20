//
//  ViewController.swift
//  serihutest
//
//  Created by JotaroSugiyama on 2020/04/15.
//  Copyright © 2020 JotaroSugiyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NormalViewDelegate, MessageViewDelegate, QuestionViewDelegate {
    
    @IBOutlet var baseView :UIView!
    
    var str: Array<Array<String>> = []

    var nextId :Int = 0

    var csvArray:[String] = []
    
    var normalView: NormalView!
    var messageView: MessageView!
    var questionView: QuestionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalView = Bundle.main.loadNibNamed("NormalView", owner: self, options: nil)!.first! as! NormalView
        normalView.delegate = self
        self.baseView.addSubview(normalView)
        
        messageView = Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)!.first! as! MessageView
        messageView.delegate = self
        self.baseView.addSubview(messageView)
        
        questionView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)!.first! as! QuestionView
        questionView.delegate = self
        self.baseView.addSubview(questionView)

        if let csvPath = Bundle.main.path(forResource: "nakano1", ofType: "csv") {
            do {
                var csvString =  try NSString(contentsOfFile: csvPath, encoding: String.Encoding.utf8.rawValue) as String
                csvString = csvString.replacingOccurrences(of: "\r", with: "")
                let rowArray:Array = csvString.components(separatedBy: "\n")

                rowArray.forEach {
                    let items = $0.components(separatedBy: ",")
                    str.append(items)
                }
            } catch {
                // エラー
            }
        }

        print(str[1][2])
        nextId = 1
        setUp()
    }
    
    func normalViewTouched() {
        setUp()
    }
    func messageViewTouched() {
        setUp()
    }
    func questionViewTouched() {
        setUp()
    }
    
    func setUp(){
        if str[nextId][1] == "normal" {
            print("normal")
            normalView.textView.text = str[nextId][2]
            normalView.image.image = UIImage(named:"image\(str[nextId][4])")
            nextId = Int(str[nextId][3])!
            self.baseView.addSubview(normalView)
        } else if str[nextId][1] == "message" {
            print("message")
            messageView.textView.text = str[nextId][2]
            messageView.image.image = UIImage(named:"image\(str[nextId][4])")
            nextId = Int(str[nextId][3])!
            self.baseView.addSubview(messageView)
        } else if str[nextId][1] == "question" {
            print("question")
            questionView.textView.text = str[nextId][2]
            questionView.image.image = UIImage(named:"image\(str[nextId][4])")
            questionView.array = (1...(str[0].count - 5)*1/2).map {str[nextId][3 + 2 * $0]}
            print(questionView.array)
            self.baseView.addSubview(questionView)
        }
        print(nextId)
    }
}
