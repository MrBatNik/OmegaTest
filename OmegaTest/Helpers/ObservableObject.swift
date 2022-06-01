//
//  ObservableObject.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 01.06.2022.
//

import Foundation

final class ObservableObject<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
    
}
