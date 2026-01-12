
import Foundation
import Observation
// 🔹 Step 1-1: FoundationModels import 추가 예정


@Observable
@MainActor
final class RegionDetailViewModel {
    let region: Region
    
    // 🔹 Step 2: LanguageModelSession 선언
    
    // 🔹 Step 5: String 응답 변수 (일반 응답)
    
    
    // 🔹 Step 8-4: Generable 응답 변수
    // 🔹 Step 10-1: Streaming을 위한 변수 설정 변경

    
    private(set) var isLoading: Bool = false
    var error: Error?
    
    init(region: Region) {
        self.region = region
        
        // 🔹 Step 3: Instructions 작성
        
        
        // 🔹 Step 4: Session 초기화
        
        
    }
    
    // 🔹 Step 6: askAI() 메서드 구현
    // 🔹 Step 8-5: askAI() 메서드 수정 - Guided Generation 사용
    // 🔹 Step 12-1 : askAI() 메서드 수정 - streaming 버전으로 교체
    func askAI() async {
        print("아직 AI기능 미구현")
            
    }

}
