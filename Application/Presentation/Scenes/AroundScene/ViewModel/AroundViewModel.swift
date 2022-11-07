//
//  AroundViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Alamofire

protocol AroundViewModelInput {
    func viewDidLoad()
}

protocol AroundViewModelOutput {
    
}

protocol AroundViewModel: AroundViewModelInput, AroundViewModelOutput { }

class DefaultAroundViewModel: AroundViewModel {
    
    // MARK: - OUTPUT

    init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultAroundViewModel {
    func viewDidLoad() {
    }
}
