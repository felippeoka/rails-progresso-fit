const uploadFilesPreview = (image, imagePlace) => {
  image.addEventListener("change", (event) => {
    imagePlace.innerHTML = ""
    console.log(imagePlace)
    const file = image.files[0]
    for (const file of image.files) {
      const fr = new FileReader()
      fr.readAsArrayBuffer(file)
      fr.onload = function () {
        const blob = new Blob([fr.result])
        const url = URL.createObjectURL(blob, { type: "image/png" });
        const a = document.createElement("img")
        a.src = url
        a.className = "img_prd";
        imagePlace.appendChild(a)
      }
    }
  });
}
module.exports = uploadFilesPreview
