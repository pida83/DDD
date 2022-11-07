//
//  ChatViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol ChatViewModelInput {
    func viewDidLoad()
}

 protocol ChatViewModelOutput {
    
}

protocol ChatViewModel: ChatViewModelInput, ChatViewModelOutput { }

class DefaultChatViewModel: ChatViewModel {
    
    // MARK: - OUTPUT
    init() {
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultChatViewModel {
    func viewDidLoad() {
    }
}
