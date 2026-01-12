import SwiftUI

struct CreateMLGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                headerSection
                Divider()
                stepsSection
            }
            .padding(50)
        }
        .navigationTitle("CreateML")
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("create_ml")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("CreateML")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Create ML은 강력한 Core ML 모델을 생성하면서 모델 학습의 복잡성을 해소합니다.")
            Text("Create ML takes the complexity out of model training while producing powerful Core ML models.")
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }
    
    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("모델은 이렇게 만들 수 있어요")
                .font(.title2)
                .bold()
            
            StepCard(
                step: 1,
                title: "CreateML 앱 실행",
                description: "Create New Project")
            makeImage(name: "1")
            
            StepCard(
                step: 2,
                title: "프로젝트 생성",
                description: "Image Classification")
            makeImage(name: "2")
            makeImage(name: "3")
            makeImage(name: "4")
            
            StepCard(
                step: 3,
                title: "데이터셋 생성",
                description: "폴더명이 label이 되고, 해당 경로에 학습할 데이터를 추가합니다.")
            datasetSection
            makeImage(name: "5")
            makeImage(name: "6")
            
            StepCard(
                step: 4,
                title: "[Settings] 학습 데이터셋 추가 및 파라미터 설정",
                description: "Max Iterations, Augmentation 설정")
            makeImage(name: "7")
            
            StepCard(
                step: 5,
                title: "[Training] 모델 학습",
                description: "▶ 버튼 클릭")
            makeImage(name: "8")
            
            StepCard(
                step: 6,
                title: "[Preview] 결과 확인",
                description: "새로운 테스트데이터를 추가해서 결과를 확인할 수 있습니다.")
            makeImage(name: "9")
            makeImage(name: "10")
            
            StepCard(
                step: 7,
                title: "[Output] 모델 내보내기",
                description: "􀈄 get 버튼을 눌러 .mlmodel 저장")
            makeImage(name: "11")
        }
    }
    private func makeImage(name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 700)
    }
    
    private var datasetSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                FileTreeItem(icon: "folder.fill", name: "TrainingData/", color: .blue, level: 0)
                FileTreeItem(icon: "folder.fill", name: "class1/", color: .white, level: 1)
                FileTreeItem(icon: "photo.fill", name: "image1", color: .secondary, level: 2)
                FileTreeItem(icon: "photo.fill", name: "image2", color: .secondary, level: 2)
                FileTreeItem(icon: "folder.fill", name: "class2/", color: .white, level: 1)
                FileTreeItem(icon: "folder.fill", name: "class3/", color: .white, level: 1)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .font(.system(.body, design: .monospaced))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
