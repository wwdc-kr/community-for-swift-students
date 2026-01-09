import SwiftUI

struct OverviewView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                featuresSection
                Divider()
                instructionsSection
                Divider()
                projectStructureSection
            }
            .padding(50)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Code along with CoreML & PencilKit frameworks")
    }

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            FeatureRow(
                icon: "pencil.tip",
                title: "PencilKit",
                description: "터치 입력으로 그림 그리기"
            )
            
            FeatureRow(
                icon: "cpu",
                title: "CreateML",
                description: "커스텀 머신러닝 모델 생성"
            )
            
            FeatureRow(
                icon: "brain.head.profile",
                title: "CoreML + Vision",
                description: "머신러닝 모델을 사용한 이미지 분류"
            )
        }
    }

    private var projectStructureSection: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("📦 프로젝트 구조")
                .font(.title)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 10) {
                FileTreeItem(icon: "folder.fill", name: "Workshop.swiftpm/", color: .white, level: 0)
                FileTreeItem(icon: "doc.text.fill", name: "README.md", color: .gray, level: 1)

                FileTreeItem(icon: "folder.fill", name: "Source", color: .white, level: 1)
                FileTreeItem(icon: "doc.text.fill", name: "ContentView.swift", color: .gray, level: 2)
                FileTreeItem(icon: "doc.text.fill", name: "MyApp.swift", color: .gray, level: 2)
                FileTreeItem(icon: "doc.text.fill", name: "SFSymbolClassifier.swift", color: .gray, level: 2)

                FileTreeItem(icon: "folder.fill", name: "Common", color: .white, level: 2)

                FileTreeItem(icon: "folder.fill", name: "View", color: .white, level: 2)

                FileTreeItem(icon: "folder.fill", name: "Overview", color: .white, level: 3)
                FileTreeItem(icon: "doc.text.fill", name: "OverviewView.swift", color: .gray, level: 4, comment: "개요")
                FileTreeItem(icon: "doc.text.fill", name: "SFSymbolsFinderView.swift", color: .gray, level: 4, comment: "SF Symbols 데모")

                FileTreeItem(icon: "folder.fill", name: "Practice", color: .white, level: 3)
                FileTreeItem(icon: "doc.text.fill", name: "PencilKitView.swift", color: .gray, level: 4, comment: "PencilKit UI")
                FileTreeItem(icon: "doc.text.fill", name: "CoreMLVisionView.swift", color: .gray, level: 4, comment: "CoreML UI")
                FileTreeItem(icon: "doc.text.fill", name: "CreateMLGuideView.swift", color: .gray, level: 4, comment: "CreateML 가이드")

                FileTreeItem(icon: "folder.fill", name: "Workshop", color: .orange, level: 2, comment: "👈 TODO!")
                FileTreeItem(icon: "doc.text.fill", name: "CoreMLVisionWorkshop.swift", color: .orange, level: 3, comment: "CoreML 핸즈온 (TODO)")
                FileTreeItem(icon: "doc.text.fill", name: "PencilKitWorkshop.swift", color: .orange, level: 3, comment: "PencilKit 핸즈온 (TODO)")
                FileTreeItem(icon: "doc.text.fill", name: "WorkshopCompleteView.swift", color: .orange, level: 3, comment: "핸즈온 통합 화면 (TODO)")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .font(.system(.body, design: .monospaced))
        }
    }

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("이렇게 진행해요")
                .font(.title2)
                .fontWeight(.semibold)

            Text("제나의 2024년 출품작인 SF Symbols Finder를 함께 만들어 봅니다.")
                .padding(.bottom)

            StepCard(step: 1, title: "탭 순서대로 워크샵을 진행합니다.")
            StepCard(step: 2, title: "TODO 주석을 찾아 필요한 코드를 작성합니다.")
            StepCard(step: 3, title: "가이드에 포함된 힌트를 참고할 수 있습니다.")
            StepCard(step: 4, title: "순서대로 단계를 따른 후에 앱을 실행하여 결과를 확인할 수 있습니다.")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}
