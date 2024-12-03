//
//  ErrorInterceptor.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Combine

class ErrorInterceptor {
    private let subject = PassthroughSubject<ErrorEvent, Never>()

    func errors() -> AnyPublisher<ErrorEvent, Never> {
        subject.eraseToAnyPublisher()
    }

    func notify(_ errorEvent: ErrorEvent) {
        subject.send(errorEvent)
    }
}

struct ErrorEvent {
    let throwable: Error
    let message: String
}

let noInternetInterceptor = ErrorInterceptor()

