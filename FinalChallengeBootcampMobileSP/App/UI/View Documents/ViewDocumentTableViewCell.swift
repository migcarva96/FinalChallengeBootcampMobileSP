//
//  ViewDocumentTableViewCell.swift
//  Sophos
//
//  Created by Miguel Urrea on 15/12/22.
//

import UIKit

class ViewDocumentTableViewCell: UITableViewCell {
  
  var nameLabel: UILabel!
  var titleLabel: UILabel!
  var topSeparator: UIView!
  var bottomSeparator: UIView!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    super.backgroundColor = .clear
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCell() {
    nameLabel = UILabel()
    nameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
    nameLabel.textColor = UIColor(named: "secondaryColor")
    nameLabel.textAlignment = .left
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(nameLabel)
    
    titleLabel = UILabel()
    titleLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
    titleLabel.textColor = UIColor(named: "secondaryColor")
    titleLabel.textAlignment = .left
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    
    topSeparator = UIView()
    topSeparator.backgroundColor = UIColor(named: "secondaryColor")
    topSeparator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(topSeparator)
    
    bottomSeparator = UIView()
    bottomSeparator.backgroundColor = UIColor(named: "secondaryColor")
    bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(bottomSeparator)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
      
      topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      topSeparator.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      topSeparator.heightAnchor.constraint(equalToConstant: 1),
      
      bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1),
      bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
      
    ])
  }
  
  func configurate(model: DocumentByEmail?) {
    
    guard let dateModel = model?.date.prefix(10) else {
      nameLabel.text = (model?.name ?? "") + " " + (model?.lastname ?? "")
      titleLabel.text = (model?.date ?? "") + " - " + (model?.fileTitle ?? "")
      return
    }
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"

    let dateFormatterPost = DateFormatter()
    dateFormatterPost.dateFormat = "dd/MM/yy"

    let date = dateFormatterGet.date(from: String(dateModel))
    
    nameLabel.text = (model?.name ?? "") + " " + (model?.lastname ?? "")
    titleLabel.text = dateFormatterPost.string(from: date!) + " - " + (model?.fileTitle ?? "")
  }
}
