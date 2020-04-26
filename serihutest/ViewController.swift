//
//  ViewController.swift
//  serihutest
//
//  Created by JotaroSugiyama on 2020/04/15.
//  Copyright © 2020 JotaroSugiyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NormalViewDelegate, MessageViewDelegate, QuestionViewDelegate {
    
//    @IBOutlet var baseView :UIView!
    @IBOutlet var normalViewView :UIView!
    @IBOutlet var messageViewView :UIView!
    @IBOutlet var questionViewView :UIView!
    
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
        self.normalViewView.addSubview(normalView)
        
        messageView = Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)!.first! as! MessageView
        messageView.delegate = self
        self.messageViewView.addSubview(messageView)
        
        questionView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)!.first! as! QuestionView
        questionView.delegate = self
        self.questionViewView.addSubview(questionView)

        if let csvPath = Bundle.main.path(forResource: "nakano", ofType: "csv") {
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
        nextId = 1
        setUp()
    }
    
    func normalViewTouched() {
        setUp()
    }
    func messageViewTouched() {
        setUp()
    }
    func questionViewTouched(getNextId: String) {
        nextId = Int(getNextId)!
        setUp()
    }
    
    func setUp(){
        if str[nextId][1] == "normal" {
            print("normal")
            normalView.textView.text = str[nextId][2]
            normalView.image.image = UIImage(named:"image\(str[nextId][4])")
            nextId = Int(str[nextId][3])!
            normalViewView.isHidden = false
            messageViewView.isHidden = true
            questionViewView.isHidden = true
        } else if str[nextId][1] == "message" {
            if str[nextId][5] == "" {
                print("message")
                messageView.textView.text = str[nextId][2]
                messageView.image.image = UIImage(named:"image\(str[nextId][4])")
                messageView.button.isHidden = false
                nextId = Int(str[nextId][3])!
            } else {
                print("message_location")
                messageView.textView.text = str[nextId][2]
                messageView.image.image = UIImage(named:"image\(str[nextId][4])")
                messageView.button.isHidden = true
                messageView.longitude = Double(str[nextId][5])!
                messageView.latitude = Double(str[nextId][6])!
                nextId = Int(str[nextId][3])!
            }
            normalViewView.isHidden = true
            messageViewView.isHidden = false
            questionViewView.isHidden = true
        } else if str[nextId][1] == "question" {
            print("question")
            questionView.textView.text = str[nextId][2]
            questionView.image.image = UIImage(named:"image\(str[nextId][4])")
            questionView.array = []
            for i in 1 ... (str[0].count - 5)*1/2 {
                questionView.array.append([str[nextId][4 + 2 * i - 1],str[nextId][4 + 2 * i]])
            }
            print(questionView.array)
            normalViewView.isHidden = true
            messageViewView.isHidden = true
            questionViewView.isHidden = false
        }
        print(nextId)
    }
}
