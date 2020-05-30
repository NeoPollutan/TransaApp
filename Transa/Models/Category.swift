//
//  Category.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    
    case donasi
    case makanan
    case hiburan
    case kesehatan
    case belanja
    case transportasi
    case kebutuhan
    case lainnya
    
    var systemNameIcon: String {
        switch self {
        case .donasi: return "hand.thumbsup.fill"
        case .makanan: return "tray.fill"
        case .hiburan: return "tv.music.note.fill"
        case .kesehatan: return "heart.fill"
        case .belanja: return "cart.fill"
        case .transportasi: return "car.fill"
        case .kebutuhan: return "bolt.fill"
        case .lainnya: return "tag.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .donasi: return Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        case .makanan: return Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        case .hiburan: return Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        case .kesehatan: return Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        case .belanja: return Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        case .transportasi: return Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        case .kebutuhan: return Color(#colorLiteral(red: 0.6357797384, green: 0.3629832268, blue: 0.9161445498, alpha: 1))
        case .lainnya: return Color(#colorLiteral(red: 1, green: 0.888686657, blue: 0.7034975886, alpha: 1))
        }
    }
}

extension Category: Identifiable {
    var id: String { rawValue }
}
