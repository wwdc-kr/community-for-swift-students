import SwiftUI
import CoreML
import Vision

/*
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - CoreML 주요 클래스:
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ MLModel - CoreML 모델의 기본 클래스                                  │
 │ VNCoreMLModel - Vision에서 사용하는 CoreML 모델                      │
 │ VNCoreMLRequest - Vision 요청 객체                                 │
 │ VNClassificationObservation - 분류 결과                            │
 │   • identifier: 클래스 이름                                        │
 │   • confidence: 신뢰도 (0.0-1.0)                                  │
 └─────────────────────────────────────────────────────────────────┘
 
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - CoreML + Vision 워크플로우:
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ 1. MLModel 로드                                                  │
 │    ↓                                                            │
 │ 2. VNCoreMLModel 생성                                            │
 │    ↓                                                            │
 │ 3. VNCoreMLRequest 생성                                          │
 │    ↓                                                            │
 │ 4. VNImageRequestHandler로 실행                                   │
 │    ↓                                                            │
 │ 5. VNClassificationObservation 처리                              │
 └─────────────────────────────────────────────────────────────────┘
 
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - 1. CoreML 모델 로드
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

class CoreMLModelLoader {
    
    /*
     TODO: CoreML 모델 로드
     
     요구사항:
     - MLModelConfiguration 생성
     - SFSymbolClassifier(configuration:) 초기화
     - 초기화한 분류모델의 model을 반환
     */
    func loadCoreMLModel() throws -> MLModel {
        fatalError("구현 필요")
    }
    
    /*
     TODO: Vision용 모델 생성
     
     요구사항:
     - MLModel을 VNCoreMLModel로 변환
     */
    func createVisionModel(from mlModel: MLModel) throws -> VNCoreMLModel {
        fatalError("구현 필요")
    }
}


/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - 2. 이미지 분류 요청
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

class ImageClassifier {
    
    var visionModel: VNCoreMLModel?
    
    /*
     TODO: 분류 요청 생성
     
     요구사항:
     - VNCoreMLRequest 생성
       - completion handler 구현
     - results를 VNClassificationObservation으로 변환해서 completion 핸들러에 전달
     
     참고
     https://developer.apple.com/documentation/vision/vncoremlrequest/init(model:completionhandler:)
     */
    func createRequest(
        model: VNCoreMLModel,
        completion: @escaping ([VNClassificationObservation]) -> Void
    ) -> VNCoreMLRequest {
        fatalError("구현 필요")
    }
    
    /*
     TODO: 이미지 분류 수행
     
     요구사항:
     - VNImageRequestHandler 생성
     - perform 메소드로 요청 실행
     
     참고
     https://developer.apple.com/documentation/vision/vnimagerequesthandler/init(cgimage:options:)
     https://developer.apple.com/documentation/vision/vnimagerequesthandler/perform(_:)
     */
    func performClassification(on image: CIImage, request: VNCoreMLRequest) throws {
        fatalError("구현 필요")
    }
    
    /*
     TODO: UIImage를 CIImage로 변환
     */
    func convertToCIImage(from uiImage: UIImage) -> CIImage? {
        fatalError("구현 필요")
    }
}


/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - 3. 분류 결과 처리
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

class ResultProcessor {
    
    /*
     TODO: 결과 정렬 및 필터링
     
     요구사항:
     - confidence 기준 내림차순 정렬
     - 상위 lenth개만 반환
     */
    func sortAndFilter(
        observations: [VNClassificationObservation],
        length: Int
    ) -> [VNClassificationObservation] {
        fatalError("구현 필요")    
    }
    
    /* 
     TODO: VNClassificationObservation을 ClassificationResult로 변환 
     
     요구사항:
     - confidence를 백분율로 변환합니다
     */
    func convertToResults(
        observations: [VNClassificationObservation]
    ) -> [ClassificationResult] {
        fatalError("구현 필요")
    }
}

struct ClassificationResult: Identifiable {
    let id = UUID()
    let identifier: String
    let confidence: Int // 백분율
}
