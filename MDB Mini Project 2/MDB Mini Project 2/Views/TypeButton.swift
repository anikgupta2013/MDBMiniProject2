//
//  TypeButton.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/18/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class TypeButton: UIButton {
    
    //Making a toggle button
    override func draw(_ rect: CGRect) {
        self.setTitleColor(.white, for: .selected)
        self.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
    }
    @objc func handleToggleBT(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    

}
