//
//  EventosViewModel.swift
//  EventosIREST
//
//  Created by Alfredo Amezcua on 5/10/24.
//

import Foundation

struct EventosViewModel {
    
    let eventos: Eventos
    
    var host: String {
        return eventos.host ?? " "
    }
    var title: String {
        return eventos.title ?? " "
    }
    var description: String {
        
        return eventos.description ?? " "
    }
    var image: String {
        return eventos.image ?? " "
    }
    var date: String {
        return eventos.date ?? " "
    }
}
