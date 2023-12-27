import Foundation
final class AbbreviationServiceMarsCamera {
    
     func getAbbreviation(for fullName: String) -> String {
         switch fullName {
         case "All":
             return "All"
         case "Front Hazard Avoidance Camera":
             return "FHAZ"
         case "Rear Hazard Avoidance Camera":
             return "RHAZ"
         case "Mast Camera":
             return "MAST"
         case "Chemistry and Camera Complex":
             return "CHEMCAM"
         case "Mars Hand Lens Imager":
             return "MAHLI"
         case "Mars Descent Imager":
             return "MARDI"
         case "Navigation Camera":
             return "NAVCAM"
         case "Panoramic Camera":
             return "PANCAM"
         default:
             return ""
         }
     }
}
