import Foundation

class EventosListViewModel {
    
    var eventosVM = [EventosViewModel]()
    let reuseID = "eventos"
    
    func getEventos(completion: @escaping ([EventosViewModel]?) -> Void) {
        NetworkManager.shared.getEventos { (eventos: [Eventos]?) in
            guard let eventos = eventos else {
                print("No eventos received.")
                completion(nil)
                return
            }

            let eventosViewModels = eventos.map { EventosViewModel(eventos: $0) }
            self.eventosVM = eventosViewModels
            completion(eventosViewModels)
        }
    }
}
