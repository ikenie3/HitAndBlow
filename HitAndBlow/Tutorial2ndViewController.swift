//
//  Tutorial2ndViewController.swift
//  HitAndBlow
//
//  Created by takemitsu on 2017/08/23.
//  Copyright © 2017年 takemitsu. All rights reserved.
//

import UIKit

class Tutorial2ndViewController: UIViewController {
    
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText.font = UIFont(name: "Courier", size: 12)
        descText.text = "例）\n\n" +
            "1234 H:0 B:0\n\nどれも一致していません\n\n" +
            "0569 H:0 B:4\n\n数字のみ4つ一致しています\n\n" +
            "1230 H:1 B:0\n\n1つ数字と位置が一致しています\n\n" +
            "5690 H:2 B:2\n\n2つ数字と位置が一致、2つ数字が一致しています\n\n\n" +
            "なおリセットでやり直せます。\n" +
            "戦績はまだ保存できないと思っています。\n\n" +
            "そんな感じです。"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func move1stButton(_ sender: UIButton) {
        if let parentView = self.parent as! TutorialPageViewController! {
            parentView.pageMove(viewController: parentView.get1st(), direction: .reverse)
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
