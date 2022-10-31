//
//  String + Extension.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/31.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit

extension String {
    func leftPadding(toLength: Int, withPad: String) -> String {
          String(String(reversed()).padding(toLength: toLength, withPad: withPad, startingAt: 0).reversed())
      }
}
