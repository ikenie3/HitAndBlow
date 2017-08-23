//
//  HitAndBlow.swift
//  HitAndBlow
//
//  Created by takemitsu on 2017/08/22.
//  Copyright © 2017年 takemitsu. All rights reserved.
//

import Foundation

class HbData {
    
    var correctAnswer:String = "1234"
    var answerCount = 0
    var answerHistory:[String] = []
    
    // コンストラクタ
    init() {
        self.initialize()
    }
    
    // 初期設定
    func initialize() {
        // 答えをセットする
        self.setNewCorrectAnswer()
        self.answerHistory = []
        self.answerCount = 0
    }
    
    // 答えをセット
    func setNewCorrectAnswer() {
        var answers:[Int] = []
        // 4 つの数字を作る
        for _ in 0..<4 {
            var isNotMatch = true
            var num:Int = Int(arc4random_uniform(10))
            
            while isNotMatch {
                if answers.contains(num) {
                    num = Int(arc4random_uniform(10))
                } else {
                    isNotMatch = false
                }
            }
            answers.append(num)
        }
        var answersStr:[String] = []
        for ans in answers {
            answersStr.append(String(ans))
        }
        self.correctAnswer = answersStr.joined()
    }
    
    // 判定
    func isWin(ans:String) -> Bool {
        
        var h:Int = 0
        var b:Int = 0
        // キャラクタで判定だとめんどいので配列化して判定する
        let answers = Array(ans.characters)
        let corrects = Array(self.correctAnswer.characters)
        for i in 0..<answers.count {
            // 位置と数が一致なら H, 数が一致なら B を
            if let index = corrects.index(of: answers[i]) {
                if index == i {
                    h += 1
                }
                else {
                    b += 1
                }
            }
        }
        // print(self.correctAnswer, ans, "H",h,"B",b)
        self.answerCount += 1
        self.answerHistory.insert(" \(self.answerCount) 回目  \(ans)  H: \(h)  B: \(b)", at: 0)

        // Hit が 4 個だと win!
        if h == 4 {
            return true
        }
        return false
    }
}
