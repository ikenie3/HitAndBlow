//
//  ViewController.swift
//  HitAndBlow
//
//  Created by takemitsu on 2017/08/21.
//  Copyright © 2017年 takemitsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var decideButton: UIButton!
    @IBOutlet weak var historyText: UITextView!
    let doneButton = UIBarButtonItem(title: "決定", style: .plain, target: self, action: #selector(decideNumberRun))
    
    var hbData:HbData = HbData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 入力履歴の枠線
        historyText.layer.borderColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0).cgColor
        historyText.layer.borderWidth = 1.0
        historyText.layer.masksToBounds = true
        historyText.layer.cornerRadius = 5.0
        // 編集できないように
        historyText.isEditable = false
        // 等倍フォントに
        historyText.font = UIFont(name: "Courier", size: 16)
        
        // 入力値が変化した場合のイベント登録
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: numberText)
        
        // ボタンは初期では無効
        decideButton.isEnabled = false
        
        // データ等を初期化
        self.initialize()
        
        // チュートリアルを表示する
        let ud = UserDefaults.standard
        var isShowTutorial:Bool = true
        if let _ = ud.object(forKey: "showTutorial") {
            if ud.bool(forKey: "showTutorial") {
                isShowTutorial = false
            }
        }
        if isShowTutorial {
            ud.set(true, forKey: "showTutorial")
            self.showTutorial()
        }
        
        // キーボードにツールバーを追加する
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = .default
        kbToolBar.sizeToFit()
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let clearButton = UIBarButtonItem(title: "クリア", style: .plain, target: self, action: #selector(clearNumberText))
        self.doneButton.isEnabled = false
        kbToolBar.items = [clearButton, spacer, self.doneButton]
        numberText.inputAccessoryView = kbToolBar
        
        // キーボード表示する
        numberText.becomeFirstResponder()
    }
    
    func clearNumberText() {
        self.numberText.text = ""
    }
    
    /// データやフィールドを初期化
    func initialize() {
        hbData.initialize()
        numberText.text = ""
        decideButton.isEnabled = false
        doneButton.isEnabled = false
        historyText.text = hbData.answerHistory.joined(separator: "\n")
        self.view.endEditing(true)
    }
    
    // 入力値が 4 桁以上入力できないように
    // 入力値が 4 桁の場合にボタンを有効化
    @objc private func textFieldDidChange(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if text.characters.count > 4 {
                numberText.text = text.substring(to: text.index(text.startIndex, offsetBy: 4))
            }
            if text.characters.count >= 4 {
                decideButton.isEnabled = true
                doneButton.isEnabled = true
            }
            else {
                decideButton.isEnabled = false
                doneButton.isEnabled = false
            }
        }
        else {
            decideButton.isEnabled = false
            doneButton.isEnabled = false
        }
    }
    
    /// 決定ボタン押下
    @IBAction func decideNumber(_ sender: UIButton) {
        self.decideNumberRun()
    }
    func decideNumberRun() {
        // 簡単にバリデーション
        var errorMessage:String?
        if let text = numberText.text {
            if text.characters.count != 4 {
                errorMessage = "４桁の数字を入力してください"
            }
        } else {
            errorMessage = "４桁の数字を入力してください"
        }
        if errorMessage != nil {
            let alert = UIAlertController(title: "エラー", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // 判定
        if hbData.isWin(ans: numberText.text!) {
            self.view.endEditing(true)
            let alert = UIAlertController(title: "正解！", message: "\(hbData.answerCount)回目で正解しました", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            numberText.text = ""
        }
        decideButton.isEnabled = false
        doneButton.isEnabled = false
        historyText.text = hbData.answerHistory.joined(separator: "\n")
    }
    
    // NewGame == リセットボタン
    @IBAction func newGameButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "新しくゲームを開始しますか？", message: "OKをタップすると隠された数字や履歴などがリセットされます", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (res) in
            print(res)
            self.initialize()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// チュートリアルを表示する
    @IBAction func dispTutorial(_ sender: UIBarButtonItem) {
        self.showTutorial()
    }
    
    func showTutorial() {
        let storyboard: UIStoryboard = UIStoryboard(name: "tutorial", bundle: nil)
        let tutorialView = storyboard.instantiateViewController(withIdentifier: "tutorialPageView") as! TutorialPageViewController
        DispatchQueue.main.async {
            self.present(tutorialView, animated: true, completion: nil)
        }
    }
    
    
    /// 画面タップでキーボードを下げる
    @IBAction func tapGeneral(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

