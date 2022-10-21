//
//  HoodViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

public protocol HoodViewModelInput {
    func viewDidLoad()
}

public protocol HoodViewModelOutput {
    
}

public protocol HoodViewModel: HoodViewModelInput, HoodViewModelOutput { }

public class DefaultHoodViewModel: HoodViewModel {
    
    // MARK: - OUTPUT
    public init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultHoodViewModel {
    public func viewDidLoad() {
    }
}
