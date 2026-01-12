import SwiftUI
import PencilKit

struct PencilKitWorkshopView: View {

    @State private var drawing = PKDrawing()
    @State private var visibleHints: Set<Int> = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                headerSection
                mainClassesSection
                Divider()
                instructionSection
                Divider()
                implementationGuideSection
            }
            .padding(50)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("PencilKit")
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("사용자의 손가락을 이용한 터치와 애플펜슬의 입력을 그림으로 캡쳐하여 드로잉 환경을 제공합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Capture touch and Apple Pencil input as a drawing, and display that content from your app.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var instructionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("📝 실습 가이드")
                .font(.headline)

            Text("PencilKitWorkshop.swift 파일을 열어 TODO 주석을 순서대로 구현하세요.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("아래 가이드를 참고하여 각 단계를 완성하면 드로잉 기능이 작동합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var mainClassesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("주요 클래스")
                .font(.title2)
                .bold()

            VStack(alignment: .leading, spacing: 12) {
                FeatureRow(
                    icon: "square.and.pencil",
                    title: "PKCanvasView",
                    description: "실제 그림을 그리는 뷰. drawing과 tool 프로퍼티로 관리"
                )

                FeatureRow(
                    icon: "photo",
                    title: "PKDrawing",
                    description: "그림 데이터 모델. image(from:scale:)로 UIImage 변환 가능"
                )

                FeatureRow(
                    icon: "pencil.tip",
                    title: "PKInkingTool",
                    description: "펜 도구. init(.pen/.pencil/.marker, color:, width:)로 생성"
                )

                FeatureRow(
                    icon: "eraser",
                    title: "PKEraserTool",
                    description: "지우개 도구. .vector 또는 .bitmap 타입 선택"
                )
            }
        }
    }

    private var implementationGuideSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("단계별로 구현하기")
                .font(.title2)
                .bold()
            
            VStack(alignment: .leading, spacing: 15) {
                StepCard(step: 1,
                         title: "makeUIView 메소드 구현",
                         description: "PKCanvasView를 설정하고 반환"
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("요구사항:")
                        .font(.callout)
                        .fontWeight(.semibold)
                    ForEach([
                        "backgroundColor를 darkGray로 설정",
                        "tool은 20pt, 흰색컬러의 pencil로 설정",
                        "canvas 반환"
                    ], id: \.self) { req in
                        Text("• \(req)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    
                    Button {
                        if visibleHints.contains(1) {
                            visibleHints.remove(1)
                        } else {
                            visibleHints.insert(1)
                        }
                    } label: {
                        HStack {
                            Image(systemName: visibleHints.contains(1) ? "eye.slash.fill" : "eye.fill")
                            Text(visibleHints.contains(1) ? "힌트 숨기기" : "힌트 보기")
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 4)

                    if visibleHints.contains(1) {
                        Text("""
                             canvas.backgroundColor = .darkGray
                             canvas.tool = PKInkingTool(.pencil, color: .white, width: 20)
                             return canvas
                            """)
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

            VStack(alignment: .leading, spacing: 15) {
                StepCard(
                    step: 2,
                    title: "Drawing 이미지 처리",
                    description: "PKDrawing을 UIImage로 변환"
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("요구사항:")
                        .font(.callout)
                        .fontWeight(.semibold)
                    ForEach([
                        "canvas의 drawing.image(from:scale:) 호출",
                        "drawing의 bounds와 scale을 1.0으로 파라미터 전달"
                    ], id: \.self) { req in
                        Text("• \(req)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }

                    Button {
                        if visibleHints.contains(2) {
                            visibleHints.remove(2)
                        } else {
                            visibleHints.insert(2)
                        }
                    } label: {
                        HStack {
                            Image(systemName: visibleHints.contains(2) ? "eye.slash.fill" : "eye.fill")
                            Text(visibleHints.contains(2) ? "힌트 숨기기" : "힌트 보기")
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 4)

                    if visibleHints.contains(2) {
                        Text("return canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0)")
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

            VStack(alignment: .leading, spacing: 15) {
                StepCard(
                    step: 3,
                    title: "Drawing 초기화",
                    description: "캔버스 비우기 기능 구현"
                )
                VStack(alignment: .leading, spacing: 8) {
                    Text("요구사항:")
                        .font(.callout)
                        .fontWeight(.semibold)
                    ForEach([
                        "clearDrawing() 구현",
                        "canvas의 drawing을 빈 PKDrawing으로 대치"
                    ], id: \.self) { req in
                        Text("• \(req)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }

                    Button {
                        if visibleHints.contains(3) {
                            visibleHints.remove(3)
                        } else {
                            visibleHints.insert(3)
                        }
                    } label: {
                        HStack {
                            Image(systemName: visibleHints.contains(3) ? "eye.slash.fill" : "eye.fill")
                            Text(visibleHints.contains(3) ? "힌트 숨기기" : "힌트 보기")
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 4)

                    if visibleHints.contains(3) {
                        Text("canvas.drawing = PKDrawing()")
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
}
