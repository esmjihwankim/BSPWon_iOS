//
//  TabBarController.swift
//  BSPWon
//
//  Created by skkuwon on 2021/07/04.
//

import UIKit

class TabBarController : UITabBarController, UITabBarControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUI()
    }

    func setUI()
    {
        guard let items = self.tabBar.items else {
            return
        }
        let titles = ["Experiment", "Pins", "Settings"]
        let images = ["gamecontroller", "cable.connector", "gear"]
        for x in 0..<items.count
        {
            items[x].title = titles[x]
            items[x].image = UIImage(systemName: images[x])
        }
        
    }
    
    
}
