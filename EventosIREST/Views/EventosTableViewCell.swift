//
//  EventosTableViewCell.swift
//  EventosIREST
//
//  Created by Alfredo Amezcua on 5/12/24.
//

import UIKit

final class EventosTableViewCell: UITableViewCell {

    var eventosVM: EventosViewModel? {
        didSet {
            if let eventosVM = eventosVM {
                titleLabel.text = eventosVM.title
                NetworkManager.shared.getImage(urlString: eventosVM.image) {
                    (data) in
                    guard let data = data else {return}
                    DispatchQueue.main.async {
                        self.eventosImage.image = UIImage(data: data)
                    }
                    
                }
                
            }
        }
    }

    var eventosImageData: Data? {
        didSet {
            if let data = eventosImageData {
                
            }
        }
    }
    
    private lazy var eventosImage: ShadowImageView = {
        let v = ShadowImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(eventosImage)
        
        setupConstraints()
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            eventosImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventosImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventosImage.topAnchor.constraint(equalTo: topAnchor),
            eventosImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: eventosImage.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
}
}

