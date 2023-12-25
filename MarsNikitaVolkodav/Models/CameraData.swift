import Foundation

struct CameraData {
    var cameraData: [CameraModel] = [
        CameraModel(name: "All", abbreviation: "All"),
        CameraModel(name: "Front Hazard Avoidance Camera", abbreviation: "FHAZ"),
        CameraModel(name: "Rear Hazard Avoidance Camera", abbreviation: "RHAZ"),
        CameraModel(name: "Mast Camera", abbreviation: "MAST"),
        CameraModel(name: "Chemistry and Camera Complex", abbreviation: "CHEMCAM"),
        CameraModel(name: "Mars Hand Lens Imager", abbreviation: "MAHLI"),
        CameraModel(name: "Mars Descent Imager", abbreviation: "MARDI"),
        CameraModel(name: "Navigation Camera", abbreviation: "NAVCAM"),
        CameraModel(name: "Panoramic Camera", abbreviation: "PANCAM")
    ]
}
