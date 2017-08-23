//
//  TutorialViewController.swift
//  HitAndBlow
//
//  Created by takemitsu on 2017/08/23.
//  Copyright © 2017年 takemitsu. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.setViewControllers([self.get1st()], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
    }
    
    func get1st() -> TutorialViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "1st")  as! TutorialViewController
    }
    func get2nd() -> Tutorial2ndViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "2nd") as! Tutorial2ndViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 進む
        if viewController.isKind(of: TutorialViewController.self) {
            return self.get2nd()
        }
        return nil
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 戻る
        if viewController.isKind(of: Tutorial2ndViewController.self) {
            return get1st()
        }
        return nil
    }
    
    
    
    func pageMove(viewController: UIViewController, direction:UIPageViewControllerNavigationDirection) {
        self.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
