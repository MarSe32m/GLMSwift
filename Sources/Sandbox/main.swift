import GLMSwift
import Dispatch

let pos = vec3(203.0, -23, 6645)
let scale = vec3(1, 1, 0)
let color = vec4(1, 1, 1, 1)
let vertex = vec4(0, 0, 0, 1)

var translationA = Matrix4A<Float>(1, 0, 0, 0,
                                  1, 1, 1, 1,
                                  0, 2, 3, 4,
                                  -5, 3, 66, 32)
var translationS = Matrix4<Float>(1, 0, 0, 0,
                                  1, 1, 1, 1,
                                  0, 2, 3, 4,
                                  -5, 3, 66, 32)

let translationMat = GLMSwift.translation(vec3(1, 0, 0))
let rotationMat = GLMSwift.rotation(1.0, vec3(0, 0, 1))
let scaleMat = GLMSwift.scale(vec3(1, 1, 1))

func calculateTranslation(matrix: mat4) -> mat4 {
    let transform = matrix
    return transform
}

func calculateTranslation(pointer: UnsafeMutablePointer<mat4>) -> mat4 {
    let transform = pointer.pointee
    return transform
}

for _ in 0..<10 {
    let startS = DispatchTime.now().uptimeNanoseconds
    for _ in 0..<1_000_000 {
        let transform = calculateTranslation(matrix: translationS)
        let k = transform * translationS
    }
    let deltaS = DispatchTime.now().uptimeNanoseconds - startS
    print("Pure struct took:", deltaS / 1_000_000, "ns")

    let startA = DispatchTime.now().uptimeNanoseconds
    for _ in 0..<1_000_000 {
        let transform = calculateTranslation(pointer: &translationS)
        let k = transform * translationS
    }
    let deltaA = DispatchTime.now().uptimeNanoseconds - startA
    print("Pointer took:", deltaA / 1_000_000, "ns")
}

print(translationA * translationA * translationA * translationA)
print(translationS * translationS * translationS * translationS)



struct Vertex {
    var x: Float = 0
    var y: Float = 0
}

func doSomething(vertex: UnsafeMutablePointer<Float>) {
    print(vertex.pointee)
    print(vertex.advanced(by: 1).pointee)
    vertex.advanced(by: 1).pointee = 483
}

var vertexx = Vertex()
vertexx.x = 1.0
vertexx.y = 324234.0

doSomething(vertex: &vertexx.y)

print(vertexx.y)