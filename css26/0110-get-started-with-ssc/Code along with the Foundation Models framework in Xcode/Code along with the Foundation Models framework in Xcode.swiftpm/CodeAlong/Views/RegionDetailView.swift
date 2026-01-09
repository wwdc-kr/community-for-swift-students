
import SwiftUI

struct RegionDetailView: View {
    let region: Region
    @State private var viewModel: RegionDetailViewModel
    
    init(region: Region) {
        self.region = region
        self._viewModel = State(wrappedValue: RegionDetailViewModel(region: region))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(region.englishName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Divider()
                
                // AI 질문 버튼
                Button {
                    Task {
                        await viewModel.askAI()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Text(viewModel.isLoading ? "Loading..." : "Ask Dr. Soju AI")
                            .font(.headline)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLoading ? Color.gray : Color.green)
                    .cornerRadius(12)
                }
                .disabled(viewModel.isLoading)
                
                // 에러 표시
                if let error = viewModel.error {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // 🔹 Step 7 이후: AI 응답 표시 영역 (처음에는 주석 처리)
                
                // 🔹 Step 8-6 이후: Generable 구조화된 응답 표시 (step 7은부분삭제)
                // 기존 step7부분 aiResponse 표시 부분 삭제할것
                // 🔹 Step 10-2 이후: Strieaming을 위한 optional 체이닝으로 수정 (step 7은부분삭제)
                

                
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(region.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
