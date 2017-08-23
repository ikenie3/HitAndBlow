//
//  TutorialViewController.swift
//  HitAndBlow
//
//  Created by takemitsu on 2017/08/23.
//  Copyright © 2017年 takemitsu. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText.text = "ヒットアンドブローとは\n\n" +
            "4桁の数字を当てるゲームです。\n\n" +
            "0から9の数字を使います。\n\n" +
            "4桁の中に同じ数字は入りません\n\n" +
            "数字を入力して決定をタップすると入力履歴にHとかBとかが表示されます。\n" +
            "H: 数字と位置が一致しています\n" +
            "B: 数字は一致していますが位置が一致していません\n\n" +
            "これらをヒントに少ない回数で当たりを競う感じです。"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func move1stButton(_ sender: UIButton) {
        if let parentView = self.parent as! TutorialPageViewController! {
            parentView.pageMove(viewController: parentView.get2nd(), direction: .forward)
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
