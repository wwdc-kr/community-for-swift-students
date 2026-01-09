import SwiftUI
import PencilKit

/*
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - PencilKit 주요 클래스:
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ PKCanvasView                                                    │
 │ - 실제 그림을 그리는 뷰                                              │
 │ - drawing: PKDrawing (그림)                                      │
 │ - tool: PKTool (도구)                                            │
 └─────────────────────────────────────────────────────────────────┘
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ PKDrawing                                                       │
 │ - 그림 데이터를 담는 모델                                             │
 │ - image(from:scale:) → UIImage                                  │
 │ - dataRepresentation() → Data                                   │
 └─────────────────────────────────────────────────────────────────┘
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ PKInkingTool                                                    │
 │ - init(.pen / .pencil / .marker, color:, width:)                │
 └─────────────────────────────────────────────────────────────────┘
 
 ┌─────────────────────────────────────────────────────────────────┐
 │ PKEraserTool                                                    │
 │ - .vector: 벡터 방식                                              │
 │ - .bitmap: 비트맵 방식                                             │
 └─────────────────────────────────────────────────────────────────┘
 
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */


/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MARK: - 1. Canvas View 구현
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

struct PencilKitCanvasView: UIViewRepresentable {
    
    let canvas = PKCanvasView()
    
    /*
     TODO: PKCanvasView를 설정하고 반환하는 makeUIView 메소드 구현
     
     요구사항:
     - backgroundColor를 darkGray로 설정
     - tool 설정 (PKInkingTool 사용, 두께는 20pt, 흰색 컬러의 pencil로 설정)
       - 다크모드 지원이 되고 있으므로, 다크모드를 사용하시는 분들은 검정색으로 설정해주세요
     - 설정이 완료된 PKCanvasView 반환
     
     참고
     https://developer.apple.com/documentation/pencilkit/pkcanvasview
     */
    func makeUIView(context: Context) -> PKCanvasView {
        fatalError("구현 필요")
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) { }
    
    /*
     TODO: Drawing을 이미지로 변환
     
     요구사항:
     - PKDrawing을 UIImage로 변환
     */
    func convertToImage() -> UIImage {
        fatalError("구현 필요")
    }
    
    /*
     TODO: Drawing 초기화
     
     요구사항:
     - PKCanvasView의 drawing을 빈 PKDrawing로 초기화
     */
    func clearDrawing() {
        fatalError("구현 필요")
        
        
        canvas.setNeedsDisplay()
    }
}
