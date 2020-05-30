

import SwiftUI


var cards: [OnboardingCard] = [OnboardingCard(image: "onboard1", title: "Catat Setiap Transaksi\n Yang Anda Lakukan", description: "Memudahkan anda untuk mencatat tiap\n aktivitas transaksi keuangan anda setiap\n harinya secara langsung."), OnboardingCard(image: "onboard2", title: "Dapatkan Semua Laporan\n Transaksi Yang Telah Tercatat", description: "Seluruh data aktivitas transaksi harian\n anda semuanya tersimpan dan dapat\n diakses kapan saja untuk membantu\n rekap keuangan anda."),OnboardingCard(image: "onboard3", title: "Data Transaksi\n Hanya untuk Anda", description: "Aplikasi ini memastikan data transaksi\n yang anda lakukan tersimpan dengan\n aman dan hanya anda yang bisa\n mengakses aplikasi ini di smartphone\n anda"), OnboardingCard(image: "", title: "login", description: "")]

struct BoardingView: View {
    
    
    @State var isOnboardingDone = false
    
    var body: some View {
        Group{
            if isOnboardingDone {ContentView()}
            else {PageView(cards.map{OnboardingCardView(card: $0)}, isOnboardingDone: $isOnboardingDone)}
       
        }.background(Rectangle().foregroundColor(.white)).onAppear{
            let userDef = UserDefaults.standard
            self.isOnboardingDone = userDef.bool(forKey: "isBoarding")
        }
    }
}

struct BoardingView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
