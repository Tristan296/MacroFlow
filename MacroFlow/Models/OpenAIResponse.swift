//
//  OpenAIResponse.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let message: Message
    }

    let choices: [Choice]
}
