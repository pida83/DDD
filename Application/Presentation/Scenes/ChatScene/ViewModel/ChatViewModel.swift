//
//  ChatViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

public protocol ChatViewModelInput {
    func viewDidLoad()
}

public  protocol ChatViewModelOutput {
    
}

public protocol ChatViewModel: ChatViewModelInput, ChatViewModelOutput { }

public class DefaultChatViewModel: ChatViewModel {
    
    // MARK: - OUTPUT
    public init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultChatViewModel {
    public func viewDidLoad() {
    }
}
