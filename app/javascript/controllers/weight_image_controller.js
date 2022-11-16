import { Controller } from "@hotwired/stimulus"
import uploadFilesPreview from "./lib/uploadFilesPreview"

// Connects to data-controller="weight-image"
export default class extends Controller {
  connect() {
    let image = document.querySelector("#weight_photos")
    let imagePlace = document.querySelector(".custom-file-container")
    uploadFilesPreview(image, imagePlace)
  }
}

// if (!image.value) {
//   imagePlace.insertAdjascentHTML("<div class='custom-file-container'></div>")
// } else {
//   imagePlace.insertAdjascentHTML("<div class='photo-card mb-3 mt-2' style='background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(https://source.unsplash.com/random/700x600/?bodybuilder)'></div>")
// }
