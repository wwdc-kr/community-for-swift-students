import SwiftUI

struct RegionListView: View {
    // 지역명 하드코딩
    private let regions = [
        Region(name: "부산", englishName: "Busan",sojuname: "Daesun Soju"),
        Region(name: "대구", englishName: "Daegu",sojuname: "Charm Soju"),
        Region(name: "제주도", englishName: "Jeju",sojuname: "Hallasan Soju"),
        Region(name: "서울/인천/경기", englishName: "Seoul/Incheon/Gyeonggi",sojuname: "Chamisul Soju"),
        Region(name: "광주/전남", englishName: "Gwangju/Jeonnam",sojuname: "Ipsaeju (a local Korean soju from Gwangju)"),
        Region(name: "울산/경남", englishName: "Ulsan/Gyeongnam",sojuname: "Good Day Soju"),
        Region(name: "대전/충남", englishName: "Daejeon/Chungnam",sojuname: "O2-rin Soju"),
        Region(name: "충북", englishName: "Chungbuk",sojuname: "Cheongpung Soju"),
        Region(name: "강원", englishName: "Gangwon",sojuname: "Chum Churum Soju")
    ]
    // 지역명 하드코딩
    
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(regions) { region in
                        NavigationLink(value: region) {
                            Text(region.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Korean Regions")
            .navigationDestination(for: Region.self) { region in
                RegionDetailView(region: region)
            }
        }
    }
}
