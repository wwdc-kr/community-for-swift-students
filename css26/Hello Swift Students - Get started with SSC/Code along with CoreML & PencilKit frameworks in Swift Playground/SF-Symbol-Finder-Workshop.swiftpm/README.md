# 🎨 SF Symbol Finder 워크샵

SF Symbol Finder를 기반으로 만들어진 Swift Playgrounds 프로젝트입니다.

해당 워크샵을 통해 PencilKit, CoreML, CreateML의 기초 지식을 학습할 수 있습니다.

## ⚙️ 요구사항

### 이런 것들이 필요해요
- Swift Playgrounds 앱이 설치된
- 맥 또는 아이패드
- ⚠️ 이 프로젝트는 **Swift Playgrounds 앱 형식** (.swiftpm)을 기준으로 만들어졌습니다.

### 이런 것들을 알고 계시면 좋아요
- Swift 기본 문법 
- SwiftUI 기초

---

## 📦 프로젝트 구조

```
Workshop.swiftpm/
├── README.md
|
└── Source
    ├── ContentView.swift
    ├── MyApp.swift                          
    ├── SFSymbolClassifier.swift
    |
    └── Common 
    |
    └── View             
        └── Overview     
             ├── OverviewView.swift            # 개요
             ├── SFSymbolsFinderView.swift     # SF Symbols 데모       
        └── Practice
             ├── PencilKitView.swift           # PencilKit UI
             ├── CoreMLVisionView.swift        # CoreML UI
             └── CreateMLGuideView.swift       # CreateML 가이드
    |
    └── Workshop                               # 👈 TODO!
        ├── CoreMLVisionWorkshop.swift         # CoreML 핸즈온 (TODO)
        ├── PencilKitWorkshop.swift            # PencilKit 핸즈온 (TODO)
        └── WorkshopCompleteView.swift         # 핸즈온 통합 화면 (TODO)
        
```

### 플레이스홀더 메소드

모든 주요 함수에는 TODO 주석과 `fatalError("구현 필요")`로 표시되어 있습니다. 

이 부분을 실제 코드로 작성하면 앱이 작동합니다.

---

## 📚 참고 자료

### Apple 공식 문서
- [PencilKit](https://developer.apple.com/documentation/pencilkit)
- [Core ML](https://developer.apple.com/documentation/coreml)
- [Vision](https://developer.apple.com/documentation/vision)
- [Create ML](https://developer.apple.com/documentation/createml)

### Swift Playgrounds
- [Swift Playgrounds 앱](https://www.apple.com/swift/playgrounds/)
- [Swift Playgrounds 가이드](https://developer.apple.com/documentation/swift-playgrounds)

---
