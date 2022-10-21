//
//  MypageViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

public protocol MypageViewModelInput {
    func viewDidLoad()
}

public protocol MypageViewModelOutput {
    
}

public protocol MypageViewModel: MypageViewModelInput, MypageViewModelOutput { }

public class DefaultMypageViewModel: MypageViewModel {
    
    // MARK: - OUTPUT
    public init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultMypageViewModel {
    public func viewDidLoad() {
    }
}
