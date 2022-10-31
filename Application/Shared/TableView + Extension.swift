//
//  TableView + Extension.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/31.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }
}
