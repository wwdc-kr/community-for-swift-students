import SwiftUI

struct CoreMLVisionWorkshopView: View {

    @State private var predictions: [ClassificationResult] = []
    @State private var visibleHints: Set<Int> = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                headerSection
                
                mainClassesSection
                workflowSection
                
                Divider()

                instructionSection

                Divider()

                implementationGuideSection
            }
            .padding(50)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("CoreML + Vision")
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("CoreML과 Vision 프레임워크를 사용하여 이미지 분류를 수행합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Use CoreML and Vision frameworks to perform image classification tasks.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var instructionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("📝 실습 가이드")
                .font(.headline)

            Text("• CoreMLVisionWorkshop.swift 파일을 열어 TODO 주석을 순서대로 구현하세요.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("• 아래 가이드를 참고하여 각 단계를 완성하면 이미지 분류 기능이 작동합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("• CoreML 모델 (.mlmodel 파일)은 Resources 폴더에 추가되어 있습니다")
                .font(.subheadline)
                .foregroundColor(.secondary)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }

    private var workflowSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("🔄 CoreML + Vision 워크플로우")
                .font(.title2)
                .bold()

            VStack(alignment: .leading, spacing: 8) {
                workflowStep(number: "1", text: "MLModel 로드")
                workflowArrow()
                workflowStep(number: "2", text: "VNCoreMLModel 생성")
                workflowArrow()
                workflowStep(number: "3", text: "VNCoreMLRequest 생성")
                workflowArrow()
                workflowStep(number: "4", text: "VNImageRequestHandler로 실행")
                workflowArrow()
                workflowStep(number: "5", text: "VNClassificationObservation 처리")
            }
            .padding()
            .background(Color.purple.opacity(0.05))
            .cornerRadius(12)
        }
    }

    private func workflowStep(number: String, text: String) -> some View {
        HStack(spacing: 12) {
            Text(number)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.purple)
                .clipShape(Circle())

            Text(text)
                .font(.body)
        }
    }

    private func workflowArrow() -> some View {
        HStack {
            Spacer()
                .frame(width: 7)
            Image(systemName: "arrow.down")
                .foregroundColor(.purple.opacity(0.6))
            Spacer()
        }
    }

    private var mainClassesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("주요 클래스")
                .font(.title2)
                .bold()

            VStack(alignment: .leading, spacing: 12) {
                FeatureRow(
                    icon: "brain",
                    title: "MLModel",
                    description: "CoreML 모델의 기본 클래스. .model 프로퍼티로 접근"
                )

                FeatureRow(
                    icon: "eye",
                    title: "VNCoreMLModel",
                    description: "Vision에서 사용하는 CoreML 모델 래퍼"
                )

                FeatureRow(
                    icon: "doc.text.magnifyingglass",
                    title: "VNCoreMLRequest",
                    description: "Vision 요청 객체. completion handler로 결과 처리"
                )

                FeatureRow(
                    icon: "photo",
                    title: "VNImageRequestHandler",
                    description: "이미지 분석을 실행하는 핸들러. perform(_:) 메소드 사용"
                )

                FeatureRow(
                    icon: "list.bullet.clipboard",
                    title: "VNClassificationObservation",
                    description: "분류 결과. identifier(클래스명)와 confidence(신뢰도) 포함"
                )
            }
        }
    }

    private var implementationGuideSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("📚 단계별 구현 가이드")
                .font(.title2)
                .bold()

            guideCard(
                step: 1,
                title: "CoreML 모델 로드",
                description: "MLModelConfiguration을 사용해 모델 로드",
                requirements: [
                    "MLModelConfiguration() 생성",
                    "SFSymbolClassifier(configuration:) 초기화",
                    "model.model 반환 (MLModel)"
                ],
                hint: """
        let config = MLModelConfiguration()
        let model = try SFSymbolClassifier(configuration: config)
        return model.model
"""
            )

            guideCard(
                step: 2,
                title: "VNCoreMLModel 생성",
                description: "MLModel을 Vision용으로 변환",
                requirements: [
                    "VNCoreMLModel(for:) 사용",
                    "MLModel을 파라미터로 전달"
                ],
                hint: "return try VNCoreMLModel(for: mlModel)"
            )

            guideCard(
                step: 3,
                title: "VNCoreMLRequest 생성",
                description: "분류 요청과 completion handler 구현",
                requirements: [
                    "VNCoreMLRequest(model:completionHandler:) 생성",
                    "request.results를 [VNClassificationObservation]으로 캐스팅",
                    "completion 클로저 호출"
                ],
                hint: """
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else { return }
            completion(results)
        }
        return request
"""
            )

            guideCard(
                step: 4,
                title: "이미지 분류 수행",
                description: "VNImageRequestHandler로 요청 실행",
                requirements: [
                    "VNImageRequestHandler(ciImage:options:) 생성",
                    "handler.perform([request]) 실행"
                ],
                hint: "let handler = VNImageRequestHandler(ciImage: image, options: [:])\ntry? handler.perform([request])"
            )

            guideCard(
                step: 5,
                title: "UIImage를 CIImage로 변환",
                description: "UIKit 이미지를 Core Image로 변환",
                requirements: [
                    "CIImage(image:) 사용",
                    "Optional 처리"
                ],
                hint: "return CIImage(image: uiImage)"
            )

            guideCard(
                step: 6,
                title: "결과 정렬 및 필터링",
                description: "confidence 기준 내림차순 정렬 후 상위 N개 선택",
                requirements: [
                    "sorted(by:) 사용, confidence 비교",
                    "prefix(length) 사용",
                    "Array로 변환"
                ],
                hint: "return Array(\n    observations.sorted { $0.confidence > $1.confidence }\n    .prefix(length)\n)"
            )

            guideCard(
                step: 7,
                title: "ClassificationResult로 변환",
                description: "VNClassificationObservation을 앱의 모델로 변환",
                requirements: [
                    "map(_:) 사용",
                    "identifier와 confidence 추출",
                    "ClassificationResult 생성"
                ],
                hint: "return observations.map {\n    ClassificationResult(\n        identifier: $0.identifier,\n        confidence: Int($0.confidence * 100)\n    )\n}"
            )
        }
    }

    private func guideCard(step: Int, title: String, description: String, requirements: [String], hint: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            StepCard(
                step: step,
                title: title,
                description: description
            )
            VStack(alignment: .leading, spacing: 8) {
                Text("요구사항:")
                    .font(.callout)
                    .fontWeight(.semibold)
                ForEach(requirements, id: \.self) { req in
                    Text("• \(req)")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }

                Button(action: {
                    if visibleHints.contains(step) {
                        visibleHints.remove(step)
                    } else {
                        visibleHints.insert(step)
                    }
                }) {
                    HStack {
                        Image(systemName: visibleHints.contains(step) ? "eye.slash.fill" : "eye.fill")
                        Text(visibleHints.contains(step) ? "힌트 숨기기" : "힌트 보기")
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding(.top, 4)

                if visibleHints.contains(step) {
                    Text(hint)
                        .font(.callout)
                        .foregroundColor(.blue)
                        .padding(.top, 2)
                }
            }
            .padding(.leading, 42)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}
