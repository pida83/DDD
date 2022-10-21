//
//  AroundViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

public protocol AroundViewModelInput {
    func viewDidLoad()
}

public protocol AroundViewModelOutput {
    
}

public protocol AroundViewModel: AroundViewModelInput, AroundViewModelOutput { }

public class DefaultAroundViewModel: AroundViewModel {
    
    // MARK: - OUTPUT

    public init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultAroundViewModel {
    public func viewDidLoad() {
    }
}
