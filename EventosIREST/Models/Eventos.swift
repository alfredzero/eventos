//
//  Eventos.swift
//  EventosIREST
//
//  Created by Alfredo Amezcua on 5/10/24.
//

import Foundation

struct Eventos: Decodable {
    let id: String
    let host: String
    let title: String
    let description: String
    let image: String
    let date: String
}

struct EventosEnvelope: Decodable {
    let eventos: EventosContainer
    
    private enum CodingKeys: String, CodingKey {
        case eventos
    }
}

struct EventosContainer: Decodable {
    let eventos: [Eventos]
}

