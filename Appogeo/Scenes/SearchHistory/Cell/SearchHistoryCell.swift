//
//  SearchHistoryCell.swift
//  Appogeo
//
//  Created by José María Jiménez on 13/4/19.
//  Copyright © 2019 José María Jiménez. All rights reserved.
//

import UIKit

class SearchHistoryCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    
    func config(with model: SearchHistory.GetSearchs.ViewModel.DisplayedSearch) {
        icon.image = model.icon
        titleLbl.text = model.title
        dateLbl.text = model.date
    }
    
}
