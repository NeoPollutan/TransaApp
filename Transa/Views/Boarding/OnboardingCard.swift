//
//  OnboardingCard.swift
//  KindcerOnboarding
//
//  Created by Rizky Adipratama Ruddyar on 21/10/19.
//  Copyright © 2019 Rizky Adipratama Ruddyar. All rights reserved.
//

import Foundation

struct OnboardingCard: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}
