//
//  PageView.swift
//  KindcerOnboarding
//
//  Created by Rizky Adipratama Ruddyar on 21/10/19.
//  Copyright © 2019 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI

struct PageView<Page:View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    @Binding var isOnboardingDone: Bool
    
    @State var currentPage: Int = 0
    
    init(_ views: [Page], isOnboardingDone: Binding<Bool> ) {
        self.viewControllers = views.map {UIHostingController (rootView: $0)}
        self._isOnboardingDone = isOnboardingDone
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                PageViewController(controllers: self.viewControllers,currentPage: self.$currentPage)
                
                if self.currentPage == 3
                {
                    
                    Text("Dengan mendaftar, kamu sudah setuju dengan kebijakan\n keamanan dan syarat dan ketentuan Transa.") .font(.system(size: 11)) .foregroundColor(.gray) .multilineTextAlignment(.center) .frame(width: geometry.frame(in: .global).width/1.2, height: geometry.frame(in: .global).height/12.0)
                    
                    
                    Button (action: {
                        let userdef = UserDefaults.standard
                        userdef.set(true, forKey: "isBoarding")
                        self.isOnboardingDone.toggle()
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: geometry.frame(in: .global).width/1.3, height: geometry.frame(in: .global).height/15.3)
                            .foregroundColor(Color(#colorLiteral(red: 0.1489486992, green: 0.390168488, blue: 0.555157125, alpha: 1)))
                            .overlay(
                                Text("Mulai")
                                    .foregroundColor(Color.white))
                        
                    })
                    
                    
                    
                    
                }
                else
                {
                    Button (action: {
                    }, label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 360, height: 10, alignment: .center)
                            .foregroundColor(Color.purple)
                            .opacity(0)
                            .overlay(
                                Text("Get Started")
                                    .foregroundColor(Color.white))
                        
                    })
                }
                
                
                PageController(numberOfPages: self.viewControllers.count, currentPage: self.$currentPage)
                
                
                
            }
        }
    }
    
    
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(cards.map{OnboardingCardView(card: $0)}, isOnboardingDone: .constant(false))
        
    }
}
