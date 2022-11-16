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
